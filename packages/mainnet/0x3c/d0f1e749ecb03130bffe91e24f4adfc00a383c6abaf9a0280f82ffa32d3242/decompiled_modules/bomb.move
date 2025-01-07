module 0x3cd0f1e749ecb03130bffe91e24f4adfc00a383c6abaf9a0280f82ffa32d3242::bomb {
    struct BOMB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOMB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOMB>(arg0, 6, b"BOMB", b"BOMBIE SUI", b"$BOMB $BOMB  $BOMB  $BOMB  $BOMB ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bomb_69003c0114.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOMB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOMB>>(v1);
    }

    // decompiled from Move bytecode v6
}

