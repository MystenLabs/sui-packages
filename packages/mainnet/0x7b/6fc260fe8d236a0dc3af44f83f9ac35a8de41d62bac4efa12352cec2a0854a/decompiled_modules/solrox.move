module 0x7b6fc260fe8d236a0dc3af44f83f9ac35a8de41d62bac4efa12352cec2a0854a::solrox {
    struct SOLROX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOLROX, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"80799ddac04db3a7dbe626cb8138783f9f01dcd08edf09c8ebf0091990fd608a                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<SOLROX>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"SOLROX      ")))), trim_right(b"SOLROX                          "), trim_right(x"4c61756e636820596f7572205265776172647320546f6b656e207769746820536f6c526f78210a0a4e6577202620556e6971756520646973747269627574696f6e206d6f64657320666f7220796f757220746f6b656e20726577617264732e0a0a313225205461782c2035302520746f20686f6c6465727320617320736f6c616e612072657761726473206576657279203135206d696e75746573210a0a486f6c64206174206c65617374203530304b20534f4c524f5820746f6b656e7320746f207265636569766520534f4c2072657761726473206576657279203135206d696e7574657320636f6e74696e756f75736c792120202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOLROX>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOLROX>>(v4);
    }

    fun trim_right(arg0: vector<u8>) : vector<u8> {
        let v0 = 32;
        let v1 = &v0;
        while (0x1::vector::length<u8>(&arg0) > 0) {
            if (0x1::vector::borrow<u8>(&arg0, 0x1::vector::length<u8>(&arg0) - 1) != v1) {
                break
            };
            0x1::vector::pop_back<u8>(&mut arg0);
        };
        arg0
    }

    // decompiled from Move bytecode v6
}

