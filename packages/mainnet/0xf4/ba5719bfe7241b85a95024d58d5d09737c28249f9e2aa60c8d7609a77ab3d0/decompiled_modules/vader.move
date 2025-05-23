module 0xf4ba5719bfe7241b85a95024d58d5d09737c28249f9e2aa60c8d7609a77ab3d0::vader {
    struct VADER has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<VADER>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<VADER>>(0x2::coin::mint<VADER>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: VADER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/base/0x731814e491571a2e9ee3c5b1f7f3b962ee8f4870.png?size=lg&key=183b35                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<VADER>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"VADER   ")))), trim_right(b"VaderAI by Virtuals             "), trim_right(b"VaderAI aims to become the ultimate Investment Sui of the Agentic Economy. VaderAI analyzes markets, tweets alphas and invests in AI Agent tokens autonomously.                                                                                                                                                                 "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VADER>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<VADER>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<VADER>>(0x2::coin::mint<VADER>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

