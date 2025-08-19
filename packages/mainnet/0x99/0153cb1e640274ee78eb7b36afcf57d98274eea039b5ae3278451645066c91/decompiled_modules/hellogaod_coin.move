module 0x990153cb1e640274ee78eb7b36afcf57d98274eea039b5ae3278451645066c91::hellogaod_coin {
    struct HELLOGAOD_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<HELLOGAOD_COIN>, arg1: 0x2::coin::Coin<HELLOGAOD_COIN>) {
        0x2::coin::burn<HELLOGAOD_COIN>(arg0, arg1);
    }

    fun init(arg0: HELLOGAOD_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HELLOGAOD_COIN>(arg0, 9, b"HELLOGAOD", b"HELLOGAOD_COIN", b"HelloGaod Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://q3.itc.cn/images01/20250220/bd7183642f8a4f6285c9defb7f6bd409.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HELLOGAOD_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HELLOGAOD_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<HELLOGAOD_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<HELLOGAOD_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

