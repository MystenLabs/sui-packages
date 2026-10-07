module 0xf9d17df975d80842323cbae5b94909b482930330762ac6d9e9386e46c61b17f1::shadow {
    struct SHADOW has drop {
        dummy_field: bool,
    }

    fun field(arg0: &vector<u8>, arg1: u64) : vector<u8> {
        let v0 = b"";
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<u8>(arg0)) {
            let v3 = *0x1::vector::borrow<u8>(arg0, v2);
            if (v3 == 124) {
                if (v1 == arg1) {
                    return v0
                };
                v1 = v1 + 1;
                v0 = b"";
            } else {
                0x1::vector::push_back<u8>(&mut v0, v3);
            };
            v2 = v2 + 1;
        };
        if (v1 == arg1) {
            v0
        } else {
            b""
        }
    }

    fun init(arg0: SHADOW, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"SHADOW|SHADOW BOY|SUI MASCOT|https://cronos.hypercarsbrokers.xyz/i/34a0ca255e39e7c543c4102d105a0e70.jpg";
        let v1 = field(&v0, 3);
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(v1)))
        };
        let (v3, v4) = 0x2::coin::create_currency<SHADOW>(arg0, 9, field(&v0, 0), field(&v0, 1), field(&v0, 2), v2, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHADOW>>(v4);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHADOW>>(v3, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

