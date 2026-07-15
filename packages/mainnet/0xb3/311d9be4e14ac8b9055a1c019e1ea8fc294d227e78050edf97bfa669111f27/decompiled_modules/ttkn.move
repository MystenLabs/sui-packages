module 0xb3311d9be4e14ac8b9055a1c019e1ea8fc294d227e78050edf97bfa669111f27::ttkn {
    struct TTKN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TTKN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TTKN>(arg0, 9, b"TTKN", b"Test Token", b"A token to unlock features", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bafybeiglhdbtryupxkapn7tmx3qjuad5dnv4qxoq4j6uxkf5ze77xgnou4.ipfs.dweb.link?filename=test-image.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<TTKN>>(0x2::coin::mint<TTKN>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TTKN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TTKN>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

