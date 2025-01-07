module 0x1ee73674525727781127d1dee461b33d91697c45475dba8aceab11e176d5bbda::xp {
    struct XP has drop {
        dummy_field: bool,
    }

    fun init(arg0: XP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XP>(arg0, 6, b"XP", b"@explicamarcos", x"546865206c6567656e64617279204d6172636f732c20756e697175652063727970746f63757272656e63792e0a0a5468697320636f696e2077696c6c20626520776f727468203120646f6c6c617220696e20746865206675747572652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/412585732_274177022308029_3019460665905231956_n_6dbdb756b0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XP>>(v1);
    }

    // decompiled from Move bytecode v6
}

