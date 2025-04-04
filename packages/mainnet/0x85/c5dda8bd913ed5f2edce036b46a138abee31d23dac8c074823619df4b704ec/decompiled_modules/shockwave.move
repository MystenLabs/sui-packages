module 0x85c5dda8bd913ed5f2edce036b46a138abee31d23dac8c074823619df4b704ec::shockwave {
    struct SHOCKWAVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHOCKWAVE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = vector[9, 1000000000000000, 0];
        let v1 = vector[b"SHOCKWAVE", b"Shock Wave", b"What happens when 99% of the supply is out of circulation? Let's find out. ", b"https://api.interestlabs.io/files/410e22537adbbefc72eaf8b900c4585d7cd910dcc81ed674.jpg"];
        let v2 = vector[b"SHOCKWAVE", b"Shock Wave", b"What happens when 99% of the supply is out of circulation? Let's find out. ", b"https://api.interestlabs.io/files/410e22537adbbefc72eaf8b900c4585d7cd910dcc81ed674.jpg"];
        let v3 = vector[b"SHOCKWAVE", b"Shock Wave", b"What happens when 99% of the supply is out of circulation? Let's find out. ", b"https://api.interestlabs.io/files/410e22537adbbefc72eaf8b900c4585d7cd910dcc81ed674.jpg"];
        let v4 = vector[b"SHOCKWAVE", b"Shock Wave", b"What happens when 99% of the supply is out of circulation? Let's find out. ", b"https://api.interestlabs.io/files/410e22537adbbefc72eaf8b900c4585d7cd910dcc81ed674.jpg"];
        let (v5, v6) = 0x2::coin::create_currency<SHOCKWAVE>(arg0, (*0x1::vector::borrow<u64>(&v0, 0) as u8), *0x1::vector::borrow<vector<u8>>(&v1, 0), *0x1::vector::borrow<vector<u8>>(&v2, 1), *0x1::vector::borrow<vector<u8>>(&v3, 2), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(*0x1::vector::borrow<vector<u8>>(&v4, 3))), arg1);
        let v7 = v5;
        let v8 = 0x2::tx_context::sender(arg1);
        let v9 = vector[9, 1000000000000000, 0];
        if (*0x1::vector::borrow<u64>(&v9, 1) > 0) {
            let v10 = vector[9, 1000000000000000, 0];
            0x2::coin::mint_and_transfer<SHOCKWAVE>(&mut v7, *0x1::vector::borrow<u64>(&v10, 1), v8, arg1);
        };
        let (v11, v12) = 0x7ead93e49fe002193faec3d2e4a7b750e9e568b5d875cafe17fcb0dc672b075e::ipx_coin_standard::new<SHOCKWAVE>(v7, arg1);
        let v13 = v12;
        let v14 = v11;
        let v15 = vector[9, 1000000000000000, 0];
        if (*0x1::vector::borrow<u64>(&v15, 2) > 0) {
            let v16 = vector[9, 1000000000000000, 0];
            0x7ead93e49fe002193faec3d2e4a7b750e9e568b5d875cafe17fcb0dc672b075e::ipx_coin_standard::set_maximum_supply(&mut v13, *0x1::vector::borrow<u64>(&v16, 2));
        };
        let v17 = vector[false, false, false, true];
        if (*0x1::vector::borrow<bool>(&v17, 0)) {
            0x2::transfer::public_transfer<0x7ead93e49fe002193faec3d2e4a7b750e9e568b5d875cafe17fcb0dc672b075e::ipx_coin_standard::MintCap>(0x7ead93e49fe002193faec3d2e4a7b750e9e568b5d875cafe17fcb0dc672b075e::ipx_coin_standard::create_mint_cap(&mut v13, arg1), v8);
        };
        let v18 = vector[false, false, false, true];
        if (*0x1::vector::borrow<bool>(&v18, 1)) {
            0x2::transfer::public_transfer<0x7ead93e49fe002193faec3d2e4a7b750e9e568b5d875cafe17fcb0dc672b075e::ipx_coin_standard::BurnCap>(0x7ead93e49fe002193faec3d2e4a7b750e9e568b5d875cafe17fcb0dc672b075e::ipx_coin_standard::create_burn_cap(&mut v13, arg1), v8);
        };
        let v19 = vector[false, false, false, true];
        if (*0x1::vector::borrow<bool>(&v19, 2)) {
            0x2::transfer::public_transfer<0x7ead93e49fe002193faec3d2e4a7b750e9e568b5d875cafe17fcb0dc672b075e::ipx_coin_standard::MetadataCap>(0x7ead93e49fe002193faec3d2e4a7b750e9e568b5d875cafe17fcb0dc672b075e::ipx_coin_standard::create_metadata_cap(&mut v13, arg1), v8);
        };
        let v20 = vector[false, false, false, true];
        if (*0x1::vector::borrow<bool>(&v20, 3)) {
            0x7ead93e49fe002193faec3d2e4a7b750e9e568b5d875cafe17fcb0dc672b075e::ipx_coin_standard::allow_public_burn(&mut v13, &mut v14);
        };
        0x7ead93e49fe002193faec3d2e4a7b750e9e568b5d875cafe17fcb0dc672b075e::ipx_coin_standard::destroy_witness<SHOCKWAVE>(&mut v14, v13);
        0x2::transfer::public_share_object<0x7ead93e49fe002193faec3d2e4a7b750e9e568b5d875cafe17fcb0dc672b075e::ipx_coin_standard::IPXTreasuryStandard>(v14);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHOCKWAVE>>(v6);
    }

    // decompiled from Move bytecode v6
}

