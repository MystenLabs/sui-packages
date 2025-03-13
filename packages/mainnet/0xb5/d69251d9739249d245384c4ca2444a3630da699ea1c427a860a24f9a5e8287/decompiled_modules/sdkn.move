module 0xb5d69251d9739249d245384c4ca2444a3630da699ea1c427a860a24f9a5e8287::sdkn {
    struct SDKN has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SDKN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::total_supply<SDKN>(arg0) + arg1 <= 290000000000, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<SDKN>>(0x2::coin::mint<SDKN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: SDKN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDKN>(arg0, 6, b"SDKN", b"SDKN", b"SDKN Token on Sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://archive.cetus.zone/assets/image/sui/moverUSD.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<SDKN>>(0x2::coin::mint<SDKN>(&mut v2, 290000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDKN>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SDKN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

