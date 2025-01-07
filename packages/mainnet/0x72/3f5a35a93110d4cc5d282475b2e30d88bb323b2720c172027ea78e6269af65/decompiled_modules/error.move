module 0x723f5a35a93110d4cc5d282475b2e30d88bb323b2720c172027ea78e6269af65::error {
    struct ERROR has drop {
        dummy_field: bool,
    }

    fun init(arg0: ERROR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ERROR>(arg0, 6, b"Error", b"Error on sui", b"website and social networks coming soon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/images_2_9516dc9e0a.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ERROR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ERROR>>(v1);
    }

    // decompiled from Move bytecode v6
}

