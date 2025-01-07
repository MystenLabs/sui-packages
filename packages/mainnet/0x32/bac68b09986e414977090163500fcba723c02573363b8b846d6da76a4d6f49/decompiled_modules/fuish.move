module 0x32bac68b09986e414977090163500fcba723c02573363b8b846d6da76a4d6f49::fuish {
    struct FUISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUISH>(arg0, 6, b"FUISH", b"SUI FUISH", b"https://x.com/suifuish", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/P_Ed2_UHNL_400x400_8067bb4b4b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FUISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

