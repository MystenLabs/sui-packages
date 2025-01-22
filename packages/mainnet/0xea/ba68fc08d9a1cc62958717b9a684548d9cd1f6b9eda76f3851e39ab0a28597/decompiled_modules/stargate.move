module 0xeaba68fc08d9a1cc62958717b9a684548d9cd1f6b9eda76f3851e39ab0a28597::stargate {
    struct STARGATE has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<STARGATE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<STARGATE>>(0x2::coin::mint<STARGATE>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: STARGATE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/AwcHQrauEYWoQjLQYCDq3CKsZDTEA9freCZpnpqPpump.png?size=lg&key=6e4cf1                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<STARGATE>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"STARGATE")))), trim_right(b"Project Stargate On Sui         "), trim_right(b"NEW: Trump announces \"Project Stargate,\" a plan for the US to invest $500B in American AI infrastructure. It will be a Joint Venture with OpenAI, Oracle, and Softbank, and other investors will come later. They're starting with a data center in Texas. More details to come soon.                                           "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STARGATE>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<STARGATE>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<STARGATE>>(0x2::coin::mint<STARGATE>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

