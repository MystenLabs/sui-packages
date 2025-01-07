module 0x6a09773ad65a68a4a2ac0b1b6baf62a5e0a38cbeae23041fbffe5006aef8f5ae::qcoin {
    struct QCOIN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<QCOIN>, arg1: 0x2::coin::Coin<QCOIN>) {
        0x2::coin::burn<QCOIN>(arg0, arg1);
    }

    fun mint_and_transfer(arg0: &mut 0x2::coin::TreasuryCap<QCOIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<QCOIN>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: QCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dhttps://dd.dexscreener.com/ds-data/tokens/solana/9AMoLuGBvJz4kjQ19N2mGtFwdEu4YQnzHrWLxDXgpump.png?size=lg&key=f07df6exscreener.com/ds-data/tokens/solana/4ff9xkoUEuJo9vuSCydaQFCjioLCpcSbY28DCpTu5bpu.png?size=lg&key=b70ccf                                                                                        ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<QCOIN>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"QCoin     ")))), trim_right(b"Zerebros Coin                   "), trim_right(b"Zerebro's Coin (Q-Coin)                                                                                                                                                                                                                                                                                                         "), v2, arg1);
        let v5 = v3;
        let v6 = &mut v5;
        let v7 = 0x2::tx_context::sender(arg1);
        mint_and_transfer(v6, 1000000000000000000, v7, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<QCOIN>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<QCOIN>>(v5);
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

