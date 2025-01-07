module 0xeb5a55ded0dadfc4c42be7befc53b033847d2d0a169099c587fa04650d78684e::smurfpepe {
    struct SMURFPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMURFPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMURFPEPE>(arg0, 6, b"SMURFPEPE", b"SMURF PEPE", b"if you know, you know.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/smurfpepe_17f8cbbc13.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMURFPEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMURFPEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

