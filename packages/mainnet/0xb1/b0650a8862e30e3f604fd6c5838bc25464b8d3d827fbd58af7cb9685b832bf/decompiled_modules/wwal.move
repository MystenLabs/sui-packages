module 0xb1b0650a8862e30e3f604fd6c5838bc25464b8d3d827fbd58af7cb9685b832bf::wwal {
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

