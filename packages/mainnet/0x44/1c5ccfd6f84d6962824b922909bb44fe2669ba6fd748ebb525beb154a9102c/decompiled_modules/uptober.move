module 0x441c5ccfd6f84d6962824b922909bb44fe2669ba6fd748ebb525beb154a9102c::uptober {
    struct UPTOBER has drop {
        dummy_field: bool,
    }

    fun init(arg0: UPTOBER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UPTOBER>(arg0, 9, b"UPTOBER", b"Uptober", b"$UPTOBER the community that start the bullrun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ac2d6b38-f1ea-4476-ad40-0eb90eb8a95b-1000179213.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UPTOBER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UPTOBER>>(v1);
    }

    // decompiled from Move bytecode v6
}

