module 0x7394adc3d7df2ba17f97410d35f52c41ba43a63b0dead7baf228d8faadcc2030::moon {
    struct MOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOON>(arg0, 9, b"MOON", b"MOONY", x"20e2809c4d4f4f4e59206973206120756e69717565206d656d6520746f6b656e206372656174656420746f20636f6e71756572207468652063727970746f20756e697665727365212044657369676e656420746f206272696e672066756e20616e6420686f70652c204d4f4f4e5920696e76697465732074686520636f6d6d756e69747920746f20736f617220746f20746865206d6f6f6e20746f67657468657221e2809d", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/101dd303-ad70-4ca8-aa92-ed5aa9f4bd0b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOON>>(v1);
    }

    // decompiled from Move bytecode v6
}

