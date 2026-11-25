module 0x3f457f50853664d24ec25b10c9687da177e055bb311980670dd56defd3275dcc::gtolamisas {
    struct GTOLAMISAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTOLAMISAS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTOLAMISAS>(arg0, 9, 0x1::string::utf8(b"GTOLAMISAS"), 0x1::string::utf8(b"AC"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/JuS1039ldUMb322u_vkTfRkhsTzsZNwnkthAoWfem7ssVhdWANEbuJ3XCWbOkQYPi_0kUNKLCZQPP8TcYCEtPmPZ_HoZb49zjSUtwWwPzock2f1a3e98YF3uvUjhlEIMu6gjPgH5migi2Ib02Fb1hMi68qQ0G0E8TrUxHIH3ZUJW9TqfF2_gFGqrwRv4ScIZ7nvwAk9vbSIj_DFFiWF6Fko_esvSV7PGpSCS-VY77oFrBO6K56OQUGdM7qcQXO7c95b-iCMSOXZPKCbz30k5OOMxAQEhFdRv24E5I25N8dnrdrxfNObOfKhFslkGzFB_U4vmH9VRb6qT4qzV2jHpSw.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTOLAMISAS>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTOLAMISAS>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

