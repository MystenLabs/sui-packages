module 0x5f8dcf83b43407df93961ecb81a181d5ebf410d99fbc8a8c61adb1b62f5679ef::trump47 {
    struct TRUMP47 has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<TRUMP47>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TRUMP47>>(0x2::coin::mint<TRUMP47>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: TRUMP47, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/7PppUqffLkgiACVTko8qiW4haHHKrZjT4sQ2BdNCpump.png?size=lg&key=002db8                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<TRUMP47>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"TRUMP47 ")))), trim_right(b"Donald Trump 47                 "), trim_right(b"$TRUMP47 is a revolutionary meme coin designed to celebrate the historic 47th Inauguration of President Donald Trump. Created by a passionate community of crypto enthusiasts, $TRUMP47 captures the spirit of political change and the enduring impact of Trump's leadership.                                                  "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUMP47>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TRUMP47>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<TRUMP47>>(0x2::coin::mint<TRUMP47>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

