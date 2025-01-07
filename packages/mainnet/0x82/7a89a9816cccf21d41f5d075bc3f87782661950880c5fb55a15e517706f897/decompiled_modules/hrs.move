module 0x827a89a9816cccf21d41f5d075bc3f87782661950880c5fb55a15e517706f897::hrs {
    struct HRS has drop {
        dummy_field: bool,
    }

    fun init(arg0: HRS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HRS>(arg0, 9, b"HRS", b"BLUE HORSE", b"Experience the power of the Blue Horse.\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0f0d5c91-f6ad-4d67-b67a-482644bca8b0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HRS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HRS>>(v1);
    }

    // decompiled from Move bytecode v6
}

