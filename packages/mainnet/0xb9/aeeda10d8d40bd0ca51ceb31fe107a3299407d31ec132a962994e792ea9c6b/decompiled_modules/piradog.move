module 0xb9aeeda10d8d40bd0ca51ceb31fe107a3299407d31ec132a962994e792ea9c6b::piradog {
    struct PIRADOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIRADOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIRADOG>(arg0, 6, b"PIRADOG", b"Pirate Dog", b"Cute and brave dog is ready to shake up the ocean, equipped with natural skills and strength he is ready to make waves", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20250503_220251_55794b4f59.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIRADOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIRADOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

