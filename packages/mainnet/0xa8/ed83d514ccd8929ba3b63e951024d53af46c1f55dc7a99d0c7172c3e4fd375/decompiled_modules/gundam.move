module 0xa8ed83d514ccd8929ba3b63e951024d53af46c1f55dc7a99d0c7172c3e4fd375::gundam {
    struct GUNDAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: GUNDAM, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/7c21xTnFy2CH4Td13JbDvPtFHnKqpbsM4Pw5Z3pCbonk.png?claimId=GDZkJOQxZaaY-Bjt                                                                                                                                                                                                      ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<GUNDAM>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Gundam      ")))), trim_right(b"Gundam                          "), trim_right(b"Steel giants blazing through the cosmos                                                                                                                                                                                                                                                                                         "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GUNDAM>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GUNDAM>>(v4);
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

