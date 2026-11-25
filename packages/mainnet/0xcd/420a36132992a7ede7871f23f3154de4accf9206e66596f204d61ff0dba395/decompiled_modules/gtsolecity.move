module 0xcd420a36132992a7ede7871f23f3154de4accf9206e66596f204d61ff0dba395::gtsolecity {
    struct GTSOLECITY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTSOLECITY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTSOLECITY>(arg0, 9, 0x1::string::utf8(b"GTSOLECITY"), 0x1::string::utf8(b"solecity"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn1.telesco.pe/file/bg7lni-UKvgTQfQB2yPp_2HKUXCH7eQAIsCQfILIclM9GgV_-ToCuRElhmI7DepngKwB1sWaU0UadYoOWyNeEt2tffCqsWfPc0HSH2aPwupdSdnfjvMuHZv6HqiZCP-WEYDDnLuu_xuwvSC5q-Wv_we7JNq2oyW0GLH0i00l27xZQVvk3RWDbcI9DgwhwpbmRegYl3WeE7D0J5JuAHFc8Ft9wycAqXqPmtpg6rdAipBnduGRwKsbFqPkKnTMhAT4vMhDutCUKtquf0tgu_J4rHuQE2SFMUti8ifY3ysozKdTw1-J_h3xJVKkECqdrpSe4JDg9l-zra7U65nU-nG-wQ.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTSOLECITY>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTSOLECITY>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

