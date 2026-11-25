module 0xd0e2af470f75b5f901ab038d63bd3734990da9bbc394d3c11c7661e4a617d650::gtjoeymaxi {
    struct GTJOEYMAXI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTJOEYMAXI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTJOEYMAXI>(arg0, 9, 0x1::string::utf8(b"GTJOEYMAXI"), 0x1::string::utf8(b"JOEYMAXI"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/XcC5CmZ0338nnFQoLuaDfnEoouoJXgfvwTqP-sWWluYTiVSZy1bBNo2BF94Xocmua4zSjIU9Zrdr1fXKT1y5Oh8cFdljzigfIe5LJd0ZdlXVW2lBzz70H4wjxDno_t9AhZv4XJhCAZZziGp6l7oOF7tJzaZ6CJBfVTC0XdD1OWMlyIauQUPXwGgKkY6Ie-8F1zyya7T_0lA4gCh_JXdiyRpbZN61Aa_Gt54mMWKvxcQvS_aRsAIxUsgvX-i5GiH1SJDL7attZrgLYFWa3QlsEcFw8W6s_GXtBzwUuIwxiEkdCvrPX2xle_rUub9l2yEyOF5_M8GgqBncWVZnoNxHaw.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTJOEYMAXI>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTJOEYMAXI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

