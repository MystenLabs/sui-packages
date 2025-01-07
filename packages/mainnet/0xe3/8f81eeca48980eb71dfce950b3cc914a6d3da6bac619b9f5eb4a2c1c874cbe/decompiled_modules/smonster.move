module 0xe38f81eeca48980eb71dfce950b3cc914a6d3da6bac619b9f5eb4a2c1c874cbe::smonster {
    struct SMONSTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMONSTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMONSTER>(arg0, 6, b"SMonster", b"Sui Monster", b"Sui monster is a community-driven token designed to add a layer of sweetness to the world of cryptocurrencies.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0xc44b29a090ca3a29e3989cec5aa57d0e03513ad6ba0e911562a9346f4f34343b_cookie_cookie_6f4a566550.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMONSTER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMONSTER>>(v1);
    }

    // decompiled from Move bytecode v6
}

