module 0xf8a18dc44bf082c524758b35c7d29ea2e54092feff38380d1c9f51f195ad3ed5::cys {
    struct CYS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CYS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://arweave.net/pB8L6g45-gVA1bx4u4Odp4rxfrLykPuFQnZ38xNoSdY";
        let v1 = if (0x1::vector::length<u8>(&v0) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arweave.net/pB8L6g45-gVA1bx4u4Odp4rxfrLykPuFQnZ38xNoSdY"))
        };
        let (v2, v3, v4) = 0x2::coin::create_regulated_currency_v2<CYS>(arg0, 9, trim_right(b"CYS"), trim_right(b"CYS  "), trim_right(b"CYS is the native token of Cysic, a decentralized DePIN network for ZK proof and AI computing, also known as ComputeFi. Its total supply is fixed at 1 billion with no inflation. Launched in"), v1, true, arg1);
        let v5 = v2;
        let v6 = 0x2::tx_context::sender(arg1);
        if (100000000000000000 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<CYS>>(0x2::coin::mint<CYS>(&mut v5, 100000000000000000, arg1), v6);
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CYS>>(v5, v6);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<CYS>>(v3, v6);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CYS>>(v4);
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

