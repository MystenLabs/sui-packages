module 0x21155b7c544c1c2657bbef5705ca71f3b9774d770175233a4ac587dac87e986e::sal9 {
    struct SAL9 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAL9, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAL9>(arg0, 9, b"SAL9", b"Salau Cat", b"Sal token for the cat lovers", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f8c39c25-d273-4a53-9b5e-d6344830a5b3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAL9>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SAL9>>(v1);
    }

    // decompiled from Move bytecode v6
}

