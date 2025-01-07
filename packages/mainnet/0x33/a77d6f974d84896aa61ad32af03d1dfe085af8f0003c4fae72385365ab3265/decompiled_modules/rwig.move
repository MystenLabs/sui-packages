module 0x33a77d6f974d84896aa61ad32af03d1dfe085af8f0003c4fae72385365ab3265::rwig {
    struct RWIG has drop {
        dummy_field: bool,
    }

    fun init(arg0: RWIG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RWIG>(arg0, 6, b"RWIG", b"Rock with google eyes", b"that rock", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_12_110305_15155c7ae1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RWIG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RWIG>>(v1);
    }

    // decompiled from Move bytecode v6
}

