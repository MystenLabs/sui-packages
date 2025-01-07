module 0x20b5ba896099a4d442bb1e60c93a37d415aaccd3362274a218b0b2c03ec5ffd9::port {
    struct PORT has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<PORT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PORT>>(0x2::coin::mint<PORT>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: PORT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/BKXQnRzZFq1DXyiJiVC6Y5EbUYMgYCMx9U89D5Yrpump.png?size=lg&key=1c4aca                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<PORT>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"PORT    ")))), trim_right(b"it's time to full port          "), trim_right(b"For the first time ever you can now buy and sell multiple coins in a single transaction, and earn fees on tradesFor the first time ever you can now buy and sell multiple coins in a single transaction, and earn fees on trades                                                                                                "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PORT>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<PORT>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<PORT>>(0x2::coin::mint<PORT>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

