module 0xcc61c05a6e251948f758750cb00267d2e07ac45ac56282c2184afba44e6009b4::dgsggsdg {
    struct DGSGGSDG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DGSGGSDG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DGSGGSDG>(arg0, 9, b"DGSGGSDG", b"SGfh", b"GSGDS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e6410cc7-1dda-4337-b4d0-85b356e0caca.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DGSGGSDG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DGSGGSDG>>(v1);
    }

    // decompiled from Move bytecode v6
}

