module 0x72ea6ff5eea0e7ecb907f6e3ae98af4af9a5cdf7b906928e09b65e5de99e706b::oendb {
    struct OENDB has drop {
        dummy_field: bool,
    }

    fun init(arg0: OENDB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OENDB>(arg0, 9, b"OENDB", b"sjekek", b"dbhej", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a0079e0b-2b14-4983-84e0-d1291283662c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OENDB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OENDB>>(v1);
    }

    // decompiled from Move bytecode v6
}

