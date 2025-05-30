module 0xb68f7cf7009e290c97a000558faac600071978812014f60e3809d083f76803a::pengsui {
    struct PENGSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PENGSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PENGSUI>(arg0, 6, b"PENGSUI", b"Penguin on Sui", x"50656e6775696e732061726520612067726f7570206f66206171756174696320666c696768746c6573732062697264732066726f6d207468652066616d696c7920537068656e69736369646165206f6620746865206f7264657220537068656e69736369666f726d657320282f7366c9aacb886ec9aa73c99966c994cb90726d69cb907a2f292077697468207468652053756920646966666572656e63652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734281283202.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PENGSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PENGSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

