module 0xdc5ffb703bebd9c820cef8286e3d6f1a3e7916f1087d5424e5dc19bf06df731f::mope {
    struct MOPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOPE>(arg0, 9, b"MOPE", b"Mogged Pepe", b"Most attractive and stylish frog on earth, Mogged Pepe $MOPE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/base/0xc77e54c9e73c6492d9c185f41583deee5b4d6ce8.png?size=xl&key=278a6d")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MOPE>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOPE>>(v2, @0x0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

