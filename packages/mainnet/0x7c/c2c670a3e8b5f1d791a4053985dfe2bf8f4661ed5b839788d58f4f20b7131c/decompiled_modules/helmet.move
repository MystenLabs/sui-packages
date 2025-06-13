module 0x7cc2c670a3e8b5f1d791a4053985dfe2bf8f4661ed5b839788d58f4f20b7131c::helmet {
    struct HELMET has drop {
        dummy_field: bool,
    }

    fun init(arg0: HELMET, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/4Tt6siivnSEjLQCKATp96BUQh2uwCyEVS3e57erNpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<HELMET>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Helmet      ")))), trim_right(b"Helmet                          "), trim_right(x"2054686520776f726c642069732064657363656e64696e6720696e746f206368616f732e205757332069732062726577696e672e2e2e20616e64206974732074696d6520746f20474541522055502e0a0a546865206d6f737420696d706f7274616e74207468696e6720746f2070726f746563743f0a20596f757220686561642e200a0a496e74726f647563696e67202448656c6d6574202074686520756c74696d6174652063727970746f20686561646765617220666f7220756e6365727461696e2074696d65732e0a20536c617020612068656c6d6574206f6e20796f757220646f672e0a20536c617020612068656c6d6574206f6e2061206361742e0a20536c6170206f6e65206f6e20612063656c65622c2061204b4f4c2c20796f757220707265736964656e74200a4e4f204f4e4520495320534146452c20554e54"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HELMET>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HELMET>>(v4);
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

