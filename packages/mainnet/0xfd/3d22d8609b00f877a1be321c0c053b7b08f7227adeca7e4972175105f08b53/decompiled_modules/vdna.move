module 0xfd3d22d8609b00f877a1be321c0c053b7b08f7227adeca7e4972175105f08b53::vdna {
    struct VDNA has drop {
        dummy_field: bool,
    }

    fun init(arg0: VDNA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"0a9cfd53f15829a686c7f6be273ed559918472c21180590bf01b89ab6215b9a4                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<VDNA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"VDNA        ")))), trim_right(b"VERRA DNA                       "), trim_right(b"VERRA DNA  COIN IS TRANSFORMATION AS THE WORLD FACES COMPOUNDING CRISESCLIMATE CHANGE, WASTE POLLUTION, ECONOMIC DISPARITY, AND SOVEREIGN DEBTTHERE IS A GROWING DEMAND FOR SUSTAINABLE, INCLUSIVE, AND DECENTRALIZED FINANCIAL SYSTEMS. THE VERRA DNA COIN EMERGES AS A SOVEREIGN-BACKED, CARBON-CREDIT-BASED DIGITAL CURRENCY "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VDNA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VDNA>>(v4);
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

