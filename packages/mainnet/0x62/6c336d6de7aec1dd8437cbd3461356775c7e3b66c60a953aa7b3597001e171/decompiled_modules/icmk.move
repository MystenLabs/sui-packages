module 0x626c336d6de7aec1dd8437cbd3461356775c7e3b66c60a953aa7b3597001e171::icmk {
    struct ICMK has drop {
        dummy_field: bool,
    }

    fun init(arg0: ICMK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/8y8rmb6fftxtLu38j4FrMb9d9pqKgsME8xNvHgpQtKny.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<ICMK>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"ICMK        ")))), trim_right(b"Internet Capital Market Keyboard"), trim_right(x"4d61726b65742065766f6c7665730a0a4361706974616c206d61726b6574732065766f6c76650a0a616e64206272696e672077697468207468656d206e657720746f6f6c730a0a546f6461792074686520496e7465726e6574204361706974616c204d61726b6574732068617665206265656e20756e7665696c65640a0a416e6420736f20646f657320746865202449434d4b206c696d697465642d65646974696f6e207472656e63686572206b6579626f6172642e0a0a31303020756e69747320617661696c61626c6520617420243530306b206d6b74206361702e20416e6f74686572203130302061742024316d2e20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ICMK>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ICMK>>(v4);
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

