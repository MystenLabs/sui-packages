module 0x3a0a5400d2fcd237846de6496ae459d9e643e80a0dc314f0d5c6d212202dd37::gtruruarca {
    struct GTRURUARCA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTRURUARCA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTRURUARCA>(arg0, 9, 0x1::string::utf8(b"GTRURUARCA"), 0x1::string::utf8(b"Ruru Arcade"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/COOPcvMXfZeU26twF6Lsx74tnoNeHcaTkV7b9z2c1hkzB2l3rFqwqjSd7F2U1eJq3n9n3m0_YOQN5IQc_zH-Sj7Nt0QrBQtDtFhq6s0upC1fx5ZjBxLz13lEUrZ5d2tdWox68TqUTnh7xnVu2VRek7xxNPZJqCaoJaXEFxhEaNwfagvz5s3nxYy2TF0swZ0h976gcxe_X-VIsWxlhEpN-FXhJum6wbeWB_QyeE1RdapDSi2DPQND828_qQdOCXkKQde6CypNABYnJQEA-UNZhcn-1Y2rCOdQ7mrnVnyDYrk0aInAlf0FGiiHSKqUkykUDBgexZQYN_R8d-ZR59mp5g.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTRURUARCA>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTRURUARCA>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

