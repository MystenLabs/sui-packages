module 0x62479e5ffcd30c97878d629562c72bb8b155170a9ddf11233258a717288cb0e::msa {
    struct MSA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MSA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MSA>(arg0, 6, b"MSA", b"Master Saiyan", b"The Miracles happen when you believe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1733143703401.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MSA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MSA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

