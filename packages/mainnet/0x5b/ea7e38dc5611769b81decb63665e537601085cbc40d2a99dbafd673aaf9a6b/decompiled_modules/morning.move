module 0x5bea7e38dc5611769b81decb63665e537601085cbc40d2a99dbafd673aaf9a6b::morning {
    struct MORNING has drop {
        dummy_field: bool,
    }

    fun init(arg0: MORNING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MORNING>(arg0, 9, b"MORNING", b"Morning", b"Good morning", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/776ba5fe-20f5-4673-bd82-ef6a82825ea0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MORNING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MORNING>>(v1);
    }

    // decompiled from Move bytecode v6
}

