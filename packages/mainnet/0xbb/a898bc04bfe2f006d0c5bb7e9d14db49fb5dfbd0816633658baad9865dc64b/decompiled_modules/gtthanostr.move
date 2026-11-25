module 0xbba898bc04bfe2f006d0c5bb7e9d14db49fb5dfbd0816633658baad9865dc64b::gtthanostr {
    struct GTTHANOSTR has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTTHANOSTR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTTHANOSTR>(arg0, 9, 0x1::string::utf8(b"GTTHANOSTR"), 0x1::string::utf8(b"Thanostrader.sui"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/rLiGT4ArjC3cgEjAjSZ54VuOIoGz2RxZdaJIJ1jnjJhYyvGpJj2hxrSUYr1Z1gn7CF07iJT09WIYdovSctqHq2edOgBw6SzlHp0Uohtqq4ZY_NY-J04LYQkVSB5JzNNSKWJLfTh0FCEVGhoQxErFlsbEmBJtRAjNxPaN7fg77NYma1PiqX0Lv7tTp4lqM9LM2G7BQO0isR46_orxc5zBX-7MMsYWXQVKZm86OSrWBN6JT6nsTO8RSemvgxPXFE0Hl3vpHfUGl3FM_xaYWlyy3j0SvZeiwrPRqqmkA6KYmuQlqk5tfo2WXsW5gUwQL9WyGEbVE9kRt-T_A5DCV9AJXw.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTTHANOSTR>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTTHANOSTR>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

