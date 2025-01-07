module 0x9d760dfbc4d4be563e5452ddd5aec33cad287e6872e6728400798ae2cbc5836c::suilodon {
    struct SUILODON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILODON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILODON>(arg0, 6, b"SUILODON", b"Sui Megalodon", b"Emerging from the deepest waters of Sui, Sui Megalodon is the ultimate apex predator in the Sui ocean.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_60_a0da95c9b2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILODON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUILODON>>(v1);
    }

    // decompiled from Move bytecode v6
}

