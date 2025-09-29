module 0x3d2c6d4fd81a0319edf51cf185219dd71d5a2204b88304ae9b4b82c85092dba3::crapto {
    struct CRAPTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRAPTO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"65285d0aa8fde32353b8dbe87d4dcbd784b84103d12c5e1a07e0e49ccbea0d99                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<CRAPTO>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"crapto      ")))), trim_right(b"craptocurrency                  "), trim_right(b"To Make $CRAPTO A Great MEME COIN TO GROW BIGGER THEN FARTLESS & FARTCOIN WHICH are outdated! To Develop a $CRAPTO Launchpad for NEW COIN LAUNCHES with CREATOR FEES & REWARDS - Updates to follow!                                                                                                                             "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRAPTO>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CRAPTO>>(v4);
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

