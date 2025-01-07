module 0x4cc7aee64cb330f2d7b62178104252bea3997c77f288830f81349bd5972b9db1::rjjdf {
    struct RJJDF has drop {
        dummy_field: bool,
    }

    fun init(arg0: RJJDF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RJJDF>(arg0, 9, b"RJJDF", b"F ndnef", x"426462c49162", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d1e5df50-f1c2-4a56-b238-a23955f3a9e8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RJJDF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RJJDF>>(v1);
    }

    // decompiled from Move bytecode v6
}

