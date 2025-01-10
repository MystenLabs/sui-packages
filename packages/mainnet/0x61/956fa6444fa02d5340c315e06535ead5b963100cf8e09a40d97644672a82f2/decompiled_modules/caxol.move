module 0x61956fa6444fa02d5340c315e06535ead5b963100cf8e09a40d97644672a82f2::caxol {
    struct CAXOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAXOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAXOL>(arg0, 6, b"CAXOL", b"Cute Axol", b"Let go Cute Axol community. This meme is ours! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736498645004.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CAXOL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAXOL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

