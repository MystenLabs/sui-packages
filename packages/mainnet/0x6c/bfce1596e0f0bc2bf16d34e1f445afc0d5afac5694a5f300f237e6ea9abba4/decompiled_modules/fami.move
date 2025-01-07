module 0x6cbfce1596e0f0bc2bf16d34e1f445afc0d5afac5694a5f300f237e6ea9abba4::fami {
    struct FAMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FAMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAMI>(arg0, 6, b"FAMI", b"SUIMILIA FAMILIA", b"Join SUI FAMILIA // $AAA   $KUN  $SPLO  $PLOP  $PLOP  $NAMI  $SUILAMA  $BLUE  $SUIJAK  $MOVEPUMP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_18_at_14_40_22_Medium_13e0b94762.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FAMI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FAMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

