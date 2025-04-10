module 0x6f82f810765c91244d01d8d0ba14313adc2939fa7b67f9c037d1a659237a7dab::liuyuedoge {
    struct LIUYUEDOGE has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<LIUYUEDOGE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<LIUYUEDOGE>>(0x2::coin::mint<LIUYUEDOGE>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: LIUYUEDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIUYUEDOGE>(arg0, 6, b"LIUYUEDOGE", b"LIUYUEDOGE", b"Liuyue Doge Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://raw.githubusercontent.com/hanhanliuyue/USDP/refs/heads/main/liuyuedoge.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIUYUEDOGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LIUYUEDOGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

