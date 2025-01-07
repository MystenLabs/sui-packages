module 0x159b084e2a35d8e4f7945430c2798b95cc6bffbca1caf3cc793256e123bf1e60::dv {
    struct DV has drop {
        dummy_field: bool,
    }

    fun init(arg0: DV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DV>(arg0, 9, b"DV", b"Dove", b"Just like a dove in the sky, fly free.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d896a59b-3b48-46e0-a03d-f1fb8cd7e990.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DV>>(v1);
    }

    // decompiled from Move bytecode v6
}

