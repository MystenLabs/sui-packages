module 0x6c0bf6629eb92d67f7cf1aae9632b794ca4c2e30ef92762ea871f67e639b83e1::marvel {
    struct MARVEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: MARVEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MARVEL>(arg0, 9, b"MARVEL", b"Deadpool", b"Marvel Jesus", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/528aeceb-1765-4a15-b122-763aa7851b3b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MARVEL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MARVEL>>(v1);
    }

    // decompiled from Move bytecode v6
}

