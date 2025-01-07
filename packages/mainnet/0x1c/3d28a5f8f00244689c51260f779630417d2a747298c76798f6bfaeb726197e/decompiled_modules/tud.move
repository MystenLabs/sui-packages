module 0x1c3d28a5f8f00244689c51260f779630417d2a747298c76798f6bfaeb726197e::tud {
    struct TUD has drop {
        dummy_field: bool,
    }

    fun init(arg0: TUD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TUD>(arg0, 9, b"TUD", b"TUD", b"TUD", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TUD>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TUD>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TUD>>(v1);
    }

    // decompiled from Move bytecode v6
}

