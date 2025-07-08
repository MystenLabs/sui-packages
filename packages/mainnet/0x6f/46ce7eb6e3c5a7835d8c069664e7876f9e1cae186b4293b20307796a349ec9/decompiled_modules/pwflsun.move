module 0x6f46ce7eb6e3c5a7835d8c069664e7876f9e1cae186b4293b20307796a349ec9::pwflsun {
    struct PWFLSUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PWFLSUN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/Ad5Y9CqarbbppoFNsTsGyoHTWfYHo56m1p8fD38SvQJc.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<PWFLSUN>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"PwflSun     ")))), trim_right(b"PowerfulSun                     "), trim_right(x"53696e6365204d617263682031362c20323031322c207468652022506f77657266756c2053756e2220536f6c6172204f62736572766174696f6e2067726f75702068617320736861726564206b6e6f776c656467652061626f7574207468652053756e277320696d70616374206f6e2045617274682e2057697468206120736d616c6c206275742067726f77696e67206d656d626572736869702c207468652067726f75702061696d7320746f2072616973652061776172656e65737320616e6420656e636f757261676520736369656e74696669632072657365617263682e0a0a546f20657870616e64206974732072656163682c207468652067726f7570206973206c61756e6368696e672061206d656d6520636f696e2063727970746f63757272656e63792c2073796d626f6c697a696e67207468652053756e277320"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PWFLSUN>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PWFLSUN>>(v4);
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

