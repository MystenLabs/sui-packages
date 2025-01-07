module 0x6d7c5450e52b22b0498aab329b4ef582eab3e330f35fffa5c272167b44aa1b49::brd {
    struct BRD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRD>(arg0, 6, b"BRD", b"Bird Dog", b"Bird dog offers the power of community and long-term future utility", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241001_145443_f39e46a5cc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRD>>(v1);
    }

    // decompiled from Move bytecode v6
}

