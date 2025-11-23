module 0xc5b29abdff54b478cafb4a2557e7f747b5b1fe9c74c84ce5a4a5887d580302fe::kick {
    struct KICK has drop {
        dummy_field: bool,
    }

    fun init(arg0: KICK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"07f8dd8e211f47e8899e016d61f215a50e7f3b2d19bef15e4e0166b1127d69fa                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<KICK>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"KICK        ")))), trim_right(b"Kickoff                         "), trim_right(x"54686520667574757265206f662073706f7274732062657474696e6720697320686572652e204b69636b6f66662069732074686520666173746573742073706f7274732070726564696374696f6e206d61726b6574206f75742e200a0a20556c7472612d666173742c206c6f7720666565732e200a204e6f20686f757365206f6464732e200a204265636f6d6520612070726f66697461626c652073706f727473206265747465722e20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KICK>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KICK>>(v4);
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

