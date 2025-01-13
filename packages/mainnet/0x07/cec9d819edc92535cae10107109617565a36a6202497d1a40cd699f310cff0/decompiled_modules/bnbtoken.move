module 0x7cec9d819edc92535cae10107109617565a36a6202497d1a40cd699f310cff0::bnbtoken {
    struct BNBTOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BNBTOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BNBTOKEN>(arg0, 6, b"BNBtoken", b"BNB token", b"fee", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://akasui-statics.sgp1.cdn.digitaloceanspaces.com/images/d3d054b6-5901-482a-844e-54bfdcf6cb10.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BNBTOKEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BNBTOKEN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

