module 0x982e39eaa9cd227cb445323c78a187029b6903f90825e187b6a9c9be515965d7::fd {
    struct FD has drop {
        dummy_field: bool,
    }

    fun init(arg0: FD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FD>(arg0, 9, b"FD", b"Sa", b"As gh ij", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9a402d4d-b46e-49b5-aeb9-e09b3b42a2b5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FD>>(v1);
    }

    // decompiled from Move bytecode v6
}

