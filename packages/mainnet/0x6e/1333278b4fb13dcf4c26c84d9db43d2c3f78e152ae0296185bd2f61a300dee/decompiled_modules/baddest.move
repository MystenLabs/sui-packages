module 0x6e1333278b4fb13dcf4c26c84d9db43d2c3f78e152ae0296185bd2f61a300dee::baddest {
    struct BADDEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: BADDEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BADDEST>(arg0, 9, b"BADDEST", b"Badi", b"I'm the one", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c01983bf-46d2-4cbb-a190-662ac1e5fe19.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BADDEST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BADDEST>>(v1);
    }

    // decompiled from Move bytecode v6
}

