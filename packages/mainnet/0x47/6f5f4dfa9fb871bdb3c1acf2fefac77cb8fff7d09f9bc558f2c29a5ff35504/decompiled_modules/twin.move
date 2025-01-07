module 0x476f5f4dfa9fb871bdb3c1acf2fefac77cb8fff7d09f9bc558f2c29a5ff35504::twin {
    struct TWIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TWIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TWIN>(arg0, 9, b"TWIN", b"TwinTower", b"Twin Tower", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bf67fab4-e18c-4c0c-a4f4-4ecbc4f212f8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TWIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TWIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

