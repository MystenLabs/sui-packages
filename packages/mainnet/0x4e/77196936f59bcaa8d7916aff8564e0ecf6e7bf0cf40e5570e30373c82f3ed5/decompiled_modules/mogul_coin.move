module 0x2f650a5162e4f7ef12b9adfbc2fadff1c30574572ebe2ed650b64a75f85b056b::mogul_coin {
    struct MOGUL_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOGUL_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOGUL_COIN>(arg0, 6, b"MOGUL", b"MOGUL Coin", b"MOGUL Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/5CWRcYw.png")), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOGUL_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOGUL_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

