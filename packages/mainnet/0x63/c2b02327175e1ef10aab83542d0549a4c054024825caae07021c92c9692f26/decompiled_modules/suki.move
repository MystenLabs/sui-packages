module 0x63c2b02327175e1ef10aab83542d0549a4c054024825caae07021c92c9692f26::suki {
    struct SUKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUKI>(arg0, 6, b"SUKI", b"SUKI ON SUI", b"Suki is a bold blue spirit born on Sui Chain , a symbol of rebellion, randomness, and unstoppable belief.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreia2nzm3c4w2ka7rgkktn2zmssxcwl665fcj267ens26bnxcpkrpmu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUKI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

