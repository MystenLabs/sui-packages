module 0x3cbaa745c40b33c246b224059529a9797f7946b63d100dbe8264b1383cea3774::b_stood {
    struct B_STOOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_STOOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_STOOD>(arg0, 9, b"bSTOOD", b"bToken STOOD", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_STOOD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_STOOD>>(v1);
    }

    // decompiled from Move bytecode v6
}

