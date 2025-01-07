module 0xc4f37e8cdeddc2cb8a414ed736dc81c609729e1801c45ba447a4c8fe518e2706::skl {
    struct SKL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKL>(arg0, 9, b"SKL", b"Skeleton", b"Skeleton waiting on bench in the park", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/beae88ae-e8fe-42fa-9ce0-7061e562e0fe.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SKL>>(v1);
    }

    // decompiled from Move bytecode v6
}

