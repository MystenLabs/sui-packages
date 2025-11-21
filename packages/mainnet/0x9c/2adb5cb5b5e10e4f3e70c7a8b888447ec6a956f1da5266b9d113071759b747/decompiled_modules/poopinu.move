module 0x9c2adb5cb5b5e10e4f3e70c7a8b888447ec6a956f1da5266b9d113071759b747::poopinu {
    struct POOPINU has drop {
        dummy_field: bool,
    }

    fun init(arg0: POOPINU, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"ca037fd02fa81710a643c77cd19af953d6d51c806baa67d046a266fba0371418                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<POOPINU>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"POOPINU     ")))), trim_right(b"POOPINU - 251119-0814           "), trim_right(x"24504f4f50494e5520697320746865206669727374206d656d6520636f696e20626f726e2066726f6d2061207265616c2064756d702e0a43617567687420696e207468652061637420647572696e6720686973206269672064726f702c207468697320666561726c65737320646f67676f20626563616d6520746865206d6173636f74206f662074686520756c74696d6174652073686974636f696e20202e0a4e6f20726f61646d61702c206e6f2070726f6d6973657320206a75737420707572652066756e2c207075726520646567656e732e0a0a4d616465206f6e20686572652066756e20616e642073686f74206f6e206d79205365656b65722020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POOPINU>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POOPINU>>(v4);
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

