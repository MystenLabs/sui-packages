module 0xdff0049b81e34683d3e5093a718c5f64b4e26ec00d2ed3381bf8fd0ee5364ffb::samuel {
    struct SAMUEL has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<SAMUEL>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SAMUEL>>(0x2::coin::mint<SAMUEL>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: SAMUEL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://cdn.dexscreener.com/cms/images/f0fc8b9d1568d0be6841e5639035866d09f622f699dc852f752c1e24df30738e?width=128&height=128&fit=crop&quality=95&format=auto                                                                                                                                                                    ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<SAMUEL>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"SAMUEL  ")))), trim_right(b"Samuel the Baby Turtle          "), trim_right(b"Samuel is not your average soldiermainly because hes still a baby. With a pacifier in his mouth and a helmet two sizes too big, Samuel waddles into battle with pure innocence, zero awareness of danger, and the heart of a hero who thinks every mission is just playtime.                                                    "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SAMUEL>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SAMUEL>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<SAMUEL>>(0x2::coin::mint<SAMUEL>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

