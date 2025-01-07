module 0xaac07397628e8799566088cc4a5b0d9db98a3c001cbac717cd5f0eb02e884921::hpn {
    struct HPN has drop {
        dummy_field: bool,
    }

    fun init(arg0: HPN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HPN>(arg0, 9, b"HPN", b"Hop bun", b"Bunny hop royal", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/60d06e0e-a0a2-4ead-823f-21d5774c4a64.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HPN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HPN>>(v1);
    }

    // decompiled from Move bytecode v6
}

