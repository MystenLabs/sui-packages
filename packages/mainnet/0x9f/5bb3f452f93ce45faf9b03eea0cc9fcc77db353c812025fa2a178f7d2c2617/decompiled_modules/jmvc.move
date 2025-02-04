module 0x9f5bb3f452f93ce45faf9b03eea0cc9fcc77db353c812025fa2a178f7d2c2617::jmvc {
    struct JMVC has drop {
        dummy_field: bool,
    }

    fun init(arg0: JMVC, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = vector[9, 777000000000, 0];
        let v1 = vector[b"jmvc", b"jose", b"hhh", b""];
        let v2 = vector[b"jmvc", b"jose", b"hhh", b""];
        let v3 = vector[b"jmvc", b"jose", b"hhh", b""];
        let v4 = vector[b"jmvc", b"jose", b"hhh", b""];
        let (v5, v6) = 0x2::coin::create_currency<JMVC>(arg0, (*0x1::vector::borrow<u64>(&v0, 0) as u8), *0x1::vector::borrow<vector<u8>>(&v1, 0), *0x1::vector::borrow<vector<u8>>(&v2, 1), *0x1::vector::borrow<vector<u8>>(&v3, 2), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(*0x1::vector::borrow<vector<u8>>(&v4, 3))), arg1);
        let v7 = v5;
        let v8 = 0x2::tx_context::sender(arg1);
        let v9 = vector[9, 777000000000, 0];
        if (*0x1::vector::borrow<u64>(&v9, 1) > 0) {
            let v10 = vector[9, 777000000000, 0];
            0x2::coin::mint_and_transfer<JMVC>(&mut v7, *0x1::vector::borrow<u64>(&v10, 1), v8, arg1);
        };
        let (v11, v12) = 0x8135dda2a2b575ef87654aa1115a46da63ea9a387abb5f7cdb93df062af7a937::ipx_coin_standard::new<JMVC>(v7, arg1);
        let v13 = v12;
        let v14 = v11;
        let v15 = vector[9, 777000000000, 0];
        if (*0x1::vector::borrow<u64>(&v15, 2) > 0) {
            let v16 = vector[9, 777000000000, 0];
            0x8135dda2a2b575ef87654aa1115a46da63ea9a387abb5f7cdb93df062af7a937::ipx_coin_standard::set_maximum_supply(&mut v13, *0x1::vector::borrow<u64>(&v16, 2));
        };
        let v17 = vector[true, false, true, true];
        if (*0x1::vector::borrow<bool>(&v17, 0)) {
            0x2::transfer::public_transfer<0x8135dda2a2b575ef87654aa1115a46da63ea9a387abb5f7cdb93df062af7a937::ipx_coin_standard::MintCap>(0x8135dda2a2b575ef87654aa1115a46da63ea9a387abb5f7cdb93df062af7a937::ipx_coin_standard::create_mint_cap(&mut v13, arg1), v8);
        };
        let v18 = vector[true, false, true, true];
        if (*0x1::vector::borrow<bool>(&v18, 1)) {
            0x2::transfer::public_transfer<0x8135dda2a2b575ef87654aa1115a46da63ea9a387abb5f7cdb93df062af7a937::ipx_coin_standard::BurnCap>(0x8135dda2a2b575ef87654aa1115a46da63ea9a387abb5f7cdb93df062af7a937::ipx_coin_standard::create_burn_cap(&mut v13, arg1), v8);
        };
        let v19 = vector[true, false, true, true];
        if (*0x1::vector::borrow<bool>(&v19, 2)) {
            0x2::transfer::public_transfer<0x8135dda2a2b575ef87654aa1115a46da63ea9a387abb5f7cdb93df062af7a937::ipx_coin_standard::MetadataCap>(0x8135dda2a2b575ef87654aa1115a46da63ea9a387abb5f7cdb93df062af7a937::ipx_coin_standard::create_metadata_cap(&mut v13, arg1), v8);
        };
        let v20 = vector[true, false, true, true];
        if (*0x1::vector::borrow<bool>(&v20, 3)) {
            0x8135dda2a2b575ef87654aa1115a46da63ea9a387abb5f7cdb93df062af7a937::ipx_coin_standard::allow_public_burn(&mut v13, &mut v14);
        };
        0x8135dda2a2b575ef87654aa1115a46da63ea9a387abb5f7cdb93df062af7a937::ipx_coin_standard::destroy_witness<JMVC>(&mut v14, v13);
        0x2::transfer::public_share_object<0x8135dda2a2b575ef87654aa1115a46da63ea9a387abb5f7cdb93df062af7a937::ipx_coin_standard::IPXTreasuryStandard>(v14);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JMVC>>(v6);
    }

    // decompiled from Move bytecode v6
}

