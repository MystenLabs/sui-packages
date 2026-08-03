module 0xbb6cce58275747da99664d0688ca9e9e0a762fbf3faa4e221641cdcd97188ebb::usbd {
    struct USBD has drop {
        dummy_field: bool,
    }

    fun init(arg0: USBD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://arweave.net/uzoJjF81rkPVrkrT3Vf4OzyHQrh3h0JOTz48i0saREM";
        let v1 = if (0x1::vector::length<u8>(&v0) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arweave.net/uzoJjF81rkPVrkrT3Vf4OzyHQrh3h0JOTz48i0saREM"))
        };
        let (v2, v3, v4) = 0x2::coin::create_regulated_currency_v2<USBD>(arg0, 9, trim_right(b"USBD"), trim_right(b"USBD  "), trim_right(b"Usbd"), v1, true, arg1);
        let v5 = v2;
        let v6 = 0x2::tx_context::sender(arg1);
        if (100000000000000000 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<USBD>>(0x2::coin::mint<USBD>(&mut v5, 100000000000000000, arg1), v6);
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USBD>>(v5, v6);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<USBD>>(v3, v6);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<USBD>>(v4);
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

