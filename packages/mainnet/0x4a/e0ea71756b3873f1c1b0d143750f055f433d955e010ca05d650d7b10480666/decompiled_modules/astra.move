module 0x4ae0ea71756b3873f1c1b0d143750f055f433d955e010ca05d650d7b10480666::astra {
    struct ASTRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASTRA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://arweave.net/wfI-yXgHk2KP0Owlu_RvntrA-JqmhCbP4NWc45GvcDQ";
        let v1 = if (0x1::vector::length<u8>(&v0) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arweave.net/wfI-yXgHk2KP0Owlu_RvntrA-JqmhCbP4NWc45GvcDQ"))
        };
        let (v2, v3, v4) = 0x2::coin::create_regulated_currency_v2<ASTRA>(arg0, 9, trim_right(b"ASTRA"), trim_right(b"ASTRA Nexus Protocol"), trim_right(b"ASTRA Nexus Protocol is a next-generation digital asset ecosystem designed to connect decentralized finance, AI technology, and community-driven innovation"), v1, true, arg1);
        let v5 = v2;
        let v6 = 0x2::tx_context::sender(arg1);
        if (10000000000000000 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<ASTRA>>(0x2::coin::mint<ASTRA>(&mut v5, 10000000000000000, arg1), v6);
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASTRA>>(v5, v6);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<ASTRA>>(v3, v6);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ASTRA>>(v4);
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

