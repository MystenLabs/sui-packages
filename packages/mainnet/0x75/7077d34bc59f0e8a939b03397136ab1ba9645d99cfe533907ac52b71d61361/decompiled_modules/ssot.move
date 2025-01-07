module 0x757077d34bc59f0e8a939b03397136ab1ba9645d99cfe533907ac52b71d61361::ssot {
    struct SSOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSOT>(arg0, 9, b"SSOT", b"Ssotona", b"Ssotona check ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/385a28ce-55c1-4c36-8c67-a0fc9de201e8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SSOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

