module 0x4f5b3ce8083f5b93e30d4251a1f22bf366e431312eb51378e8831654c3859f1d::burnedlmo {
    struct BURNEDLMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BURNEDLMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BURNEDLMO>(arg0, 9, b"BURNEDLMO", b"BurnedSuielmo", b"BURNLIQUIDITY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://media.tenor.com/seXPKp5sj3oAAAAj/fire.gif")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BURNEDLMO>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BURNEDLMO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BURNEDLMO>>(v1);
    }

    // decompiled from Move bytecode v6
}

