module 0x4f49093942543493204baf90800ef1812226e00fddebdeb13ce6122283085ada::b_bot {
    struct B_BOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_BOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_BOT>(arg0, 9, b"bBot", b"bToken Bot", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_BOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_BOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

