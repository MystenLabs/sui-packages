module 0xdf4933300a5a60b7a8e5d595bea1d506a251e0697a437182bed4d3c9be926897::pengsuinuioui {
    struct PENGSUINUIOUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PENGSUINUIOUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PENGSUINUIOUI>(arg0, 6, b"PengSuiNuiOui", b"Pengui Sui Nui Oui", b"the cheerful world of penguins", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigrj2tyiuhuaiyghrdbw5uhfzfoykl5iiiky7ih7zsgistai2ix2i")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PENGSUINUIOUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PENGSUINUIOUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

