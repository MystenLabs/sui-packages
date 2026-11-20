module 0x616b539f77d1701ce102d605aee6c98abc62ecd810408b4c932b0d169ce3271b::khers {
    struct KHERS has drop {
        dummy_field: bool,
    }

    fun init(arg0: KHERS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"9643d7d5523535718b8c5347d2073433372483ee9f835b2f162392429b8580c7")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"9643d7d5523535718b8c5347d2073433372483ee9f835b2f162392429b8580c7"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<KHERS>(arg0, 9, 0x1::string::utf8(b"KHERS"), 0x1::string::utf8(b"Flying Khers"), 0x1::string::utf8(x"4465736372697074696f6e3a204b68657273206d65616e732027626561722720696e205065727369616e2c20616e642074686973206f6e6520666c6965732e2041206d656d65636f696e206f6e2053756920666f722065766572796f6e652077686f207375727669766564207468652062656172206d61726b65742e204e6f20726f61646d61702c206e6f2070726f6d697365732e204a757374206120666c79696e6720626561722e20f09f90bb"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/60e2389281706da0f42f6fed1049705c91f973e9287ec19de9de47f88c26f455.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<KHERS>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<KHERS>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

