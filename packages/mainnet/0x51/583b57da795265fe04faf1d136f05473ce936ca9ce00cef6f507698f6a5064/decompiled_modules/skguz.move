module 0x51583b57da795265fe04faf1d136f05473ce936ca9ce00cef6f507698f6a5064::skguz {
    struct SKGUZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKGUZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKGUZ>(arg0, 6, b"SKGUZ", b"SKGUZBECS", b"IMAGINARY CREATURE LIVING IN FORESTS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3_5927ab59a6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKGUZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SKGUZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

