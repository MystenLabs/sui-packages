module 0x5918f8d9ed7f18d41d6b55e39fb48bb757b0c8b3dd05d0c60954dae8985d622f::cballers {
    struct CBALLERS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CBALLERS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/ECLRKMWYmihc2wH2bp4mFH8fETrx84xfH6eqtBevFALX.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<CBALLERS>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"CBALLERS    ")))), trim_right(b"CRYPTO BALLERS                  "), trim_right(b"Being a Crypto Baller means more than just investing in digital assetsits about embracing financial freedom, innovation, and the power of blockchain technology. Most of us want to be Crypto Rich to help out family members and friends. To give the less fortunate an opportunity to change their lives.  The Crypto Ballers "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CBALLERS>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CBALLERS>>(v4);
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

