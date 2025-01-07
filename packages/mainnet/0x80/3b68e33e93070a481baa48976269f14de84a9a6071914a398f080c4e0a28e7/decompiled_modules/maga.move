module 0x803b68e33e93070a481baa48976269f14de84a9a6071914a398f080c4e0a28e7::maga {
    struct MAGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAGA>(arg0, 8, b"MAGA", b"MAKE AMERICA GREAT AGAIN", b"WE CAN - WE DO!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://harlequin-minimum-mouse-625.mypinata.cloud/ipfs/QmcD4fSq9YQzPZnKx6g52PAquZz3ePgPkz54JRj3J51Lf7?_gl=1*1aq2rlm*_ga*NTI5NTk3NDI4LjE3MDI1ODI0MzY.*_ga_5RMPXG14TE*MTcwMjYzOTg3My43LjEuMTcwMjYzOTg5OS4zNC4wLjA.")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MAGA>(&mut v2, 4200000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAGA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

