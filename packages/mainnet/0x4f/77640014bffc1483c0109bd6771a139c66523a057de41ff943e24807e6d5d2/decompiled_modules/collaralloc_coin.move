module 0x4f77640014bffc1483c0109bd6771a139c66523a057de41ff943e24807e6d5d2::collaralloc_coin {
    struct COLLARALLOC_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<COLLARALLOC_COIN>, arg1: 0x2::coin::Coin<COLLARALLOC_COIN>) {
        0x2::coin::burn<COLLARALLOC_COIN>(arg0, arg1);
    }

    fun init(arg0: COLLARALLOC_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COLLARALLOC_COIN>(arg0, 9, b"COLLARALLOC_COIN", b"collaralloc_coin", b"collaralloc coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/77825640?v=4")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COLLARALLOC_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COLLARALLOC_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<COLLARALLOC_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<COLLARALLOC_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

