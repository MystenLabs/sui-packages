module 0x6a590f39fa4a94fb193793d1785d1ee0eb0a19c944670a5eb6fd1316a5027abc::usdcw {
    struct USDCW has drop {
        dummy_field: bool,
    }

    fun init(arg0: USDCW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USDCW>(arg0, 9, b"USDCw", b"Usdc wherwlof", b"Dhhjfht bggfj", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<USDCW>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDCW>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<USDCW>>(v1);
    }

    // decompiled from Move bytecode v6
}

