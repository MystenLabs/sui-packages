module 0xedc502bbfbf6b9844685b833d4105fab5f644cdc2e32df47f94ffc8d89dc4725::gtvtnugrah {
    struct GTVTNUGRAH has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTVTNUGRAH, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTVTNUGRAH>(arg0, 9, 0x1::string::utf8(b"GTVTNUGRAH"), 0x1::string::utf8(x"4e75676d617878696e6720e5a4a2e789a9"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/fwe_VTT6dkjc5jSPkUWCKVf-3T97b2-RSmyCBfg-y2xLw4aoo-BO-Oof6ACGZZfHKzDAVigYvBmBXdl-YzjsDgCWtLmT_40SB5xuq6cpxbYMKCVsglJmlfqfAhv7dDcaENvlvnANBX9_8WfWr0yVYq1jaZg9ShOqPjz74y7D502qUlbo4MuZ8GHIjFUuyF6spIpe_ZNhiCDB_5CAc13ZSjJS67CDTna1r-mlLTHAQmBlrw_OO1Uw4m3UJ2X00yvlxvlx6NE2Lb-Zf-NcV5WPh2UW-8ITxNMOs1bFVJ_cRh6TjtYqquTHaSjmmyju8GQqT9ZL80kIH266_xO36PgzAg.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTVTNUGRAH>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTVTNUGRAH>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

