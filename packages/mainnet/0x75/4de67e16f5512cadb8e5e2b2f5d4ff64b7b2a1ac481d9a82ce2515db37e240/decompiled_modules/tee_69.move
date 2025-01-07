module 0x754de67e16f5512cadb8e5e2b2f5d4ff64b7b2a1ac481d9a82ce2515db37e240::tee_69 {
    struct TEE_69 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEE_69, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEE_69>(arg0, 9, b"TEE_69", b"Tee", b"For fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d60a49b8-cf77-4137-aa2e-10c16cc1b3bd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEE_69>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEE_69>>(v1);
    }

    // decompiled from Move bytecode v6
}

