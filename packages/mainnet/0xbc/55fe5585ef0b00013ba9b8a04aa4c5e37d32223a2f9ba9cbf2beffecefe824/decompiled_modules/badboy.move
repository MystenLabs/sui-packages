module 0xbc55fe5585ef0b00013ba9b8a04aa4c5e37d32223a2f9ba9cbf2beffecefe824::badboy {
    struct BADBOY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BADBOY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BADBOY>(arg0, 9, b"BADBOY", b"BADBOY", b"BADBOY Memecoin is a daring, edgy cryptocurrency project that embodies the rebellious spirit of meme culture. SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1842027444414644224/Gnk6AKW8_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BADBOY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BADBOY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BADBOY>>(v1);
    }

    // decompiled from Move bytecode v6
}

