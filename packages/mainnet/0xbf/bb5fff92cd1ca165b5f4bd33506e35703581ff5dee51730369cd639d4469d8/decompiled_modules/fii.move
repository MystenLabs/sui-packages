module 0xbfbb5fff92cd1ca165b5f4bd33506e35703581ff5dee51730369cd639d4469d8::fii {
    struct FII has drop {
        dummy_field: bool,
    }

    fun init(arg0: FII, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FII>(arg0, 6, b"Fii", b"Fii swap", b"Welcome to Fii family ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000020425_d650b9249d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FII>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FII>>(v1);
    }

    // decompiled from Move bytecode v6
}

