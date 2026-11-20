module 0x89ceb98314448ec2d7fd90009f6b6f4cba2da4a00c6f80e8d25a1d25a1f29ea::perfin {
    struct PERFIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PERFIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"f24991fd8e550ec716e3e116aafc484ae8a4db069ff8665fd903626b58d46f86")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"f24991fd8e550ec716e3e116aafc484ae8a4db069ff8665fd903626b58d46f86"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<PERFIN>(arg0, 9, 0x1::string::utf8(b"PERFIN"), 0x1::string::utf8(b"Perfin"), 0x1::string::utf8(b"Every coin gets its own stamp. perfinpress.xyz"), 0x1::string::utf8(b"https://perfinpress.xyz/brand/token.png"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<PERFIN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<PERFIN>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

