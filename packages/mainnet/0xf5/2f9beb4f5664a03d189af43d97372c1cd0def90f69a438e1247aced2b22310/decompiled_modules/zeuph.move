module 0xf52f9beb4f5664a03d189af43d97372c1cd0def90f69a438e1247aced2b22310::zeuph {
    struct ZEUPH has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZEUPH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZEUPH>(arg0, 6, b"ZEUPH", b"Zeuph On Sui", x"54686520636f6f6c6570687420646f67206f6e207468652053756920436861696e21200a546865206f7665726269746520646566696e65732074686520646f672e200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0228_f7e464d463.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZEUPH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZEUPH>>(v1);
    }

    // decompiled from Move bytecode v6
}

