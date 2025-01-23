module 0x3532548064873c8ef1236337f1cab7d2d4b47dca950c93a077e33bbf29e688fb::dukie {
    struct DUKIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUKIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUKIE>(arg0, 6, b"DUKIE", b"DUKIE SUI", b"Dukie in the toilet  not on the chart ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250124_052005_458_ca75b19914.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUKIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUKIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

