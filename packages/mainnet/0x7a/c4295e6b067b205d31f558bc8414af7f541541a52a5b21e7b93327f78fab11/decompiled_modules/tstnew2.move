module 0x7ac4295e6b067b205d31f558bc8414af7f541541a52a5b21e7b93327f78fab11::tstnew2 {
    struct TSTNEW2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TSTNEW2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TSTNEW2>(arg0, 6, b"TSTNEW2", b"TSTNEW2 Token", b"This is a test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeibxoqyrauo3po2milbl457qswcpzgdoju275mujji45tndpeej3ri")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TSTNEW2>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TSTNEW2>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

