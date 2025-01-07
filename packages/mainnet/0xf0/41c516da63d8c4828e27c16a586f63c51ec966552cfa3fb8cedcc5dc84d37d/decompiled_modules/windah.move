module 0xf041c516da63d8c4828e27c16a586f63c51ec966552cfa3fb8cedcc5dc84d37d::windah {
    struct WINDAH has drop {
        dummy_field: bool,
    }

    fun init(arg0: WINDAH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WINDAH>(arg0, 9, b"WINDAH", b"Windut", b"Windah Gendut", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/dd6335ec-91f5-4eed-ae1d-e8adbc6bbd3d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WINDAH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WINDAH>>(v1);
    }

    // decompiled from Move bytecode v6
}

