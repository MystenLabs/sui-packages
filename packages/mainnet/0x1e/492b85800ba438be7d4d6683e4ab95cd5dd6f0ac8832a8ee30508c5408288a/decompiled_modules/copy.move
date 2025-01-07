module 0x1e492b85800ba438be7d4d6683e4ab95cd5dd6f0ac8832a8ee30508c5408288a::copy {
    struct COPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: COPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COPY>(arg0, 9, b"copy", b"copy cat", x"636f70792063617420ca87c990c99420ca8e646fc994", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<COPY>(&mut v2, 600000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COPY>>(v2, @0x4377c868be3687b19914a93fa18ae196bc14810054e241d40dc7ecef8868b863);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

