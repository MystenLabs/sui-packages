module 0x6ef3547846e3f2bf4245293474324d9af6e3a3de055f1a02020b1017cab21ae3::ywjs {
    struct YWJS has drop {
        dummy_field: bool,
    }

    fun init(arg0: YWJS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YWJS>(arg0, 9, b"YWJS", b"gdjd", b"bdb", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0e6e20b3-c7d7-414e-b238-1c0a36431c08.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YWJS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YWJS>>(v1);
    }

    // decompiled from Move bytecode v6
}

