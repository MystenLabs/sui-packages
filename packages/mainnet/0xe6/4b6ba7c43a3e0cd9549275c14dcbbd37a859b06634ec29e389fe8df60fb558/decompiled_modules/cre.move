module 0xe64b6ba7c43a3e0cd9549275c14dcbbd37a859b06634ec29e389fe8df60fb558::cre {
    struct CRE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRE>(arg0, 9, b"CRE", b"Creeez", b"just a meme coin by Chos", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c0d2594e-76f7-4a62-85b0-7e2f1942652a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CRE>>(v1);
    }

    // decompiled from Move bytecode v6
}

