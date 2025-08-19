module 0xdbba0bf90f7735fb853d11d6e8c718bfc58ae4b02c8bf615b92faed8d870777f::beatai {
    struct BEATAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEATAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEATAI>(arg0, 6, b"BEATAI", b"eBeat AI ($BEAT)", b"Revolutionizes the music creation process by combining the power of Al and Blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreic4b6taxfhcy3pgrr6choeqzhoode5gplwjvvtt2tr6zlvso7lf24")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEATAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BEATAI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

