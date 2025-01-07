module 0xf34396b4b2562f583b29ec5541dfcdfb30e44576d5e99e450022ece9e536783a::lukuku {
    struct LUKUKU has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUKUKU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUKUKU>(arg0, 6, b"LUKUKU", b"LUKUKU on SUI", x"57686f277320676f696e6720746f2062652074686520746f7020737472696b657220696e206575726f3f0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ly_Ci_Zk_S9_400x400_66d664bd17.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUKUKU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LUKUKU>>(v1);
    }

    // decompiled from Move bytecode v6
}

