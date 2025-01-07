module 0xe86cf0e90a5fd46cbcd9711cb6635eb0e74db3f04397d9c54d554b19a16bf7cd::hbjbh {
    struct HBJBH has drop {
        dummy_field: bool,
    }

    fun init(arg0: HBJBH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HBJBH>(arg0, 6, b"Hbjbh", b"jhg", b"bhk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735374862271.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HBJBH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HBJBH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

