module 0xd8153bfd26118d01ff1a30b16244517dc9248aace2aee1bec32f80cc636f9868::slo {
    struct SLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLO>(arg0, 6, b"SLO", b"SUIRLO", b"SUIRLO is the business dolphin on SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suirlo_752d3641d9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLO>>(v1);
    }

    // decompiled from Move bytecode v6
}

