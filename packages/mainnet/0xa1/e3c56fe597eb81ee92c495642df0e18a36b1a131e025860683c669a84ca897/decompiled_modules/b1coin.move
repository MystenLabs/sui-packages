module 0xa1e3c56fe597eb81ee92c495642df0e18a36b1a131e025860683c669a84ca897::b1coin {
    struct B1COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: B1COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B1COIN>(arg0, 6, b"B1COIN", b"wen lamba", b"b1coin is dedicated to the idea of making money from crypto to buy a Lamborghini.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2_12_b367422e0e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B1COIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B1COIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

