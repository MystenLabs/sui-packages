module 0xf6ebd6f4d0d81e115676bc44db0cebc26182f22be8c6160b9d18a02c016026bc::twistcap {
    struct TWISTCAP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TWISTCAP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"81751df8e0260c2867f78b85e9e8d31c828a829edd898c2722b26f82659765c2")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"81751df8e0260c2867f78b85e9e8d31c828a829edd898c2722b26f82659765c2"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<TWISTCAP>(arg0, 9, 0x1::string::utf8(b"TWISTCAP"), 0x1::string::utf8(b"Twistcap"), 0x1::string::utf8(b"Twist the knob, get a coin. twistcap.lol"), 0x1::string::utf8(b"https://twistcap.lol/brand/token.png"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<TWISTCAP>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<TWISTCAP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

