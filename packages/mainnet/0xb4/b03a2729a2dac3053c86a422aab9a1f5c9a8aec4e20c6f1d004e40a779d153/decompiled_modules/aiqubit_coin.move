module 0xb4b03a2729a2dac3053c86a422aab9a1f5c9a8aec4e20c6f1d004e40a779d153::aiqubit_coin {
    struct AIQUBIT_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<AIQUBIT_COIN>, arg1: 0x2::coin::Coin<AIQUBIT_COIN>) {
        0x2::coin::burn<AIQUBIT_COIN>(arg0, arg1);
    }

    fun init(arg0: AIQUBIT_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIQUBIT_COIN>(arg0, 9, b"AIQC", b"AIQUBIT_COIN", b"Don't ask why", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/35585232?v=4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIQUBIT_COIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AIQUBIT_COIN>>(v1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<AIQUBIT_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<AIQUBIT_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

