module 0xcd49f57af153ef89e0fec90ee1a110979034c9a937faf651f854fba01427ea5f::grich {
    struct GRICH has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRICH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRICH>(arg0, 6, b"GRICH", b"RICH", b"Get $RICH with $SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Gbd_I_Ttbac_AA_Pyy_B_c209c260df.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRICH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GRICH>>(v1);
    }

    // decompiled from Move bytecode v6
}

