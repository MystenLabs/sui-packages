module 0x51ffa39734b5ddef4f6c8d382a9db1c9a0cfea3b06dd7dec531762e663ed8813::sblue {
    struct SBLUE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBLUE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBLUE>(arg0, 6, b"SBLUE", b"SUIBLUE", b"SUIBLUEEEEEEEEEEEE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/funny_dino_meme_trex_tshirt_party_gift_womens_premium_sweatshirt_22855efc45.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBLUE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBLUE>>(v1);
    }

    // decompiled from Move bytecode v6
}

