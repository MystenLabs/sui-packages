module 0xbf389fc7e4d0794235f9b3155de10fc39b755af96be8a924365cb29f6a036125::koji {
    struct KOJI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOJI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOJI>(arg0, 6, b"KOJI", b"KOJI DOG", b"The Most Famous AI DOG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3cats_70a10a53e0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOJI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KOJI>>(v1);
    }

    // decompiled from Move bytecode v6
}

