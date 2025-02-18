module 0xbb1627ab9b54a76852153782225ce0ab6fe8bd9e03d47fe295d3432a32205cc7::ayx {
    struct AYX has drop {
        dummy_field: bool,
    }

    fun init(arg0: AYX, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"https://gateway.pinata.cloud/ipfs/bafkreiaappom6a7fdugtzaekpno5sy4na5hxympdbz576ixow5dtksavom                                                                                                                                                                                                                                   ");
        let v1 = if (0x1::vector::length<u8>(&v0) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v0))
        };
        let (v2, v3) = 0x2::coin::create_currency<AYX>(arg0, 9, 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"AYX     ")))), trim_right(b"AylabX                          "), trim_right(x"506f776572732041492044726976656e206d61726b6574696e672063616d706169676e7320616e6420757365722067726f77746820696e20776562332065636f73797374656d200a4159582063616e206265207573656420666f722074617267657465642061647320616e64206c6f79616c74792070726f6772616d7320616e642067616d6966696564207573657220696e746572616374696f6e732020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v1, arg1);
        let v4 = v2;
        0x2::transfer::public_transfer<0x2::coin::Coin<AYX>>(0x2::coin::mint<AYX>(&mut v4, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<AYX>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AYX>>(v3);
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

