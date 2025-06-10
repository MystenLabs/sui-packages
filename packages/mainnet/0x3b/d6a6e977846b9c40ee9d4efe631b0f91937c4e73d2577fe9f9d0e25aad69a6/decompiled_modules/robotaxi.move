module 0x3bd6a6e977846b9c40ee9d4efe631b0f91937c4e73d2577fe9f9d0e25aad69a6::robotaxi {
    struct ROBOTAXI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROBOTAXI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/GDe456KVvMgZgdPtu4cfEaBppftLxtDzdtALfeoVfayV.png?claimId=vU2Cgsm7iF_q51Yj                                                                                                                                                                                                      ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<ROBOTAXI>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Robotaxi    ")))), trim_right(b"Tesla Robotaxi                  "), trim_right(b"The Tesla Cybercab, also known as the Robotaxi, is an upcoming two passenger battery electric self driving car under development by Tesla. The vehicle is planned to be fully autonomous. The prototype vehicles have no steering wheel or pedals.                                                                              "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROBOTAXI>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROBOTAXI>>(v4);
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

