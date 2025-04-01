module 0x998b3ac29824ead9cd1668006c1e8b63b8db3830f8a95dade87c3d9d45b4dca8::sofa111 {
    struct SOFA111 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOFA111, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOFA111>(arg0, 9, b"Sofa111", b"sofa", b"Mause", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/522cae6cd1351431e4123b56e0c50dfcblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SOFA111>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOFA111>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

