module 0x860db1c5cc3cd255898ba373c9b5c5560d1fcb85f71a7f9803243e392980de6f::gtadadaxcv {
    struct GTADADAXCV has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTADADAXCV, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTADADAXCV>(arg0, 9, 0x1::string::utf8(b"GTADADAXCV"), 0x1::string::utf8(b"jose"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/kAa_eKCzbgKXgqD9BFo5yySjhNkrKjZodEr3ArBBVlcRYs3vaWgB-2gvHaFJNXfQlosO1MPB1Y1HdY3hC0ZmcTOQTz8tUTJGN66ihQ3-527vaC7CWjnmzVlkCS31PEZHddaYTELsa2jbxKjtqbr_1dqiAPq7SkHDLYLzdvoAknO9CKIcJ2e00eBOuNV1Ic1tjN5sHmkCgR_lBNiDyxKxFIZjzLtOI5wq5-vE0juymdpEhmJ_xy__wSBm_8yHIxjanaPHo9N-K51s-O5u0XmF9EsbnjE57TXyn_zSqdruv30_UXCpn6wjMQIMxSAAiUv7oKrgb_J-RK6jFJGJvSZ7Pw.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTADADAXCV>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTADADAXCV>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

