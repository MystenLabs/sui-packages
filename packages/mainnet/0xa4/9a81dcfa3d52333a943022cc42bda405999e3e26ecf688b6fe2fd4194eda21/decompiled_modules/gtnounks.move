module 0xa49a81dcfa3d52333a943022cc42bda405999e3e26ecf688b6fe2fd4194eda21::gtnounks {
    struct GTNOUNKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTNOUNKS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTNOUNKS>(arg0, 9, 0x1::string::utf8(b"GTNOUNKS"), 0x1::string::utf8(b"Nounks"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/ciI-c8wPm7_aICk0CPiNNqUCuy2oOe6YKiA2RcH9waHehNTuMCHxTBddxltbRecTDmhwDVOt5bDuiVAUrumcArxDe7NMcFVUmzoZY04_qeqg3aiRY6SeOmxUStWzrq8yhbyX79NQMW8WqjOBADDB9ubxIUIpgfigHOwzMifJpuccdfbbzyIlWiEq5-IolGM0EaEYLnwAg9y_AjI7lEouO3nqgFrlG15qlE46dtiA0nxbOVcRg_Ge5IKNsBHt5bVabalPjYK2EdEZspZkSKU4OnW7v1D5p7adFvexjM2F_eCEx5NDVk2K-Kgo_uC6PXPXG0Ky5J5z3BSqvf17WnyFcw.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTNOUNKS>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTNOUNKS>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

