module 0x4d3e225c7445ad42a86ab9a291cdf6cef7429ac3b5ba200e16327dfc2f9c0ecb::suizilla {
    struct SUIZILLA has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUIZILLA>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SUIZILLA>>(0x2::coin::mint<SUIZILLA>(arg0, arg2 * 1000000000, arg3), arg1);
    }

    fun init(arg0: SUIZILLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIZILLA>(arg0, 9, b"SUIZ", b"SUIZILLA", b"SUIZILLA the giant meme of sui!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1857754417870811140/u9aYuhiH_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIZILLA>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIZILLA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIZILLA>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

