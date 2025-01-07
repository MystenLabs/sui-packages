module 0x591783c58fdb833ca5ffca7e5c13b43e1f5a922f88ad2c92667d0ba16f6941b7::riches {
    struct RICHES has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<RICHES>, arg1: 0x2::coin::Coin<RICHES>) {
        0x2::coin::burn<RICHES>(arg0, arg1);
    }

    fun mint_and_transfer(arg0: &mut 0x2::coin::TreasuryCap<RICHES>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<RICHES>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: RICHES, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/AYFyp2VTyFAUVYjFYbaxLjVHnpZnaoDs6UFyaBzopump.png?size=lg&key=04f901                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<RICHES>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"RICHES    ")))), trim_right(b"RACCOON RICHES                  "), trim_right(x"526163636f6f6e205269636865732069732061206d656d6520746f6b656e20696e7370697265642062790a74686520636c6576657220726163636f6f6e2c20616c77617973206b6e6f77696e6720686f7720746f0a67657420776861742069742077616e7473212044726177696e6720696e737069726174696f6e2066726f6d0a7468697320696e74656c6c6967656e7420616e696d616c2c20776869636820697320616c776179732067726561740a617420646973636f766572696e672068696464656e207472656173757265732c207765206272696e670a526163636f6f6e20526963686573206173206120746f6b656e2074686174206f66666572730a756e6578706563746564206f70706f7274756e697469657320696e2074686520776f726c64206f662063727970746f63757272656e63792e2020202020202020"), v2, arg1);
        let v5 = v3;
        let v6 = &mut v5;
        let v7 = 0x2::tx_context::sender(arg1);
        mint_and_transfer(v6, 1000000000000000000, v7, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RICHES>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<RICHES>>(v5);
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

