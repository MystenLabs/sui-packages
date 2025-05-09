module 0xd896e539e16e2159c6f302c7ea51fc57888539958cd02e32021996ae901a2e6b::lrry {
    struct LRRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LRRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LRRY>(arg0, 6, b"LRRY", b"Lrry-Coin", b"$LRRY Doesn't want your drama!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000067990_8bad9f9e31.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LRRY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LRRY>>(v1);
    }

    // decompiled from Move bytecode v6
}

