module 0xbb053519e86dd94cbdf1359e96b8fa4ae688b9e9c082aa088eebfc468b7e66b9::bread_wal {
    struct BREAD_WAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BREAD_WAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BREAD_WAL>(arg0, 9, b"BreadWal", b"Bread Walrus", b"First Content Creator LST of Walrus of @Mrbreadsmith - Powered by @WalrusLST", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://interestprotocol.infura-ipfs.io/ipfs/QmZG3Mnc9QvwUbpweS3TtX8iLsYYyxGkXQEocpmh7MjpcX")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BREAD_WAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BREAD_WAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

