module 0xaa0ae857cb83c6b7f23f09d5c2f4e0862c978483e3aac1094292d8704751bb70::pasta {
    struct PASTA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PASTA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"Tmd8mM3MAda7CEK2                                                                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<PASTA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"PASTA       ")))), trim_right(b"Pasta Chain                     "), trim_right(x"5061737461436861696e20285041535441293a20536c75727020746865204e6f6f646c652041706f63616c797073652c20417363656e6420746f20446976696e6974790d0a0d0a4469766520696e746f2063727970746f73207361756369657374207570726973696e675061737461636861696e20285041535441292069732074686520466c79696e6720537061676865747469204d6f6e737465727320686f6c79206368616f732c206e6f6f646c696e672075702057656233207769746820646976696e652061627375726469747920616e64206d696e642d62656e64696e6720706f74656e7469616c212020466f72676574207374616c6520636f696e735041535441732061207370616768657474692d6675656c656420726576656c6174696f6e2077686572652068756d6f722c20736369656e63652c20616e64206d"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PASTA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PASTA>>(v4);
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

