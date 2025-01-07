module 0x95e65d5a5ed4882787e2d044e743c831e6d36eb513c8edeeb45a410c14b0a0d5::alam {
    struct ALAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALAM>(arg0, 9, b"ALAM", b"mas alam", b"comel", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8d9bed25-4233-4b7a-a108-9bf9d6debe5e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALAM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ALAM>>(v1);
    }

    // decompiled from Move bytecode v6
}

