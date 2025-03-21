module 0xf932c64d83d01d1c69ff713d0797072e40323831bf9712c9b6076d0317f2ba77::trustai {
    struct TRUSTAI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TRUSTAI>, arg1: 0x2::coin::Coin<TRUSTAI>) {
        0x2::coin::burn<TRUSTAI>(arg0, arg1);
    }

    fun mint_and_transfer(arg0: &mut 0x2::coin::TreasuryCap<TRUSTAI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TRUSTAI>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: TRUSTAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/FJrCK1KBpHx8uJr5HLgF8gpYNRtm8ymhvTs6pDdDpump.png?size=lg&key=ea0dae                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<TRUSTAI>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"TrustAI   ")))), trim_right(b"Trust AI Agent                  "), trim_right(b"Your reliable partner for innovative AI-powered audit and compliance solutions. We integrate seamless KYC processes, advanced audits, and cutting-edge security to elevate trust and regulatory confidence.                                                                                                                     "), v2, arg1);
        let v5 = v3;
        let v6 = &mut v5;
        let v7 = 0x2::tx_context::sender(arg1);
        mint_and_transfer(v6, 1000000000000000000, v7, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUSTAI>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TRUSTAI>>(v5);
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

