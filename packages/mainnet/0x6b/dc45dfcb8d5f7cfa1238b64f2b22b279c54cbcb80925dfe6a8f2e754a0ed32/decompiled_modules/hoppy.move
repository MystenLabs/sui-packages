module 0x6bdc45dfcb8d5f7cfa1238b64f2b22b279c54cbcb80925dfe6a8f2e754a0ed32::hoppy {
    struct HOPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPPY>(arg0, 9, b"HOPPY", b"HOPPY", b"Let's hop on HOPPY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1825384615571283968/o7e1xYm2.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HOPPY>(&mut v2, 120000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOPPY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOPPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

