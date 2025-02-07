module 0x63fa946beb43273e26b842535268465b5d4c8abe1193a4def3b2bbcb595bee99::kkbs {
    struct KKBS has drop {
        dummy_field: bool,
    }

    fun init(arg0: KKBS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KKBS>(arg0, 6, b"KKBS", b"KKBEAR ON SUI", b"KOOK KOOK BEAR ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/kook_logo_012_01_4a4c85a8f0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KKBS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KKBS>>(v1);
    }

    // decompiled from Move bytecode v6
}

