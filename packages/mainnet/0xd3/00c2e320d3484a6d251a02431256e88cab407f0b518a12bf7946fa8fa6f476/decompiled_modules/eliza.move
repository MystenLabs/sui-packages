module 0xd300c2e320d3484a6d251a02431256e88cab407f0b518a12bf7946fa8fa6f476::eliza {
    struct ELIZA has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<ELIZA>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<ELIZA>>(0x2::coin::mint<ELIZA>(arg0, arg2 * 1000000000, arg3), arg1);
    }

    fun init(arg0: ELIZA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELIZA>(arg0, 9, b"ELIZA", b"ELIZA", b"An ai ELIZA comes to sui best framework so far, integrated into sui blockchain becoming the major agent.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1867788948933582848/hZwR1MiM_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ELIZA>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ELIZA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELIZA>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

