module 0x7969af90890b72566fdcd6dc954876ca86c9786dd1cbd2e2ec4753260fb4ee68::lucr {
    struct LUCR has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUCR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111      ");
        let v1 = trim_right(b"https://gateway.irys.xyz/7NfQEk6DpMHJt5G1r0mrFe_y1MOkUe7sLj2rLd_fd64                                                                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<LUCR>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"LUCR    ")))), trim_right(b"LUCORO                          "), trim_right(x"4c75636f726f2069732061207374796c69736820636f6d6d756e69747920746f6b656e206372656174656420746f2073796d626f6c697a6520696e646570656e64656e63652c2063616c6d2c20616e642061206e657720666f726d206f66206469676974616c207765616c74682e205468652070616e6461206d6173636f7420726570726573656e747320737472656e6774682c20656c6567616e63652c20616e642073746162696c6974792e2054686520746f74616c20746f6b656e20737570706c79206973206361707065642061742036392c3030302c303030204c5543522e0a486f6c64204c75636f726f2e2052756c6520696e2073696c656e63652e20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUCR>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LUCR>>(v4);
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

