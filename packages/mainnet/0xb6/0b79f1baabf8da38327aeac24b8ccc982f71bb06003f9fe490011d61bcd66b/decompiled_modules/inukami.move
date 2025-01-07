module 0xb60b79f1baabf8da38327aeac24b8ccc982f71bb06003f9fe490011d61bcd66b::inukami {
    struct INUKAMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: INUKAMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<INUKAMI>(arg0, 6, b"INUKAMI", b"FIRST INU KAMI ON SUI", b"FIRST INU KAMI ON SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_15_90afbaac96.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<INUKAMI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<INUKAMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

