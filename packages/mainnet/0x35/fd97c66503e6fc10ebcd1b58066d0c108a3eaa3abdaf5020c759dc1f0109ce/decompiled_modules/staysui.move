module 0x35fd97c66503e6fc10ebcd1b58066d0c108a3eaa3abdaf5020c759dc1f0109ce::staysui {
    struct STAYSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: STAYSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STAYSUI>(arg0, 6, b"STAYSUI", b"STAY SUI", b"Stay stay stay stay stay stay Sui!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigb26vnsd2w5hvzmgz5g3qjcmrjfw2uxc66l7gxzqo7hfg7en7l4i")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STAYSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<STAYSUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

