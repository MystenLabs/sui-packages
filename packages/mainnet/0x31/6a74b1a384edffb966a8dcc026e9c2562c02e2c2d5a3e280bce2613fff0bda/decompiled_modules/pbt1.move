module 0x316a74b1a384edffb966a8dcc026e9c2562c02e2c2d5a3e280bce2613fff0bda::pbt1 {
    struct PBT1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: PBT1, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x79a1b44c551613cbc63cc0406f8ff8d717407378dd6f17d43d9e1b3fd63a573::creator_authority::new_account(x"2ecf75aaf182eb60508395645d4e76ebce07b90af8130c6314d2548955e281ad")
        } else {
            0x79a1b44c551613cbc63cc0406f8ff8d717407378dd6f17d43d9e1b3fd63a573::creator_authority::new_address(0x2::address::from_bytes(x"2ecf75aaf182eb60508395645d4e76ebce07b90af8130c6314d2548955e281ad"))
        };
        0x2::transfer::public_transfer<0x79a1b44c551613cbc63cc0406f8ff8d717407378dd6f17d43d9e1b3fd63a573::launch_ticket::LaunchTicket<PBT1>>(0x79a1b44c551613cbc63cc0406f8ff8d717407378dd6f17d43d9e1b3fd63a573::launch_ticket::new<PBT1>(arg0, 9, 0x1::string::utf8(b"PBT1"), 0x1::string::utf8(b"POPULAR test PBT1"), 0x1::string::utf8(b"POPULAR integration test, not a real coin"), 0x1::string::utf8(b""), v0, true, 100, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

