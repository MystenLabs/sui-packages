module 0x2a026f49f2b5b8e771b0ed22d8f2a8d2c3312409c04c37dc340c0112ce64432a::fb {
    struct FB has drop {
        dummy_field: bool,
    }

    fun init(arg0: FB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FB>(arg0, 6, b"Fb", b"fat boy", b"save money for weightloss", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731023487798.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

