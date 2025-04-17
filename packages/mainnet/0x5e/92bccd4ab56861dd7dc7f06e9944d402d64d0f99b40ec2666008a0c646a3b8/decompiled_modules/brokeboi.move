module 0x5e92bccd4ab56861dd7dc7f06e9944d402d64d0f99b40ec2666008a0c646a3b8::brokeboi {
    struct BROKEBOI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BROKEBOI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BROKEBOI>(arg0, 9, b"brokeboi", b"Tokenized baby", b"Tokenized baby on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmUYXDW5mSHQ2pkvY6xHdYWpvU5UR9uf3VKTgTkzTCo8UC")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BROKEBOI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BROKEBOI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BROKEBOI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

