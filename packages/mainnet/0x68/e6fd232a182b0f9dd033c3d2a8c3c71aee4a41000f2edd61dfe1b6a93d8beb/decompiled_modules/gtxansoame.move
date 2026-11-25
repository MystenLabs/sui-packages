module 0x68e6fd232a182b0f9dd033c3d2a8c3c71aee4a41000f2edd61dfe1b6a93d8beb::gtxansoame {
    struct GTXANSOAME has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTXANSOAME, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTXANSOAME>(arg0, 9, 0x1::string::utf8(b"GTXANSOAME"), 0x1::string::utf8(b"Xanso Amero"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/r60hUIu-gnRsolxC4ZkPIUgBd1wWvtiIJSnZgQRushPA9FElqy871BDoK1Smjy0NS5RiO5nqrmBD-ise5uduoXbW-su0wiQ0wPddLb7xXRfcEBwFuawmVeJ1LiDq0dPc_FvTkLntsw1tVypcoOLOi7-91C63PRFo3Xx4XcNXuna34ue9RSggjJ3Pw-YSh-EUOr7KfJcgehPyxjTvE_ff_Du3hyiWVrxwJHXzxSZ4Spi4UW_8byWixX8oxzVdA7EOi-kcYJ92yZvwLqMBy6_pp66tC4O1Kqxf_jytosLq0S9RKgIvF9P479CBwAXvp16mogzQ2-AKwYf0iKPJnnku7w.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTXANSOAME>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTXANSOAME>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

