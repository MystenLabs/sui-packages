module 0x6e2f29a5eaf8809d177953e18a25a14e0a145361d64685c562172e1f4783e2df::gtaverify {
    struct GTAVERIFY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTAVERIFY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTAVERIFY>(arg0, 9, 0x1::string::utf8(b"GTAVERIFY"), 0x1::string::utf8(b"airtx"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn1.telesco.pe/file/c6pAcENqLVmnyhjzsLtc7ArAA4PAXT2P8BpqaPOHvfTRcmseizot37COwl7P0_-JsCEznqDs1-qX8hvvCeZ4-j9U1YhgS3L8grK37CTNg8l72XcPv_CATl7E87Nd9FFeRE9BZxG_icetS15hjGcNBMFLe450BgahOCnhGBHcNftqMvgXE6vOEIlc1oaPvQU6I5QiEBGIeSTwfP7x79XoScUfRazse2R0U8ARD-4lhmDYrrqEI6MSOuAMxLzfKg_lkiLofBf4Ay78wo9KP3x1F8ZXtNOGPPvwh1yKfz5rqK10XWjkBPCdQogxVyhzqx1fnFflH4TcJkBmGimqysFjFQ.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTAVERIFY>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTAVERIFY>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

