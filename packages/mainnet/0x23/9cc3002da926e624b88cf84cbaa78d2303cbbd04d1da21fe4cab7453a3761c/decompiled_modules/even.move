module 0x239cc3002da926e624b88cf84cbaa78d2303cbbd04d1da21fe4cab7453a3761c::even {
    struct EVEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: EVEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EVEN>(arg0, 6, b"EVEN", b"Even", b"Even Chenk iz an legen in teh crypto space, a master of none, nd teh kinda guy who probbly misplaced teh priv8 keys 2 ur wallet. But hey, hes here 2 lead teh way in teh memecoinrevlulution.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/134123_52_9b684ffe9a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EVEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EVEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

