module 0x291e64abdc061ff933b1839720e0f1f72818a99a0357b2fee2488c9ca42d2310::muscle {
    struct MUSCLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUSCLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUSCLE>(arg0, 6, b"MUSCLE", b"Muscle cat on sui", x"6e2074686520627573746c696e67206d6574726f706f6c6973206f662053756920436974792c20610a706563756c6961722066656c696e65206e616d6564204d7573636c65204361740a726f616d65642074686520737472656574732c20686973206d757363756c61720a706879736971756520616e642064657465726d696e65642065787072657373696f6e20610a737461726b20636f6e747261737420746f206869732066656c6c6f772066656c696e65732e0a4d7573636c652043617420776173206e6f206f7264696e617279206361740a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000052725_bf1dc99059.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUSCLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MUSCLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

