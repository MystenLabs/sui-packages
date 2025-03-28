module 0x58c373a207df62ffef68d75610b623aa7cc4e2cc2cfbdc6fafe330603c8bce16::wwal {
    struct WWAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: WWAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WWAL>(arg0, 9, b"wWAL", x"e29d84efb88f2057414c", b"A Liquid Staking Wal Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://interestprotocol.infura-ipfs.io/ipfs/QmPLCVWv7citJSc813NbcbZnRSXAEJ4BWVKq4zK8pPVEWq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WWAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WWAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

