module 0x9565a9a67948a2864d220e2301eb2adac8b50d3adb7fb0a397aa2a71423ab3ea::g2o2 {
    struct G2O2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: G2O2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<G2O2>(arg0, 9, b"G2O2", b"Gogo", b"It is gogo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b040fa06-ce9f-4e03-a289-5fcf6f70b460.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<G2O2>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<G2O2>>(v1);
    }

    // decompiled from Move bytecode v6
}

