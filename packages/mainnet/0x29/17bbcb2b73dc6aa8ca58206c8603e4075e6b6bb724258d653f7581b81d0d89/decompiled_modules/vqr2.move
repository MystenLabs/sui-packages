module 0x2917bbcb2b73dc6aa8ca58206c8603e4075e6b6bb724258d653f7581b81d0d89::vqr2 {
    struct VQR2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: VQR2, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"da0b0c83706267be5596ac49128d5f90c690f3cc9d4b46f9296b136cfb4b31d1")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"da0b0c83706267be5596ac49128d5f90c690f3cc9d4b46f9296b136cfb4b31d1"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<VQR2>(arg0, 9, 0x1::string::utf8(b"VQR2"), 0x1::string::utf8(b"Viper QA VQR2"), 0x1::string::utf8(b"Viper Terminal engine test. Test coin, do not buy."), 0x1::string::utf8(b""), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<VQR2>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<VQR2>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

