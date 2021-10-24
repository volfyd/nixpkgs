# Generated by bower2nix v3.2.0 (https://github.com/rvl/bower2nix)
{ fetchbower, buildEnv }:
buildEnv { name = "bower-env"; ignoreCollisions = true; paths = [
  (fetchbower "jquery" "2.2.4" "2.2.4" "0kaln93pzjlr4vqf2zvsm9dwgjkrii9xlsqg48hc1vs16cl109rn")
  (fetchbower "tweetnacl" "0.12.2" "0.12.2" "1lfzbfrdaly3zyzbcp1p53yhxlrx56k8x04q924kg7l52gblm65g")
  (fetchbower "components-font-awesome" "4.7.0" "^4.6.3" "1w27im6ayjrbgjqa0i49ml5d3wy4ld40h9b29hz9myv77bpx4lg1")
  (fetchbower "ckeditor" "4.14.0" "4.14.0" "0lw9q0k8c0jlxvf35vrccab9c3c8rgpc6x66czj9si8yy2lyliyp")
  (fetchbower "codemirror" "5.63.3" "^5.19.0" "09di53sfsgpd328fvz1qjlmybk5mmnb2p9r38xw329bi9b21rq0r")
  (fetchbower "requirejs" "2.3.5" "2.3.5" "05lyvgz914h2w08r24rk0vkk3yxmqrvlg7j3i5av9ffkg9lpzsli")
  (fetchbower "marked" "1.1.0" "1.1.0" "1sdgqw9iki9c1pfm4c5h6c956mchbip2jywjrcmrlb75k53flsjz")
  (fetchbower "rangy" "rangy-release#1.3.0" "rangy-release#~1.3.0" "13x3wci003p8jyv2ncir0k23bxckx99b3555r0zvgmlwycg7w0zv")
  (fetchbower "json.sortify" "2.1.0" "~2.1.0" "1rz9xz0gnm4ak31n10vhslqsw8fw493gjylwj8xsy3bxqq1ygpnh")
  (fetchbower "secure-fabric.js" "secure-v1.7.9" "secure-v1.7.9" "1l56mk7hbnsm9cdg5zdcmg95p7a9w96dq0bbl8fp11vs0awjil7a")
  (fetchbower "hyperjson" "1.4.0" "~1.4.0" "1n68ls3x4lyhg1yy8i4q3xkgh5xqpyakf45sny4x91mkr68x4bd9")
  (fetchbower "chainpad-crypto" "0.2.6" "^0.2.0" "0h6ibv6gcym7mm080swdw4l6l159xjmxgqnahyxw3aydha5cj1z0")
  (fetchbower "chainpad-listmap" "1.0.0" "^1.0.0" "0qzqblw67y1p69xc9n734srfhjviwwb2jbqxgxs0rf4vdyspwvcb")
  (fetchbower "chainpad" "5.2.4" "^5.2.0" "1f4nap0r8w50qpmjdfhhjhpz5xcl0n4zaxxnav1qaxi5j6dyg8h6")
  (fetchbower "file-saver" "1.3.1" "1.3.1" "065nzkvdiicxnw06z1sjz1sbp9nyis8z839hv6ng1fk25dc5kvkg")
  (fetchbower "alertifyjs" "1.0.11" "1.0.11" "0v7323bzq90k35shm3h6azj4wd9la3kbi1va1pw4qyvndkwma69l")
  (fetchbower "scrypt-async" "1.2.0" "1.2.0" "0d076ax708p9b8hcmk4f82j925nlnm0hmp0ni45ql37g7iirfpyv")
  (fetchbower "require-css" "0.1.10" "0.1.10" "106gz9i76v71q9zx2pnqkkj342m630lvssnw54023a0ljc0gqcwq")
  (fetchbower "bootstrap" "4.6.0" "^v4.0.0" "1pp2n88pkms25p7mbna7vxxl5mkpdn8nvnfzwcwpp6b0871njmr6")
  (fetchbower "diff-dom" "2.1.1" "2.1.1" "0nrn6xqlhp0p5ixjxdk8qg3939crkggh1l8swd20d7bsz186l5f1")
  (fetchbower "nthen" "0.1.7" "0.1.7" "03yap5ildigaw4rwxmxs37pcwhq415iham8w39zd56ka98gpfxa5")
  (fetchbower "open-sans-fontface" "1.4.2" "^1.4.2" "0ksav1fcq640fmdz49ra4prwsrrfj35y2p4shx1jh1j7zxd044nf")
  (fetchbower "bootstrap-tokenfield" "0.12.1" "0.12.1" "1dh791s6ih8bf9ihck9n39h68c273jb3lg4mqk94bvqraz45fvwx")
  (fetchbower "localforage" "1.10.0" "^1.5.2" "019rh006v2w5x63mgk78qhw59kf8czbkwdvfngmac8fs6gz88lc8")
  (fetchbower "html2canvas" "0.4.1" "^0.4.1" "0yg7y90nav068q0i5afc2c221zkddpf28hi0hwc46cawx4180c69")
  (fetchbower "croppie" "2.6.5" "^2.5.0" "1j1v5620zi13ad42r358i4ay891abwn6nz357484kgq2bgjj6ccx")
  (fetchbower "sortablejs" "1.14.0" "^1.6.0" "104d688lrbwxi3hnfr4q169850ffyfv1s8qnycqxhx0zfh3887m0")
  (fetchbower "saferphore" "0.0.1" "^0.0.1" "1wfr9wpbm3lswmvy2p0247ydb108h4qh5s286py89k871qh6jwdi")
  (fetchbower "jszip" "Stuk/jszip#3.7.1" "Stuk/jszip#^3.1.5" "0lzq1zd2glvfh3wwj73c9sffas56ql5472yj1cwq3g7iva5iliwq")
  (fetchbower "requirejs-plugins" "1.0.3" "^1.0.3" "00s3sdz1ykygx5shldwhhhybwgw7c99vkqd94i5i5x0gl97ifxf5")
  (fetchbower "dragula.js" "3.7.2" "3.7.2" "0dbkmrl8bcxiplprmmp9fj96ri5nahb2ql8cc7zwawncv0drvlh0")
  (fetchbower "MathJax" "3.0.5" "3.0.5" "087a9av15qj43m8pr3b9g59ncmydhmg40m6dfzsac62ykianh2a0")
  (fetchbower "chainpad-netflux" "1.0.0" "^1.0.0" "08rpc73x1vyvd6zkb7w0m1smzjhq3b7cwb30nlmg93x873zjlsl6")
  (fetchbower "netflux-websocket" "1.0.0" "^1.0.0" "10hgc5ra3ll7qc2r8aal6p03gx6dgz06l2b54lh995pvf901wzi6")
]; }
