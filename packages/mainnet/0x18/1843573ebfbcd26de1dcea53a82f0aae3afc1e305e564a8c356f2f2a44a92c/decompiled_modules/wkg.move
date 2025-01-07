module 0x181843573ebfbcd26de1dcea53a82f0aae3afc1e305e564a8c356f2f2a44a92c::wkg {
    struct WKG has drop {
        dummy_field: bool,
    }

    fun init(arg0: WKG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WKG>(arg0, 9, b"WKG", b"Wokang", b"Wokang fan token ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1a5816f7-a1db-4c12-8aed-7f80b2195fcc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WKG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WKG>>(v1);
    }

    // decompiled from Move bytecode v6
}

