module 0x1c47d520eb3f2ba88b5d43008812f39603ec53a21d7bc1e203accb72986d2a09::drg {
    struct DRG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRG>(arg0, 6, b"DRG", b"DRAGONS", b"To The Moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Desain_tanpa_judul_3_225bfd598f.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DRG>>(v1);
    }

    // decompiled from Move bytecode v6
}

