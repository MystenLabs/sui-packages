module 0x2364a35b182ce63929dd9a196cf375703f4b20ca626e94e57bdec970eda187e2::juicy {
    struct JUICY has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<JUICY>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<JUICY>>(0x2::coin::mint<JUICY>(arg0, arg2 * 1000000000, arg3), arg1);
    }

    fun init(arg0: JUICY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JUICY>(arg0, 9, b"JUICY", b"JUICY", b"Simply JUICY no cabals no pre-sale and especially no airdrops against the establishments and cabal memes!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1861067725990400000/OYjc3DLp_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<JUICY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JUICY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JUICY>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

