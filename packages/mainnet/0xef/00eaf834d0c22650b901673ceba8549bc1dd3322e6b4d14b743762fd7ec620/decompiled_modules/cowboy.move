module 0xef00eaf834d0c22650b901673ceba8549bc1dd3322e6b4d14b743762fd7ec620::cowboy {
    struct COWBOY has drop {
        dummy_field: bool,
    }

    fun init(arg0: COWBOY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COWBOY>(arg0, 9, b"COWBOY", b"sharcat", b"Enjoy the Cheroni shark", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/37a0ad7f-0fa3-454b-81f4-52d3c0e18c9b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COWBOY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COWBOY>>(v1);
    }

    // decompiled from Move bytecode v6
}

