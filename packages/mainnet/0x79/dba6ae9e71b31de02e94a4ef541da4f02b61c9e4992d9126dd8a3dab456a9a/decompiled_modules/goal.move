module 0x79dba6ae9e71b31de02e94a4ef541da4f02b61c9e4992d9126dd8a3dab456a9a::goal {
    struct GOAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOAL>(arg0, 9, b"GOAL", b"GOAL PUMP", b"GOAL PUMP To the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0adfd4ed-794c-4ecd-a7cf-d3a73d087bfb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GOAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

