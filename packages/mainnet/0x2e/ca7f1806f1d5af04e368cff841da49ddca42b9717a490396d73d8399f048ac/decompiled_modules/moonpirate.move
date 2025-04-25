module 0x2eca7f1806f1d5af04e368cff841da49ddca42b9717a490396d73d8399f048ac::moonpirate {
    struct MOONPIRATE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOONPIRATE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOONPIRATE>(arg0, 6, b"MOONPIRATE", b"MoonPirate", b"MoonPirate  The legendary SUI brand returns! Community-powered & decentralized. #MoonPirate #SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2025_04_26_01_05_29_72f00d332f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOONPIRATE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOONPIRATE>>(v1);
    }

    // decompiled from Move bytecode v6
}

