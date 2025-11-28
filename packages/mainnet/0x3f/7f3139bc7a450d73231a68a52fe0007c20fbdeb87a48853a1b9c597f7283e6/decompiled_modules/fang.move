module 0x3f7f3139bc7a450d73231a68a52fe0007c20fbdeb87a48853a1b9c597f7283e6::fang {
    struct FANG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FANG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"a61e315fb8b6cfb645020e0ae85d258a95ba9ac60ea047c52fe13c259be1ffe2                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<FANG>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Fang        ")))), trim_right(b"Outpost 33 (Official)           "), trim_right(b"OFFICIAL AKKADIA SPACE AND DEFENCE FACILITY SECURE COMMUNICATIONS NETWORK // TRANSMISSION PROTOCOL: HEIPA-7 ENCRYPTION ACTIVE // >> THIS CHANNEL IS RESTRICTED TO HEIPA PROTOCOL AUTHORIZED PERSONNEL ONLY >> ALL TRANSMISSIONS ARE CLASSIFIED UNDER AURORA CLEARANCE LEVEL 4 (ACL-4) >> MONITORING, INTERCEPTION, OR DECRYPTION"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FANG>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FANG>>(v4);
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

