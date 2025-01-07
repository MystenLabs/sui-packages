module 0xaebb53e83d93bf309ee2b3bf707523555d2ffc277f17c99b75480f07cbce3596::fug {
    struct FUG has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<FUG>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<FUG>>(0x2::coin::mint<FUG>(arg0, arg2 * 1000000000, arg3), arg1);
    }

    fun init(arg0: FUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUG>(arg0, 9, b"FUG", b"FUG", b"FUG The Plug entirely community token no pre-sale no airdrops no team allocation tokens just fan base meme for sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1852865119308693504/yXHt1gtN_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FUG>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FUG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUG>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

