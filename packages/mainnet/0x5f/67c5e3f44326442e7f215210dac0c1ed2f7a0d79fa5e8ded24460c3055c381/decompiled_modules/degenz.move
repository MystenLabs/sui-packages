module 0x5f67c5e3f44326442e7f215210dac0c1ed2f7a0d79fa5e8ded24460c3055c381::degenz {
    struct DEGENZ has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<DEGENZ>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<DEGENZ>>(0x2::coin::mint<DEGENZ>(arg0, arg2 * 1000000000, arg3), arg1);
    }

    fun init(arg0: DEGENZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEGENZ>(arg0, 9, b"DEGENZ", b"DEGENZ", b"FULLI GIGA MEGA SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1796615206778376192/mu-jTQqa_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DEGENZ>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DEGENZ>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEGENZ>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

