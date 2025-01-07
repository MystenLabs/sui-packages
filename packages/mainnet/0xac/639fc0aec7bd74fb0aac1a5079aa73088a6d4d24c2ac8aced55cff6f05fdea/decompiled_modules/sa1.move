module 0xac639fc0aec7bd74fb0aac1a5079aa73088a6d4d24c2ac8aced55cff6f05fdea::sa1 {
    struct SA1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SA1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SA1>(arg0, 9, b"SA1", b"songanh", b"SA1 toekn", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0bfe6219-fca3-4fe3-9974-512f8e820165.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SA1>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SA1>>(v1);
    }

    // decompiled from Move bytecode v6
}

