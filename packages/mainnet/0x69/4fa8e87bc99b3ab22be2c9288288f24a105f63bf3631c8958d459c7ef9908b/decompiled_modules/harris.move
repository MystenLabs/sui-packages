module 0x694fa8e87bc99b3ab22be2c9288288f24a105f63bf3631c8958d459c7ef9908b::harris {
    struct HARRIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: HARRIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HARRIS>(arg0, 9, b"HARRIS", b"HARRIS", b"Who will win? Trump or Harris?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://super.ru/image/rs::3840:::/quality:90/plain/s3://super-static/prod/64e864df3a0315358bc47264-1900x.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HARRIS>(&mut v2, 10000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HARRIS>>(v2, @0xe9e43c9e89434aef993ee5eb91efc32fbc2ea4fa2b7e642991b538e2bbc0f691);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HARRIS>>(v1);
    }

    // decompiled from Move bytecode v6
}

