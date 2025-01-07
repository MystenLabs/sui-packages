module 0x48dc2eb6245dbdefb1e06a471c0d54c1f40fab1b357d715126373def137227e8::dawd {
    struct DAWD has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAWD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAWD>(arg0, 6, b"DAWD", b"dwad", b"DASDWD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ub_P8rz_Rm_400x400_removebg_preview_8eaf4841da.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAWD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DAWD>>(v1);
    }

    // decompiled from Move bytecode v6
}

