module 0x9ce7bbf8b397fcbd229ce4e6f2e9a84fbc70c931ead025abc25f1eb77e174a1c::btc2025 {
    struct BTC2025 has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<BTC2025>, arg1: 0x2::coin::Coin<BTC2025>) {
        0x2::coin::burn<BTC2025>(arg0, arg1);
    }

    fun mint_and_transfer(arg0: &mut 0x2::coin::TreasuryCap<BTC2025>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<BTC2025>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: BTC2025, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/3JwbwyziShzWqzjb5b5iQ9kyonZPyGRVu637QmsHpump.png?size=lg&key=df106d                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<BTC2025>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"BTC2025   ")))), trim_right(b"Bitcoin2025                     "), trim_right(b"The prophecy is clear: 2025 is The year for Bitcoins legendary pump!  Backed by the power duo Donald Trump and Elon Musk, with nations racing to legalize BTC, the stage is set for Bitcoin to go absolutely parabolic!                                                                                                         "), v2, arg1);
        let v5 = v3;
        let v6 = &mut v5;
        let v7 = 0x2::tx_context::sender(arg1);
        mint_and_transfer(v6, 1000000000000000000, v7, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BTC2025>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BTC2025>>(v5);
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

