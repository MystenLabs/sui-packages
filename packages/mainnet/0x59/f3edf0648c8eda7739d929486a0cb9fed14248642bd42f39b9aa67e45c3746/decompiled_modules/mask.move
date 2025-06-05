module 0x59f3edf0648c8eda7739d929486a0cb9fed14248642bd42f39b9aa67e45c3746::mask {
    struct MASK has drop {
        dummy_field: bool,
    }

    fun init(arg0: MASK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MASK>(arg0, 6, b"MASK", b"Fishwifmask", x"52656c61756e636820626563617573652074686520747572626f7320706f6f6c2077617320756e6c6f636b61626c650a0a546f6b656e20686f6c64657273206765742061697264726f70706564", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifuf75lzndhtzlaqxocethmuc2j2uytxjy6za7jhswriz63sxtj3m")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MASK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MASK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

