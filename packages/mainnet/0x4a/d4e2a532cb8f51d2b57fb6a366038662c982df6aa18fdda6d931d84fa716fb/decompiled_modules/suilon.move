module 0x4ad4e2a532cb8f51d2b57fb6a366038662c982df6aa18fdda6d931d84fa716fb::suilon {
    struct SUILON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILON>(arg0, 6, b"SUILON", b"SUILON ON SUI", b"colony of suilions taking over sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2024_10_03_18_36_54_93cebf1dd6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUILON>>(v1);
    }

    // decompiled from Move bytecode v6
}

