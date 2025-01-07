module 0xb0f9fd69ab6760e721b361deac811d450a34f076e5e15187cddb425a550916c1::kam {
    struct KAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAM>(arg0, 6, b"KAM", b"KAMALA2025", b"Vote for Kamala Harris", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/test_5c24475c9d.PNG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KAM>>(v1);
    }

    // decompiled from Move bytecode v6
}

