module 0xe663d6aab3b921275f7e5f653fc691be1f315e379f6387753057c120c36fc243::usdc {
    struct USDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: USDC, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://gateway.irys.xyz/95dOM5MksnynZDg1uePzfrAWJ6fOnx3SSJ8lThyW-Dc                                                                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<USDC>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"USDC    ")))), trim_right(b"USD Coin                        "), trim_right(x"55534454202854657468657229204465736372697074696f6e3a0a55534454202854657468657229206973206120626c6f636b636861696e2d626173656420737461626c65636f696e2064657369676e656420746f206d61696e7461696e20612076616c7565206571756976616c656e7420746f206120666961742063757272656e63792c207479706963616c6c792074686520555320446f6c6c61722e20497420697320776964656c79207573656420696e207468652063727970746f63757272656e63792065636f73797374656d20666f722074726164696e672c207061796d656e74732c20616e64206173206120686564676520616761696e7374206d61726b65742020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDC>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<USDC>>(v4);
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

