module 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::event {
    struct NewVaultEvent has copy, drop {
        global: 0x2::object::ID,
        vault_name: 0x1::string::String,
        created_epoch: u64,
        maturity_epoch: u64,
        initial_apy: u128,
    }

    struct RegisterPoolEvent has copy, drop {
        global: 0x2::object::ID,
        lp_name: 0x1::string::String,
        weight_x: u64,
        weight_y: u64,
        is_stable: bool,
        is_lbp: bool,
    }

    struct SwappedEvent has copy, drop {
        global: 0x2::object::ID,
        lp_name: 0x1::string::String,
        coin_x_in: u64,
        coin_x_out: u64,
        coin_y_in: u64,
        coin_y_out: u64,
    }

    struct FutureSwappedEvent has copy, drop {
        global: 0x2::object::ID,
        lp_name: 0x1::string::String,
        staked_sui_in: u64,
        future_yield_amount: u64,
        coin_y_out: u64,
    }

    struct AddLiquidityEvent has copy, drop {
        global: 0x2::object::ID,
        lp_name: 0x1::string::String,
        coin_x_amount: u64,
        coin_y_amount: u64,
        lp_amount: u64,
        is_pool_creator: bool,
    }

    struct RemoveLiquidityEvent has copy, drop {
        global: 0x2::object::ID,
        lp_name: 0x1::string::String,
        coin_x_amount: u64,
        coin_y_amount: u64,
        lp_amount: u64,
    }

    struct UpdateVaultApy has copy, drop {
        global: 0x2::object::ID,
        vault_name: 0x1::string::String,
        vault_apy: u128,
    }

    struct MintEvent has copy, drop {
        vault_name: 0x1::string::String,
        input_amount: u64,
        pt_amount: u64,
        asset_object_id: 0x2::object::ID,
        sender: address,
        epoch: u64,
    }

    struct MigrateEvent has copy, drop {
        from_vault: 0x1::string::String,
        from_amount: u64,
        to_vault: 0x1::string::String,
        to_amount: u64,
        sender: address,
        epoch: u64,
    }

    struct RedeemEvent has copy, drop {
        vault_name: 0x1::string::String,
        pt_burned: u64,
        sui_amount: u64,
        sender: address,
        epoch: u64,
    }

    struct ExitEvent has copy, drop {
        vault_name: 0x1::string::String,
        pt_burned: u64,
        sui_amount: u64,
        sender: address,
        epoch: u64,
    }

    public(friend) fun add_liquidity_event(arg0: 0x2::object::ID, arg1: 0x1::string::String, arg2: u64, arg3: u64, arg4: u64, arg5: bool) {
        let v0 = AddLiquidityEvent{
            global          : arg0,
            lp_name         : arg1,
            coin_x_amount   : arg2,
            coin_y_amount   : arg3,
            lp_amount       : arg4,
            is_pool_creator : arg5,
        };
        0x2::event::emit<AddLiquidityEvent>(v0);
    }

    public(friend) fun exit_event(arg0: 0x1::string::String, arg1: u64, arg2: u64, arg3: address, arg4: u64) {
        let v0 = ExitEvent{
            vault_name : arg0,
            pt_burned  : arg1,
            sui_amount : arg2,
            sender     : arg3,
            epoch      : arg4,
        };
        0x2::event::emit<ExitEvent>(v0);
    }

    public(friend) fun future_swapped_event(arg0: 0x2::object::ID, arg1: 0x1::string::String, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = FutureSwappedEvent{
            global              : arg0,
            lp_name             : arg1,
            staked_sui_in       : arg2,
            future_yield_amount : arg3,
            coin_y_out          : arg4,
        };
        0x2::event::emit<FutureSwappedEvent>(v0);
    }

    public(friend) fun migrate_event(arg0: 0x1::string::String, arg1: u64, arg2: 0x1::string::String, arg3: u64, arg4: address, arg5: u64) {
        let v0 = MigrateEvent{
            from_vault  : arg0,
            from_amount : arg1,
            to_vault    : arg2,
            to_amount   : arg3,
            sender      : arg4,
            epoch       : arg5,
        };
        0x2::event::emit<MigrateEvent>(v0);
    }

    public(friend) fun mint_event(arg0: 0x1::string::String, arg1: u64, arg2: u64, arg3: 0x2::object::ID, arg4: address, arg5: u64) {
        let v0 = MintEvent{
            vault_name      : arg0,
            input_amount    : arg1,
            pt_amount       : arg2,
            asset_object_id : arg3,
            sender          : arg4,
            epoch           : arg5,
        };
        0x2::event::emit<MintEvent>(v0);
    }

    public(friend) fun new_vault_event(arg0: 0x2::object::ID, arg1: 0x1::string::String, arg2: u64, arg3: u64, arg4: u128) {
        let v0 = NewVaultEvent{
            global         : arg0,
            vault_name     : arg1,
            created_epoch  : arg2,
            maturity_epoch : arg3,
            initial_apy    : arg4,
        };
        0x2::event::emit<NewVaultEvent>(v0);
    }

    public(friend) fun redeem_event(arg0: 0x1::string::String, arg1: u64, arg2: u64, arg3: address, arg4: u64) {
        let v0 = RedeemEvent{
            vault_name : arg0,
            pt_burned  : arg1,
            sui_amount : arg2,
            sender     : arg3,
            epoch      : arg4,
        };
        0x2::event::emit<RedeemEvent>(v0);
    }

    public(friend) fun register_pool_event(arg0: 0x2::object::ID, arg1: 0x1::string::String, arg2: u64, arg3: u64, arg4: bool, arg5: bool) {
        let v0 = RegisterPoolEvent{
            global    : arg0,
            lp_name   : arg1,
            weight_x  : arg2,
            weight_y  : arg3,
            is_stable : arg4,
            is_lbp    : arg5,
        };
        0x2::event::emit<RegisterPoolEvent>(v0);
    }

    public(friend) fun remove_liquidity_event(arg0: 0x2::object::ID, arg1: 0x1::string::String, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = RemoveLiquidityEvent{
            global        : arg0,
            lp_name       : arg1,
            coin_x_amount : arg2,
            coin_y_amount : arg3,
            lp_amount     : arg4,
        };
        0x2::event::emit<RemoveLiquidityEvent>(v0);
    }

    public(friend) fun swapped_event(arg0: 0x2::object::ID, arg1: 0x1::string::String, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = SwappedEvent{
            global     : arg0,
            lp_name    : arg1,
            coin_x_in  : arg2,
            coin_x_out : arg3,
            coin_y_in  : arg4,
            coin_y_out : arg5,
        };
        0x2::event::emit<SwappedEvent>(v0);
    }

    public(friend) fun update_vault_apy_event(arg0: 0x2::object::ID, arg1: 0x1::string::String, arg2: u128) {
        let v0 = UpdateVaultApy{
            global     : arg0,
            vault_name : arg1,
            vault_apy  : arg2,
        };
        0x2::event::emit<UpdateVaultApy>(v0);
    }

    // decompiled from Move bytecode v6
}

