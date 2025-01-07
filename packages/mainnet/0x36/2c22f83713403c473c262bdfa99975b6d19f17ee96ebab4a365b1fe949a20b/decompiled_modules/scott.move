module 0x362c22f83713403c473c262bdfa99975b6d19f17ee96ebab4a365b1fe949a20b::scott {
    struct SCOTT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCOTT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCOTT>(arg0, 9, b"SCOTT", b"Scott Dog", x"53636f74742074686520646f67f09f90be2069732061207265766f6c7574696f6e20696e20746865206d656d6520776f726c642e2053636f74742074686520646f67206272696e67732066756e20616e64207061772d73697469766520766962657320746f207468652063727970746f2073706163652e200af09f90b6f09f92b0", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5a1a28d5-183a-4f65-b6b4-1aa0fb643b0d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCOTT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCOTT>>(v1);
    }

    // decompiled from Move bytecode v6
}

