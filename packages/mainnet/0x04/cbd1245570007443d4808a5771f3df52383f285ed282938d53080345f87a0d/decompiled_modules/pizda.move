module 0x4cbd1245570007443d4808a5771f3df52383f285ed282938d53080345f87a0d::pizda {
    struct PIZDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIZDA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIZDA>(arg0, 9, b"PIZDA", b"PIZDA", b"PIZDA", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PIZDA>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIZDA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIZDA>>(v1);
    }

    // decompiled from Move bytecode v6
}

