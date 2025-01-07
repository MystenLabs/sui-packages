module 0x1532623105e527df9d770602f3dfbdb116dc1c54861d724a4d3196dbde6072a::bpac {
    struct BPAC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BPAC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BPAC>(arg0, 6, b"BPAC", b"BluePacman", b"the blue pacman become a millionerrrrrrrrr", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730964157389.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BPAC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BPAC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

