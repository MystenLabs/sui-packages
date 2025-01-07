module 0x791790098e7eaae893b86d260c4c4e925b95433f1e99b11533d9a09aefec3b5e::kreet {
    struct KREET has drop {
        dummy_field: bool,
    }

    fun init(arg0: KREET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KREET>(arg0, 9, b"KREET", b"Krett", b"Brett? Britt? Brett's cousin? Enough is enough. It's time to dethrone Brett and his family.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1842175104530190336/8WD8Sg9j_400x400.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<KREET>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KREET>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KREET>>(v1);
    }

    // decompiled from Move bytecode v6
}

