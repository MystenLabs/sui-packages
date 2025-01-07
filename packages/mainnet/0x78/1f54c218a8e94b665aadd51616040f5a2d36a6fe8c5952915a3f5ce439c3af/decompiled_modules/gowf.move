module 0x781f54c218a8e94b665aadd51616040f5a2d36a6fe8c5952915a3f5ce439c3af::gowf {
    struct GOWF has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOWF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOWF>(arg0, 0, b"GOWF", b"FWOG", b"https://t.me/fwogsuigowf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GOWF>(&mut v2, 138332217125018, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOWF>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOWF>>(v1);
    }

    // decompiled from Move bytecode v6
}

