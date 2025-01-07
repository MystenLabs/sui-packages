module 0xd06085eb8d742eaf602d5b4b7fd83adc9d3a6cbef398da3b6d686658b937dbe7::updog {
    struct UPDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: UPDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UPDOG>(arg0, 6, b"UPDOG", b"What's Updog", x"576f6f6620576f6f6620576527766520666f756e6420746865207570646f67200a0a4e6f20736f6369616c732073656e642069742074686520776966206f6620737569", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0081_a88c2b9320.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UPDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UPDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

