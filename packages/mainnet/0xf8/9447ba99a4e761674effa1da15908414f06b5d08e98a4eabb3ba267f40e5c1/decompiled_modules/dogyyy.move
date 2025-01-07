module 0xf89447ba99a4e761674effa1da15908414f06b5d08e98a4eabb3ba267f40e5c1::dogyyy {
    struct DOGYYY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGYYY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGYYY>(arg0, 9, b"DOGYYY", b"Dogyy", b"Meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e819780c-7145-4934-bc6d-8c02d838b819.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGYYY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGYYY>>(v1);
    }

    // decompiled from Move bytecode v6
}

