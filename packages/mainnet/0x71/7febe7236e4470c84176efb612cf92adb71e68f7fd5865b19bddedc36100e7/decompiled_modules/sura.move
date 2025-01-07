module 0x717febe7236e4470c84176efb612cf92adb71e68f7fd5865b19bddedc36100e7::sura {
    struct SURA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SURA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SURA>(arg0, 6, b"SURA", b"SUIRA", x"2453555241206973206f6e2061206d697373696f6e20746f2070726f76696465206368696c6472656e207769746820736d696c657320616c6c2061726f756e642074686520776f726c642e204c61756e63682054756573646179207468652038206f66204f63746f626572210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/5_Juhy_KL_400x400_60fc4a79dd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SURA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SURA>>(v1);
    }

    // decompiled from Move bytecode v6
}

