module 0x7a72d05d37bb9d7cf00b51870848b5ecb1b0dc1b00112e9d95fd407f8169cf9f::gtivanfyj {
    struct GTIVANFYJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTIVANFYJ, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTIVANFYJ>(arg0, 9, 0x1::string::utf8(b"GTIVANFYJ"), 0x1::string::utf8(b"Ivan Daniel"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/iBKn6eljdmA7umLUdUbr4DS1by_94Dq0nPIpi6Qk_GmNZh2V91_gjHN-dw7q1NEQ5CEyblfPUMij7AI38kVFiGcY6tfYvXeu7f6yCUOXj3q1yW2jR5vv8MpgnszQF9Atf8etQeWZrB-d7f7KWPTZW41rdQ9NNAjYro00qZykOIXJEU5a9ySvEBfdkjLcFrqVkrarMAdFjw1q9rIpygj37b2ut6w7THKtLXXcXng8LVvp3ERIvg8ouU2ykXibPuFl64uRXZORqCyV-TsPse3gYWAGHdEd4fGXugGZlMeJI8538Xr1X9a7l3HSG0GFUc2FjO_Xjat6zF_Hkg_4wF8WIQ.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTIVANFYJ>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTIVANFYJ>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

