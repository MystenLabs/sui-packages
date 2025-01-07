module 0xa5202a31bffa1bdcd4acaeb40976f9c91fadf7246b6ba02f289d57da2b0e00a2::chdjc {
    struct CHDJC has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHDJC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHDJC>(arg0, 9, b"CHDJC", x"686475e1babd68", x"6ac4916a646a636a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/760102b8-668e-4251-bdf9-e65f974ec8e0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHDJC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHDJC>>(v1);
    }

    // decompiled from Move bytecode v6
}

