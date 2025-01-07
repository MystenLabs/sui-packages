module 0xc725e405e8f04f89a1a9e03b502d9cd04fca060927b0532a2347fd571a409554::NST {
    struct NST has drop {
        dummy_field: bool,
    }

    fun init(arg0: NST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NST>(arg0, 9, b"NS", b"SuiNS Token", b"The native token for the SuiNS Protocol.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://token-image.suins.io/icon.svg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NST>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<NST>>(0x2::coin::mint<NST>(&mut v2, 500000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<NST>>(v2);
    }

    // decompiled from Move bytecode v6
}

