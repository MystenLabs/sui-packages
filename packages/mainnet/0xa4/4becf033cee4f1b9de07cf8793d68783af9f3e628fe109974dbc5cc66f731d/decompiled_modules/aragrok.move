module 0xa44becf033cee4f1b9de07cf8793d68783af9f3e628fe109974dbc5cc66f731d::aragrok {
    struct ARAGROK has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARAGROK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ARAGROK>(arg0, 6, b"ARAGROK", b"Ara Grok Companion Sui", b"Ara Grok Companion", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifv7kvnjm4oox4dmnwava2iu7y5lnfeegiu3xmfncls6minhrmz2y")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARAGROK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ARAGROK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

