module 0x74c11a4541f2a697d7cba871209d0cb7209bfe89154c234f09fe136866a0e199::muffinpaws {
    struct MUFFINPAWS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUFFINPAWS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUFFINPAWS>(arg0, 9, b"MUFFY", b"Muffinpaws", x"437574656e65737320736f20737765657420796f75722077616c6c6574206d6967687420676574206120746f6f746861636865e280944d756666696e7061777320616c77617973206c616e6473206f6e2069747320666565742c2070726566657261626c7920696e20612063757063616b6520747261792e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiap3wfd4zlph7qthdgsiabsxe34wpqvo23orgt4stxpb73w2xzxly")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MUFFINPAWS>(&mut v2, 1000000000000000000, @0x72c767ff9daadbf73e24475876ba497a7bc211f59e49cc673f495dd24420383b, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUFFINPAWS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MUFFINPAWS>>(v1);
    }

    // decompiled from Move bytecode v6
}

