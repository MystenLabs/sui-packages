module 0x3070afb3b97ca944727dd291328eb67c580428e883aead75ef82d5b17b401daa::kentoo {
    struct KENTOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: KENTOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KENTOO>(arg0, 6, b"KENTOO", b"KENTO", b"KENTOOOO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Copy_of_0xe3360ed65e5e6c1d584647d02333aead5942357502574654c266d83cf8c455a0towel_TOWEL_200_x_200_px_500_x_500_px_65b5a4393a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KENTOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KENTOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

