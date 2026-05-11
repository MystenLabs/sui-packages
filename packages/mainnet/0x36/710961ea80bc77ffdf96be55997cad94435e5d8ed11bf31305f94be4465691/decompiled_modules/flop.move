module 0x36710961ea80bc77ffdf96be55997cad94435e5d8ed11bf31305f94be4465691::flop {
    struct FLOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLOP>(arg0, 9, b"FLOP", b"Flop", b"Flop is the seal of Sui. Born from the community, built for the culture, and here to bring fun back onchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/bafkreiecousxvwsorqkjp2jwk2pzehyxvbg4mafv4obdfgt3gqnknmphb4")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<FLOP>>(0x2::coin::mint<FLOP>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FLOP>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<FLOP>>(v2);
    }

    // decompiled from Move bytecode v7
}

