module 0xaf6cabcfb6f5cc14823de7901d9480d44968326333445987c73a843e6b528d71::pulpo {
    struct PULPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PULPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PULPO>(arg0, 6, b"PULPO", b"El Pulpo", b"Pure Charisma", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/48cb35da_f059_4b4b_ac9e_53606f7beaf5_309ec8644d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PULPO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PULPO>>(v1);
    }

    // decompiled from Move bytecode v6
}

