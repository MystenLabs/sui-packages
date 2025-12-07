module 0x6e8e80cdc3afe43144c43dbde5086cde6dc72f17304abe132a06864d58d99848::axp {
    struct AXP has drop {
        dummy_field: bool,
    }

    fun init(arg0: AXP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"22f83bf61313e94f3b46fea05cf489179c1873d4cacfbf5629f27c6ef5d9893e                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<AXP>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"AXP         ")))), trim_right(b"American XRP                    "), trim_right(b"Built for investors who demand precision, speed, and prestige, American XRP is the top company that mines XRP. stands at the intersection of elite finance and modern blockchain culture. Whether youre a high-level trader or a forward-thinking believer in the future of digital currency, American XRP offers a refined, fut"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AXP>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AXP>>(v4);
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

