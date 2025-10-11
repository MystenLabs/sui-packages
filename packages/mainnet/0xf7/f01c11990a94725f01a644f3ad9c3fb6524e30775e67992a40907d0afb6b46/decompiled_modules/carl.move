module 0xf7f01c11990a94725f01a644f3ad9c3fb6524e30775e67992a40907d0afb6b46::carl {
    struct CARL has drop {
        dummy_field: bool,
    }

    fun init(arg0: CARL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"5f88fd6f9974c7f7f5bcd2684439f21d2859b21d2a61800c0491fe54a62770d1                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<CARL>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Carl        ")))), trim_right(b"Carl Weezer                     "), trim_right(x"596f75206163636964656e74616c6c79206c656674206120646f6c6c617220696e206d792068616e642c20616e642049207475726e656420697420696e746f2061206d696c6c696f6e210a0a57656c636f6d6520746f2074686520776f726c64206f6620244341524c2c207768657265206368696c64686f6f64206e6f7374616c676961206d6565747320756e73746f707061626c65206d656d6520656e6572677920616e642063727970746f20696e6e6f766174696f6e2e20496e737069726564206279207468652069636f6e6963204361726c20576865657a65722066726f6d204a696d6d79204e657574726f6e2c20244341524c2069736e74206a75737420616e6f7468657220636f696e6974732061206d6f76656d656e7420706f7765726564206279206c617567687465722c20636f6d6d756e6974792c20616e64"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CARL>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CARL>>(v4);
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

