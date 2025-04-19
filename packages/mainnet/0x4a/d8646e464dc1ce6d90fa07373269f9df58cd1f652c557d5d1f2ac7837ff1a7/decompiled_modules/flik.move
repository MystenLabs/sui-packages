module 0x4ad8646e464dc1ce6d90fa07373269f9df58cd1f652c557d5d1f2ac7837ff1a7::flik {
    struct FLIK has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLIK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/QzhnkQrqZdbZE8uZgAz2qWQEPG8dM8J27U3yLwU4vrm.png                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<FLIK>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"FLIK        ")))), trim_right(b"FLIK PEPE                       "), trim_right(x"2024464c494b202054686520546f6b656e205468617420446573657276657320616e204f73636172202862757420736574746c656420666f7220536f6c616e61290a4c69676874732e2043616d6572612e2045786974204c69717569646974792e0a0a24464c494b20697320746865206d656d6520746f6b656e20796f757220706f7274666f6c696f206469646e74206b6e6f7720697420776173206d697373696e672020666f7267656420696e20746865206669726573206f6620486f6c6c79776f6f6420647265616d7320616e6420646567656e206d656d65732c206e6f77207072656d696572696e67206f6e2074686520536f6c616e6120626c6f636b636861696e2e0a0a546869732069736e74206a75737420616e6f746865722070756d7020636f696e2e0a546869732069732063696e656d612e0a546869732069"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLIK>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLIK>>(v4);
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

