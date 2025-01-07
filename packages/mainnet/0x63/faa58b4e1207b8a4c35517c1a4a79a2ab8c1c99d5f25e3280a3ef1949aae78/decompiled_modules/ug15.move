module 0x63faa58b4e1207b8a4c35517c1a4a79a2ab8c1c99d5f25e3280a3ef1949aae78::ug15 {
    struct UG15 has drop {
        dummy_field: bool,
    }

    fun init(arg0: UG15, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UG15>(arg0, 9, b"UG15", b"Kanju", b"The main purpose of this token is to make transaction easy and reduce gas fee", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8ab057dd-8d0e-4255-a2a4-5625135dffb9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UG15>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UG15>>(v1);
    }

    // decompiled from Move bytecode v6
}

