module 0xad34291a69d7e83d9f9e4b45b93b8e57ca0bf787c2ddbf224fe619978ad0766a::gtoxmichae {
    struct GTOXMICHAE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTOXMICHAE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTOXMICHAE>(arg0, 9, 0x1::string::utf8(b"GTOXMICHAE"), 0x1::string::utf8(b"MICHAEL"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/f9Mo8ziQCGJOI2TUBmz7qRP_Bxxiuc2CiXwwIBVtXwE6LJ-xfDkwX2UeiFDpr2NVB5HeImzZJ0aL04E-D0m4JkXRBySN6JRmENcDgSNjlkO19i6UXtUiK_YGs0uq8bcerz1lTHG16TnAC7gTKWkzZkpNaiBN85uw77CLRoJVY_w3wHybflcXFNTnatLNmEYj5gHjKPwMHO-cyc_vjHxV5crYabPhZ_f9xHZ-F3_DY6t7sd38y4JhxLplBGDLEgiNg9qFnO9fwNuWelhQ388h0RmGLv26EesHwEMzFhsDE_-uZYxbwo5JhsOF_wgoq9Ee8ziqptkZj98I1yXPAxaQ5g.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTOXMICHAE>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTOXMICHAE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

