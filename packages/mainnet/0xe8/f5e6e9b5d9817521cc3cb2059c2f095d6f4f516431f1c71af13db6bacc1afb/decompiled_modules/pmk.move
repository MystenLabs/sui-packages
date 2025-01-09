module 0xe8f5e6e9b5d9817521cc3cb2059c2f095d6f4f516431f1c71af13db6bacc1afb::pmk {
    struct PMK has drop {
        dummy_field: bool,
    }

    fun init(arg0: PMK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<PMK>(arg0, 6, b"PMK", b"PEACH MILK by SuiAI", b"Peach Milk (PMK) is a vibrant, community-driven token that embodies the spirit of joyous collaboration on the SUI blockchain. Inspired by the delightful moments, togetherness and too much drinking, Peach Milk aims to create a space where every member feels valued and connected. With a sweet blend of creativity and purpose, PMK is the perfect token for those who cherish the good times and believe in building strong, supportive communities. Dive into the refreshing world of Peach Milk and be a part of something truly extraordinary.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/image_3_8c2d496f05.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PMK>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PMK>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

