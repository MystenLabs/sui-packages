module 0x63bd351866bb4a2e53d5e43b8b8030b0b0863b0a5ce2aa1f18a7406376a6e8af::mo278_25 {
    struct MO278_25 has drop {
        dummy_field: bool,
    }

    fun init(arg0: MO278_25, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MO278_25>(arg0, 9, b"MO278_25", b"Milami", b"A new meme token to featured on the L1 Blockchain technology ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e5b91ab0-494e-4e06-aed4-afcab3d70fc0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MO278_25>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MO278_25>>(v1);
    }

    // decompiled from Move bytecode v6
}

