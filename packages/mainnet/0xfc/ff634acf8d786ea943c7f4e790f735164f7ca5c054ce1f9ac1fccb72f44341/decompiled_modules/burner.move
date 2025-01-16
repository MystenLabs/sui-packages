module 0xfcff634acf8d786ea943c7f4e790f735164f7ca5c054ce1f9ac1fccb72f44341::burner {
    struct BURNER has drop {
        dummy_field: bool,
    }

    fun init(arg0: BURNER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BURNER>(arg0, 9, b"BURNER", b"Trump Burner", b"I will make America's economy truly crypto!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmcNff1nhf5ttJmmjPqU7WAkEnZuvpRKC4EkdJVtkYok1D")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BURNER>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BURNER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BURNER>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

