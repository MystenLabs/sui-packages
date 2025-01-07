module 0xed7415ef570e722caba0b416a1cdf0456150872a4d5e32b34e931048e6a5c193::suimilk {
    struct SUIMILK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMILK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMILK>(arg0, 6, b"SUIMILK", b"Suimilk", x"0a5375696d696c6b2063616e206d616b6520796f757220626f6479206865616c74687920616e64206e65757472616c697a6520766172696f7573206765726d732c206865616c746879206c6976696e6720697320696d706f7274616e74", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000052324_4ecf45441b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMILK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMILK>>(v1);
    }

    // decompiled from Move bytecode v6
}

