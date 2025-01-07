module 0x8a49b97d9ac54fbb57c6f3fb9e49612afcf58e22cc18f0027ca3041bdc5a18b3::aaahippo {
    struct AAAHIPPO has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<AAAHIPPO>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<AAAHIPPO>>(0x2::coin::mint<AAAHIPPO>(arg0, arg2 * 1000000000, arg3), arg1);
    }

    fun init(arg0: AAAHIPPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAAHIPPO>(arg0, 9, b"HIPAAA", b"AAAHIPPO", b"Can stop thinking about sui(hippo parody)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1838038177912913920/55CPVIMX_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<AAAHIPPO>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AAAHIPPO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAHIPPO>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

