module 0xb0122c04b490a9ef533c5c406a6a61339879548c1579aa4ca94e1abd2d0ad97e::tuku {
    struct TUKU has drop {
        dummy_field: bool,
    }

    fun init(arg0: TUKU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TUKU>(arg0, 9, b"TUKU", b"Tukumaka", b"Just a man", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/50af5c24-9884-4b7c-a87f-578c9bb31df0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TUKU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TUKU>>(v1);
    }

    // decompiled from Move bytecode v6
}

