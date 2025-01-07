module 0x968eeb3aed94f29b014185fb42bb70a479bc075c1ba0c7ccd24057d5060030d::plonk {
    struct PLONK has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLONK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLONK>(arg0, 6, b"PLONK", b"PLONKTON ON SUI", b"PLONKTON ON SUI ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/plankton_b0af6ddd66.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLONK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PLONK>>(v1);
    }

    // decompiled from Move bytecode v6
}

