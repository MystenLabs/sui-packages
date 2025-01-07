module 0x889256288b41656c010163a6a4c27fea4480485475aab86a4ce2d330ee438ae7::dburger {
    struct DBURGER has drop {
        dummy_field: bool,
    }

    fun init(arg0: DBURGER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DBURGER>(arg0, 9, b"DBURGER", b"DogeBurger", x"204675656c20796f75722063727970746f2077616c6c657420776974682061206a7569637920446f67654275726765722c20746865206d656d6520636f696e2074686174e280997320616c6c2061626f75742074686520666173742d666f6f64206c6966657374796c652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f0c37fdd-4efc-428d-8fc1-a8ab7f3fa422.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DBURGER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DBURGER>>(v1);
    }

    // decompiled from Move bytecode v6
}

