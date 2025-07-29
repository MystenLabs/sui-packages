module 0xc8a6c3548797880b48c9f8213ba3c2e844474d8e51417d2b3104c1a680150458::koisui {
    struct KOISUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOISUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOISUI>(arg0, 6, b"KOIsui", b"KOI", b"A Bold Fish Making Waves of Wealth in the Sui Ocean @SuiNetwork", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreict7bme7d5rj3rktgs5pilpt5kjgk7fywd5gxga5rsq3ufrskbiym")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOISUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KOISUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

