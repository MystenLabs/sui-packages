module 0xa1f2f1a0fe362b9d271e32f41e5745b81bdcda4f27912497e1f936813a9ce3e9::noob {
    struct NOOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOOB>(arg0, 9, b"NOOB", b"HellTy", b"So noob but so good", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e2a44fbe-ae35-4837-9cf5-760ce440a387.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOOB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NOOB>>(v1);
    }

    // decompiled from Move bytecode v6
}

