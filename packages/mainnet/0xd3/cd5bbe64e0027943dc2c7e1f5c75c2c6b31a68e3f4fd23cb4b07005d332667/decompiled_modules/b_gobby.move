module 0xd3cd5bbe64e0027943dc2c7e1f5c75c2c6b31a68e3f4fd23cb4b07005d332667::b_gobby {
    struct B_GOBBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_GOBBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_GOBBY>(arg0, 9, b"bGOBBY", b"bToken GOBBY", b"bToken for GOBBY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"ICON_URL_PLACEHOLDER")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_GOBBY>>(v0, @0x54d8f987d3d74ef971bc63538b70d0ce4591772d8118b37f03a5373b84a77ec5);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<B_GOBBY>>(v1, @0x54d8f987d3d74ef971bc63538b70d0ce4591772d8118b37f03a5373b84a77ec5);
    }

    // decompiled from Move bytecode v6
}

