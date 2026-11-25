module 0x56dfb321eada021c3d9b857c5702cc6582887b7eb4c0321fb3b6a207e362c8be::gtxtaghan {
    struct GTXTAGHAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTXTAGHAN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTXTAGHAN>(arg0, 9, 0x1::string::utf8(b"GTXTAGHAN"), 0x1::string::utf8(b"MR HAN"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/dnuK4Ginee90CLFG-Y80N-UsLW2RQicmwHgGksDA2FeC-LZCtJt5n1_jAPZGCos6A6BCxoopCpbvrZxGyv8-YZjYG-TUrwYxuAM2pTNzEoGeGlfS6JUgbLonfrlfQqQhYaP7ZqkhjQZTPnE9DCy0AS5c9EapD1V1JQ_MN27fWXh4kqkJGfkhLMYdmx_gVbwmMCNkzz5lL-DEDM-N9-LJzh9b2e_3zXbyrDmZX1-7xMRdQqX9mNKs08AYQ9CKLngAa245GicDLacLdIMzowuaSiEdtg793IzlcoJ6lDmb_Il8OZplWgT_4wuU0QcHaNRS0YRfjKVTzrFtMFz8FcSRkQ.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTXTAGHAN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTXTAGHAN>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

