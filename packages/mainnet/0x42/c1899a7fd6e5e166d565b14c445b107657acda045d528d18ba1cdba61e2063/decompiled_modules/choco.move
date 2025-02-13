module 0x42c1899a7fd6e5e166d565b14c445b107657acda045d528d18ba1cdba61e2063::choco {
    struct CHOCO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHOCO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"https://gateway.pinata.cloud/ipfs/bafybeif54k5lpo4kglp3peg2wc5nkvxbnhnuxpjcoxlv2wu5mpbmnc7sr4                                                                                                                                                                                                                                   ");
        let v1 = if (0x1::vector::length<u8>(&v0) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v0))
        };
        let (v2, v3) = 0x2::coin::create_currency<CHOCO>(arg0, 9, 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"CHOCO   ")))), trim_right(b"ChocoCat MemeCoin               "), trim_right(b"CHOCO powers Chococat AI in Web3 Holders unlock premium AI insights governance rights staking rewards and ecosystem perks like exclusive NFT drops and discounts Use it to influence Chococat responses access priority support and maybe just maybe avoid its full sarcastic wrath                                             "), v1, arg1);
        let v4 = v2;
        0x2::transfer::public_transfer<0x2::coin::Coin<CHOCO>>(0x2::coin::mint<CHOCO>(&mut v4, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<CHOCO>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHOCO>>(v3);
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

