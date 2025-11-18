module 0x2b96ba1a44dcc040e2b8e8abbfbc9ade8b5c5af6b56fcaddaab9a4ad468ce37f::gtf {
    struct GTF has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTF, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"ae4bbcf7c84cafbcf639e4cf91fa2ca51389f1cf30dd65a6dbc8a2195ac7cca5                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<GTF>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"GTF         ")))), trim_right(b"Goat Farming                    "), trim_right(x"476f6174204661726d2045737461626c6973686d656e743a205365742075702074686520696e697469616c20676f6174206661726d20616e6420626567696e206f7065726174696f6e732e0a546563686e6f6c6f677920496e746567726174696f6e3a20496d706c656d656e7420626c6f636b636861696e2d626173656420736f6c7574696f6e7320666f7220737570706c7920636861696e206d616e6167656d656e7420616e6420616e696d616c20747261636b696e672e0a506172746e65727368697020446576656c6f706d656e743a20436f6c6c61626f72617465207769746820737570706c696572732c206469737472696275746f72732c20616e6420696e647573747279206578706572747320746f20657870616e64207468652065636f73797374656d2e0a546f6b656e204c697374696e673a204c6973742024"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GTF>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GTF>>(v4);
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

