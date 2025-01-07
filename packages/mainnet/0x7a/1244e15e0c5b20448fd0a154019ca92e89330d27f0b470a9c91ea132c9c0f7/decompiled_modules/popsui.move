module 0x7a1244e15e0c5b20448fd0a154019ca92e89330d27f0b470a9c91ea132c9c0f7::popsui {
    struct POPSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPSUI>(arg0, 9, b"POPSUI", b"Poponsui", b"Popsui on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6686c754-ba33-4330-9e13-a21cefe1bbcd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POPSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

