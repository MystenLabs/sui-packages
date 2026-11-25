module 0xc922bd04a45a9fc26e5fb1d604666cd9b405b677cc770db22681ebb4b9646271::gtminionsu {
    struct GTMINIONSU has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTMINIONSU, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTMINIONSU>(arg0, 9, 0x1::string::utf8(b"GTMINIONSU"), 0x1::string::utf8(b"minion.sui"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/Cj5g8AZ3OXlRulJEkdxzA8Z8BygQdHNytRvRNa4q2_4-tcUkKjT2xAb5-o8cRJVUfw5fzeD212oI2icxmqFfKB-GXikYbMOzO9hl0YcP8ATwFYzxsLUuNS0lvwHp2lCdCxchMKitYC9Y2wYN_Ke7BOo4sbU9XeKWDuh3eL6dIdhThLLgiDQhXN1GSLSOu8HWeOPY-n-e4mDbBLgyoHDcuWfe2PAVkJOlrQIGuTSN_jcNuWrYjBjvUPKUz3yzDBRzuqIB6aVXtoSdLWy9NSe5LtSTNH_nhbcxSKB6tWsmcrjE3cRpiFd4D2yabZLfU50X4DDdA2VlmaCfOHeo_oFI9w.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTMINIONSU>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTMINIONSU>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

