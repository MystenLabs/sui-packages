module 0x44803e1bd0de7fd649a6ea3a8f157771259a85ef008a8240abb084b1d1363b41::shepe {
    struct SHEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHEPE>(arg0, 6, b"SHEPE", b"SHEPE SUI", x"446f6e617465206e6f7720616e64207361766520612054524f4e2053484550452066726f6d20696d70656e64696e6720646f6f6d2e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ovmon_1fee18d476.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

