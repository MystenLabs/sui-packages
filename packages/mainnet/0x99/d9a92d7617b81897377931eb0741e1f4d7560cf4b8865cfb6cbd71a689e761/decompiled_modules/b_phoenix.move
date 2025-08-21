module 0x99d9a92d7617b81897377931eb0741e1f4d7560cf4b8865cfb6cbd71a689e761::b_phoenix {
    struct B_PHOENIX has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_PHOENIX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_PHOENIX>(arg0, 9, b"bPHOENIX", b"bToken PHOENIX", b"bToken for PHOENIX", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"ICON_URL_PLACEHOLDER")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_PHOENIX>>(v0, @0x54d8f987d3d74ef971bc63538b70d0ce4591772d8118b37f03a5373b84a77ec5);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<B_PHOENIX>>(v1, @0x54d8f987d3d74ef971bc63538b70d0ce4591772d8118b37f03a5373b84a77ec5);
    }

    // decompiled from Move bytecode v6
}

