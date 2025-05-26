module 0x9080f997c9b250b2e0aceabefb994ba939759f32679320397d72013b98ba556e::gwath {
    struct GWATH has drop {
        dummy_field: bool,
    }

    fun init(arg0: GWATH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GWATH>(arg0, 6, b"gwath", b"gwath", b"welyes", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GWATH>(&mut v2, 2000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GWATH>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GWATH>>(v1);
    }

    // decompiled from Move bytecode v6
}

