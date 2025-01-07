module 0x7365f93aa84a9a323a64d8ef4e5468828a3e216b01e8928e12b76fad96c1575a::lifeguard2 {
    struct LIFEGUARD2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIFEGUARD2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIFEGUARD2>(arg0, 9, b"LIFEGUARD2", b"SURF", x"4c6574e2809973207269646520776176657320746f6765746865722049e280996c6c20677569646520796f7520f09f8f84e2808de29982efb88ff09f8c8a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/454c25de-97f7-49dc-8729-03d44d2de09b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIFEGUARD2>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LIFEGUARD2>>(v1);
    }

    // decompiled from Move bytecode v6
}

