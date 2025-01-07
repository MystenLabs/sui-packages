module 0x6a89ee69efad9b0d95212eb22b015b6f4a616732a966787c3772c784c7276e4b::lazycat {
    struct LAZYCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAZYCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LAZYCAT>(arg0, 9, b"LAZYCAT", b"Lazy", b"Meme coin. J4f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/87c2b2c2-1631-4e56-95bd-05f4eb640035.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LAZYCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LAZYCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

