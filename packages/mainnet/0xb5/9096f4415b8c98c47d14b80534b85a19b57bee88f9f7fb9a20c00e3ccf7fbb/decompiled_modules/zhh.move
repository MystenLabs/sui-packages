module 0xb59096f4415b8c98c47d14b80534b85a19b57bee88f9f7fb9a20c00e3ccf7fbb::zhh {
    struct ZHH has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZHH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZHH>(arg0, 9, b"ZHH", b"Jjjj", b"Hhhhh", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/22a0175f-d182-48f4-9f5f-f8f50ccbaf9c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZHH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZHH>>(v1);
    }

    // decompiled from Move bytecode v6
}

