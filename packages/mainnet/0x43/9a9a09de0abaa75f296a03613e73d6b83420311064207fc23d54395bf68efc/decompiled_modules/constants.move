module 0x439a9a09de0abaa75f296a03613e73d6b83420311064207fc23d54395bf68efc::constants {
    public fun get_character_name(arg0: u64) : vector<u8> {
        if (arg0 == 1) {
            b"Goblin"
        } else if (arg0 == 2) {
            b"Orc"
        } else if (arg0 == 3) {
            b"Knight"
        } else if (arg0 == 4) {
            b"Elf Archer"
        } else if (arg0 == 5) {
            b"Minotaur"
        } else if (arg0 == 6) {
            b"Sorcerer"
        } else if (arg0 == 7) {
            b"Necromancer"
        } else if (arg0 == 8) {
            b"Dragon"
        } else {
            b""
        }
    }

    public fun get_lock_duration(arg0: u64) : u64 {
        if (arg0 >= 1 && arg0 <= 8) {
            1 * 2629746000
        } else if (arg0 >= 9 && arg0 <= 16) {
            2 * 2629746000
        } else if (arg0 >= 17 && arg0 <= 24) {
            3 * 2629746000
        } else if (arg0 >= 25 && arg0 <= 32) {
            4 * 2629746000
        } else if (arg0 >= 33 && arg0 <= 40) {
            5 * 2629746000
        } else if (arg0 >= 41 && arg0 <= 48) {
            6 * 2629746000
        } else if (arg0 >= 49 && arg0 <= 56) {
            7 * 2629746000
        } else if (arg0 >= 57 && arg0 <= 64) {
            8 * 2629746000
        } else {
            0
        }
    }

    public fun get_nft_image(arg0: u64) : vector<u8> {
        if (arg0 == 1) {
            b"bafybeid5fthbie3fmogqh256twonlo7hnjx7q276fu45iak7lka3z3fqcq"
        } else if (arg0 == 2) {
            b"bafybeiczmhpnpq37sbveuwbvb67w5tpi5gjh2gniyf43il5gcqatkrxnbm"
        } else if (arg0 == 3) {
            b"bafybeidmotjaboaf2kss2kdfstgtdcerhsf2j44evqehrcwv32no4nbodi"
        } else if (arg0 == 4) {
            b"bafybeiag5rgni53x7csq6eczfgiymkryjhoqeya77j5y6nqbdzfuwo6lk4"
        } else if (arg0 == 5) {
            b"bafybeigm4o2zu4zxx6ccbirlbiveosjmuolg24mbdxsnrrz6lspptwsffa"
        } else if (arg0 == 6) {
            b"bafybeigbdns6z4hjkfrba7mjoo5pxeg65zmwlqkjjhpiervszsvozivavi"
        } else if (arg0 == 7) {
            b"bafybeieaqhdtzuwggiaxvirkjkouuwubanqf2x7yplvwqgdxxoueraazri"
        } else if (arg0 == 8) {
            b"bafybeigtk6juu62aifqjflxx4toubijsvoxohhmknwvxrnjefra5njxxfa"
        } else if (arg0 == 9) {
            b"bafybeidw5f4uzvg55qt63pbwvidit32pwfohi76lcxsa2jm63w3vbez4ge"
        } else if (arg0 == 10) {
            b"bafybeigqafwhnioxsf2fndevej74pnbey5rjbsi5yghowhfjdoakupyese"
        } else if (arg0 == 11) {
            b"bafybeidh7c4qbpz5sy7kxw7fzl7brs3vg3su4mwvr277xskncoxblyk44u"
        } else if (arg0 == 12) {
            b"bafybeidgccpn2rkzal6r45m5xxs7mkexkhrf3osad5w6wy6rjymt2j4ot4"
        } else if (arg0 == 13) {
            b"bafybeiax3cj6vr555gom5hmqomhsr6ljove2vqcbwt3wlaadxw2ja6dmyi"
        } else if (arg0 == 14) {
            b"bafybeicop2i4ngv5q5awgw4spzyeild7g7y6jpra6tf4foltx2cqg6hiay"
        } else if (arg0 == 15) {
            b"bafybeie4ktvj7n327al5qybzzv6k5yaiqhtxm4ctp6fjp5zgadv4d3qruu"
        } else if (arg0 == 16) {
            b"bafybeieh2a4reqox324262t4wz5orrnva3ewechhfacmjdgdnsz2e7xcum"
        } else if (arg0 == 17) {
            b"bafybeicg64edq23zlazxcb2udzmd7bdyl66hggpiwnoes2ibk4wphiyrjq"
        } else if (arg0 == 18) {
            b"bafybeib5qho4rlydcv25h6j3fpxabo5kpsvwgvkpucco5fl4ga5hlqnh4e"
        } else if (arg0 == 19) {
            b"bafybeiaby6mvpgekkxodjw26z34bqpnuyrrjfhh7fhjncivsr7ap62iz24"
        } else if (arg0 == 20) {
            b"bafybeiea4q53xk6jtqb23oapdymcdiwsmyiaa5x2ur22hznbowbmdzmy34"
        } else if (arg0 == 21) {
            b"bafybeigdbcu4j3mb4uel26zgyewn3n6dn3k3w6m6n6bd74ckadhu2kofui"
        } else if (arg0 == 22) {
            b"bafybeihxla2vwcmcq7glleo2moyir7bsn2r7uiza3efrov3cssg2twzavm"
        } else if (arg0 == 23) {
            b"bafybeievm3kfln5d24ady2fjpbfjjfrdsd5h7nubxdmcdtqmvthjzrnoli"
        } else if (arg0 == 24) {
            b"bafybeib67wmjytoasw6vkkly5tcqbjs7mm26k73clhkxrwwhypf3enpqda"
        } else if (arg0 == 25) {
            b"bafybeiae3eo663i5ctdggrobmzcmn4u73cljhvnxqcgwi37rej536hpcw4"
        } else if (arg0 == 26) {
            b"bafybeieobpztbykl7kk7qvhujtl3dh367ajiemtenevxfgmagoipnzkqzq"
        } else if (arg0 == 27) {
            b"bafybeifwugzfebi7gyswvxe5s3eirwoblxld6sg5eecpeihzzhvp67kl3q"
        } else if (arg0 == 28) {
            b"bafybeicu4vt74q33bfsv6en5ujvtz3jskgsqo2re37fsrkcnekpdgcc57m"
        } else if (arg0 == 29) {
            b"bafybeidwomxed6vhjjnymj2fr4av7gwfu2rm4g5472d3luybgtefjdgumy"
        } else if (arg0 == 30) {
            b"bafybeie6g4oevfyw2ge6ks7bq6z7dqwyf7plpqeq3ok6vo5ukgw4mnrz44"
        } else if (arg0 == 31) {
            b"bafybeialfqfymzq3q5atjqymtcuar57t2oszhnp3gaykn5g4x6onn4bmru"
        } else if (arg0 == 32) {
            b"bafybeiemf24nilkdbrb22ysotwik7rjysgy4aqr2pmrh3hjhk5etddyha4"
        } else if (arg0 == 33) {
            b"bafybeigqcccr4o7bpi7gtlcxcxrnw34scbk53htx6jxezhh6maylp65gva"
        } else if (arg0 == 34) {
            b"bafybeiffdn4h3lxsq6tlwkn3igxk6fga23mxnp4ktkq6xvnem4yqmex6my"
        } else if (arg0 == 35) {
            b"bafybeif7hgifgb4ngaigjv3nhygbvg4tolk5tdq2qunxj7j7nee5c7m3vm"
        } else if (arg0 == 36) {
            b"bafybeib5wdeasyru4syqgp7ugscpsetbbe5off53laojthq7642v3ozahy"
        } else if (arg0 == 37) {
            b"bafybeiao3hg7ycx55gr5uirxqf67segrwn4vcaeho5zlh6cvaf4yvax5tu"
        } else if (arg0 == 38) {
            b"bafybeicp63ruy3vhdd5zbhrtqa74cnlnlmqbpgta7ho2l4edj7hianumyq"
        } else if (arg0 == 39) {
            b"bafybeiavnmpkeysudhgir3mnw6victowt6arcgfqjeqcx2mfjyrnnkzk3i"
        } else if (arg0 == 40) {
            b"bafybeiejrn4y33yolgkmomt25tcybdu3ujybd7scxu3reh6l2jsxoyyzva"
        } else if (arg0 == 41) {
            b"bafybeichbn4tswwuhy7ian75jmlo7jeqjmmkagn6xgraz6zg5ts2pbb7fu"
        } else if (arg0 == 42) {
            b"bafybeihj4lskb62k3jlfd6g5mmmxcepqj4hjtb6vat24mgx75v4xn7xkoe"
        } else if (arg0 == 43) {
            b"bafybeidto2q65prra2naqw5cmshpdgn33vhgv2h2mb3a3qerjbnky6lbfm"
        } else if (arg0 == 44) {
            b"bafybeibwq7pixgh2wt5s52bm3djx6mu2kptmm35bumb2uicbyib3ygxjhm"
        } else if (arg0 == 45) {
            b"bafybeiebjabjyknr7jplrzasm6g2xn7mrtl5rg7bziwacqbcarqbvwwsme"
        } else if (arg0 == 46) {
            b"bafybeibvjejgv36lxgx5xm5hxhgxngvldsz3hmv4p4duyevzawrdsira7m"
        } else if (arg0 == 47) {
            b"bafybeickfb27z5v7zyx3vdhey2byswzebuterr6rhkwxwqm4y4fcr6orr4"
        } else if (arg0 == 48) {
            b"bafybeihoof5y2gszfxb72nhjpyjy7zjyn6kqwyyypu5bty5u2f6ryhpphy"
        } else if (arg0 == 49) {
            b"bafybeicopxko3hvim2aa42hm6yg6gildbhu2ynq5ackabkedmmb3cdsze4"
        } else if (arg0 == 50) {
            b"bafybeic5lw5yzffkvmu3gxz7kyjd67uwnffpc5235uwzdbfrelucs3uw3u"
        } else if (arg0 == 51) {
            b"bafybeic2gdlijqltiaktu23mijd2tks3iqt3qiwsjoeacqzi32nonss33q"
        } else if (arg0 == 52) {
            b"bafybeihznxchnfu53qy3c7qcdlz2bhyxwvqsoulm2aw7v7mgwd6bxiq5y4"
        } else if (arg0 == 53) {
            b"bafybeih5dogo7atxcjstx5lwbpx7crmzadzqmnvlru6f32kmbykpwkgkn4"
        } else if (arg0 == 54) {
            b"bafybeiad4knwd2jiq7kuv2jbb7z55tnfs2y6jpmjmyks7il25boalzu2om"
        } else if (arg0 == 55) {
            b"bafybeib4jk7ok4alymlg7vtvrphks2oqsxgkp4qwkg63dj4uvjampszejy"
        } else if (arg0 == 56) {
            b"bafybeidqaaqdapezuusvzt2kbut4tu6zccnqwwnrr7q36cyssm3n5i3zka"
        } else if (arg0 == 57) {
            b"bafybeidl227m67j5asmacwvtlw6677rqrpuarwnnqwmk2wsch62j6bbzgm"
        } else if (arg0 == 58) {
            b"bafybeie5xobr5colt7u3i6ykev6r7etc26ejuidr37pumu76wj3q3jsvxy"
        } else if (arg0 == 59) {
            b"bafybeie2syl2wmwjms2ynsxvybpumdekgvcrtxpbjz6ogf6sxdxxcadnkm"
        } else if (arg0 == 60) {
            b"bafybeihkeotjbyj3tlpqothxq7e4jckk26miqlnbxrq2j2ad7l4biasxsi"
        } else if (arg0 == 61) {
            b"bafybeigr2g7rfout2s4uagoqxuzyrupy5py54ghtsquvq6kl5lxb3xfniy"
        } else if (arg0 == 62) {
            b"bafybeiezbhrsqpzkvkcqtgfj4i2mppmhqei5dqber5fo3ehafmbkr7owcy"
        } else if (arg0 == 63) {
            b"bafybeicjb2bnbfctwyf4x5a72twhxi67iormwukx3k4zv4xdgodpbwioka"
        } else if (arg0 == 64) {
            b"bafybeiei7dequ5latu3xnt447nuwrasxkcmvbh4xpi43zjnl3is6nubwyy"
        } else {
            b""
        }
    }

    // decompiled from Move bytecode v6
}

