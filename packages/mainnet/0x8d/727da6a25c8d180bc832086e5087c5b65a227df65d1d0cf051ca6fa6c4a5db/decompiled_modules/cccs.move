module 0x8d727da6a25c8d180bc832086e5087c5b65a227df65d1d0cf051ca6fa6c4a5db::cccs {
    struct CCCS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CCCS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CCCS>(arg0, 6, b"CCCS", b"C", b"CS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730963042521.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CCCS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CCCS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

