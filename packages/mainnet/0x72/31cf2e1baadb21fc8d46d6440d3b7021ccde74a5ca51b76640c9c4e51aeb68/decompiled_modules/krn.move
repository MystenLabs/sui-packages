module 0x7231cf2e1baadb21fc8d46d6440d3b7021ccde74a5ca51b76640c9c4e51aeb68::krn {
    struct KRN has drop {
        dummy_field: bool,
    }

    fun init(arg0: KRN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KRN>(arg0, 9, b"KRN", b"Kronos", b"KRONOS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a9e9b2c0-68db-4121-8158-fa3fbd53488a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KRN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KRN>>(v1);
    }

    // decompiled from Move bytecode v6
}

