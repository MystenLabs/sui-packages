module 0x3a3f2daa1cfa992356f31b4257c60b874df078bf9610a57de8415ced61ad033b::rocket {
    struct ROCKET has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<ROCKET>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<ROCKET>>(0x2::coin::mint<ROCKET>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: ROCKET, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/bsc/0x4a1c76b8e8b347e1852352ea931bfe649fc64444.png?size=lg&key=e97203                                                                                                                                                                                                                 ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<ROCKET>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"ROCKET  ")))), trim_right(b"DOGE ROCKET                     "), trim_right(b"DOGE ROCKET is a completely fresh project with a brand-new name and logo that has never been launched before. This isnt a rebrand or a copycat  its a ground-up creation aimed at riding the next big wave of memecoin mania.                                                                                                   "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ROCKET>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<ROCKET>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<ROCKET>>(0x2::coin::mint<ROCKET>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

