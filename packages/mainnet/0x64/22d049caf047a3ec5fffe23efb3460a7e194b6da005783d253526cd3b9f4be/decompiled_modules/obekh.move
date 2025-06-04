module 0x6422d049caf047a3ec5fffe23efb3460a7e194b6da005783d253526cd3b9f4be::obekh {
    struct OBEKH has drop {
        dummy_field: bool,
    }

    fun init(arg0: OBEKH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OBEKH>(arg0, 6, b"Obekh", b"Obek", b"Bshs", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiebgwgt4llbliprxc46hm7ptkvcwutlnlqqddxvfz2rfnucuozi6q")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OBEKH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<OBEKH>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

