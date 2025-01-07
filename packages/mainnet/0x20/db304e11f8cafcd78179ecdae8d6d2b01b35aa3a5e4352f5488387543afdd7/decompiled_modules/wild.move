module 0x20db304e11f8cafcd78179ecdae8d6d2b01b35aa3a5e4352f5488387543afdd7::wild {
    struct WILD has drop {
        dummy_field: bool,
    }

    fun init(arg0: WILD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WILD>(arg0, 6, b"Wild", b"Wild Sui", b"Wild For the Wild Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/images_317be9493c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WILD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WILD>>(v1);
    }

    // decompiled from Move bytecode v6
}

