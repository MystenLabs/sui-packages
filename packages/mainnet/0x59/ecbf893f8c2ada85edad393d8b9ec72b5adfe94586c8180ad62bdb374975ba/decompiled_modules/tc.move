module 0x59ecbf893f8c2ada85edad393d8b9ec72b5adfe94586c8180ad62bdb374975ba::tc {
    struct TC has drop {
        dummy_field: bool,
    }

    fun init(arg0: TC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TC>(arg0, 9, b"TC", b"Thuan Capi", x"546875e1baad6e204361706974616c", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e9fcedbe-c5c0-4520-b672-da36a0df7407.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TC>>(v1);
    }

    // decompiled from Move bytecode v6
}

