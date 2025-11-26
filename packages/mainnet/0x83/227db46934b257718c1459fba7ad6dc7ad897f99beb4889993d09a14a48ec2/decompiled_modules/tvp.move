module 0x83227db46934b257718c1459fba7ad6dc7ad897f99beb4889993d09a14a48ec2::tvp {
    struct TVP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TVP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://gateway.irys.xyz/rB4xJXDHD5n9ZxB19S3vU6CuL2_AXhmsZxDX1uJfB0A";
        let v1 = if (0x1::vector::length<u8>(&v0) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.irys.xyz/rB4xJXDHD5n9ZxB19S3vU6CuL2_AXhmsZxDX1uJfB0A"))
        };
        let (v2, v3, v4) = 0x2::coin::create_regulated_currency_v2<TVP>(arg0, 9, trim_right(b"TVP"), trim_right(b"TVP  "), trim_right(x"646563656e7472616c697a65642063727970746f63757272656e6379206c657665726167696e672050726f6f66206f66204469766572736974792028506f442920666f7220372d7365636f6e6420626c6f636b2074696d657320616e64207363616c61626c650a446546692f6d6963726f7061796d656e74732e205769746820323025206f66206974732032304d20737570706c7920616c6c6f636174656420746f206561726c792076616c696461746f7273206f76657220362079656172732c20697420656d70686173697a65732064656d6f63726174696320676f7665726e616e636520726571756972696e67203e3530252076616c696461746f72"), v1, true, arg1);
        let v5 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TVP>>(v2, v5);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<TVP>>(v3, v5);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TVP>>(v4);
    }

    fun trim_right(arg0: vector<u8>) : vector<u8> {
        let v0 = 32;
        while (0x1::vector::length<u8>(&arg0) > 0) {
            if (0x1::vector::borrow<u8>(&arg0, 0x1::vector::length<u8>(&arg0) - 1) != &v0) {
                break
            };
            0x1::vector::pop_back<u8>(&mut arg0);
        };
        arg0
    }

    // decompiled from Move bytecode v6
}

