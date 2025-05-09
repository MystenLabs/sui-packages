module 0x979bbcf9a9921a575f630853ab893b2d8aaa222442e4e716c3e9bb62897d5a73::mmt {
    struct MMT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MMT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MMT>(arg0, 6, b"MMT", b"Momentum Finance", b"The central liquidity engine of the move ecosystem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000067966_b07080d142.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MMT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MMT>>(v1);
    }

    // decompiled from Move bytecode v6
}

