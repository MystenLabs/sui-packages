module 0x2899008fd365a2ea99f198da1f6598f8e9cf5289f804203a10d836a47b74fa2d::triplesix {
    struct TRIPLESIX has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRIPLESIX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRIPLESIX>(arg0, 9, b"TRIPLESIX", b"Morroc", b"No project, just people power! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0c7a1f9f-b4e3-463c-92eb-29acb442df4f-1000085846.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRIPLESIX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRIPLESIX>>(v1);
    }

    // decompiled from Move bytecode v6
}

