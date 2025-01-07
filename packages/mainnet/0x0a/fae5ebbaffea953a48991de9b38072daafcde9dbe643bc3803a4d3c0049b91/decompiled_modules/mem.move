module 0xafae5ebbaffea953a48991de9b38072daafcde9dbe643bc3803a4d3c0049b91::mem {
    struct MEM has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEM>(arg0, 9, b"MEM", b"Mem", b"Just a mem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/61e02035-b0bb-4748-9354-629c10a93c66.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEM>>(v1);
    }

    // decompiled from Move bytecode v6
}

