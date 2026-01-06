module 0x1b369c0c1adf7a0e3b30493885e38dd32d04b869e533dd30a23fe00108442b15::flappy {
    struct FLAPPY has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<FLAPPY>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<FLAPPY>>(0x2::coin::mint<FLAPPY>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: FLAPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://cdn.dexscreener.com/cms/images/2718b8b8f2adc1ee4777e0b020270b1bcf480195cad7bec3eaa65a7061aa1867?width=128&height=128&fit=crop&quality=95&format=auto                                                                                                                                                                    ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<FLAPPY>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"FLAPPY  ")))), trim_right(b"Flap Mascot                     "), trim_right(b"Flap mascot Flappy is a Sui-dividend token created to reward the community. Built with a simple 3% transaction tax, all collected fees are automatically redistributed to holders as Sui dividends. Flappy represents the value of being part of a strong community.                                                            "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FLAPPY>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<FLAPPY>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<FLAPPY>>(0x2::coin::mint<FLAPPY>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

