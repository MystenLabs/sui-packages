module 0x105454c50bcfef60f6c06ed36ea43e44b2029b5c01241fa1d9ed3b28b1485dfd::pac {
    struct PAC has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAC>(arg0, 6, b"PAC", b"America Pac", x"46726565205370656563682069732074686520626564726f636b206f662044656d6f63726163792e200a0a537570706f72742063616e646964617465732077686f206368616d70696f6e2046726565646f6d2c206e6f742043656e736f72736869702e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9008_aecd3002e1.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PAC>>(v1);
    }

    // decompiled from Move bytecode v6
}

