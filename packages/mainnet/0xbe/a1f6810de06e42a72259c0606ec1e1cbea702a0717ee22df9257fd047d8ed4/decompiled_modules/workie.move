module 0xbea1f6810de06e42a72259c0606ec1e1cbea702a0717ee22df9257fd047d8ed4::workie {
    struct WORKIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WORKIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WORKIE>(arg0, 9, b"WORKIE", b"WORKIE ON SUI", b"REMEMBER, WE ALL WORKIES!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/Qma1Zct5adnNKsoVa5MBtqUfxQ6AmUmjfuwx2fn1mqMYAS")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WORKIE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WORKIE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WORKIE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

