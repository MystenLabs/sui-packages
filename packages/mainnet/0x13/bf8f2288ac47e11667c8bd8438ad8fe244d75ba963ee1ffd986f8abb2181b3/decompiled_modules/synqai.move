module 0x13bf8f2288ac47e11667c8bd8438ad8fe244d75ba963ee1ffd986f8abb2181b3::synqai {
    struct SYNQAI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SYNQAI>, arg1: 0x2::coin::Coin<SYNQAI>) {
        0x2::coin::burn<SYNQAI>(arg0, arg1);
    }

    fun mint_and_transfer(arg0: &mut 0x2::coin::TreasuryCap<SYNQAI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SYNQAI>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: SYNQAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/9geNRCEuk1iUqMM9ru23a8yhNVCVkN5BN5NNvrdjpump.png?size=lg&key=76a007                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<SYNQAI>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"SYNQAI    ")))), trim_right(b"SynaptiQ System                 "), trim_right(b"SynaptiQ Systems integrates advanced AI with decentralized architecture on Solana, enabling autonomous, adaptive operations within Web3.                                                                                                                                                                                        "), v2, arg1);
        let v5 = v3;
        let v6 = &mut v5;
        let v7 = 0x2::tx_context::sender(arg1);
        mint_and_transfer(v6, 1000000000000000000, v7, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SYNQAI>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SYNQAI>>(v5);
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

