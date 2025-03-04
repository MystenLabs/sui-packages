module 0x466338fc5eee1ed889df33485fb2cf6b272cb6033e906bcf1ac71502e7ad31ed::minghuichou_coin {
    struct MINGHUICHOU_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<MINGHUICHOU_COIN>, arg1: 0x2::coin::Coin<MINGHUICHOU_COIN>) {
        0x2::coin::burn<MINGHUICHOU_COIN>(arg0, arg1);
    }

    fun init(arg0: MINGHUICHOU_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MINGHUICHOU_COIN>(arg0, 9, b"MINGHUICHOU", b"MINGHUICHOU_COIN", b"MINGHUICHOU Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/129301868?s=400&v=4")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MINGHUICHOU_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MINGHUICHOU_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MINGHUICHOU_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MINGHUICHOU_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

