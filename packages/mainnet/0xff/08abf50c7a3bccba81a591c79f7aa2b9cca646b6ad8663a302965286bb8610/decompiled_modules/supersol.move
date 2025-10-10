module 0xff08abf50c7a3bccba81a591c79f7aa2b9cca646b6ad8663a302965286bb8610::supersol {
    struct SUPERSOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUPERSOL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"6c7e9377f65c802c24b8c3afe8824d0eb5431aa2737fd324d4917a1d4393f181                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<SUPERSOL>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"SuperSol    ")))), trim_right(b"IN SOLANA WE TRUST              "), trim_right(x"496e20536f6c616e6120576520547275737420200a5765206d616e696665737420534f4c414e412053555052454d41435921205765206d616e6966657374205452454e4348455320484f4d454c414e4420536f6c616e6121205765206d616e69666573742022496e20536f6c616e612057652054727573742220746f207472696275746520746865204245535420434841494e20455645522c20536f6c616e612120245375706572536f6c2020426f7720646f776e20746f20536f6c616e612c2074686520554e544f55434841424c45205355504552204b494e47206f6620414c4c20626c6f636b636861696e732c2064726f7070696e27206c696768746e696e672d66617374206761696e7320616e64206665657320736f20636865617020697427732073747261696768742d757020534f52434552592120536f6c616e61"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUPERSOL>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUPERSOL>>(v4);
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

