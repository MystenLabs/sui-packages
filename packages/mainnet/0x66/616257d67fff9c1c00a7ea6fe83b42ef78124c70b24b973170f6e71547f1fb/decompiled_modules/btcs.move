module 0x66616257d67fff9c1c00a7ea6fe83b42ef78124c70b24b973170f6e71547f1fb::btcs {
    struct BTCS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTCS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTCS>(arg0, 6, b"BTCS", b"Sui Bitcoin", x"4920776f6e7420627579206669727374205e2e5e0a4d61646520666f722074686520636f6d6d756e6974792e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6_88a2fe1a1b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTCS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BTCS>>(v1);
    }

    // decompiled from Move bytecode v6
}

