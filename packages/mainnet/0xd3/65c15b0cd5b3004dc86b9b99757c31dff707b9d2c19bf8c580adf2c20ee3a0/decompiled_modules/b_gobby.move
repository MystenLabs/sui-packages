module 0xd365c15b0cd5b3004dc86b9b99757c31dff707b9d2c19bf8c580adf2c20ee3a0::b_gobby {
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

