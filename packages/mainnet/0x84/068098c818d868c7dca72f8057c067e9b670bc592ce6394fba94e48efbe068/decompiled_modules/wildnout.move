module 0x84068098c818d868c7dca72f8057c067e9b670bc592ce6394fba94e48efbe068::wildnout {
    struct WILDNOUT has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<WILDNOUT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<WILDNOUT>>(0x2::coin::mint<WILDNOUT>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: WILDNOUT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/5m9AhhwMnosop8CAWdSJDNfLLkg3EFkX5sJ3zAuMpump.png?size=lg&key=3e42b5                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<WILDNOUT>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"WILDNOUT")))), trim_right(b"Official Wild 'N Out            "), trim_right(b"Get ready for the wildest meme coin to hit Sui! Brought to you by only and only Nick Cannon, $WILDNOUT is bringing the same Wild N Out energy that made it legendary. Were blasting straight to the moon!                                                                                                                       "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WILDNOUT>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<WILDNOUT>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<WILDNOUT>>(0x2::coin::mint<WILDNOUT>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

