module 0xd72896c8d2a5885557e9ac67ede4dacb2282bafe842a4392776f34cdf0b93ebf::priscila {
    struct PRISCILA has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<PRISCILA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PRISCILA>>(0x2::coin::mint<PRISCILA>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: PRISCILA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/3a3WzYEabnojYSxtBsX2wmE5HxMdxGvX23efVhD1pump.png?size=lg&key=c4be58                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<PRISCILA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Priscila")))), trim_right(b"Priscila The Dancing Dog        "), trim_right(x"4d656574205072697363696c612c207468652064616e63696e6720646f672c20717565656e206f66207061727469657320616e642062656174732e2053686520726164696174657320656e657267792c206c6f766573206d757369632c20616e64206272696e67732065766572796f6e6520746f676574686572207468726f7567682066756e2e20526561647920746f2064616e63652077697468205072697363696c613f0020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PRISCILA>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<PRISCILA>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<PRISCILA>>(0x2::coin::mint<PRISCILA>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

