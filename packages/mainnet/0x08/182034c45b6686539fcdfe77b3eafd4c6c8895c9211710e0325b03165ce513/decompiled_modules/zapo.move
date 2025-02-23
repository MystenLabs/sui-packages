module 0x8182034c45b6686539fcdfe77b3eafd4c6c8895c9211710e0325b03165ce513::zapo {
    struct ZAPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZAPO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"drPQ1WwumUlN_VAG                                                                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<ZAPO>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"ZAPO        ")))), trim_right(b"ZAPO                            "), trim_right(x"54686520556c74696d617465204d656d652043617420436f696e200d0a0d0a245a41504f2069736e74206a7573742061206d656d656974732061207265766f6c7574696f6e206f6e20536f6c616e61206c656420627920746865206d6f737420656c65637472696679696e672077686974652063617420696e2063727970746f2120546869732066656c696e6520697320666173742c20666561726c6573732c20616e6420726561647920746f2074616b65206f7665722074686520626c6f636b636861696e206a756e676c652e0d0a0d0a0d0a0d0a546869732063617420686173207a65726f206368696c6c20616e6420696e66696e69746520706f74656e7469616c67657420696e206265666f726520697420706f756e636573212020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZAPO>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZAPO>>(v4);
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

