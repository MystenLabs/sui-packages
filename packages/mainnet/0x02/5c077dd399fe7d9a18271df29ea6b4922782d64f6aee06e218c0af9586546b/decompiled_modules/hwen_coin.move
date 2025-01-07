module 0x25c077dd399fe7d9a18271df29ea6b4922782d64f6aee06e218c0af9586546b::hwen_coin {
    struct HWEN_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<HWEN_COIN>, arg1: 0x2::coin::Coin<HWEN_COIN>) {
        0x2::coin::burn<HWEN_COIN>(arg0, arg1);
    }

    fun init(arg0: HWEN_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HWEN_COIN>(arg0, 9, b"HWEN", b"HWEN_COIN", b"HWEN Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/76983474")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HWEN_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HWEN_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<HWEN_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<HWEN_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

