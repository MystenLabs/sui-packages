module 0xff293166bbdee86bfb6d72e66e0d2e2d0d6381bf52c803892e532bb5a6d60ae9::spp {
    struct SPP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPP>(arg0, 6, b"SPP", b"Test SPP", b"tesst", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1765765034678.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

