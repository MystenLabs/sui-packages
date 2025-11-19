module 0xe2c4d91747cb480f3a21a7c18bb9f962ed8eab8a37eea73ac02ab075b9d45c61::vbtc {
    struct VBTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: VBTC, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://gateway.irys.xyz/dIPCNC2fJl1vIPsGlvDaIAJT7DTvq4lfvyF6YcUTmPU";
        let v1 = if (0x1::vector::length<u8>(&v0) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.irys.xyz/dIPCNC2fJl1vIPsGlvDaIAJT7DTvq4lfvyF6YcUTmPU"))
        };
        let (v2, v3, v4) = 0x2::coin::create_regulated_currency_v2<VBTC>(arg0, 9, trim_right(b"VBTC"), trim_right(b"VBTC  "), trim_right(b"VBTCGOfan"), v1, true, arg1);
        let v5 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VBTC>>(v2, v5);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<VBTC>>(v3, v5);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VBTC>>(v4);
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

