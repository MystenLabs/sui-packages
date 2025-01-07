module 0x87091641c8ce2bb1123acab0d02ff6664c677d4c2c9759db1011e8075f973f16::losui {
    struct LOSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOSUI>(arg0, 9, b"LOSui", b"Lucky one", b"A Lucky Drop", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/33f6b7a1bb11db2ae62206e0ea5e4b54blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LOSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

