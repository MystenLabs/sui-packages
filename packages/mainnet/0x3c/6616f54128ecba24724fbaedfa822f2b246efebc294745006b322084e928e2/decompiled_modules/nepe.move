module 0x3c6616f54128ecba24724fbaedfa822f2b246efebc294745006b322084e928e2::nepe {
    struct NEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEPE>(arg0, 6, b"NEPE", b"Neiro Pepe Inu", b"Neiro Pepe Inu ($NEPE) is combining strong narratives in the space and is on it's way to become a T1-Memecoin in the market.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_03_15_06_44_88f599c2ee.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

