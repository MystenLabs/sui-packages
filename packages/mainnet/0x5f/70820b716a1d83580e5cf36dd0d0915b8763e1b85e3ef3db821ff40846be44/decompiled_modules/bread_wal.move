module 0x5f70820b716a1d83580e5cf36dd0d0915b8763e1b85e3ef3db821ff40846be44::bread_wal {
    struct BREAD_WAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BREAD_WAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BREAD_WAL>(arg0, 9, b"BreadWal", b"Bread Walrus", b"First Content Creator LST of Walrus of @Mrbreadsmith - Powered by @WalrusLST", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://interestprotocol.infura-ipfs.io/ipfs/QmPrMy99KRFygqPu16nztkEPLtDMA4nr3nks2YybJw5Tro")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BREAD_WAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BREAD_WAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

