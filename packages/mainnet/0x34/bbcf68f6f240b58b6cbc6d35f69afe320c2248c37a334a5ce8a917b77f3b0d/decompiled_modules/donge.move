module 0x34bbcf68f6f240b58b6cbc6d35f69afe320c2248c37a334a5ce8a917b77f3b0d::donge {
    struct DONGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DONGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DONGE>(arg0, 9, b"DONGE", b"Donge kong", b"Dongekong", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5f894eb8-9eca-4b80-90d8-597381b8596e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DONGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DONGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

