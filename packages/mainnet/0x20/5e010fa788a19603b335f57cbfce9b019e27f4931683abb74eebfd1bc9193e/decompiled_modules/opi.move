module 0x205e010fa788a19603b335f57cbfce9b019e27f4931683abb74eebfd1bc9193e::opi {
    struct OPI has drop {
        dummy_field: bool,
    }

    fun init(arg0: OPI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://gateway.irys.xyz/RXJFjlnHIoTqbi-BcnQRG1Br7eqHSbTsnCx8PDNuO8k                                                                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<OPI>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"OPI     ")))), trim_right(b"OPI                             "), trim_right(b"oPIis a decentralized cryptocurrency leveraging Proof of Diversity (PoD) for 7-second block times and scalable DeFi/micropayments. With 20% of its 20M supply allocated to early validators over 6 years, it emphasizes democratic governance requiring >50% validator consensus.                                               "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OPI>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OPI>>(v4);
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

