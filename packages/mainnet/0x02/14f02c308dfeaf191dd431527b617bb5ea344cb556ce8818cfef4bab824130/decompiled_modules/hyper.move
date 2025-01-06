module 0x214f02c308dfeaf191dd431527b617bb5ea344cb556ce8818cfef4bab824130::hyper {
    struct HYPER has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<HYPER>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<HYPER>>(0x2::coin::mint<HYPER>(arg0, arg2 * 1000000000, arg3), arg1);
    }

    fun init(arg0: HYPER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HYPER>(arg0, 9, b"HYPER", b"HYPER", b"Sui most hyped chains crushing everything on its path in honour of the hype a meme called HYPER is here to stay.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1862529238437441536/XAaG2M73_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HYPER>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HYPER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HYPER>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

