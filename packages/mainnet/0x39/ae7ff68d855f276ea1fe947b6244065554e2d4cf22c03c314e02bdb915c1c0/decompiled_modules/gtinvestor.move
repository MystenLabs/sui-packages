module 0x39ae7ff68d855f276ea1fe947b6244065554e2d4cf22c03c314e02bdb915c1c0::gtinvestor {
    struct GTINVESTOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTINVESTOR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTINVESTOR>(arg0, 9, 0x1::string::utf8(b"GTINVESTOR"), 0x1::string::utf8(b"INVESTORS BJ"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/fhfZHfMKaiSsMZUx1664HkjwAy4nLtBqd4XI5is9Gt8BqGBDgXrQtGqdJUaVNAGIEEA1zOxZo6dEeHv-troZk3huMZq3mPmtMcoTo3MVezE4RM5T2qwx0RDTvdgqkpFKveM1m1kCGSYHnP-YU6ResyOF3SOsb6YiIbaGNTPJYekfssP6RL6cIo6Vet7rcZmffJYnSNCDoC1NYMEMWJlhr-9Uvgu7GcIlaZNprxa6CiBBYkqFsgJ38mvBtnROBl2ayDymJ3agopyqH4CaLFo0u9yjWao-aIpbbZwvOBe6BeSfLKi3iiAO9LXw__SgfjAX-HBjbYNDZzeLMnGmzgHs8Q.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTINVESTOR>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTINVESTOR>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

