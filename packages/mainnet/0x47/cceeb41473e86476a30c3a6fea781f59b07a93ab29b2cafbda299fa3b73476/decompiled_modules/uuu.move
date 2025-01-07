module 0x47cceeb41473e86476a30c3a6fea781f59b07a93ab29b2cafbda299fa3b73476::uuu {
    struct UUU has drop {
        dummy_field: bool,
    }

    fun init(arg0: UUU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UUU>(arg0, 6, b"UUU", b"UUUT", b"XXX", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cetus-1.gitbook.io/~gitbook/image?url=https%3A%2F%2F1666578391-files.gitbook.io%2F%7E%2Ffiles%2Fv0%2Fb%2Fgitbook-x-prod.appspot.com%2Fo%2Fspaces%252FA2PGyy4VtU6V9KDHXtio%252Ficon%252FVRK68eHAZw8xbRSgjg2G%252Fcetus_icon.png%3Falt%3Dmedia%26token%3Ddef45084-716b-4d9c-a952-0a7f4bbdb1d1&width=32&dpr=2&quality=100&sign=39da5624&sv=1")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<UUU>(&mut v2, 666666666000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UUU>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UUU>>(v1);
    }

    // decompiled from Move bytecode v6
}

