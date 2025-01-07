module 0xe1b891b23803cad6ae19c4c9e28f72624926dd0e4b41ac691a1a9d80b2dbe96d::gmcoin {
    struct GMCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GMCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GMCOIN>(arg0, 9, b"GMCOIN", b"GMC", b"Community token ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/60a646d3-e52e-4440-8e81-6403374e2c45.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GMCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GMCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

