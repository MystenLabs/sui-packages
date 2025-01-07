module 0x6734613eaa59c1e6093b9c0e2a042e3b9f7c7a484f385106696e810031067853::zta {
    struct ZTA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZTA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZTA>(arg0, 9, b"ZTA", b"Zumta ", b"A musical/entertainment token ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/84622fba-3330-420f-8468-f7ffcd618636.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZTA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZTA>>(v1);
    }

    // decompiled from Move bytecode v6
}

