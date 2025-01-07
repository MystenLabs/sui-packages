module 0xd7413dbd9f6e0a7474c698a564214372e3b5317c78b9c9b8dcf245d8f28f3ff2::nowater {
    struct NOWATER has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOWATER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOWATER>(arg0, 6, b"NoWater", b"De_sSert", b"No H2O here . No pussies! Only Chads-Tg only", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_3eabbde768.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOWATER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NOWATER>>(v1);
    }

    // decompiled from Move bytecode v6
}

