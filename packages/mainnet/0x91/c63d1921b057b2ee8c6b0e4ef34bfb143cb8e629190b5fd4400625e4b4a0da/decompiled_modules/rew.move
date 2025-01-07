module 0x91c63d1921b057b2ee8c6b0e4ef34bfb143cb8e629190b5fd4400625e4b4a0da::rew {
    struct REW has drop {
        dummy_field: bool,
    }

    fun init(arg0: REW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REW>(arg0, 6, b"rew", b"rew", b"erdefcd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<REW>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REW>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<REW>>(v1);
    }

    // decompiled from Move bytecode v6
}

