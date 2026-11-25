module 0xdabdad99ad958b6a3c9ec0b21dff174396fcedd3fc2aa00b0ab670609e185c8e::gtbotionsu {
    struct GTBOTIONSU has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTBOTIONSU, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTBOTIONSU>(arg0, 9, 0x1::string::utf8(b"GTBOTIONSU"), 0x1::string::utf8(b"Boti"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/GkxeDn5Sk-lLy-Yn2Fk7KzKYGg7uliOL4T6W6meXfaPJZrQQB45FmTO1gINjfOke-BwnKpSYkb0RU2g1n5uI1OSO1N0zir4xHUNO43FQVRTvFpQziK1E51yAi7mw1HoiQc-SklfowyY0NyHhCjHHDMqIZyAUltLYDduLLzef6Ju40IJIVNiaTARrWzumOSZ_AEIFze4-Dubgx8tMx7Sz4UflJoPXOHXnLN-Jw-RPVJwJ-KsK6s1_-MHDpTqDGbZi_ZBD3_3S7JCUzfTof6JKgokO124yRPwbDNwpn10vV5b1Tlgkkd-Kx8YnmMtot4T9rH0bMDQ_QEv50bFqKq4w3A.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTBOTIONSU>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTBOTIONSU>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

