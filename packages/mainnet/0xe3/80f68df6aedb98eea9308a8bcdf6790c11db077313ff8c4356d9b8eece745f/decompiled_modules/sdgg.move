module 0xe380f68df6aedb98eea9308a8bcdf6790c11db077313ff8c4356d9b8eece745f::sdgg {
    struct SDGG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDGG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDGG>(arg0, 9, b"SDGG", b"GSG", b"HFG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/354e7965-62bc-4951-a9ca-143f24d5c740.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDGG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SDGG>>(v1);
    }

    // decompiled from Move bytecode v6
}

