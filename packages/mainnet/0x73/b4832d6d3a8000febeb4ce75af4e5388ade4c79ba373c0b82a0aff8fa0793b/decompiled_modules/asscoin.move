module 0x73b4832d6d3a8000febeb4ce75af4e5388ade4c79ba373c0b82a0aff8fa0793b::asscoin {
    struct ASSCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASSCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/G3EDZoS49NRVKP8X1HggHZJueJeR8d2izUHeXdV3pump.png?claimId=4WTMuvS8A4x8BANX                                                                                                                                                                                                      ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<ASSCOIN>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"ASSCOIN     ")))), trim_right(b"ASSCOIN                         "), trim_right(x"417373436f696e20697320746865206c617465737420696e6e6f7661746976652070726f6a6563742062726f7567687420746f20796f75206279207468652073616d6520646576656c6f70657220626568696e642074686520766972616c2073656e736174696f6e2c2046617274436f696e2e0a0a43616e2774206661727420776974686f757420616e206173732e0a0a466c61756e7420667265656c79202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASSCOIN>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ASSCOIN>>(v4);
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

