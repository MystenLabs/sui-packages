module 0xa394cb974007611b90f2382a39d10b3cd0eb8efef9bf54d45fcb65c94288725a::gtixwilson {
    struct GTIXWILSON has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTIXWILSON, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTIXWILSON>(arg0, 9, 0x1::string::utf8(b"GTIXWILSON"), 0x1::string::utf8(b"Wilson"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/Alk28SnrlpLQH2aRGgr8V-J290PTeGS47293zYWD5VT8CmFm5PjmUPYWs6mOFDa76fsgYRU11jr-Xmhk2EV9K49Afu3rs-OfrPiHzIYSFyldVMXlquGh6HhjWXxV_I6OPHf7dtPzi67Qp-Eq1ps6wQy-xPaemy5mdgo_4t4KYZ_6yEPMuVxgSIgcsJS62O3t6k9dBvBLpwIXNMIe-bXsOGE-J-X1H5pjB0XF_4Z3ToS4u7lzQSw1i2PCS4YAvr71VKcDfbS8i2RW0p7XA6qpachm9SxJmD0e2W9bWVItjt4FT8vt6k2-XcPnyol_29zw1tZ68vCR_nACS-o7r7VYKw.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTIXWILSON>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTIXWILSON>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

