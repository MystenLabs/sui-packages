module 0x7ff340835bc3daf95ed9432af8bc298e64be3015a93ce69ccc609dd7393ab0e3::berf {
    struct BERF has drop {
        dummy_field: bool,
    }

    fun init(arg0: BERF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BERF>(arg0, 6, b"BERF", b"BERFonSUI", b"BERF SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_48_5a3d0dd5ff.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BERF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BERF>>(v1);
    }

    // decompiled from Move bytecode v6
}

