module 0x5c768a9baf8985ee9837fe6e6f4f97797b7b690893cbef013d20b887a16934c::ftt {
    struct FTT has drop {
        dummy_field: bool,
    }

    fun init(arg0: FTT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/BbM9dkZzjgniCCW6fzNxE4JZmYtyHMsCMmqeYs7Lpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<FTT>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"FTT         ")))), trim_right(b"Fwog The Tap                    "), trim_right(x"46574f47205448452054415020697320612066756e20506c61792d746f2d4561726e20416e64726f69642061707020706f7765726564206279207468652046545420546f6b656e206f6e2074686520536f6c616e6120626c6f636b636861696e2e0a0a0a20576879204a6f696e3f0a0a2d204561726e20546f6b656e733a2054617020746f206561726e2046545420546f6b656e73210a2d20526566657220467269656e64733a20496e7669746520667269656e647320616e6420626f7468206561726e206d6f726520706f696e74732120596f7520676574202b3220706f696e747320706572207461702c20616e6420796f757220667269656e647320676574202b312e0a2d20426f6f737473202620526577617264733a20556e6c6f636b20626f6f73747320616e642077696e20617765736f6d65207072697a65732e0a"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FTT>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FTT>>(v4);
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

