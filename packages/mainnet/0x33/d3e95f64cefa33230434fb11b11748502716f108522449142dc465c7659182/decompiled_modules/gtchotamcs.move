module 0x33d3e95f64cefa33230434fb11b11748502716f108522449142dc465c7659182::gtchotamcs {
    struct GTCHOTAMCS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTCHOTAMCS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTCHOTAMCS>(arg0, 9, 0x1::string::utf8(b"GTCHOTAMCS"), 0x1::string::utf8(b"Chota"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/UxXqINquYJ2rjcKzJ_6Mkt020ivai-pZL6wm5w7dugXnro9uoQovGasadYWegBovoKHzEhrSEyBqeF2p3jgcrcAmPNp2H8gvVZUpM_yIVFtwc4fzWiqqi5vwhFvj0ZwYUGrvO_eY1ZQR0D_nb96JK1or3f6kvQnhnqB_xWuu18VLn1fzSPjwzEUwpOSancw18K6M-ReIZkRaznXnjUwHnB2YtspLEUGWhSEFoepSOZ6TiCrPlWHlmxeOqrEkon_zQGK0ALqnDvr5H8VsX7UZTNW5GdcyZj-IfQ4POsLa1eHepjtL-ea4Q1gsaLr67HhPa7L1jM4o3gro8ELgwTfp1A.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTCHOTAMCS>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTCHOTAMCS>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

