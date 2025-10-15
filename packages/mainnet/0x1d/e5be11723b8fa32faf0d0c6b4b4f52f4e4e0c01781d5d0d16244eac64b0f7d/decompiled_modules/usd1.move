module 0x1de5be11723b8fa32faf0d0c6b4b4f52f4e4e0c01781d5d0d16244eac64b0f7d::usd1 {
    struct USD1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: USD1, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://gateway.irys.xyz/B5kWcdfZzceuEqDd6f_Phf0aT11RE2aPGunV5NeSym0";
        let v1 = if (0x1::vector::length<u8>(&v0) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.irys.xyz/B5kWcdfZzceuEqDd6f_Phf0aT11RE2aPGunV5NeSym0"))
        };
        let (v2, v3, v4) = 0x2::coin::create_regulated_currency_v2<USD1>(arg0, 9, trim_right(b"USD1"), trim_right(b"Useless Dollar 1"), trim_right(b"USD1 is a U.S. dollar stablecoin launched in March 2025 by World Liberty Financial (WLFI), a crypto industry entity of the Trump family. As of July 2025, the market capitalization of USD1 has exceeded the $2.2 billion mark."), v1, true, arg1);
        let v5 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USD1>>(v2, v5);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<USD1>>(v3, v5);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<USD1>>(v4);
    }

    fun trim_right(arg0: vector<u8>) : vector<u8> {
        let v0 = 32;
        while (0x1::vector::length<u8>(&arg0) > 0) {
            if (0x1::vector::borrow<u8>(&arg0, 0x1::vector::length<u8>(&arg0) - 1) != &v0) {
                break
            };
            0x1::vector::pop_back<u8>(&mut arg0);
        };
        arg0
    }

    // decompiled from Move bytecode v6
}

