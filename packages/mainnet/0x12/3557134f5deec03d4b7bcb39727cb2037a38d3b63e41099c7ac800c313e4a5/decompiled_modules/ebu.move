module 0x123557134f5deec03d4b7bcb39727cb2037a38d3b63e41099c7ac800c313e4a5::ebu {
    struct EBU has drop {
        dummy_field: bool,
    }

    fun init(arg0: EBU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EBU>(arg0, 9, b"EBU", b"Ebullient ", b"A futurist and an entrepreneur ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bc183e46-36ae-44eb-9ed3-fed9e3ee65e8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EBU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EBU>>(v1);
    }

    // decompiled from Move bytecode v6
}

