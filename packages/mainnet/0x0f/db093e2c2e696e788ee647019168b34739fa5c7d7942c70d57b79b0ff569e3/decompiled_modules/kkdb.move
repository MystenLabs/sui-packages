module 0xfdb093e2c2e696e788ee647019168b34739fa5c7d7942c70d57b79b0ff569e3::kkdb {
    struct KKDB has drop {
        dummy_field: bool,
    }

    fun init(arg0: KKDB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KKDB>(arg0, 9, b"KKDB", b"KKDB", b"KKDB", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/bafkreif6nvlmg2kwmd4zpfnpeeosshgdefipm3df4hezsylpz3qblfoex4")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<KKDB>>(0x2::coin::mint<KKDB>(&mut v2, 100000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KKDB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KKDB>>(v2, @0x0);
    }

    // decompiled from Move bytecode v7
}

