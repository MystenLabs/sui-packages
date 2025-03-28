module 0x6287742d9518463d216c22071647ddbae7c63a888628fe238b393a347f9131ad::bathub {
    struct BATHUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BATHUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BATHUB>(arg0, 6, b"BATHUB", b"Bathub", b"Bathub taking the instinctive method of memecoin, without warning suddenly shot up", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000051439_a2798d8495.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BATHUB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BATHUB>>(v1);
    }

    // decompiled from Move bytecode v6
}

