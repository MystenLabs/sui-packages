module 0x3a4beaf27b1618c0a6cbe24992cbdc1d8cb98511581b54818ab97844b944b27b::starbutt {
    struct STARBUTT has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<STARBUTT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<STARBUTT>>(0x2::coin::mint<STARBUTT>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: STARBUTT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/DcmLeCeH1yDDjLVfRC72XVr2YFFyNjvbBrRMFF5ppump.png?size=lg&key=bb42a6                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<STARBUTT>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Starbutt")))), trim_right(b"Starbutt                        "), trim_right(b"Welcome to the juiciest roast on the blockchain! Starbutts serves up hot coffee, hotter mermaids, and a whole latte gains. Whether you're in it for the memes or the moon, this cheeky tokens got your back(side). Hold tight, sip slow, and enjoy the grind!                                                                   "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STARBUTT>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<STARBUTT>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<STARBUTT>>(0x2::coin::mint<STARBUTT>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

