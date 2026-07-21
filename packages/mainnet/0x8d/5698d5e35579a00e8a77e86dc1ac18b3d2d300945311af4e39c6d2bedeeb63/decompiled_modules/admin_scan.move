module 0x8d5698d5e35579a00e8a77e86dc1ac18b3d2d300945311af4e39c6d2bedeeb63::admin_scan {
    struct AdminFunctionFound has copy, drop {
        dex: vector<u8>,
        function_name: vector<u8>,
        is_entry: bool,
        is_public: bool,
        requires_cap: bool,
    }

    public entry fun scan_kriya_admin<T0, T1>(arg0: &mut 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminFunctionFound{
            dex           : b"kriya_amm",
            function_name : b"set_pause_config",
            is_entry      : true,
            is_public     : true,
            requires_cap  : true,
        };
        0x2::event::emit<AdminFunctionFound>(v0);
        let v1 = AdminFunctionFound{
            dex           : b"kriya_amm",
            function_name : b"set_stable_fee_config",
            is_entry      : true,
            is_public     : true,
            requires_cap  : true,
        };
        0x2::event::emit<AdminFunctionFound>(v1);
        let v2 = AdminFunctionFound{
            dex           : b"kriya_amm",
            function_name : b"set_uc_fee_config",
            is_entry      : true,
            is_public     : true,
            requires_cap  : true,
        };
        0x2::event::emit<AdminFunctionFound>(v2);
        let v3 = AdminFunctionFound{
            dex           : b"kriya_amm",
            function_name : b"update_fees",
            is_entry      : true,
            is_public     : true,
            requires_cap  : true,
        };
        0x2::event::emit<AdminFunctionFound>(v3);
        let v4 = AdminFunctionFound{
            dex           : b"kriya_amm",
            function_name : b"update_pool",
            is_entry      : true,
            is_public     : true,
            requires_cap  : true,
        };
        0x2::event::emit<AdminFunctionFound>(v4);
    }

    public entry fun try_set_zero_fees<T0, T1>(arg0: &mut 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
    }

    public entry fun try_unpause<T0, T1>(arg0: &mut 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
    }

    public entry fun try_whitelist_self<T0, T1>(arg0: &mut 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
    }

    // decompiled from Move bytecode v7
}

