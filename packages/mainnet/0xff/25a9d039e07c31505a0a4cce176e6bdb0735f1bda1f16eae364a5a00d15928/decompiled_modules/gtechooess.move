module 0xff25a9d039e07c31505a0a4cce176e6bdb0735f1bda1f16eae364a5a00d15928::gtechooess {
    struct GTECHOOESS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTECHOOESS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTECHOOESS>(arg0, 9, 0x1::string::utf8(b"GTECHOOESS"), 0x1::string::utf8(b"echo es"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/YsidH_kJaBBNHB1dsyTqSIq9uYRJxaHF2BBX_rucTCILs9vpg-PCHhHNQ1yVZ-oQHts0GPaViiWNV5LT83G_TsBf4zC4BLBc52GbR_JpzcA4dIhqDqK0NIYikxqS6GCSoqGrNLwC5jE902aQ7DdL5Ip2DbsiI0w0e1Ggrb5js7DNRqfqoinhNCMWCaPaC-cP7xI6G0cjtQjL6aaXAkTwTPi00bSfSYknFMzNN85DNgAYhM39V8fr1cl4AOjnSZQAHGBkBIArdDFbHwCjs1wqP07LXeMUV1n6WV3epIbuqkqLwYp8IMG3xbewitm7dq2n8wAhAWQ2Fqzb77AXr48eUg.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTECHOOESS>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTECHOOESS>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

