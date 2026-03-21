module 0x772ae77460234dde7866a086c0cc65570193f33492a0c7624e2fa5c361a840b5::usyd {
    struct USYD has drop {
        dummy_field: bool,
    }

    fun init(arg0: USYD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://arweave.net/3oNv69rbXKZClfTtnDW-rO09PpidcydXml9d4ZxCAUU";
        let v1 = if (0x1::vector::length<u8>(&v0) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arweave.net/3oNv69rbXKZClfTtnDW-rO09PpidcydXml9d4ZxCAUU"))
        };
        let (v2, v3, v4) = 0x2::coin::create_regulated_currency_v2<USYD>(arg0, 9, trim_right(b"USYD"), trim_right(b"USYDD"), trim_right(b"As one of the stablecoins with the highest market capitalization and the widest range of applications"), v1, true, arg1);
        let v5 = v2;
        let v6 = 0x2::tx_context::sender(arg1);
        if (100000000000000000 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<USYD>>(0x2::coin::mint<USYD>(&mut v5, 100000000000000000, arg1), v6);
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USYD>>(v5, v6);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<USYD>>(v3, v6);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<USYD>>(v4);
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

