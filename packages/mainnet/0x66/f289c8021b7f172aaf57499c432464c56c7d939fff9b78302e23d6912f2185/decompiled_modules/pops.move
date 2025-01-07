module 0x66f289c8021b7f172aaf57499c432464c56c7d939fff9b78302e23d6912f2185::pops {
    struct POPS has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPS>(arg0, 6, b"POPS", b"POPSUI", b"POP CAT ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/POPCAT_2e284eae63.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POPS>>(v1);
    }

    // decompiled from Move bytecode v6
}

