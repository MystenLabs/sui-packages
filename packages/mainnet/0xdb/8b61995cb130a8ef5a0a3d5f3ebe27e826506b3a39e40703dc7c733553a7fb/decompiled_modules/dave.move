module 0xdb8b61995cb130a8ef5a0a3d5f3ebe27e826506b3a39e40703dc7c733553a7fb::dave {
    struct DAVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAVE>(arg0, 6, b"Dave", b"suidavedot", x"245355492063656e747269632c2024424c5542206d6178692e2024424c554220436f6d6d756e697479204c6561642e2020687474703a2f2f742e6d652f626c756273756920457863697465642061626f7574200a40626c75627375690a2026200a40616e696d616c6162735f696f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3059_caee5adc36.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAVE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DAVE>>(v1);
    }

    // decompiled from Move bytecode v6
}

