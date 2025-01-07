module 0x46df2ef9daf85608962da2b0d6f8bf9ce4ae304ba2c0ca4cc2a1302b1228a2b6::fish {
    struct FISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: FISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FISH>(arg0, 9, b"FISH", b"Shoaling and Schooling Fish", b"The Strongest Shoaling and Schooling Fish on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.ethoswallet.xyz/ipfs/bafybeielfvz4m33f3vesmp3kxc2oplp3lmoaq7cu4tq45p5tp3fqdcnkxm")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FISH>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FISH>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

