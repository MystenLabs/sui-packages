module 0x3d3cb6e31b7aa100be8de01365abca15ce7c043711921668464369e3f967c01a::yucky {
    struct YUCKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: YUCKY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"dbf02f429faf8efe5587befacad17d891e0482df6745a64b32ce84c072ce61d0                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<YUCKY>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Yucky       ")))), trim_right(b"Bucky Evil Twin                 "), trim_right(x"5975636b7920697320746865206576696c2062726f74686572206f66204275636b792e0a0a426f746820636f6d652066726f6d20346368616e206d656d652066616d6520696e20323031392e202053616d652063726561746f722e0a0a54686520756c74696d617465206d656d6520626174746c6520626567696e732120200a0a5975636b79207673204275636b79212020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YUCKY>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YUCKY>>(v4);
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

