module 0xed05387c75fd8678766f629d61b51e07cb09537ed9616c9482f88023a5d625bb::qwadrox {
    struct QWADROX has drop {
        dummy_field: bool,
    }

    fun init(arg0: QWADROX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QWADROX>(arg0, 6, b"QWADROX", b"Qwadrox", x"54686520776f726c64206e656564732061206368616e67652e0a2051776164726f78202d20612063727970746f63757272656e637920776974682061206d697373696f6e2c0a537570706f727420636861726974792c206d616b6520616e20696d706163742c206275696c6420746865206675747572652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/nrspdv_674517623c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QWADROX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<QWADROX>>(v1);
    }

    // decompiled from Move bytecode v6
}

