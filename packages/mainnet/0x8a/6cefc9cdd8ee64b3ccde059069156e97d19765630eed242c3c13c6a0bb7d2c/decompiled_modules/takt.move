module 0x8a6cefc9cdd8ee64b3ccde059069156e97d19765630eed242c3c13c6a0bb7d2c::takt {
    struct TAKT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TAKT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TAKT>(arg0, 9, b"TAKT", b"takata12", b"FRom cLata ec", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/48e43fd7ddf66f6e39bdc8e7b93a36f1blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TAKT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TAKT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

