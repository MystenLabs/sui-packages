module 0xb12608342931be68488bbc7c3a47824f7ae9a92b22503d7d8e0d5e616334f8dc::shogu {
    struct SHOGU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHOGU, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://pump.mypinata.cloud/ipfs/QmNQpwoHxntH2QagpkUyradxV41q6owFsHDdtRuTvh6Mhr?img-width=256&img-dpr=2&img-onerror=redirect                                                                                                                                                                                                    ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<SHOGU>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"SHOGU   ")))), trim_right(b"SHOGU                           "), trim_right(b"SHOGU is the ultimate meme culture fusioncombining the playful spirit of $PNUT, Elon Musks ingenuity with a  in hand - https://x.com/elonmusk/status/1857052742788776189?s=46&t=34Rau4p5lkSppsqC1JfE2A                                                                                                                          "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHOGU>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHOGU>>(v4);
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

