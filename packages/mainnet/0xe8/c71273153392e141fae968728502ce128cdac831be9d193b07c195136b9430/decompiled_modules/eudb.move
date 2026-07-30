module 0xe8c71273153392e141fae968728502ce128cdac831be9d193b07c195136b9430::eudb {
    struct EUDB has drop {
        dummy_field: bool,
    }

    fun init(arg0: EUDB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EUDB>(arg0, 9, b"EUDB", x"e6aca7e5b881", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/bafkreibiovatqdhmvxe6ipy5ettdqvmpyfen2laocjefpsp5fzofisoicy")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<EUDB>>(0x2::coin::mint<EUDB>(&mut v2, 100000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EUDB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EUDB>>(v2, @0x0);
    }

    // decompiled from Move bytecode v7
}

