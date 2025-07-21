module 0x62b8a17812ad5e826b3ad8a0b8fe717195d41e2193c456f2f2d3382e843ce7f5::btc {
    struct BTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTC, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/25mXqqr8yjZG1jCo87vMerjVKPoEbeDCj3Gwavdsbonk.png?claimId=y5VmUWK2HEbHQ3ca                                                                                                                                                                                                      ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<BTC>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"BTC         ")))), trim_right(b"Bitcoin                         "), trim_right(b"$BTC - Bitcoin on Bonk. 21 million supply, Tomtoshi's (Bonk Dev) wallet has 968,452 BTC just like the real BTC and Satoshi. Giving the people a 2nd chance at BTC, born on Solana so its faster and more affordable. Built on Bonk $BTC isn't just another token, its a ticking time bomb!                                      "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTC>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BTC>>(v4);
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

