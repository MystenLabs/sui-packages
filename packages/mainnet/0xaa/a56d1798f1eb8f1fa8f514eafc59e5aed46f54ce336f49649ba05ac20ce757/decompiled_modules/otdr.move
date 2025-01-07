module 0xaaa56d1798f1eb8f1fa8f514eafc59e5aed46f54ce336f49649ba05ac20ce757::otdr {
    struct OTDR has drop {
        dummy_field: bool,
    }

    fun init(arg0: OTDR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OTDR>(arg0, 9, b"OTDR", b"OtterDolla", b" For otterly good returns.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/50f6872f-5c1a-4e53-813d-7f7d13a59b89.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OTDR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OTDR>>(v1);
    }

    // decompiled from Move bytecode v6
}

