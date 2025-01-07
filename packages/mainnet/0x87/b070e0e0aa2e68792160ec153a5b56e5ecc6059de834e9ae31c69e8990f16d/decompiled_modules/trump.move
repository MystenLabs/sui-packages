module 0x87b070e0e0aa2e68792160ec153a5b56e5ecc6059de834e9ae31c69e8990f16d::trump {
    struct TRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMP>(arg0, 9, b"TRUMP", b"TRUMP", b"Who will win? Trump or Harris?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://super.ru/image/rs::3840:::/quality:90/plain/s3://super-static/prod/64e864df3a0315358bc47264-1900x.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TRUMP>(&mut v2, 10000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMP>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

