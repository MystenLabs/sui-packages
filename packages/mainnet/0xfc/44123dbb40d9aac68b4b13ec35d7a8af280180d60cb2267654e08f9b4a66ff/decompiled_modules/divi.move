module 0xfc44123dbb40d9aac68b4b13ec35d7a8af280180d60cb2267654e08f9b4a66ff::divi {
    struct DIVI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIVI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIVI>(arg0, 9, b"DIVI", b"DivingCoin", x"446976696e6720436f696e2069732061206d656d6520636f696e20696e7370697265642062792074686520776f726c64206f6620756e646572776174657220616476656e747572657320616e642065787472656d6520646976696e672e20497473206d697373696f6e20697320746f2073796d626f6c697a6520746865206578706c6f726174696f6e206f662066726565646f6d20616e64207370697269742c20616c6c6f77696e6720757365727320746f20e2809c64697665e2809d20696e746f2074686520776f726c64206f662063727970746f63757272656e637920776974682066756e20616e642068756d6f722e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1e770fd2-2a44-4bda-80d1-25ae5e02b07d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIVI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DIVI>>(v1);
    }

    // decompiled from Move bytecode v6
}

