module 0xb012867cb0892fee26a9b5f1e8c74b850232f0ab9bb64da0dfef66111f29b306::suibulba {
    struct SUIBULBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBULBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBULBA>(arg0, 6, b"SUIBULBA", b"BULBASUI", b"Bulba bulba-sui! Suii-saur bulba bulba!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeif33krrdtra6ob4lzipj4r3u3c7rqronjnxaezm6v6d54l42jmle4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBULBA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIBULBA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

