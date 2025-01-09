module 0x790a6bb77d3ebc4278d6afa7551306a8be5a349b6d78fe3e4cfab24bdb42a0ca::pchy {
    struct PCHY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PCHY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<PCHY>(arg0, 6, b"PCHY", b"PEACH MILK by SuiAI", b"Peach Milk (PCHY) is a vibrant, community-driven token that embodies the spirit of EUPHORIA on the SUI blockchain. Inspired by the delightful moments, togetherness, too much drinking, and most importantly, ME! Peach Milk aims to create a space where every member feels valued and connected. With a sweet blend of creativity and purpose, $PCHY is the perfect token for those who cherish the good times and believe in building strong, supportive communities. Dive into the refreshing world of Peach Milk and be a part of something truly extraordinary.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/image_3_f5fd166863.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PCHY>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PCHY>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

