module 0x5d0e6e20136ab4c2c1fef2379b5ea0b154a67a86271a6f04c298f8105b68a37::plonk {
    struct PLONK has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLONK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLONK>(arg0, 6, b"PLONK", b"PLonksui", b"PLONKTON ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/plankton_1a001e79cd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLONK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PLONK>>(v1);
    }

    // decompiled from Move bytecode v6
}

