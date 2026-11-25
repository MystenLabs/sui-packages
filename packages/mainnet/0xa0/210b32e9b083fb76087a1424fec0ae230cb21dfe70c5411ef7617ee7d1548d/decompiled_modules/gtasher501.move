module 0xa0210b32e9b083fb76087a1424fec0ae230cb21dfe70c5411ef7617ee7d1548d::gtasher501 {
    struct GTASHER501 has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTASHER501, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTASHER501>(arg0, 9, 0x1::string::utf8(b"GTASHER501"), 0x1::string::utf8(b"Asher"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/ohIXKqs6qMxXDw3k2ejEP71P9Y4TqwMjnSvxE69TIliD42d9vBFoTyUueETWoaqaZGpl126jDVQO4qqSIV01ehrs-5V6NebewhURs5BxKVkIO4FrGwbNAh7MmNWzsoNgAHEwopiW4DY9_8Vw98XQ792UygPdxnsht4NyiSjLtDi9bm4Zsrc6Smnil1fPvPeh_UjkotM-r69PeQBClKuckk3iWrUph_VR-R-28rdXkfaeOHkCLmiroOoCS0N9VDnh2C8mSYMT_iKyX_HqqyErOjRDZTqIs_NwGJsKPsMLINf9DrzYQpUR4F6eEYFGVfpXTBnCk3x0wgLZTiknO123hQ.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTASHER501>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTASHER501>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

