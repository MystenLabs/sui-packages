module 0x3b18ba280bae5d5d7b1e2fef8bbd5a105ea5f65ffaab35cd1ae8c12863d855c3::gtexcelcon {
    struct GTEXCELCON has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTEXCELCON, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTEXCELCON>(arg0, 9, 0x1::string::utf8(b"GTEXCELCON"), 0x1::string::utf8(b"ETH M"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/rtlqDFujHLiTMiBiuENRzqoc3_RE58h6lAQCDgS5UoT3pGIKsB6D96GvOTeC3TKkZ_KtHTT7YXl9lgd9cU80OREbJjmCL1VjYeq6ica43z9zPen9hBx9WB46WBaC1y1dM3cRU976lekF3w33rEp16hiXxVV1onid91ErDY2DtDQIjfz-FiOD7danLUwcXN-NTtzrKrSnJCtvOoY81YG4l2vu-Ogc7JgqK-AXt-oBie5XW3zK1GktNU93LVt4AjJXH7fPTuBjdghkVbksMp3EagtbSWPPc6zkRjlySikybrsSmX3awFgyvM79coTsAOEa5KCFYXTVH9jW0xaQkrLl0w.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTEXCELCON>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTEXCELCON>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

