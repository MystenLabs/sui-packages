module 0x1038b28452994e1d893a10112742f520ab46ac807da7bc623673b4a3ddc5f57b::gtpatopaqu {
    struct GTPATOPAQU has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTPATOPAQU, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTPATOPAQU>(arg0, 9, 0x1::string::utf8(b"GTPATOPAQU"), 0x1::string::utf8(b"PatoPaqui"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn1.telesco.pe/file/U1rxkYp827ykK4GvDiQEEGlFvhh7KRBS2zmpEDr4L08J1fPwOmG6EdvoDR7MhZngxJJUc8c6HPtBRn7tdlXi-D7_nu2yWQFtfoy6arq9Oi9sh5b_WyGGqfumOq0X0sOM6DuVpRWnDLCVPnF_5Gn0x98HmCgDSmxpCpgQ-V8o-bzdO07qS0llkcApEuariWlCNqhX_e2WWnqddTeHTqHbU_SNsTAsXuqY_qMH0oJf8ocVZv_zVkPzeEScgQbRD6VLLe15xlHUAsGu5ln8BK2oCEMhIRBeNvJ1OnXKI-G3qNHAI7JCp7BeBJefdFFvx3wXqMh2HGtAN_tOnTqs-6roHw.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTPATOPAQU>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTPATOPAQU>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

