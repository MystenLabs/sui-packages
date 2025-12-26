module 0x87f166fcdc3e8aec19a6a8a9a05e22e8bdeeed9cf556afec4c69e13a62da83e8::lah {
    struct LAH has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAH, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111      ");
        let v1 = trim_right(b"https://ipfs.io/ipfs/QmSbRfFKioZjMfFGAJFYz8zLswNQNFnEThNL4q4aBriaDP                                                                                                                                                                                                                                                             ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<LAH>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"LAH     ")))), trim_right(b"SGLAH                           "), trim_right(x"244c41482069732074686520756c74696d61746520537569206d656d6520636f696e20666f7220746865207472756520626c75652053696e6761706f7265616e207370697269742e204e6f207374726573732c206e6f206472616d612c206a7573742070757265205368696f6b2076696265732e0a57687920244c41483f0a426563617573652065766572797468696e6720736f756e6473206265747465722077697468206120224c6168222061742074686520656e642e20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LAH>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LAH>>(v4);
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

