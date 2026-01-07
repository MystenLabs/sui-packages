module 0x3e70d668f5762a580c46ca2be62c978c16d3f7b5237d2f2129ae92319a70e101::jsy {
    struct JSY has drop {
        dummy_field: bool,
    }

    fun init(arg0: JSY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://gateway.irys.xyz/HhcQGscGjhjDH0p-hlC2HJ87henRIfxS8yOcgnkADGg";
        let v1 = if (0x1::vector::length<u8>(&v0) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.irys.xyz/HhcQGscGjhjDH0p-hlC2HJ87henRIfxS8yOcgnkADGg"))
        };
        let (v2, v3, v4) = 0x2::coin::create_regulated_currency_v2<JSY>(arg0, 8, trim_right(b"JSY"), trim_right(b"JSY longevity token"), trim_right(b"This is a cultivation token, used for tuition fees to improve oneself, and can also be used to purchase cultivation courses on the official website. More use cases will be launched in the future."), v1, true, arg1);
        let v5 = v2;
        let v6 = 0x2::tx_context::sender(arg1);
        if (1949000000000000000 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<JSY>>(0x2::coin::mint<JSY>(&mut v5, 1949000000000000000, arg1), v6);
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JSY>>(v5, v6);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<JSY>>(v3, v6);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JSY>>(v4);
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

