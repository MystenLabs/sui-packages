module 0x2568064e9d8c226411e9ea29bd177f1003ba3264477630f87b76f358f848f4a3::bab {
    struct BAB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAB>(arg0, 9, b"BAB", b"BABY", b"LITTLE MAN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6cb80f74-cefc-474f-af0e-2f8f6a584c1a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BAB>>(v1);
    }

    // decompiled from Move bytecode v6
}

