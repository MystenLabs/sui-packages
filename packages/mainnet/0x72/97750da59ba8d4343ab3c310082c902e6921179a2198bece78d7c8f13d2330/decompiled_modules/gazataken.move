module 0x7297750da59ba8d4343ab3c310082c902e6921179a2198bece78d7c8f13d2330::gazataken {
    struct GAZATAKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GAZATAKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GAZATAKEN>(arg0, 9, b"GAZATAKEN", b"CAN I TAKE GAZA", b"Whats up with that?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/b9a223996d92cb405b3a6d10b1a58d85blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GAZATAKEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GAZATAKEN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

