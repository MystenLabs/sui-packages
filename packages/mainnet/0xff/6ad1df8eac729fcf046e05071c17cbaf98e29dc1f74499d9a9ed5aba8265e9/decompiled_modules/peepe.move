module 0xff6ad1df8eac729fcf046e05071c17cbaf98e29dc1f74499d9a9ed5aba8265e9::peepe {
    struct PEEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/7kyEj1pxJRnFGc1MqFQHQFg8pfFm5dST6aiZXcoCpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<PEEPE>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Peepe       ")))), trim_right(b"Peepe                           "), trim_right(x"50454550452069732074686520756c74696d61746520667573696f6e206f662050657065207468652046726f672c207065652068756d6f722c20616e642063727970746f206d61646e6573732120426f726e2066726f6d207468652064616e6b65737420636f726e657273206f662074686520696e7465726e65742c205045455045206973206865726520746f206272696e67206c617567687465722c206368616f732c20616e642061206c6974746c6520626974206f66206d6973636869656620746f2074686520626c6f636b636861696e2e200a0a57697468206e6f207574696c6974792c206e6f20726f61646d61702c20616e64206162736f6c7574656c79206e6f2061706f6c6f676965732c20504545504520697320746865206d656d6520636f696e207468617420646f65736e742074616b6520697473656c6620"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEEPE>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEEPE>>(v4);
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

