module 0xa7a357041c37fe8295a4c1ae833a08c7be59ff1d3e4a2ae37de7ac514ba00125::sucat {
    struct SUCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUCAT>(arg0, 9, b"SUCAT", b"SUPERCAT", b"The first MEMECOIN that pays you to use it", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/47a2981a-2d02-41a8-a02f-988c3b02d55d-nWcOQZoe_400x400.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

