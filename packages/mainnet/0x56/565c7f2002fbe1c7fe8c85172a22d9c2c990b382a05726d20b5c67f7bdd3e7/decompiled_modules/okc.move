module 0x56565c7f2002fbe1c7fe8c85172a22d9c2c990b382a05726d20b5c67f7bdd3e7::okc {
    struct OKC has drop {
        dummy_field: bool,
    }

    fun init(arg0: OKC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OKC>(arg0, 6, b"OKC", b"OceanKingCat", x"54686520234f6365616e4b696e674361742020244f4b432069732074686520677561726469616e206f6620746865206b696e67646f6d206f6620245355492e0a4c697665206c6f6e6720616e642070726f73706572206d792066656c6c6f7720636974697a656e7320", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Lf_Hw_PG_5r_400x400_54a58f2428.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OKC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OKC>>(v1);
    }

    // decompiled from Move bytecode v6
}

