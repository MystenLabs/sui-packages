module 0xdd0a185cedbfc6a4c60e1dcbfb0ad30124d5255a2973b5d824b0d97a9ccd94dd::latelit {
    struct LATELIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: LATELIT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"a9aef647d447ad7f3a054ddc641c8c0cd9b7befb0fa636d3bba7313218ae2ed1")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"a9aef647d447ad7f3a054ddc641c8c0cd9b7befb0fa636d3bba7313218ae2ed1"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<LATELIT>(arg0, 9, 0x1::string::utf8(b"LATELIT"), 0x1::string::utf8(b"Latelit"), 0x1::string::utf8(b"A city block where every coin gets a window. Buys keep the lights on. latelit.xyz"), 0x1::string::utf8(b"https://latelit.xyz/brand/pp-512.png"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<LATELIT>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<LATELIT>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

