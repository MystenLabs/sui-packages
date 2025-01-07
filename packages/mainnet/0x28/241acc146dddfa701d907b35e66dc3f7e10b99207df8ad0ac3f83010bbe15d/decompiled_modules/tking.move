module 0x28241acc146dddfa701d907b35e66dc3f7e10b99207df8ad0ac3f83010bbe15d::tking {
    struct TKING has drop {
        dummy_field: bool,
    }

    fun init(arg0: TKING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TKING>(arg0, 9, b"TKING", b"Tiger king", b"Love you ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b2329045-f1df-4ea4-b945-7a14ef766381-IMG-20240504-WA0002.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TKING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TKING>>(v1);
    }

    // decompiled from Move bytecode v6
}

