module 0x3e029f0ab8e915f93f240a0148265fc1d9e12162794a8a240d4eba1fa932e4dd::duckai {
    struct DUCKAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUCKAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUCKAI>(arg0, 6, b"DUCKAI", b"DONALDUCKAI", b"A duck AI agent that will help you invest and manage your finances", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736929060459.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DUCKAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUCKAI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

