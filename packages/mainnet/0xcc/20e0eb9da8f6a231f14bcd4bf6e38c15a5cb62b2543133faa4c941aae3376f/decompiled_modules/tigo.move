module 0xcc20e0eb9da8f6a231f14bcd4bf6e38c15a5cb62b2543133faa4c941aae3376f::tigo {
    struct TIGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TIGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TIGO>(arg0, 6, b"TIGO", b"Tigo On Sui", b"$TIGO Now live on sui network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000453_3dc88f0871.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TIGO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TIGO>>(v1);
    }

    // decompiled from Move bytecode v6
}

