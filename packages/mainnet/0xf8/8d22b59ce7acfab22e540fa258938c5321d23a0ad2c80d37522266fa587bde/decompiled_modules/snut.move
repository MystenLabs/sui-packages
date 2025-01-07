module 0xf88d22b59ce7acfab22e540fa258938c5321d23a0ad2c80d37522266fa587bde::snut {
    struct SNUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNUT>(arg0, 9, b"SNUT", b"Seanut - Arc On SUI", b"Not a copy, just thinking in simply net, it is what a catching vibe.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/213894e69999e2e5df3f034826b014b8blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SNUT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNUT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

