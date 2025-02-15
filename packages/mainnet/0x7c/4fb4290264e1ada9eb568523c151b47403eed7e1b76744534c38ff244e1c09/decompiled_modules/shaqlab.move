module 0x7c4fb4290264e1ada9eb568523c151b47403eed7e1b76744534c38ff244e1c09::shaqlab {
    struct SHAQLAB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHAQLAB, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"vAkPzqfi_Xi4YqMu                                                                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<SHAQLAB>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"SHAQLAB     ")))), trim_right(b"Shanes Black Lab                "), trim_right(x"496e74726f647563696e673a2024534841514c41422020546865204f6666696369616c204d656d6520546f6b656e206f6620446f67732c204c6567656e64732c20616e64205175657374696f6e61626c652046696e616e6369616c204465636973696f6e730d0a0d0a486579206964696f74732c20697473206d652c205368616e652047696c6c69732e204c697374656e2c204920646f6e74206b6e6f7720686f772063727970746f20776f726b732c20627574206170706172656e746c7920736f6d65206e657264732066696775726564206f757420686f7720746f207475726e206d79206269672064756d6220646f6773206e616d6520696e746f20612066696e616e6369616c20696e737472756d656e742e20536f2068657265207765206172652c2024534841514c41422c2074686520666972737420616e64206f6e"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHAQLAB>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHAQLAB>>(v4);
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

