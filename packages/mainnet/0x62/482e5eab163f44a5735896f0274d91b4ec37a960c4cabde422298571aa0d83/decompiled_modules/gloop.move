module 0x62482e5eab163f44a5735896f0274d91b4ec37a960c4cabde422298571aa0d83::gloop {
    struct GLOOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: GLOOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GLOOP>(arg0, 6, b"Gloop", b"Gloop on SUI", x"476c6f6f702061727269766573206f6e2053554921200a0a4865732074686520627261766573742068756d616e206669736820696e2074686520656e74697265206f6365616e2c20656d626f6479696e67206a6f792c2068617070696e6573732c20616e642072657370656374210a0a5765726520676f696e6720746f206275696c642061207374726f6e6720616e64207468726976696e6720636f6d6d756e6974792e0a0a476c6f6f7020746f2074686520746f7021", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pfp_673a4e9d0b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GLOOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GLOOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

