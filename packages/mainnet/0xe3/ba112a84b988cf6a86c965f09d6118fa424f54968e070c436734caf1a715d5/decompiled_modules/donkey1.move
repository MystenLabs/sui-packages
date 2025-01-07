module 0xe3ba112a84b988cf6a86c965f09d6118fa424f54968e070c436734caf1a715d5::donkey1 {
    struct DONKEY1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: DONKEY1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DONKEY1>(arg0, 9, b"DONKEY1", b"Donkey ", b"For", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c38044e5-257d-4412-8794-e0e248b95fb4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DONKEY1>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DONKEY1>>(v1);
    }

    // decompiled from Move bytecode v6
}

