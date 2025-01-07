module 0xa3e08aade4ff7963193f5306fd529d395f95ad93c930611f23e88e44bf418ca3::hhog {
    struct HHOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: HHOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HHOG>(arg0, 6, b"HHog", b"Hedge Hog - SUI archaeologist", b"Hello, I'm Hedge Hog in the SUI world, has a mission to find SUI piece by piece. follow my journey :))", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/hedge_hog_sui_892310636f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HHOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HHOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

