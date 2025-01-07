module 0xc5274250c370f00c59ce3d9900b9c497d2d00d59f213c19b1a5b670d8b28e06::aat {
    struct AAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAT>(arg0, 6, b"AAT", b"aaa turtle", b"Cant stop, wont stop (making waves for Sui)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/giphy_0ae96ceb50.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

