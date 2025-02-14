module 0xf72368851fb9d28049932d845887b5a4701fdd18d9d90989c55b910933cfc453::azur {
    struct AZUR has drop {
        dummy_field: bool,
    }

    fun init(arg0: AZUR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = vector[9, 10000000000000000000, 0];
        let v1 = vector[b"AZUR", b"AZUR CRYPTUS", x"2046726f6d2074686520646570746873206f662074686520626c6f636b636861696e2c20417a75722043727970747573207269736573e280946120666f726365206f66206368616f7320616e64206f70706f7274756e6974792e2041206d656d6574696320706f7765722c206120646563656e7472616c697a6564206c6567656e642e", b"https://api.interestlabs.io/files/738441ed31ef7f906d274feb7cc1e9d34360bf1b279b4ea2.jpg"];
        let v2 = vector[b"AZUR", b"AZUR CRYPTUS", x"2046726f6d2074686520646570746873206f662074686520626c6f636b636861696e2c20417a75722043727970747573207269736573e280946120666f726365206f66206368616f7320616e64206f70706f7274756e6974792e2041206d656d6574696320706f7765722c206120646563656e7472616c697a6564206c6567656e642e", b"https://api.interestlabs.io/files/738441ed31ef7f906d274feb7cc1e9d34360bf1b279b4ea2.jpg"];
        let v3 = vector[b"AZUR", b"AZUR CRYPTUS", x"2046726f6d2074686520646570746873206f662074686520626c6f636b636861696e2c20417a75722043727970747573207269736573e280946120666f726365206f66206368616f7320616e64206f70706f7274756e6974792e2041206d656d6574696320706f7765722c206120646563656e7472616c697a6564206c6567656e642e", b"https://api.interestlabs.io/files/738441ed31ef7f906d274feb7cc1e9d34360bf1b279b4ea2.jpg"];
        let v4 = vector[b"AZUR", b"AZUR CRYPTUS", x"2046726f6d2074686520646570746873206f662074686520626c6f636b636861696e2c20417a75722043727970747573207269736573e280946120666f726365206f66206368616f7320616e64206f70706f7274756e6974792e2041206d656d6574696320706f7765722c206120646563656e7472616c697a6564206c6567656e642e", b"https://api.interestlabs.io/files/738441ed31ef7f906d274feb7cc1e9d34360bf1b279b4ea2.jpg"];
        let (v5, v6) = 0x2::coin::create_currency<AZUR>(arg0, (*0x1::vector::borrow<u64>(&v0, 0) as u8), *0x1::vector::borrow<vector<u8>>(&v1, 0), *0x1::vector::borrow<vector<u8>>(&v2, 1), *0x1::vector::borrow<vector<u8>>(&v3, 2), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(*0x1::vector::borrow<vector<u8>>(&v4, 3))), arg1);
        let v7 = v5;
        let v8 = 0x2::tx_context::sender(arg1);
        let v9 = vector[9, 10000000000000000000, 0];
        if (*0x1::vector::borrow<u64>(&v9, 1) > 0) {
            let v10 = vector[9, 10000000000000000000, 0];
            0x2::coin::mint_and_transfer<AZUR>(&mut v7, *0x1::vector::borrow<u64>(&v10, 1), v8, arg1);
        };
        let (v11, v12) = 0x8135dda2a2b575ef87654aa1115a46da63ea9a387abb5f7cdb93df062af7a937::ipx_coin_standard::new<AZUR>(v7, arg1);
        let v13 = v12;
        let v14 = v11;
        let v15 = vector[9, 10000000000000000000, 0];
        if (*0x1::vector::borrow<u64>(&v15, 2) > 0) {
            let v16 = vector[9, 10000000000000000000, 0];
            0x8135dda2a2b575ef87654aa1115a46da63ea9a387abb5f7cdb93df062af7a937::ipx_coin_standard::set_maximum_supply(&mut v13, *0x1::vector::borrow<u64>(&v16, 2));
        };
        let v17 = vector[false, false, true, true];
        if (*0x1::vector::borrow<bool>(&v17, 0)) {
            0x2::transfer::public_transfer<0x8135dda2a2b575ef87654aa1115a46da63ea9a387abb5f7cdb93df062af7a937::ipx_coin_standard::MintCap>(0x8135dda2a2b575ef87654aa1115a46da63ea9a387abb5f7cdb93df062af7a937::ipx_coin_standard::create_mint_cap(&mut v13, arg1), v8);
        };
        let v18 = vector[false, false, true, true];
        if (*0x1::vector::borrow<bool>(&v18, 1)) {
            0x2::transfer::public_transfer<0x8135dda2a2b575ef87654aa1115a46da63ea9a387abb5f7cdb93df062af7a937::ipx_coin_standard::BurnCap>(0x8135dda2a2b575ef87654aa1115a46da63ea9a387abb5f7cdb93df062af7a937::ipx_coin_standard::create_burn_cap(&mut v13, arg1), v8);
        };
        let v19 = vector[false, false, true, true];
        if (*0x1::vector::borrow<bool>(&v19, 2)) {
            0x2::transfer::public_transfer<0x8135dda2a2b575ef87654aa1115a46da63ea9a387abb5f7cdb93df062af7a937::ipx_coin_standard::MetadataCap>(0x8135dda2a2b575ef87654aa1115a46da63ea9a387abb5f7cdb93df062af7a937::ipx_coin_standard::create_metadata_cap(&mut v13, arg1), v8);
        };
        let v20 = vector[false, false, true, true];
        if (*0x1::vector::borrow<bool>(&v20, 3)) {
            0x8135dda2a2b575ef87654aa1115a46da63ea9a387abb5f7cdb93df062af7a937::ipx_coin_standard::allow_public_burn(&mut v13, &mut v14);
        };
        0x8135dda2a2b575ef87654aa1115a46da63ea9a387abb5f7cdb93df062af7a937::ipx_coin_standard::destroy_witness<AZUR>(&mut v14, v13);
        0x2::transfer::public_share_object<0x8135dda2a2b575ef87654aa1115a46da63ea9a387abb5f7cdb93df062af7a937::ipx_coin_standard::IPXTreasuryStandard>(v14);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AZUR>>(v6);
    }

    // decompiled from Move bytecode v6
}

