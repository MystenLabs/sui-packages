module 0x8646e7f398c7575ede981f651b1d104d812b53b70e83dd7c573f3f16612ac187::token_k {
    struct TOKEN_K has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOKEN_K, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOKEN_K>(arg0, 9, b"TKNK", b"TOKEN_K", b"Test token K", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://assets.coingecko.com/coins/images/1047/standard/sa9z79.png")), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<TOKEN_K>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOKEN_K>>(v1);
    }

    // decompiled from Move bytecode v6
}

