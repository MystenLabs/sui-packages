module 0xb803771e4da1af45ca60f5ac87041831d80ef0a29514630607ae4e7b39199fa6::goji {
    struct GOJI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOJI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOJI>(arg0, 6, b"GOJI", b"goji On Sui", x"48692069276d20476f6a6921204120535549206d656d65636f696e20666f6375736564206f6e20434f4d4d554e4954592c204152542e200a0a0a0a492061696d20746f20626520746865206269676765737420616e64206d6f7374207265636f676e697a6564206d656d65636f696e206f6e2074686520696e7465726e657421", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/W7_S8m_Xjw_400x400_2e53658987.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOJI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOJI>>(v1);
    }

    // decompiled from Move bytecode v6
}

