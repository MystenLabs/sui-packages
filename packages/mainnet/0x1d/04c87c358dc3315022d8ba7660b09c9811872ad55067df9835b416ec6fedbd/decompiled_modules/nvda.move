module 0x1d04c87c358dc3315022d8ba7660b09c9811872ad55067df9835b416ec6fedbd::nvda {
    struct NVDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: NVDA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NVDA>(arg0, 6, b"NVDA", b"NVDA6900", x"4e6576657220566f6c6174696c6520446566696e6974656c7920417065203639303020244e5644410a0a244e564441206973206f6e65206f6620746865206c656164696e672073746f636b7320696e2074686520776f726c64210a0a536f6f6e2069742077696c6c20626520746865206c656164696e672073746f636b206f6e2024535549210a0a536f6369616c7320636f6d696e6720736f6f6e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_d3c295f6b3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NVDA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NVDA>>(v1);
    }

    // decompiled from Move bytecode v6
}

