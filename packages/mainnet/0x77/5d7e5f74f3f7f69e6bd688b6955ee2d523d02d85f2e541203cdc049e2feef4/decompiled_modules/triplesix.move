module 0x775d7e5f74f3f7f69e6bd688b6955ee2d523d02d85f2e541203cdc049e2feef4::triplesix {
    struct TRIPLESIX has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRIPLESIX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRIPLESIX>(arg0, 9, b"TRIPLESIX", b"Morroc", b"No project, just people power! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/49561560-b03f-4c56-beab-1df08933ef02-1000085846.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRIPLESIX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRIPLESIX>>(v1);
    }

    // decompiled from Move bytecode v6
}

