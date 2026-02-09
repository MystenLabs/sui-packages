module 0x9a83f4b283c322750b9c429291d31ff7d39f8aefc3d00089df3b332dbb001bda::llv_protocol_params {
    public fun cetus_farming_config_id_index() : u64 {
        6
    }

    public fun cetus_farming_pool_id_index() : u64 {
        4
    }

    public fun cetus_global_config_id_index() : u64 {
        3
    }

    public fun cetus_haedal_staking_id_index() : u64 {
        7
    }

    public fun cetus_max_price_deviation_bps_index() : u64 {
        1
    }

    public fun cetus_max_slippage_bps_index() : u64 {
        0
    }

    public fun cetus_pool_id_index() : u64 {
        2
    }

    public fun cetus_rewarder_manager_id_index() : u64 {
        5
    }

    public fun cetus_vault_id_index() : u64 {
        0
    }

    public fun cetus_vaults_manager_id_index() : u64 {
        1
    }

    public fun create_cetus_config(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: 0x2::object::ID, arg6: 0x2::object::ID, arg7: 0x2::object::ID, arg8: u64, arg9: u64) : 0x9a83f4b283c322750b9c429291d31ff7d39f8aefc3d00089df3b332dbb001bda::llv_pool::ProtocolConfig {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x2::object::ID>(v1, arg0);
        0x1::vector::push_back<0x2::object::ID>(v1, arg1);
        0x1::vector::push_back<0x2::object::ID>(v1, arg2);
        0x1::vector::push_back<0x2::object::ID>(v1, arg3);
        0x1::vector::push_back<0x2::object::ID>(v1, arg4);
        0x1::vector::push_back<0x2::object::ID>(v1, arg5);
        0x1::vector::push_back<0x2::object::ID>(v1, arg6);
        0x1::vector::push_back<0x2::object::ID>(v1, arg7);
        let v2 = 0x1::vector::empty<u64>();
        let v3 = &mut v2;
        0x1::vector::push_back<u64>(v3, arg8);
        0x1::vector::push_back<u64>(v3, arg9);
        0x9a83f4b283c322750b9c429291d31ff7d39f8aefc3d00089df3b332dbb001bda::llv_pool::create_config(v0, v2, 0x2::vec_map::empty<u8, vector<u8>>())
    }

    public fun create_hearn_config(arg0: 0x2::object::ID, arg1: u64) : 0x9a83f4b283c322750b9c429291d31ff7d39f8aefc3d00089df3b332dbb001bda::llv_pool::ProtocolConfig {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        0x1::vector::push_back<0x2::object::ID>(&mut v0, arg0);
        let v1 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v1, arg1);
        0x9a83f4b283c322750b9c429291d31ff7d39f8aefc3d00089df3b332dbb001bda::llv_pool::create_config(v0, v1, 0x2::vec_map::empty<u8, vector<u8>>())
    }

    public fun create_navi_config(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: u8) : 0x9a83f4b283c322750b9c429291d31ff7d39f8aefc3d00089df3b332dbb001bda::llv_pool::ProtocolConfig {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x2::object::ID>(v1, arg0);
        0x1::vector::push_back<0x2::object::ID>(v1, arg1);
        0x1::vector::push_back<0x2::object::ID>(v1, arg2);
        0x1::vector::push_back<0x2::object::ID>(v1, arg3);
        0x1::vector::push_back<0x2::object::ID>(v1, arg4);
        let v2 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v2, (arg5 as u64));
        0x9a83f4b283c322750b9c429291d31ff7d39f8aefc3d00089df3b332dbb001bda::llv_pool::create_config(v0, v2, 0x2::vec_map::empty<u8, vector<u8>>())
    }

    public fun create_scallop_config(arg0: 0x2::object::ID, arg1: 0x2::object::ID) : 0x9a83f4b283c322750b9c429291d31ff7d39f8aefc3d00089df3b332dbb001bda::llv_pool::ProtocolConfig {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x2::object::ID>(v1, arg0);
        0x1::vector::push_back<0x2::object::ID>(v1, arg1);
        0x9a83f4b283c322750b9c429291d31ff7d39f8aefc3d00089df3b332dbb001bda::llv_pool::create_config(v0, vector[], 0x2::vec_map::empty<u8, vector<u8>>())
    }

    public fun create_suilend_config(arg0: 0x2::object::ID, arg1: u64) : 0x9a83f4b283c322750b9c429291d31ff7d39f8aefc3d00089df3b332dbb001bda::llv_pool::ProtocolConfig {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        0x1::vector::push_back<0x2::object::ID>(&mut v0, arg0);
        let v1 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v1, arg1);
        0x9a83f4b283c322750b9c429291d31ff7d39f8aefc3d00089df3b332dbb001bda::llv_pool::create_config(v0, v1, 0x2::vec_map::empty<u8, vector<u8>>())
    }

    public fun hearn_id_index() : u64 {
        0
    }

    public fun hearn_market_id_index() : u64 {
        0
    }

    public fun navi_asset_cetus() : u8 {
        4
    }

    public fun navi_asset_hasui() : u8 {
        5
    }

    public fun navi_asset_id_index() : u64 {
        0
    }

    public fun navi_asset_navx() : u8 {
        7
    }

    public fun navi_asset_sui() : u8 {
        0
    }

    public fun navi_asset_usdc() : u8 {
        1
    }

    public fun navi_asset_usdt() : u8 {
        2
    }

    public fun navi_asset_vsui() : u8 {
        6
    }

    public fun navi_asset_weth() : u8 {
        3
    }

    public fun navi_incentive_v2_id_index() : u64 {
        2
    }

    public fun navi_incentive_v3_id_index() : u64 {
        3
    }

    public fun navi_pool_id_index() : u64 {
        1
    }

    public fun navi_price_oracle_id_index() : u64 {
        4
    }

    public fun navi_storage_id_index() : u64 {
        0
    }

    public fun protocol_cetus_vault() : u8 {
        1
    }

    public fun protocol_hearn_vault() : u8 {
        0
    }

    public fun protocol_navi() : u8 {
        4
    }

    public fun protocol_scallop() : u8 {
        3
    }

    public fun protocol_suilend() : u8 {
        2
    }

    public fun scallop_market_id_index() : u64 {
        1
    }

    public fun scallop_version_id_index() : u64 {
        0
    }

    public fun suilend_lending_market_id_index() : u64 {
        0
    }

    public fun suilend_reserve_array_index() : u64 {
        0
    }

    // decompiled from Move bytecode v6
}

