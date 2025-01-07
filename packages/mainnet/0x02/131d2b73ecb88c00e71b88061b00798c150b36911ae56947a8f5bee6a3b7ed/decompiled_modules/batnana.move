module 0x2131d2b73ecb88c00e71b88061b00798c150b36911ae56947a8f5bee6a3b7ed::batnana {
    struct BATNANA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BATNANA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BATNANA>(arg0, 6, b"BATNANA", b"BananaBat", x"536865206973205665727920637574737920616e6420776f6e742062697465207368652070726f6d6973652c2073686520697320766567616e2c20736865206f6e6c7920656174732066727569747320616e6420766567676965732c20616e6420736f6d657468696d65732e2e2042616e616e617321210a2879657320736865206973206b696e64206f6620612063616e6e6962616c290a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/LOGA_1_3f194a9659.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BATNANA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BATNANA>>(v1);
    }

    // decompiled from Move bytecode v6
}

