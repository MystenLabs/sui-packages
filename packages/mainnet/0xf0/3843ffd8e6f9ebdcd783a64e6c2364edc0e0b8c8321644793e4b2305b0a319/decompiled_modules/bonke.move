module 0xf03843ffd8e6f9ebdcd783a64e6c2364edc0e0b8c8321644793e4b2305b0a319::bonke {
    struct BONKE has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BONKE>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<BONKE>>(0x2::coin::mint<BONKE>(arg0, arg2 * 1000000000, arg3), arg1);
    }

    fun init(arg0: BONKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BONKE>(arg0, 9, b"BONKE", b"BONKE", b"Just a chilling BONKE, ready to go NFT collection of a blue watery PONKE spin-off.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1775854227983863808/z6SnPBxs_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BONKE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BONKE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BONKE>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

