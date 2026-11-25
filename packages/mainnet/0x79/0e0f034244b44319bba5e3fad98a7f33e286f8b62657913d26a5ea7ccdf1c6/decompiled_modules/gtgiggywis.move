module 0x790e0f034244b44319bba5e3fad98a7f33e286f8b62657913d26a5ea7ccdf1c6::gtgiggywis {
    struct GTGIGGYWIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTGIGGYWIS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTGIGGYWIS>(arg0, 9, 0x1::string::utf8(b"GTGIGGYWIS"), 0x1::string::utf8(b"giggywise H"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/KU9ZGcLYKFXZJ1nYrELuvyV-n2CdkfsOrK9CmPCHbdQ31vrEoMXFflqqZmH66MajOlINKncaZxHUNnO8DhQNgvfKnd-uwNoojs4fvkBkohcTV7tdLEoei_ZzQuZdu29E6c3DypXr5Gr3ssXUJIlHg1uPiZwADE9PczETn3P9OikBytSQVywvkwjiFn9EGPolHCZ-pP8K7tLg9U_0m4gzOfPagGCOk7Rra3NhqkXJvewj-rFkclMOB8kRa815oQlpmk2TW8fwVGu-WN8Y2SaYoYipfBoiElrt5MTcahWcec7VuOtAl85IRfGwz4k11LL485t1uH1GbvVC8YzFtynR_w.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTGIGGYWIS>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTGIGGYWIS>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

