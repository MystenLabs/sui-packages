module 0x47c9d78e44ffbb8f725bc69726017d440b8bbe556eda12d170492d84d191aa29::dope {
    struct DOPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOPE>(arg0, 6, b"DOPE", b"DOPE the Dolphin", b"just a little dolphin on $SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730967663861.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOPE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOPE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

