module 0x4763d99ca910aa0eb255d02ed3166696fa6e2b6f9bf039653efbc2cb1549a6ae::drop_coin {
    struct DROP_COIN has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<DROP_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<DROP_COIN>>(0x2::coin::mint<DROP_COIN>(arg0, arg1 * 1000000000, arg3), arg2);
    }

    fun init(arg0: DROP_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DROP_COIN>(arg0, 9, b"TMPL", b"Template Coin", b"Template Coin Description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dropkit.wtf/images/default-coin-image.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DROP_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DROP_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

