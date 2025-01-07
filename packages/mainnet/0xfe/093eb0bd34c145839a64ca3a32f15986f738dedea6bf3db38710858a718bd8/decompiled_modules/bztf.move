module 0xfe093eb0bd34c145839a64ca3a32f15986f738dedea6bf3db38710858a718bd8::bztf {
    struct BZTF has drop {
        dummy_field: bool,
    }

    fun init(arg0: BZTF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BZTF>(arg0, 6, b"bztf", b"bztf", b"in", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BZTF>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BZTF>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BZTF>>(v1);
    }

    // decompiled from Move bytecode v6
}

