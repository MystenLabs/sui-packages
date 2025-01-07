module 0xb8261e87fdb6e1b6245cb29a8875f7e4caaea0fd7ba6d602f080793efb1a07d5::acd {
    struct ACD has drop {
        dummy_field: bool,
    }

    fun init(arg0: ACD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ACD>(arg0, 6, b"ACD", b"Acid", b"This acid dog is design to bring vibrance and joy to sui ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0055_5d87f61027.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ACD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ACD>>(v1);
    }

    // decompiled from Move bytecode v6
}

