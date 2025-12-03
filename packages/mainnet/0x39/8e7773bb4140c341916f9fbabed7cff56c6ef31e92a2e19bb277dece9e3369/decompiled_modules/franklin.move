module 0x398e7773bb4140c341916f9fbabed7cff56c6ef31e92a2e19bb277dece9e3369::franklin {
    struct FRANKLIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRANKLIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"c441755c0cf4f418750e610276acae6dab649d5af2fb5a3355d05118643efe6c                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<FRANKLIN>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Franklin    ")))), trim_right(b"Franklin Meets a Retard         "), trim_right(b"Franklin Meets a Retard is a fun, community-driven project born on Solana, created to bring back the true meme spirit that everyone loves.This project is built by people who understand memes, culture, and the power of togetherness. Every part of it is shaped by the community.                                            "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRANKLIN>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FRANKLIN>>(v4);
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

