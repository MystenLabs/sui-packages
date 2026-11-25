module 0x18da2e05097455aa5006665cd7cff0a3e1ab7ec67b6ae6b49a4c37e5658906e3::gtjobiakk {
    struct GTJOBIAKK has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTJOBIAKK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTJOBIAKK>(arg0, 9, 0x1::string::utf8(b"GTJOBIAKK"), 0x1::string::utf8(b"Jobiak"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/vOBrQruiXgnU-WIz5z7a1RNkx0KsAbilDriNd3OSAWyeJOdfgCk7ptDum4LESpdQm8XSUdiZlV4EStScv-5_WI8DTKGbB1h3pYmXOX--vph05vIzOcJ0yEqALeChO08o8SgYC49TpOaB42buOmGc0_dIgv9LZ23eowo-O6BGj1-MHR7tW9z2SP2Ys0UXhEfzxjjbGNTv4isbpXl2BiaOBJbWLJWazUFWS1p3yP7KU_d--XNIGE6yPLYv05pJy_2L9FzVLLzNnhrLWu8ydTC1EhtYSMKZIPhtKaF-wixzf3JJR41AiYnx_O5hWwl2QUGeGfdGOIjkwmPtEEGVGdKF6g.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTJOBIAKK>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTJOBIAKK>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

