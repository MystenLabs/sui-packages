module 0x29a7fad697015efb15322da972becf7adda7d67aefcdfb6594e05127a680b81d::xsui {
    struct XSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: XSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XSUI>(arg0, 9, b"XSUI", b"X sui", b"Next stage SUI token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/511acb3e8d0a8befcf78859e87ee22d8blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

