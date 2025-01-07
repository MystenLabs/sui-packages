module 0x204e27f16640450941b048a1a7e77fbae38dc669cdec139278a6aa633e24f8ff::syg {
    struct SYG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SYG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SYG>(arg0, 9, b"SYG", b"See you", b"See you again", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/257a2a3a-01ef-4b19-8995-a3bae779341a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SYG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SYG>>(v1);
    }

    // decompiled from Move bytecode v6
}

