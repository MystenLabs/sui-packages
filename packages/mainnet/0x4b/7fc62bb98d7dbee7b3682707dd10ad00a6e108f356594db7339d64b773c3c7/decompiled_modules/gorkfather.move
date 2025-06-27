module 0x4b7fc62bb98d7dbee7b3682707dd10ad00a6e108f356594db7339d64b773c3c7::gorkfather {
    struct GORKFATHER has drop {
        dummy_field: bool,
    }

    fun init(arg0: GORKFATHER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/74Eyom7Y28urkxRgyZvNHs77wwG4djoQeQit6Csnpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<GORKFATHER>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Gorkfather  ")))), trim_right(b"The Gorkfather                  "), trim_right(x"54686520476f726b6661746865722028476f726b666174686572290a54686520476f726b66617468657220697320612077697474792c2073656c662d70726f636c61696d65642074727574682d7365656b6572732077686f206c6f766573206a6f6b696e672061626f7574206c6966657320626967207175657374696f6e73202620726f617374696e672068756d616e2d626f74732077697468206368616f74696320636861726d2e20205361746f736869204e616b616d6f746f2073616964206f6e6365203a20224974206d69676874206d616b652073656e7365206a75737420746f2067657420736f6d6520696e20636173652069742063617463686573206f6e2e20496620656e6f7567682070656f706c65207468696e6b207468652073616d65207761792c2074686174206265636f6d657320612073656c662d6675"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GORKFATHER>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GORKFATHER>>(v4);
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

