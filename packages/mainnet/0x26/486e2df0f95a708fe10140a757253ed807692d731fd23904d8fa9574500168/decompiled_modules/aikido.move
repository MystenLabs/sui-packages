module 0x26486e2df0f95a708fe10140a757253ed807692d731fd23904d8fa9574500168::aikido {
    struct AIKIDO has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIKIDO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIKIDO>(arg0, 6, b"AIKIDO", b"Sui Andrew Tate", x"4c697374656e2075702c2070656173616e747321202441494b49444f2069732074686520746f702047206f662074686520537569204e6574776f726b2e200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_82_c58beca934.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIKIDO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AIKIDO>>(v1);
    }

    // decompiled from Move bytecode v6
}

