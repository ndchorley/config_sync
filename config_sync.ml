let config_file file =
  not (String.equal file ".git") &&
    not (String.equal file ".gitignore")

let changed repo_dir file =
  let home_dir = (Sys.getenv "HOME") ^ "/" in
  let command =
    ("diff " ^ home_dir ^
       file ^ " " ^ repo_dir ^ "/" ^ file ^ " &> /dev/null") in

  (Sys.command command) = 1

let repo_dir = Sys.argv.(1)

let () =
  (Sys.readdir repo_dir)
  |> Array.to_list
  |> List.filter config_file
  |> List.filter (changed repo_dir)
  |> List.iter print_endline
