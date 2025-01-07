module 0x1f6061d9818ce20da38b1ab4e7fe9c324ee6d1dab5dc9bbb328d4170094dd33::pry {
    struct PRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRY>(arg0, 9, b"PRY", b"Perry ", b"A nice token for the future ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6c02ea60-26de-4eeb-824e-231a3e059026.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PRY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PRY>>(v1);
    }

    // decompiled from Move bytecode v6
}

