module 0x31fa61cfe40773a1dcab3874220750684893ecc235ae20eb4eb6c8560038c4e0::lester {
    struct LESTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: LESTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LESTER>(arg0, 9, b"LESTER", b"Lester", b"Lest lo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/164950e4-90fb-413c-a0cd-b4e10178efe7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LESTER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LESTER>>(v1);
    }

    // decompiled from Move bytecode v6
}

