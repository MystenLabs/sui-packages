module 0x9b9c80b4249cf62c5f2164fb4ad3255dd42ff591d3b28c4e9024970a8692f6d0::morty {
    struct MORTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MORTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MORTY>(arg0, 9, b"MORTY", b"Morty", b"Morty Smith ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e2cee748-715a-4a14-964f-829e1e681cd7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MORTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MORTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

