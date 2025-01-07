module 0x1272677919645d825af6df20f3a87a00331dace4d2532f58ab8dc13aff394e2b::row {
    struct ROW has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROW>(arg0, 6, b"ROW", b"Row", b"Scam Token, don't buy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cursor_188765211c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROW>>(v1);
    }

    // decompiled from Move bytecode v6
}

