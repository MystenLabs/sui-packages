module 0xccdfaa243758867b38a6603fd21eddfc4f868341399e70692448bf10c425094d::apu {
    struct APU has drop {
        dummy_field: bool,
    }

    fun init(arg0: APU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<APU>(arg0, 6, b"APU", b"Apu Apustaja", b"Apu, also known as Peepo or Helper, is a pepe-variant that is used to represent a much younger, kinder and more naive anthropomorphic frog.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ebi_v_Pe_E_400x400_c41e30c0e8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<APU>>(v1);
    }

    // decompiled from Move bytecode v6
}

