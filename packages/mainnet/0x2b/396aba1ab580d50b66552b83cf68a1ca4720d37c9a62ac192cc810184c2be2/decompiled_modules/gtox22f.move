module 0x2b396aba1ab580d50b66552b83cf68a1ca4720d37c9a62ac192cc810184c2be2::gtox22f {
    struct GTOX22F has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTOX22F, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTOX22F>(arg0, 9, 0x1::string::utf8(b"GTOX22F"), 0x1::string::utf8(b"005"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/kFRqvOF0N5R4mfD9-FUuBRarMeLxjYqZnpI5XgtfXG35Ozdn_AESEzb6p-xizLmzRn-3PWGo1vEmFLsZbe0ZFC9IgUU3ywrn653JeU6EnFpjr9_7bYkso5b9ZyDaYpJq9nm0gFTyM9_NuYfiECDW0B-3nEtUnLxnuLsrpP67TQyTZgOOYwjGT5eMgN6Z6Jm3HLOuHkDb9Jr7jdkGtL7t34flyeq62Nt0QlNzUXxB06xpwO3HZ6ErprlINfTKMm_IfKurxIswJ6z_ZM8YlSo7IdmEuP2PntsLnueFfkHWIsOdhNBp-HLX0l_qDloIffkrNTUQ1rOMYZRuqbCXF3Jm7A.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTOX22F>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTOX22F>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

