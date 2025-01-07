module 0x46ef38dfbb2f895b96ad5a93d070e4792a1acf85699b0ed20e75d1331c81db8d::gin {
    struct GIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GIN>(arg0, 6, b"GIN", b"Sui Gin", b"Suntory Sui Gin, the new expression of Japanese gin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Sui_Gin_3cfd83cde1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

