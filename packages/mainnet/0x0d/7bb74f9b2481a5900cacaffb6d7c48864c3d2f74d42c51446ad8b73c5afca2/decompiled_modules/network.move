module 0xd7bb74f9b2481a5900cacaffb6d7c48864c3d2f74d42c51446ad8b73c5afca2::network {
    struct NETWORK has drop {
        dummy_field: bool,
    }

    fun init(arg0: NETWORK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NETWORK>(arg0, 9, b"NETWORK", b"Pi", b"Pi ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/edcd6ea3-1a60-43c9-9f28-71784bf45057.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NETWORK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NETWORK>>(v1);
    }

    // decompiled from Move bytecode v6
}

