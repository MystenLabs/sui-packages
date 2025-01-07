module 0xd2ce54f75296f33138fc26c14702a7892e066c8294488886cb95f6cb5221c491::owo {
    struct OWO has drop {
        dummy_field: bool,
    }

    fun init(arg0: OWO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OWO>(arg0, 6, b"OwO", b"owo cat", b"cute cat on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_07_08_01_16_14_a7723991dd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OWO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OWO>>(v1);
    }

    // decompiled from Move bytecode v6
}

