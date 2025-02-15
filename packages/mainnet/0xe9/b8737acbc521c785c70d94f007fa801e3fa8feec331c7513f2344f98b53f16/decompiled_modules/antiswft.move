module 0xe9b8737acbc521c785c70d94f007fa801e3fa8feec331c7513f2344f98b53f16::antiswft {
    struct ANTISWFT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANTISWFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"CUBWEj36mUvbLZQI                                                                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<ANTISWFT>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"ANTISWFT    ")))), trim_right(b"The AntiSwifties                "), trim_right(x"2054686520416e746953776966746965732028414e544953574654292020546865204d656d6520436f696e205468617420576f6e7420437279204f76657220427265616b75707321200d0a0d0a5469726564206f66206d61696e73747265616d20687970653f20414e5449535746542069732074686520726562656c6c696f7573206d656d6520636f696e2074616b696e67206f76657220536f6c616e612e204e6f2073616420736f6e67736a757374206d656d652d6675656c6564206368616f732c20636f6d6d756e69747920706f7765722c20616e6420756e73746f707061626c65206879706521204275696c7420666f7220666173742c206c6f772d636f73742074726164696e672c207765726520736b697070696e6720746865204572617320546f757220616e642068656164696e6720737472616967687420666f"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANTISWFT>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ANTISWFT>>(v4);
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

