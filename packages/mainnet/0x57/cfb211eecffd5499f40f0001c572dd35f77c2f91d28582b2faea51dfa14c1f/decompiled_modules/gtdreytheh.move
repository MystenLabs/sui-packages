module 0x57cfb211eecffd5499f40f0001c572dd35f77c2f91d28582b2faea51dfa14c1f::gtdreytheh {
    struct GTDREYTHEH has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTDREYTHEH, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTDREYTHEH>(arg0, 9, 0x1::string::utf8(b"GTDREYTHEH"), 0x1::string::utf8(b"DREY"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/iWgyPCiH28dlOjZjiWEVM8jUu6Rvqhx8EcgEvTsSGXYIb8L1CjEP-jnAklIpNTxYjbNT4uJ08ec65PHnOEix6IUuQps6Lx-cvu9HfTwch1lykAJt8Xf0xN3TDs7U3nuneOtCbe6fRPR3hYd2UOIRiONqHigBSSqB9sGlj5PBk_jOvfSlomtNfr74RzrfhKQUSfhxqTi78QEOSnRU2n--ps2-wFZilEZiGoheHJelcA8tcuxiaTnetw4Edpty81_8L95P1z6qbHydhkP2MdUcWhAy2a9Pn7u5KHyGgKXd3URFabF9rDgxq5_bD4mUJMAgc_o8rzzCKb5xpmU2MSiOmQ.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTDREYTHEH>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTDREYTHEH>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

