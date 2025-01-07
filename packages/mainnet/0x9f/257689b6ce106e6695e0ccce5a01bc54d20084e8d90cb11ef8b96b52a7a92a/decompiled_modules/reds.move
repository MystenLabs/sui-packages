module 0x9f257689b6ce106e6695e0ccce5a01bc54d20084e8d90cb11ef8b96b52a7a92a::reds {
    struct REDS has drop {
        dummy_field: bool,
    }

    fun init(arg0: REDS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REDS>(arg0, 9, b"REDS", b"Reditus", b"Mining token. 1 Reds equal 1Th power.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/50f0c0f1-046e-4c51-86aa-52f63b597eec.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REDS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<REDS>>(v1);
    }

    // decompiled from Move bytecode v6
}

