module 0x27aaca67abd39964a93f56d18e26b4133ae676af1f1c0ed5a660d526440e95d9::ns {
    struct NS has drop {
        dummy_field: bool,
    }

    fun init(arg0: NS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NS>(arg0, 9, b"NS", b"SuiNS Token", b"The native token for the SuiNS Protocol.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://token-image.suins.io/icon.svg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<NS>>(0x2::coin::mint<NS>(&mut v2, 500000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<NS>>(v2);
    }

    // decompiled from Move bytecode v6
}

