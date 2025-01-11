module 0xfd1f767e17210476858bed5440b4a76b4246508ed68376d92c81e636d91f5247::wgs {
    struct WGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: WGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WGS>(arg0, 6, b"WGS", b"WolfGem on sui", b"Welcome to the world of strange dreams with WolfGem! Let's explore the surprises on the Sui ecosystem together.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2025_01_11_00_23_31_b59b517c1d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WGS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WGS>>(v1);
    }

    // decompiled from Move bytecode v6
}

