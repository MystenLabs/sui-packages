module 0x3569f5bf97c0b6e546d91ed2c73d05a633c0c700be29836bf5094701752c3fb0::mv {
    struct MV has drop {
        dummy_field: bool,
    }

    fun init(arg0: MV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MV>(arg0, 6, b"MV", b"mavriks", b"Mavrik on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Captura_de_ecr_A_2024_12_04_104022_c45d7b8f32.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MV>>(v1);
    }

    // decompiled from Move bytecode v6
}

