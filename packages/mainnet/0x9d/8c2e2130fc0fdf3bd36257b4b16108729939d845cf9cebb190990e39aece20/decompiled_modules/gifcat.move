module 0x9d8c2e2130fc0fdf3bd36257b4b16108729939d845cf9cebb190990e39aece20::gifcat {
    struct GIFCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GIFCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GIFCAT>(arg0, 6, b"GIFCAT", b"gif cat", b"$GIFCAT is the first fully animated cat artcoin/memecoin on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000122379_a277d89c3a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GIFCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GIFCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

