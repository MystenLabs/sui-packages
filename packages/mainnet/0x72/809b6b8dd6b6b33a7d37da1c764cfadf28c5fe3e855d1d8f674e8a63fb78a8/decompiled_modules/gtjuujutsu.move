module 0x72809b6b8dd6b6b33a7d37da1c764cfadf28c5fe3e855d1d8f674e8a63fb78a8::gtjuujutsu {
    struct GTJUUJUTSU has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTJUUJUTSU, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTJUUJUTSU>(arg0, 9, 0x1::string::utf8(b"GTJUUJUTSU"), 0x1::string::utf8(b"Juuju"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/ThTioNvkFKXCETOkx7AJU-1iWtyUZjFXqg_09oYcJ5Tgf3iwPDHlhs2a1ucbxTrunc1TY088tShGpPQL63cBXbmnum4AB6S2fCA2540qhtCyrzm4eIwl05PvIcrYsSLRyqWXfJf7nEr1KsQBsSE3sm3KmiczUTcBdUW9FLaIpwiokq_DJJP9tYZ8isqgsRdCN4kGD4bcgW-nDLhAhn8nvdjk-Zb94iBPbaesapFLpbyiOcd-69QVZS61oDgHxdbslGjYlI86jNqnQdqTa5uecZ0Go0Pmd43dz3jG9reM5VyECgYb1U1wHSVah6aLE-hc5Zg329icotlFol1r5Kav9w.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTJUUJUTSU>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTJUUJUTSU>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

