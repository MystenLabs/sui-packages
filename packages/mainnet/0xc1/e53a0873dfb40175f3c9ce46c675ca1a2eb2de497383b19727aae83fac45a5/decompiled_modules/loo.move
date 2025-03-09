module 0xc1e53a0873dfb40175f3c9ce46c675ca1a2eb2de497383b19727aae83fac45a5::loo {
    struct LOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOO>(arg0, 9, b"LOO", b"lolcoin", b"just for vibes ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/1a15eb59a0da10a39602f403e005a52cblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LOO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

