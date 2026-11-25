module 0xf6f6ad7e195ed9b34cb36dd50b2712bcad1b72e4f896dfff796f109425c189a5::gtchartsli {
    struct GTCHARTSLI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTCHARTSLI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTCHARTSLI>(arg0, 9, 0x1::string::utf8(b"GTCHARTSLI"), 0x1::string::utf8(b"Sherlock"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/PvBSqzGyx5r3cP0dHFtt7kzhEfjwovnujcggkQr6FCWgKK5ibvqhHUtUVlMrFk_MLv_KyapCykOMgFmFrIobODHJp1L2q0QDwdUUjNdQn34WXHc8Jpsd74XvxYFUkjLoMsdJa_ZrLyweM02_8nlcrAzb0eMiOQS1yqOTc8iwOhgEMhCRuFbi5v104YOMDUv_Wm_jTl30Zoa3gpfhuso1Z5vpR9UGkjk7d68LI2P-d8i7SxX-hZoe-JgyJLyFYr5UzjlkURpVQsyp4BpeEdhGXsraLjIrbXO8Ex7VNDYUo9BOYD_fLfAG-Om5iHtb_IwxZt7CdXnePjjuvlgiCsJhXw.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTCHARTSLI>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTCHARTSLI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

