module 0x1107f833f81b3afcfe1ec793b0644013eb76ba01a774d82691a92e5847e1399d::soym {
    struct SOYM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOYM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOYM>(arg0, 9, b"SoyM", x"d4bb73f198a3ad3159697349", x"436a4460646631205927503b15450b3d47557b2d63202020315920daa126207d2020202d205d42202220202020e4bab42044262020202020202020202020e78885203159daba0a69202078207120203920202020641120207b713e776531597b7332cda17f162020202076c69ad58d541831592020da864028547b6904", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/e727d2194bc30ad6e4969e94e2479399blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SOYM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOYM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

