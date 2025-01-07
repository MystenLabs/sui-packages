module 0x4570032a4d76333292781f5bebd4baec7d4c9c9f6008b1b9b78bb759168c1733::cuongbok {
    struct CUONGBOK has drop {
        dummy_field: bool,
    }

    fun init(arg0: CUONGBOK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CUONGBOK>(arg0, 9, b"CUONGBOK", b"BOK", x"446570207472616920736f2031207468652067696f6920f09f8c8f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d317cb2d-233e-421f-b49a-1ff36d540a63.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CUONGBOK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CUONGBOK>>(v1);
    }

    // decompiled from Move bytecode v6
}

