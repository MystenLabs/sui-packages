module 0xb4f0e0adfbb57aa3ca45eb7254469c93e62c527e39285b97e2354bf9b3957eb1::arasui {
    struct ARASUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARASUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ARASUI>(arg0, 6, b"ARASUI", b"ara grok sui", b"ara grok companion sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifv7kvnjm4oox4dmnwava2iu7y5lnfeegiu3xmfncls6minhrmz2y")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARASUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ARASUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

