module 0xfef3fa8cee0c3925926a523f9bdec18a9e1d9844d30a41190c0adada10692c18::cre {
    struct CRE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRE>(arg0, 9, b"CRE", b"Creaz", b"Meme coin top 1 in the world", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/68e0218e-9840-4ef4-98a9-2c53e7bda070.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CRE>>(v1);
    }

    // decompiled from Move bytecode v6
}

