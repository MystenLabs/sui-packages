module 0xf52cb81aeb0aa35ec076d48f86479971ab2f1c9f8e569994b6055e115f09245::julieeking_coin {
    struct JULIEEKING_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<JULIEEKING_COIN>, arg1: 0x2::coin::Coin<JULIEEKING_COIN>) {
        0x2::coin::burn<JULIEEKING_COIN>(arg0, arg1);
    }

    fun init(arg0: JULIEEKING_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JULIEEKING_COIN>(arg0, 9, b"JULIEEKING_COIN", b"JULIEEKING_COIN", b"coin create by mqh", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/168746609?v=4")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JULIEEKING_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JULIEEKING_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<JULIEEKING_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<JULIEEKING_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

