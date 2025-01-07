module 0x3425861968e63f2d98c5a9e991ca1f71f1d8dd7248ba3b6fedbef5f7a32da9c0::finpe {
    struct FINPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FINPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FINPE>(arg0, 6, b"FINPE", b"FINPE SUI", b"I am FINPE. the freest clownfish Or Sometimes also been recognised as a frog..but whatever you want to call it Im shooting and making the most breathtaking and impressive selfies!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_11_03_00_48_18_39bc2f338c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FINPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FINPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

