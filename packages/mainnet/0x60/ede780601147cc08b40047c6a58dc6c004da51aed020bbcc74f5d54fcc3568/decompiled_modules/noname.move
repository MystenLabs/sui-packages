module 0x60ede780601147cc08b40047c6a58dc6c004da51aed020bbcc74f5d54fcc3568::noname {
    struct NONAME has drop {
        dummy_field: bool,
    }

    fun init(arg0: NONAME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NONAME>(arg0, 9, b"NONAME", b"NONAM", b"Atata Noname", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4df1b6dd-3b2c-4849-91fd-5b5dbc5d66a4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NONAME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NONAME>>(v1);
    }

    // decompiled from Move bytecode v6
}

