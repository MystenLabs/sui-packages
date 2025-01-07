module 0x1b8f04c14c3e098c5f14729b4b5d087baf580659e1da2dcf65ae6ee0f70ebb47::gsi {
    struct GSI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GSI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GSI>(arg0, 9, b"GSI", b"GameSi", b"GameFi, but GameSI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://s2.coinmarketcap.com/static/img/coins/200x200/11783.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GSI>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GSI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GSI>>(v1);
    }

    // decompiled from Move bytecode v6
}

