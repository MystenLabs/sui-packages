module 0x292d7c2913053b8d2ec1e103624af4df67fac6a516c49f824b42297bcc4a4613::faircoin {
    struct FAIRCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FAIRCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAIRCOIN>(arg0, 9, b"USDT ", b"Fair USD", b"Community token for fair distribution. All permissions renounced at deployment.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://uploader.irys.xyz/HiZKj8fYVf5VvDTywJQNMCLKSjAku7i2mq2innSLz5M7")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FAIRCOIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<FAIRCOIN>>(0x2::coin::mint<FAIRCOIN>(&mut v2, 34836901000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FAIRCOIN>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

