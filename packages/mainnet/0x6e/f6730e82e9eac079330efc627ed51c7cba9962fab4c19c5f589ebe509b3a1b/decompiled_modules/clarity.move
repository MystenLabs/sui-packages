module 0x6ef6730e82e9eac079330efc627ed51c7cba9962fab4c19c5f589ebe509b3a1b::clarity {
    struct CLARITY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLARITY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLARITY>(arg0, 6, b"Clarity", b"Post Nut Clarity", b"Bro, I know you wanna LOCK TF IN and go get this SUI bag! But you need $CLARITY to do so. We wont stop till were in Miami on a yacht", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/5_F43_AC_96_02_BC_46_CB_9_AEC_73_A43620_CD_8_D_08d3e1f2f6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLARITY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CLARITY>>(v1);
    }

    // decompiled from Move bytecode v6
}

