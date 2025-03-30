module 0xbd635efdef21439f48c730f07d363498cd4f6aecd0bc04817fad8e611f73a6f2::skr {
    struct SKR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKR>(arg0, 9, b"SKR", b"stalkerismo", b"OBLIVION at the end", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/cb31b39093221c3e3e863803cff0ea6ablob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SKR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

