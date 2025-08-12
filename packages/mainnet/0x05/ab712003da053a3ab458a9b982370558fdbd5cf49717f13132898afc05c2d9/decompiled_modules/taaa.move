module 0x5ab712003da053a3ab458a9b982370558fdbd5cf49717f13132898afc05c2d9::taaa {
    struct TAAA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TAAA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TAAA>(arg0, 9, b"taaa", b"taaaaa", b"taaaaaaaaaaaaaaaaaaaaaaaaa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TAAA>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TAAA>>(v2, @0xd2420ad33ab5e422becf2fa0e607e1dde978197905b87d070da9ffab819071d6);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TAAA>>(v1);
    }

    // decompiled from Move bytecode v6
}

