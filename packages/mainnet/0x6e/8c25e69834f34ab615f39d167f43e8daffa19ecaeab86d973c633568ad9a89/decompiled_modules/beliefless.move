module 0x6e8c25e69834f34ab615f39d167f43e8daffa19ecaeab86d973c633568ad9a89::beliefless {
    struct BELIEFLESS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BELIEFLESS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"57701ef6a3af8bc1efa1ffdefdc379d39efc7bc233c6dba41919af807bca6092                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<BELIEFLESS>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"BELIEFLESS  ")))), trim_right(b"Beliefless Coin                 "), trim_right(x"42454c4945464c4553532069732061206d656d6520746f6b656e206f6e20536f6c616e6120626f726e206f7574206f662070757265206d61726b657420656d6f74696f6e2020666561722c20666174696775652c20616e64207265616c69736d2e205768656e20746865206d61726b657473206772656564792c2065766572796f6e652062656c69657665732e20427574207768656e206665617220686974732c207265616c697479207365747320696e2020616e642074686174732077686572652042454c4945464c455353206c697665732e0a0a43726561746564206279205553454c455353204465762c2042454c4945464c45535320666c6970732074686520736372697074206f6e20626c696e64206f7074696d69736d2e20497473206e6f742061626f75742062656c696576696e6720206974732061626f757420"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BELIEFLESS>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BELIEFLESS>>(v4);
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

