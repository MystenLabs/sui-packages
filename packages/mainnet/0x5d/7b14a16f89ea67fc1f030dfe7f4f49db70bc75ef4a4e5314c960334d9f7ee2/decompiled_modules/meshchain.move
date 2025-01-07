module 0x5d7b14a16f89ea67fc1f030dfe7f4f49db70bc75ef4a4e5314c960334d9f7ee2::meshchain {
    struct MESHCHAIN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<MESHCHAIN>, arg1: 0x2::coin::Coin<MESHCHAIN>) {
        0x2::coin::burn<MESHCHAIN>(arg0, arg1);
    }

    fun mint_and_transfer(arg0: &mut 0x2::coin::TreasuryCap<MESHCHAIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MESHCHAIN>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: MESHCHAIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/GzkE8jBurir9SDPXb8oMWVkmae7tq3eb8F4J8AQ6pump.png?size=lg&key=720d26                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<MESHCHAIN>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Meshchain ")))), trim_right(b"Meshchain Ai                    "), trim_right(b"Connecting AI & blockchain to create a powerful decentralized network. Scalable compute for AI, gaming, and beyond.                                                                                                                                                                                                             "), v2, arg1);
        let v5 = v3;
        let v6 = &mut v5;
        let v7 = 0x2::tx_context::sender(arg1);
        mint_and_transfer(v6, 1000000000000000000, v7, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MESHCHAIN>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MESHCHAIN>>(v5);
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

