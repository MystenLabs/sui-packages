module 0x7df11a2381e682d7b93fe335b175b457e3ede96c9ddde634d2e0b19abc4cd62c::srwdio {
    struct SRWDIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SRWDIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SRWDIO>(arg0, 6, b"srwd.io", b"aSUI staking reward claimable at srwd.io", b"staking reward", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/yn4pT8mZ/images-1.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SRWDIO>(&mut v2, 10000000000 * 0x1::u64::pow(10, 6), 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SRWDIO>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SRWDIO>>(v1);
    }

    // decompiled from Move bytecode v6
}

