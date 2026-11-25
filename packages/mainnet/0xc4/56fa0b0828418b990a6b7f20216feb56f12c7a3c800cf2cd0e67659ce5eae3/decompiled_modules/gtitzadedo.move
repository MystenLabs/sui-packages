module 0xc456fa0b0828418b990a6b7f20216feb56f12c7a3c800cf2cd0e67659ce5eae3::gtitzadedo {
    struct GTITZADEDO has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTITZADEDO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTITZADEDO>(arg0, 9, 0x1::string::utf8(b"GTITZADEDO"), 0x1::string::utf8(b"ADEKRYPT_S.O.G"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/nVEOTy-xGaH_BVDb8447TWYsDo7F2ZrAbBC4knqQ8K26eUuiDYdgtBwCYM8xVjhPL6929K523ZSDcOGZqSHJeUjg3ZIipxNg0nW9-rYt_fxJJ3iHlH1_U0JrrqyCyGVH3-AKpVK33-hMxbwHTPrheK8m3-0Rqc6Mqgm4Jwk_iyROuUrS23ilAWi862JEbyI6k-IYcllixvWsjg3hvxMAfNuO18vN0i24SfeJ46YS-pD_u33gok6DIYz1zagcqXAbYd5TaBGfL7T3Zv4f-DIJISrB0u50fTiuPZtmzf0cBBZf28EyBpwYj18oYLLtki8I_PlYirYLp_02RZiYPj7ZVQ.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTITZADEDO>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTITZADEDO>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

