module 0xde81a5ff05cd8821b1a965f685cd649035d95b1e8dabf1f2890595fef556c28a::gtrolodots {
    struct GTROLODOTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTROLODOTS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTROLODOTS>(arg0, 9, 0x1::string::utf8(b"GTROLODOTS"), 0x1::string::utf8(b"0xrolo.69"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/P0lxmbJKnAsT4fDmbFI8qraCue-jaPPtx6BVhLlsyCVhtBy3EV8k4t3q_IbMQaJhbsuJBhH2NC5zThUGaXyRqwQxmL3Cbawz7OFGuaQQoZgX0nv5RphZncSBJewPJR2m2DvrU8wcnyUZXLuYOS6TSJsraHFQOAmhnYzegHsWyfJFJcLJR1CY5gbzW8OnHzXHE3Wb_TVwV9_i3D_8qZO0HwDSpTE9zpzniMtFDr0WDAt8-BqdLppBnRKTjxsifatNgp_3ZrO-DVa_lhM9lSufqF0N_2CDYtld4wmuvL5sDWl0GAbJWlmdAbume6qdyv2LWxaXcinaXIoBTBTFP1APPg.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTROLODOTS>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTROLODOTS>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

