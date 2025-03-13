module 0x6c9d224fe9a8dcb4b7a0fe1afed4993303c2f0f6464aae271435db03186fd9d0::sqr {
    struct SQR has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SQR>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::total_supply<SQR>(arg0) + arg1 <= 290000000000, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<SQR>>(0x2::coin::mint<SQR>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: SQR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQR>(arg0, 6, b"SQR", b"SQR", b"SQR Token on Sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://archive.cetus.zone/assets/image/sui/moverUSD.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<SQR>>(0x2::coin::mint<SQR>(&mut v2, 290000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQR>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SQR>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

