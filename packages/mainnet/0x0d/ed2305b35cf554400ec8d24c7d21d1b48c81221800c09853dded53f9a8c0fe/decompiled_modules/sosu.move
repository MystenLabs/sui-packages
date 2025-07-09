module 0xded2305b35cf554400ec8d24c7d21d1b48c81221800c09853dded53f9a8c0fe::sosu {
    struct SOSU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOSU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOSU>(arg0, 6, b"SOSU", b"SUKI ON SUI", b"Not followed by anyone you are following", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreia2nzm3c4w2ka7rgkktn2zmssxcwl665fcj267ens26bnxcpkrpmu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOSU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SOSU>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

