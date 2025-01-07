module 0x6c8b3e86dfa7529f64fc1436e78d2a2cb308451ce429767e81cf6462f11f0868::wl {
    struct WL has drop {
        dummy_field: bool,
    }

    fun init(arg0: WL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WL>(arg0, 9, b"WL", b"Wallet", b"Wave Wallet", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/95493817-d4c9-43b6-8fb3-04b11f1bfcd9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WL>>(v1);
    }

    // decompiled from Move bytecode v6
}

