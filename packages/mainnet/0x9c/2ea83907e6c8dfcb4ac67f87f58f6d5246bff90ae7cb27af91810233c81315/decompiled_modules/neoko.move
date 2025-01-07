module 0x9c2ea83907e6c8dfcb4ac67f87f58f6d5246bff90ae7cb27af91810233c81315::neoko {
    struct NEOKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEOKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEOKO>(arg0, 6, b"NEOKO", b"Neoko", b"Welcome to NeoKo! We unite gamers all around the world through web3 gaming. Deploy games for free, play games and earn rewards at NeoKo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000042461_17760720b0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEOKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEOKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

