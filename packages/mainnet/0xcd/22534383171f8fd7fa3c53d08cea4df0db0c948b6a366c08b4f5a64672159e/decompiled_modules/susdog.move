module 0xcd22534383171f8fd7fa3c53d08cea4df0db0c948b6a366c08b4f5a64672159e::susdog {
    struct SUSDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUSDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUSDOG>(arg0, 6, b"SUSDOG", b"Susdog Sui", b"https://t.me/susdog_sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000416_4540388ed4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUSDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUSDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

