module 0x8263158072df50c0e45a40ff5ed9ffcb7d6308c4bcccad4864cb4aaa3f05c342::suiman {
    struct SUIMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMAN>(arg0, 9, b"SUIMAN", b"SuiMan", b"inspired by aquaman LFG SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1737435331744727040/LkXuzneL_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIMAN>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMAN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

