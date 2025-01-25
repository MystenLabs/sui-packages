module 0x47714ceaabf902ae051288d3b33583a32e4e49103a70a4d3d67a4d3bbc3e2fd::move {
    struct MOVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOVE>(arg0, 6, b"MOVE", b"MoveeOn", b"Time to move on and reach for new heights with $MOVE  because your old tokens were just a warm-up!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_6f13f9781c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOVE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOVE>>(v1);
    }

    // decompiled from Move bytecode v6
}

