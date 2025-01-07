module 0x4c85c2dd9cec212796fb57af9291fce0a7192eb8b3e81f420ae3ee2d74ced75::visk {
    struct VISK has drop {
        dummy_field: bool,
    }

    fun init(arg0: VISK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VISK>(arg0, 9, b"VISK", b"Viski", b"Viski for everything", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e7a93ad8-8eb9-434a-9924-d4be417bd5d4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VISK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VISK>>(v1);
    }

    // decompiled from Move bytecode v6
}

