module 0x46e3e21db263ca74bba0c78dba043c5ba851614917c188343860a40d5ced6b28::eth {
    struct ETH has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<ETH>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<ETH>>(0x2::coin::mint<ETH>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: ETH, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/5kGVjyXaEejcywCYm1zPcVc7vFbuYm8H4mBhAz6xQBHG.png?size=lg&key=8a4408                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<ETH>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"ETH     ")))), trim_right(b"Exodus                          "), trim_right(b"A permissionless bridge giving ETH holders the chance to put an end to years of suffering, by swapping native ETH directly to ETH the memecoin on Sui. Join the cause                                                                                                                                                           "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ETH>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<ETH>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<ETH>>(0x2::coin::mint<ETH>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

