module 0xff298a8a2ffc1098cc2f327109fa7d4fa11b03cf6ab82e32bf190692205d2169::soul {
    struct SOUL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOUL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOUL>(arg0, 9, b"SOUL", b"Soul Token", b"Ahhh, i'm witch bro! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/00c3efe5-6b82-40a9-94c7-9a28feb05572.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOUL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SOUL>>(v1);
    }

    // decompiled from Move bytecode v6
}

