module 0x191e7f9c38f355412402d4f4ac8699a7986f77f38a7269c215e4e64cc9b08b39::b1coin {
    struct B1COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: B1COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B1COIN>(arg0, 6, b"B1COIN", b"B1COIN BULLISH", b"GREEN BULL is the most bullish & fun community-driven memecoin ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/tf7ixydn7nfcgj9wqj3frdkravsz8eghcx_1_d984a61985.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B1COIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B1COIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

