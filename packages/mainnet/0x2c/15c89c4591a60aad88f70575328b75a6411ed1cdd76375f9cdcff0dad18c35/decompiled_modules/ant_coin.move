module 0x2c15c89c4591a60aad88f70575328b75a6411ed1cdd76375f9cdcff0dad18c35::ant_coin {
    struct ANT_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANT_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::epoch(arg1) == 819 || 0x2::tx_context::epoch(arg1) == 820, 1);
        let (v0, v1) = 0x2::coin::create_currency<ANT_COIN>(arg0, 9, b"ANT", b"Ant Coin", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.filebase.io/ipfs/QmXY7w4HNAeTpPnYaCt8XrEw1h2xBzc3B8uBXDkERkiFi2"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ANT_COIN>(&mut v2, 10000000000000000000, @0xb65667cd24bac7dde3f391cd77ce621af4f80f4aae232da751ab776db983daf1, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANT_COIN>>(v2, @0xb65667cd24bac7dde3f391cd77ce621af4f80f4aae232da751ab776db983daf1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ANT_COIN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

