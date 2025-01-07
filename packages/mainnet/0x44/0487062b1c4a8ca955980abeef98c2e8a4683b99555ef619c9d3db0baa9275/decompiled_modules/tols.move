module 0x440487062b1c4a8ca955980abeef98c2e8a4683b99555ef619c9d3db0baa9275::tols {
    struct TOLS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOLS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOLS>(arg0, 9, b"TOLS", b"tolstoy", b"Leo tolstoy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/25f271a8-caa2-44d5-abfd-5b80323ab4eb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOLS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOLS>>(v1);
    }

    // decompiled from Move bytecode v6
}

