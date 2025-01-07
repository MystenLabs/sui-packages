module 0x774207aa0de1123cc5e43fac34ee8d115456b06c1764ec1ce628e2bf9ad4a895::suuuuuuuuuuuuuuuuuuuipike {
    struct SUUUUUUUUUUUUUUUUUUUIPIKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUUUUUUUUUUUUUUUUUUUIPIKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUUUUUUUUUUUUUUUUUUUIPIKE>(arg0, 0, b"SUUUUUUUUUUUUUUUUUUUIPIKE", b"SPIKE 1984 SUI", b"https://t.me/spike1984sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUUUUUUUUUUUUUUUUUUUIPIKE>(&mut v2, 7856412, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUUUUUUUUUUUUUUUUUUUIPIKE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUUUUUUUUUUUUUUUUUUUIPIKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

