module 0x416658227c37533f3a72a2a19cbe0bf6f27078c439c51f6f9f451064138ee22::dscape {
    struct DSCAPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DSCAPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DSCAPE>(arg0, 6, b"DSCAPE", b"DefiScape", b"The Text Based RuneScape like blockchain game on Sui. Train skills, fight bosses and gather rare items!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3377_5fb2fd6150.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DSCAPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DSCAPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

