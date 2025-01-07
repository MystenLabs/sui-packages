module 0xd3ab386531d5a49acceb115c38b6a227ab17b572d295a41f5daf3f9bf66630b8::horin {
    struct HORIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: HORIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HORIN>(arg0, 6, b"HORIN", b"Sui Horin", b"Horin, or \"Halloween Torin,\" brings a haunting twist to Tesla's mascot, Torin, by merging it with Halloween's eerie spirit", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000002865_1f325be9d5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HORIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HORIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

