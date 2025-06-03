module 0xeb0d713dd86347aaaa80f805303a1a6f5eadb714a469294d6ad5a34de861f232::bunny {
    struct BUNNY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUNNY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUNNY>(arg0, 6, b"BUNNY", b"BUNNY SUI", x"42756e6e792053756920697320616c6c2061626f757420676f6f6420766962657320616e6420677265617420656e65726779210a437574652c20636f6d6d756e69747920706f77657265642c20616e6420686f7070696e6720746f7761726420746865206d6f6f6e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreib2hycbdhtvwd5dj5obxle3eitdctz75bn3kdszxjcvgiywjauxdi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUNNY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BUNNY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

