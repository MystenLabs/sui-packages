module 0x292295126a70b16516108f708e31f2d54ba67db42d7441416a735a340e7ad2b::ups {
    struct UPS has drop {
        dummy_field: bool,
    }

    fun init(arg0: UPS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UPS>(arg0, 6, b"UPS", b"UP SUI-NDROME", b"I got a chronic case of that UP SUI-NDROME", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUICAT_min_191f9c8bbb.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UPS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UPS>>(v1);
    }

    // decompiled from Move bytecode v6
}

