module 0x278e1d7b1dece251ec16bbf0529e21f16cd2717bcf61f03f6e8ab87eb1368739::gtx4dwin {
    struct GTX4DWIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTX4DWIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTX4DWIN>(arg0, 9, 0x1::string::utf8(b"GTX4DWIN"), 0x1::string::utf8(b"4dwin"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/MZwQU0ru5XzAKOgFTGiZ3_At8AiGlY1CFYBIcgJ2DcttAYSk06JTjdgqkPzLVh-hkEKvO4MhgKck1wuWAiLw7SMYImIwSgOSvqYwDjod8Hn5K-8jS2YzIsNGopvRIVj_TaScOdkw5vlNybgyiRYPPY1dood1zG7MSWgVqwimCdAfr_Tbc0fPJtWjZ86o9bywHOzbzzEMaa93WS-ssLij_FPRL9VypbO7kc4BNqAHY-PO2zHXgXv_aEYqOAd-IjlM4lywt4uHcFg5yeVxCEoOsQaQuXTsjda0i0UfDlMJvvEJOJ8402r0tOp3Dz0HayM-lQtnQT5GLarKG3aaadrOow.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTX4DWIN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTX4DWIN>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

