module 0x333afa2dbffe94a13615860ae22220bbd4edfa208e194f47831c996987ade70a::ctonike {
    struct CTONIKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CTONIKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CTONIKE>(arg0, 6, b"CTONIKE", b"NIKE", b"$NIKE maxi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_65_a224a387be.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CTONIKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CTONIKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

