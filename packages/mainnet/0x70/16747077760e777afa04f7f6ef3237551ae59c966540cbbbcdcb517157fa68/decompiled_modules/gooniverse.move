module 0x7016747077760e777afa04f7f6ef3237551ae59c966540cbbbcdcb517157fa68::gooniverse {
    struct GOONIVERSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOONIVERSE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/EmkPjycc2utnUBQryY36bJ9xfs9ySUtRx8mVEBuHpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<GOONIVERSE>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"GOONIVERSE  ")))), trim_right(b"Gooniverse Season               "), trim_right(x"5b434f4e534f4c455d0a0a2f2f204c4f4144494e472e2e2e200a0a202020203e53595354454d204f4e4c494e453a2024474f4f4e495645525345200a202020203e42494720475245454e2043414e444c45533a20494e434f4d494e47200a202020203e5354415455533a20474f4f4e494e472034323036396d7068200a0a2f2f20454e44205452414e534d495353494f4e2e2e2e20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOONIVERSE>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOONIVERSE>>(v4);
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

