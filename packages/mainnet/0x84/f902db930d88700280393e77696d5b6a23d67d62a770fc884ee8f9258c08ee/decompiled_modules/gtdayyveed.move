module 0x84f902db930d88700280393e77696d5b6a23d67d62a770fc884ee8f9258c08ee::gtdayyveed {
    struct GTDAYYVEED has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTDAYYVEED, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTDAYYVEED>(arg0, 9, 0x1::string::utf8(b"GTDAYYVEED"), 0x1::string::utf8(b"Dayveed.sui"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/Zx06kWhPFbJcTuZt6CPFpmh9gONWkY3Kqz7b_mgnjxu3E3XAiV8JYMtZRTi3vO-P79PB1ce6PS1GIn8afmbutfwn4V1KIkwcdALQiWw2qqK3CbVo30reo0s9ID7i-yTkZrdOsqEcePNvLRungLTK1OS62hBvFwBZYwLVou9svV8wSRS42azyNCAGVOrB237fb5AqF8AEY9Tos_4eLpcwLXvrmxmwsKmHjJK6MmRFMNgM0_5UnqoVoIHcyUoGQNQ0DayKFm0I8HyjFzbXDYBq0pywkFzOXWbpwpCuGAkR7ToPSjZ0esYPrl3GAW5GHoSPBRFKpEq2UlF06Mw6KKzNdw.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTDAYYVEED>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTDAYYVEED>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

