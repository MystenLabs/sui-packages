module 0x17c323254035158aa0a4c00ae1769ceea826ddd39b5728ec2d5a5abd63b652d2::gtluaradic {
    struct GTLUARADIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTLUARADIC, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTLUARADIC>(arg0, 9, 0x1::string::utf8(b"GTLUARADIC"), 0x1::string::utf8(b"Shinobi"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/KIpGnoUZK5mS3ZOXoehqSR44NMpnBdchmtVf7b6zfyBvZDp0GofWHIZ4TrWpG3zrCv90C5RdjcJFKU3riSct3ViYl-g6kPzSCbSBcZaLm6wyfRT03qef5aMNvlUlq_nVCo5MjGQBQUnww6-21UAwR7RwRcKPPuha6sWTSHdpfG-urrMUIL1c1tmbVYBh_hReimQwEAPMtDtJblxqZsFpDwBmIh4LyhfQ1pHOJaM3jR8TZH_HmI6sBCxBjHhABN4E5MWZi5X8Ljs095a29C_j_-GmWjLQandx_myvgC3k6SfRfA3_wsnLZhaAZ06BnbhsAQTKg154sE3FXZTZwFwwwg.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTLUARADIC>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTLUARADIC>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

