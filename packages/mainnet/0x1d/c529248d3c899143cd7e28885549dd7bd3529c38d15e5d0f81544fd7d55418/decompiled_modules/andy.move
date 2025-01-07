module 0x1dc529248d3c899143cd7e28885549dd7bd3529c38d15e5d0f81544fd7d55418::andy {
    struct ANDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANDY>(arg0, 9, b"ANDY", b"Andywifsui", b"AndywifSui is a fun, community-focused token on the SUI blockchain, offering fast, secure transactions. It makes DeFi accessible and enjoyable, blending innovation with Andy's playful spirit.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1793600162595811329/uLUd8F3E.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ANDY>(&mut v2, 330000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANDY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ANDY>>(v1);
    }

    // decompiled from Move bytecode v6
}

