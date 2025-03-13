module 0x5c6d5739ac03c13d4986671f160dfed00ac9416f15cc9dbcfd30acff3fe1026e::token_d {
    struct TOKEN_D has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOKEN_D, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOKEN_D>(arg0, 9, b"TKND", b"TOKEN_D", b"Test token D", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://assets.coingecko.com/coins/images/5/standard/dogecoin.png")), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<TOKEN_D>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOKEN_D>>(v1);
    }

    // decompiled from Move bytecode v6
}

