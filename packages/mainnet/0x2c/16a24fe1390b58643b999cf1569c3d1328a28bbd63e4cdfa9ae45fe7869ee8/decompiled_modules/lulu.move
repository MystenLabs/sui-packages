module 0x2c16a24fe1390b58643b999cf1569c3d1328a28bbd63e4cdfa9ae45fe7869ee8::lulu {
    struct LULU has drop {
        dummy_field: bool,
    }

    fun init(arg0: LULU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LULU>(arg0, 6, b"LULU", b"LULU rich Dog", b"\"Lulu Rich Dog\" is a humorous meme project centered around the extravagant and absurdly lavish lifestyle of a fictional dog named Lulu. This spoiled canine enjoys all the luxuries", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735915279273.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LULU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LULU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

