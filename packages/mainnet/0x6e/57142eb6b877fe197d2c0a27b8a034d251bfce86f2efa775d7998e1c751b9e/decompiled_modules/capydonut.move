module 0x6e57142eb6b877fe197d2c0a27b8a034d251bfce86f2efa775d7998e1c751b9e::capydonut {
    struct CAPYDONUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAPYDONUT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/CfwTqgjG8cfNiRvGU91GCabVmkRsrnCDqC4yVNComYyp.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<CAPYDONUT>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"CAPYDONUT   ")))), trim_right(b"Capybara Donut                  "), trim_right(x"20436170796261726120446f6e757420282443415059444f4e5554292020546865205377656574657374204d656d65636f696e206f6e20536f6c616e6121200a0a5361792068656c6c6f20746f20436170796261726120446f6e757420282443415059444f4e5554292020746865206d6f7374206368696c6c2c20736e61636b2d6c6f76696e6720746f6b656e20726f6c6c696e67206f6e746f20536f6c616e6121204275696c7420666f722073706565642c2066756e2c20616e642064656c6963696f7573206761696e732c202443415059444f4e555420697320746865207065726665637420626c656e64206f6620636170796261726120766962657320616e642073756761727920726577617264732e0a0a576879204a6f696e20746865202443415059444f4e5554204372617a653f0a20426c617a696e672d466173"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAPYDONUT>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CAPYDONUT>>(v4);
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

