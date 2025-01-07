module 0x5c7d13881e29457f9ffe101b8038f77470186a4bc0c1560930dbe7033275cb67::sirp {
    struct SIRP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIRP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIRP>(arg0, 9, b"SIRP", b"SIRP COIN", b"The bird that sings politely, as if following etiquette rules.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4e2af1ad-4c10-4efb-a38b-c0c138df41a8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIRP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SIRP>>(v1);
    }

    // decompiled from Move bytecode v6
}

