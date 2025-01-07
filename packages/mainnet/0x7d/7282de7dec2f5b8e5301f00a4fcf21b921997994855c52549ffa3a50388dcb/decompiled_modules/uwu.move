module 0x7d7282de7dec2f5b8e5301f00a4fcf21b921997994855c52549ffa3a50388dcb::uwu {
    struct UWU has drop {
        dummy_field: bool,
    }

    fun init(arg0: UWU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UWU>(arg0, 9, b"UWU", b"UWUCLEAR", b"UWUCLEARS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5c31ed55-f069-41e4-8a64-5e16c235798e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UWU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UWU>>(v1);
    }

    // decompiled from Move bytecode v6
}

