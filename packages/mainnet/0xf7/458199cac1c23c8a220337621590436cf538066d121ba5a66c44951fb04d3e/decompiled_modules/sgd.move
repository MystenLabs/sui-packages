module 0xf7458199cac1c23c8a220337621590436cf538066d121ba5a66c44951fb04d3e::sgd {
    struct SGD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SGD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://gateway.irys.xyz/-m6ygPlD1DM_sjUqQrck7YOv9apvSi4L5WKX2b1baHE";
        let v1 = if (0x1::vector::length<u8>(&v0) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.irys.xyz/-m6ygPlD1DM_sjUqQrck7YOv9apvSi4L5WKX2b1baHE"))
        };
        let (v2, v3, v4) = 0x2::coin::create_regulated_currency_v2<SGD>(arg0, 9, trim_right(b"SGD"), trim_right(b"SGD - SUI"), trim_right(b"SGD "), v1, true, arg1);
        let v5 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SGD>>(v2, v5);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<SGD>>(v3, v5);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SGD>>(v4);
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

