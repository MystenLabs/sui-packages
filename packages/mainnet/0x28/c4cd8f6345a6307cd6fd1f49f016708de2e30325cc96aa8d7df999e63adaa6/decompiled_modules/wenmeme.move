module 0x28c4cd8f6345a6307cd6fd1f49f016708de2e30325cc96aa8d7df999e63adaa6::wenmeme {
    struct WENMEME has drop {
        dummy_field: bool,
    }

    fun init(arg0: WENMEME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WENMEME>(arg0, 1, b"WENMEME", b"WENMEME", b"-WEN-", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WENMEME>(&mut v2, 100000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WENMEME>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WENMEME>>(v1);
    }

    // decompiled from Move bytecode v6
}

