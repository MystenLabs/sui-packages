module 0xc085bd4df5a44285f5c6e319cd5940db8143fd40d61d19efe7fe08cf4aaae011::alphacat {
    struct ALPHACAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALPHACAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALPHACAT>(arg0, 6, b"ALPHACAT", b"Alphacat Sui", b"ALPHACAT doesnt just meow, it roars through the market like a blue-furred juggernaut, ready to dominate every chart and every wallet it touches", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000258_5c466ff2f3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALPHACAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ALPHACAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

