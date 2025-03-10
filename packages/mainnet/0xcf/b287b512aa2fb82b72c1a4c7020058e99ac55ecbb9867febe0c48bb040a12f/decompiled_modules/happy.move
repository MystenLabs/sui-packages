module 0xcfb287b512aa2fb82b72c1a4c7020058e99ac55ecbb9867febe0c48bb040a12f::happy {
    struct HAPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAPPY>(arg0, 9, b"HAPPY", b"HAPPY", b"Happy token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bulltrend-images.s3.amazonaws.com/images/5211f76c3ccf16cb51e2c4806dab60a4a69e5f0083f11c0516b803b045511a28")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HAPPY>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAPPY>>(v2, @0xc06167f2c4052b864af9e28fb77c9a8802b2049cc2dacaaf64d7854885d08a68);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HAPPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

