module 0x6b12d03aab6858f8e33419a30c5fbbf2704f6455786665cd7ee86d2220e9700e::di {
    struct DI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DI>(arg0, 9, b"DI", b"Dod", b"Sks are the best ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/deefad0d-6787-4d06-bdad-ac17d924c170.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DI>>(v1);
    }

    // decompiled from Move bytecode v6
}

