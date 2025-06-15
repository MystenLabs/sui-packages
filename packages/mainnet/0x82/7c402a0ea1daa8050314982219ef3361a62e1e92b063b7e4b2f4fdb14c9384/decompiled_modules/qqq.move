module 0x827c402a0ea1daa8050314982219ef3361a62e1e92b063b7e4b2f4fdb14c9384::qqq {
    struct QQQ has drop {
        dummy_field: bool,
    }

    fun init(arg0: QQQ, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"7930aec6a02c4765ad5808a4a0dd8121439141303e4bb50e6cb5e2eb3612d1c2                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<QQQ>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"QQQ         ")))), trim_right(b"NASCRAQ                         "), trim_right(x"4f6e65204d697373696f6e2c20466c697020746865204e617364617120202343726171746865446171202057686572652062756c6c73204f4420616e6420626561727320676f2062726f6b65200a0a57657265206865726520746f20666c697020746865204e4153444151206f6e20697473206f7665722d6c65766572616765642068656164202d206974206d69676874206c6f6f6b206c696b652061206a6f6b652c2062757420746865206d697373696f6e206973207265616c2e202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QQQ>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<QQQ>>(v4);
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

