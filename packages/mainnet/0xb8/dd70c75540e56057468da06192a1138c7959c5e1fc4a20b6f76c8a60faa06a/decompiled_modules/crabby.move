module 0xb8dd70c75540e56057468da06192a1138c7959c5e1fc4a20b6f76c8a60faa06a::crabby {
    struct CRABBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRABBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRABBY>(arg0, 6, b"CRABBY", b"Dog Crabby", b"The dog wants to be like a crabby!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GJ_Yx5_X_Sbc_AA_Nutn_3787900e49.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRABBY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CRABBY>>(v1);
    }

    // decompiled from Move bytecode v6
}

