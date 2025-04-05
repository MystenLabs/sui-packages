module 0xfecdb6831b08e115ce606f7c2c98f2f7976e9a2c812291ee890d5a6dad581821::ttfk {
    struct TTFK has drop {
        dummy_field: bool,
    }

    fun init(arg0: TTFK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TTFK>(arg0, 9, b"TTfk", b"trh", b"catu", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/950a17d3c98978ae1a8aa3280e1a2e9fblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TTFK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TTFK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

