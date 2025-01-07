module 0x7660ca43f687c298b76661544c241778c6aed675d1502eed1138cb30415400b6::fork {
    struct FORK has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<FORK>, arg1: 0x2::coin::Coin<FORK>) {
        0x2::coin::burn<FORK>(arg0, arg1);
    }

    fun mint_and_transfer(arg0: &mut 0x2::coin::TreasuryCap<FORK>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<FORK>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: FORK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/BHrgRyaXbK2QSL6bNXVCxhpsfuU3ErNE6YCQ3SBUpump.png?size=lg&key=a1490e                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<FORK>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"FORK      ")))), trim_right(b"FORK                            "), trim_right(b"Create your own \"fork\" of $FORK, submit it, and compete on the leaderboard for $FORK tokens. Each month, the top 5 forks with the highest market cap win $FORK tokens and public shoutouts on . Fork it, submit it, win the golden fork prize. socials for more:                                                                "), v2, arg1);
        let v5 = v3;
        let v6 = &mut v5;
        let v7 = 0x2::tx_context::sender(arg1);
        mint_and_transfer(v6, 1000000000000000000, v7, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FORK>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<FORK>>(v5);
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

