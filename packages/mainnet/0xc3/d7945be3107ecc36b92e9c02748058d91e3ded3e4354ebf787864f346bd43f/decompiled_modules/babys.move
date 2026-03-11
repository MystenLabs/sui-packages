module 0xc3d7945be3107ecc36b92e9c02748058d91e3ded3e4354ebf787864f346bd43f::babys {
    struct BABYS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://arweave.net/SJRzVBV6kPHnkHKR4NjimkqBxVuELhEsynSYwoisgBE";
        let v1 = if (0x1::vector::length<u8>(&v0) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arweave.net/SJRzVBV6kPHnkHKR4NjimkqBxVuELhEsynSYwoisgBE"))
        };
        let (v2, v3, v4) = 0x2::coin::create_regulated_currency_v2<BABYS>(arg0, 7, trim_right(b"BaByS"), trim_right(b"BaByS  "), trim_right(x"42614279530a496d6d656173757261626c652076616c756520696e2074686520667574757265"), v1, true, arg1);
        let v5 = v2;
        let v6 = 0x2::tx_context::sender(arg1);
        if (1000000000000 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<BABYS>>(0x2::coin::mint<BABYS>(&mut v5, 1000000000000, arg1), v6);
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYS>>(v5, v6);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<BABYS>>(v3, v6);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYS>>(v4);
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

