module 0xcf26c201ef332204809892d4041b7060e4d6ab9fd6be9926ef46c3a99bf7eda1::sq1000ty {
    struct SQ1000TY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQ1000TY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQ1000TY>(arg0, 9, b"SQ1000TY", b"SQUINTY", b"Playfully silly funny meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2d919260-75a8-4fb8-8018-7ab711e61f5d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQ1000TY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SQ1000TY>>(v1);
    }

    // decompiled from Move bytecode v6
}

