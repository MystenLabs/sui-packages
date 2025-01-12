module 0x2b0e90e77f65677238ac8f5ab3888e0ebb6cf4f7c015762c5b7653aaf10d9040::burp {
    struct BURP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BURP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BURP>(arg0, 9, b"BURP", b"BurpCoin", b"$BURPBecause holding it in was never an option ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmUJ2eJgz3PqTG8GpLgnWB79WURJLzkb3tRUCV5BtbRc2R")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BURP>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BURP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BURP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

