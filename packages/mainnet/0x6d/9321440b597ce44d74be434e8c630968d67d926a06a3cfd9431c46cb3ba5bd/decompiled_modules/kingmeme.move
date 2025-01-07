module 0x6d9321440b597ce44d74be434e8c630968d67d926a06a3cfd9431c46cb3ba5bd::kingmeme {
    struct KINGMEME has drop {
        dummy_field: bool,
    }

    fun init(arg0: KINGMEME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KINGMEME>(arg0, 9, b"KINGMEME", b"nin", b"a new meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ddcd4999-ec41-4500-945e-c75ceaf8bad9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KINGMEME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KINGMEME>>(v1);
    }

    // decompiled from Move bytecode v6
}

