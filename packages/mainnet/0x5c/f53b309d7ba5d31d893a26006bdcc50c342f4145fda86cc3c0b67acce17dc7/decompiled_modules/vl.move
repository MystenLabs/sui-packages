module 0x5cf53b309d7ba5d31d893a26006bdcc50c342f4145fda86cc3c0b67acce17dc7::vl {
    struct VL has drop {
        dummy_field: bool,
    }

    fun init(arg0: VL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VL>(arg0, 9, b"VL", b"Ngu", b"Nguvcl", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8155e38f-799b-46c9-906c-531e656c1042.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VL>>(v1);
    }

    // decompiled from Move bytecode v6
}

