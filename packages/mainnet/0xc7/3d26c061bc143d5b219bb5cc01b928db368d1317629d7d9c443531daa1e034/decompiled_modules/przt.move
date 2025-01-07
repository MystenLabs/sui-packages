module 0xc73d26c061bc143d5b219bb5cc01b928db368d1317629d7d9c443531daa1e034::przt {
    struct PRZT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PRZT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRZT>(arg0, 9, b"PRZT", b"Parazito", b"ZhIV", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d348e109-7e81-4939-8fdb-15226e4068c0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PRZT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PRZT>>(v1);
    }

    // decompiled from Move bytecode v6
}

