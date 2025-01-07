module 0x7d1eb3221f7089b4dd36da732aea02e79ff7bc105f26d7b1ffccba767343fb6c::bee {
    struct BEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEE>(arg0, 9, b"BEE", b"BEE SUI", b"Super bee best token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/9946cdf47d22e4f2b1b0e4cd1afe39f6blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BEE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

