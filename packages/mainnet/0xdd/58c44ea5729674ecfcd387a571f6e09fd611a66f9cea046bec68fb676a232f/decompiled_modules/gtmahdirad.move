module 0xdd58c44ea5729674ecfcd387a571f6e09fd611a66f9cea046bec68fb676a232f::gtmahdirad {
    struct GTMAHDIRAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTMAHDIRAD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTMAHDIRAD>(arg0, 9, 0x1::string::utf8(b"GTMAHDIRAD"), 0x1::string::utf8(b"Mahdi R"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/NtSKK1v9MZd9hAzm899z3W-HuJ7GV01FvQ_ulso5bC3W2kzII-WvoUz_Qw7_3n1CRgwGsz7lsm3CQ4r8M61YHLoinoXq7cdiVKRpstSFUxaUrHjlGa2pUyR1IwIFjIfN4fDSzntxAvGBftVUFT_5NKCLxL8V2CVliogiaNjGPD9eD8yT9JKjPj4GrrHt7VThi3USX_osP-ohhqFZOC4JodppudoBJ4l-JNAOv4r3oYQBf1J83sVhBRZ0nIy26GzQapT1GNjj1Sfu0EY8a29DgpbKfmDIkKYGQBf1tms0pzZNC-vY-FE7QlvrajVSHw0BpdkzYMSsIcN5YqWwPg2_zw.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTMAHDIRAD>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTMAHDIRAD>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

