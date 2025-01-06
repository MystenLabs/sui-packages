module 0xc77bb054f0b87d2d869aabda61e9bac72e4b5c7728d8941ddb3808df51f86b2d::nexusai {
    struct NEXUSAI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<NEXUSAI>, arg1: 0x2::coin::Coin<NEXUSAI>) {
        0x2::coin::burn<NEXUSAI>(arg0, arg1);
    }

    fun mint_and_transfer(arg0: &mut 0x2::coin::TreasuryCap<NEXUSAI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<NEXUSAI>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: NEXUSAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/AtVt7vHoxq9qyk18dvxHnsYYGmq7vKagP3cWXFwSpump.png?size=lg&key=33aa1c                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<NEXUSAI>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"NEXUSAI   ")))), trim_right(b"NEXUS AI                        "), trim_right(b"$NEXUS is a next-generation prediction protocol that combines artificial intelligence, machine learning, and decentralized analytics to predict real-world event.                                                                                                                                                               "), v2, arg1);
        let v5 = v3;
        let v6 = &mut v5;
        let v7 = 0x2::tx_context::sender(arg1);
        mint_and_transfer(v6, 1000000000000000000, v7, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NEXUSAI>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<NEXUSAI>>(v5);
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

