module 0x659279e303e2e6d5fdba94406a8956841d2d045cbffbe96304b7c4795aca8020::drunk {
    struct DRUNK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRUNK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRUNK>(arg0, 6, b"DRUNK", b"Boozy Apes Society", b"Welcome to $DRUNK  the token born from good vibes, bad decisions, and a love for partying. No utility, no problem. Just apes, drinks, and chaos. Lets pump, sip, and see where this ride takes us!\" ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000042094_b406ca8232.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRUNK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DRUNK>>(v1);
    }

    // decompiled from Move bytecode v6
}

