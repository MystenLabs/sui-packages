module 0xb44fa938a354676ea5c3b5b9f5bd967c697bb08b87e3b0fefd696a2e6dbc4f65::navi_strategy {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Strategy has key {
        id: 0x2::object::UID,
        version: u64,
        navi_cap: 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap,
        borrowed_ratio: u64,
        vault_access: 0x1::option::Option<0x6fea415a5e53b87fb6849969139a3e02ee2d7c157a1f5ab26e12a61e4211c5e0::vault::VaultAccess>,
        underlying_nominal_value_usdt: u64,
        st_sbuck_reserve: 0x2::balance::Balance<0xd01d27939064d79e4ae1179cd11cfeeff23943f32b1a842ea1a1e15a0045d77d::st_sbuck::ST_SBUCK>,
        collected_profits: 0x2::bag::Bag,
    }

    // decompiled from Move bytecode v6
}

