module 0x568d5c67c442c836a12aa3d9f7bbe9acff34b1f5fb1b8f584e575d147239925a::jmh {
    struct JMH has drop {
        dummy_field: bool,
    }

    fun init(arg0: JMH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JMH>(arg0, 9, b"JMH", b"JIMAH", b"Defining Technology in its best ways", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/73e37cc3-80bd-4033-b018-8290fbbdc766.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JMH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JMH>>(v1);
    }

    // decompiled from Move bytecode v6
}

