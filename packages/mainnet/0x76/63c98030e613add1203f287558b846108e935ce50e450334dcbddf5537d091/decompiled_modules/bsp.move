module 0x7663c98030e613add1203f287558b846108e935ce50e450334dcbddf5537d091::bsp {
    struct BSP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BSP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/9em9pHmkmHeff6DG3jfR7m8PskanwgcUjRHYq35hbonk.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<BSP>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"BSP         ")))), trim_right(b"BONK SPACE PROGRAM              "), trim_right(x"53706163652069732061207374617274696e6720706f696e742024425350204c495645204f4e20580a0a4f757220637573746f6d2d6275696c7420726f636b65742077696c6c20726561636820616e20616c746974756465206f6620757020746f2035306b6d2c20636170747572696e6720696d61676573206f66204561727468732063757276617475726520746f2070726f7665206f6e636520616e6420666f7220616c6c207468617420746865204561727468206973206e6f7420666c61742020616e6420746f207065726d616e656e746c792073746f72652074686f736520686973746f7269632073686f7473206f6e2d636861696e2e2020200a0a4c61756e63682048617264776172653a20437573746f6d2d6275696c7420686967682d616c746974756465206d6f64656c20726f636b6574207769746820666c69"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BSP>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BSP>>(v4);
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

