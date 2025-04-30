module 0x4b8e3e4f1e250c3ad7d9205f32ac08d9f0afd934a13d899bed9071eeb4e67552::pupy {
    struct PUPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUPY>(arg0, 6, b"PUPY", b"Sui Pupy", b"Pupy is a awesome memecoin born on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20250501_003337_b9a59b5674.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

