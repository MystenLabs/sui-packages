module 0x8f5ca643eb34ba9db6a9e39ef250587f93deebde39e1ef4e9bae2fdb86c76ce1::pbt2 {
    struct PBT2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: PBT2, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x79a1b44c551613cbc63cc0406f8ff8d717407378dd6f17d43d9e1b3fd63a573::creator_authority::new_account(x"2ecf75aaf182eb60508395645d4e76ebce07b90af8130c6314d2548955e281ad")
        } else {
            0x79a1b44c551613cbc63cc0406f8ff8d717407378dd6f17d43d9e1b3fd63a573::creator_authority::new_address(0x2::address::from_bytes(x"2ecf75aaf182eb60508395645d4e76ebce07b90af8130c6314d2548955e281ad"))
        };
        0x2::transfer::public_transfer<0x79a1b44c551613cbc63cc0406f8ff8d717407378dd6f17d43d9e1b3fd63a573::launch_ticket::LaunchTicket<PBT2>>(0x79a1b44c551613cbc63cc0406f8ff8d717407378dd6f17d43d9e1b3fd63a573::launch_ticket::new<PBT2>(arg0, 9, 0x1::string::utf8(b"PBT2"), 0x1::string::utf8(b"POPULAR test PBT2"), 0x1::string::utf8(b"POPULAR integration test, not a real coin"), 0x1::string::utf8(b""), v0, true, 100, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

