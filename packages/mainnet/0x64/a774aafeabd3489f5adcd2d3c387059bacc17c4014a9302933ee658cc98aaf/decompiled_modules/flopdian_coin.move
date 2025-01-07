module 0x64a774aafeabd3489f5adcd2d3c387059bacc17c4014a9302933ee658cc98aaf::flopdian_coin {
    struct FLOPDIAN_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<FLOPDIAN_COIN>, arg1: 0x2::coin::Coin<FLOPDIAN_COIN>) {
        0x2::coin::burn<FLOPDIAN_COIN>(arg0, arg1);
    }

    fun init(arg0: FLOPDIAN_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLOPDIAN_COIN>(arg0, 9, b"FLOPDIAN_COIN", b"flopdian", b"virtual coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/167522723")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FLOPDIAN_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLOPDIAN_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<FLOPDIAN_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<FLOPDIAN_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

