module 0xe251b124a2aabb6ee6d65986536bced7b17148f2429a85f49d8d183d0352d41a::bluird {
    struct BLUIRD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUIRD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUIRD>(arg0, 6, b"BLUIRD", b"Blue Eyed Bird", b"AAA blue-eyed bird", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bluird_6f07285933.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUIRD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUIRD>>(v1);
    }

    // decompiled from Move bytecode v6
}

