module 0x36fd59c4c16a0d38254d8750c912f347322a754cb8e634f44380cd5695303484::evan {
    struct EVAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: EVAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EVAN>(arg0, 2, b"EVAN", b"(twitter.com/EvanWeb3)", b"EVAN ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1748078847629971456/IF7njFnw_400x400.jpg")), arg1);
        let v2 = v0;
        let v3 = &mut v2;
        let v4 = 0x2::tx_context::sender(arg1);
        mint(v3, 100000000, v4, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EVAN>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<EVAN>>(v2);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<EVAN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<EVAN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

