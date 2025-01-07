module 0x94d85100dbd528a5c15a4c24ca1b09ff6d607d4cdc53f692087a5b97ce76350f::rigby {
    struct RIGBY has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<RIGBY>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<RIGBY>>(0x2::coin::mint<RIGBY>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: RIGBY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://cdn.dexscreener.com/cms/images/KWYK4vsR6XkPD6KE?width=150&height=150&fit=crop&quality=95&format=auto                                                                                                                                                                                                                    ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<RIGBY>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"RIGBY   ")))), trim_right(b"RIGBY                           "), trim_right(x"5269676279206973206f6e65206f6620746865206d61696e2063686172616374657273206f6620526567756c61722053686f772e2048652773206120726163636f6f6e2077686f20776f726b7320617320612067726f756e64736b656570657220617420746865207061726b2e204b6e6f776e20666f7220686973206c617a7920616e64206972726573706f6e7369626c65206e61747572652c205269676279206f6674656e20676574732068696d73656c6620616e6420686973206265737420667269656e64204d6f72646563616920696e746f2074726f75626c6520776974682068697320696d70756c73697665206465636973696f6e7320616e642064657369726520666f7220717569636b20746872696c6c732e00202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RIGBY>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<RIGBY>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<RIGBY>>(0x2::coin::mint<RIGBY>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

