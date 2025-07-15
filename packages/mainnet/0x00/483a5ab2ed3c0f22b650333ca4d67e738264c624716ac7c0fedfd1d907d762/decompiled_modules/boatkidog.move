module 0x483a5ab2ed3c0f22b650333ca4d67e738264c624716ac7c0fedfd1d907d762::boatkidog {
    struct BOATKIDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOATKIDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/AZUj2C2H9bEpisjfzrMmiq4SXzL39PQPV8BVd26Hbonk.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<BOATKIDOG>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"BoatKidOG   ")))), trim_right(b"Aura Farming 99999%             "), trim_right(x"43656365702069736e74206a75737420612063726561746f72202068657320746865206d61737465726d696e6420626568696e642074686520766972616c2070616375206a616c7572207068656e6f6d656e6f6e2120457665722073696e63652044696b612044616e63652041757261204661726d696e6720626c6577207570206f6e2054696b546f6b20616e64206f7468657220736f6369616c20706c6174666f726d73206c696b6520582c20686973206e616d6520686173206265656e2062757a7a696e67206163726f737320496e646f6e6573696120616e642074686520776f726c642e204e6f773f20486573206f6666696369616c6c7920656e746572696e6720576562332e0a0a54686520636f696e206c61756e63686564206f6e2042656c69657665206f6e204a756c792031342c20323032352c20696e737461"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOATKIDOG>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOATKIDOG>>(v4);
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

