module 0x9887809f548c9a9647bbe47ebc5cd355f222494c39b0001d022fadbe6b587d79::nyan {
    struct NYAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: NYAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NYAN>(arg0, 6, b"NYAN", b"NYAN CAT USA", b"FIRST NYAN ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1737451265800.gif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NYAN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NYAN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

