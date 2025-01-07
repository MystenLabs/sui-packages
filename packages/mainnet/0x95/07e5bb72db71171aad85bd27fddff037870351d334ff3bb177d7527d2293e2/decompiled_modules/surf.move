module 0x9507e5bb72db71171aad85bd27fddff037870351d334ff3bb177d7527d2293e2::surf {
    struct SURF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SURF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SURF>(arg0, 9, b"SURF", b"SURF", b"MEME IS LITERALLY A MEME COIN.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmYzNtVYJz45FY4sdL7vyA4Zu9Sexh6Ebp78TvYy2ibGFm")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SURF>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SURF>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SURF>>(v1);
    }

    // decompiled from Move bytecode v6
}

