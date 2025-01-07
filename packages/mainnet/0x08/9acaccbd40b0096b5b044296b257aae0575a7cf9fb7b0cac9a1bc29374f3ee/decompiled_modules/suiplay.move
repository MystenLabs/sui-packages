module 0x89acaccbd40b0096b5b044296b257aae0575a7cf9fb7b0cac9a1bc29374f3ee::suiplay {
    struct SUIPLAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPLAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPLAY>(arg0, 6, b"SUIPLAY", b"0X1", b"Tribute Meme Coin of SUIPLAY0X1 Gaming Console", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Sui_Play0_X1_Symbol_Stroke_White_with_Gradient_BG_e4ef2fd41d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPLAY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPLAY>>(v1);
    }

    // decompiled from Move bytecode v6
}

