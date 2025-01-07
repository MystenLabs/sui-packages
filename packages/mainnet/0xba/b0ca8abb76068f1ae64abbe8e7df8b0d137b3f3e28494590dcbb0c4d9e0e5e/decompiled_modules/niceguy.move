module 0xbab0ca8abb76068f1ae64abbe8e7df8b0d137b3f3e28494590dcbb0c4d9e0e5e::niceguy {
    struct NICEGUY has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<NICEGUY>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<NICEGUY>>(0x2::coin::mint<NICEGUY>(arg0, arg2 * 1000000000, arg3), arg1);
    }

    fun init(arg0: NICEGUY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NICEGUY>(arg0, 9, b"NICEGUY", b"NICEGUY", b"NICEGUY is here the CHILLGUY of sui polished better looking and indipendent, the end of all zoo typed dog-themed memes is here, NICEGUYS are taking over.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1862220370121469952/MdgYxX3J_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NICEGUY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NICEGUY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NICEGUY>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

