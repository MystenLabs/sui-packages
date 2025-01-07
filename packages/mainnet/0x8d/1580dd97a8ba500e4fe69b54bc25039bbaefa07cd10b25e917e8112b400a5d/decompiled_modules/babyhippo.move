module 0x8d1580dd97a8ba500e4fe69b54bc25039bbaefa07cd10b25e917e8112b400a5d::babyhippo {
    struct BABYHIPPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYHIPPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYHIPPO>(arg0, 9, b"BabyHippo", b"BABYHIPPO", b"Same Hippo but baby", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1840439596548493312/8ohcTVBD_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BABYHIPPO>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYHIPPO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYHIPPO>>(v1);
    }

    // decompiled from Move bytecode v6
}

