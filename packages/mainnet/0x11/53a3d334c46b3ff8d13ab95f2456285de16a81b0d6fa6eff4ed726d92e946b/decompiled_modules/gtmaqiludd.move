module 0x1153a3d334c46b3ff8d13ab95f2456285de16a81b0d6fa6eff4ed726d92e946b::gtmaqiludd {
    struct GTMAQILUDD has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTMAQILUDD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTMAQILUDD>(arg0, 9, 0x1::string::utf8(b"GTMAQILUDD"), 0x1::string::utf8(b"Aqilll"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/HMcUWV64pLJbIbxM9PGZxkRBNf0bS-9l76H0VfoEdyr8xUpzb31ypga_buN3cgX6VE3h6ZyBNQ0aspc3XhBjfGtmo0G-L1r-0TX4R-o1Zboig3took6LiHTVHu0-ORH8yGHIYTM5kAgDXRez6cs2RWrsiBbCzDXlfStgQHxvOwmEz3RHe--AuKupwmmkKNVA2OQtqUPYg7njIqCh3x1SkuL4D-LKC-I-75KmTjvXM7vLf8F9BHQMjcv4tZjTFGotMfnFDWmuRl7nzKGsuwSTcAm4PFJcWrRXetH8sax5SKxVyWf6X1Q75XnB7VAUKJMpxbPy_MccQVg19bpjeegBmg.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTMAQILUDD>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTMAQILUDD>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

