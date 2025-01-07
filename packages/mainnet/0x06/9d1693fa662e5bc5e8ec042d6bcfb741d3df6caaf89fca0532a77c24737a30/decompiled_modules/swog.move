module 0x69d1693fa662e5bc5e8ec042d6bcfb741d3df6caaf89fca0532a77c24737a30::swog {
    struct SWOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWOG>(arg0, 6, b"SWOG", b"Sui Swog", b"In the water emerged a new swog, a more based swog for sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/d3b83887_1f8f_48b3_a688_296d73905d79_b0f5090de9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SWOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

