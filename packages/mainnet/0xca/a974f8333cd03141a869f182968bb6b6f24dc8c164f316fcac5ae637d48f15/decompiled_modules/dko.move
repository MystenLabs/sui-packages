module 0xcaa974f8333cd03141a869f182968bb6b6f24dc8c164f316fcac5ae637d48f15::dko {
    struct DKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DKO>(arg0, 9, b"DKO", b"Duko", x"f09f9a802057656c636f6d6520746f2074686520467574757265206f662043727970746f204d696e696e672120f09f9a800a4a6f696e20696e206f7572206d697373696f6e2068747470733a2f2f742e6d652f64756b6f5f746f6e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bdc05bd8-69a9-487b-8be2-d9fec1f0ea9f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

