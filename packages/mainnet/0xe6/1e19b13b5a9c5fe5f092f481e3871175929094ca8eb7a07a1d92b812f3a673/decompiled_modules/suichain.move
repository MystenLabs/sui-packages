module 0xe61e19b13b5a9c5fe5f092f481e3871175929094ca8eb7a07a1d92b812f3a673::suichain {
    struct SUICHAIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICHAIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICHAIN>(arg0, 6, b"SUICHAIN", b"Sui Chain", x"4c696e6b696e672074686520537569204e6574776f726b20746f6765746865722c2024535549434841494e20697320746865206261636b626f6e65206f6620636f6e6e656374696f6e2e200a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_66_e137bd4a99.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICHAIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICHAIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

