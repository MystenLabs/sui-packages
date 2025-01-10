module 0xd693713804bb88ffb3fba164d2f74cd8f40e5a56c26b2cdc6b530acdf16fa848::dagent {
    struct DAGENT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAGENT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAGENT>(arg0, 6, b"DAGENT", b"Dolphin Agent", x"57454c434f4d4520544f20444f4c5048494e204147454e542120594f555220534f4e415220494e2054484520535549204f4345414e2e2057494c4c2042452046554c4c5920555020414e442052554e4e494e4720494e20323420484f5552532e200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6159_0b92a14f9e.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAGENT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DAGENT>>(v1);
    }

    // decompiled from Move bytecode v6
}

