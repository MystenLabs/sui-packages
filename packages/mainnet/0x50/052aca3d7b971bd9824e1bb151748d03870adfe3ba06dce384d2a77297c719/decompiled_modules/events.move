module 0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::events {
    struct NewPool has copy, drop {
        pool: address,
        state: address,
        coins: vector<0x1::type_name::TypeName>,
        lpCoin: 0x1::type_name::TypeName,
        a: u256,
    }

    struct Swap has copy, drop {
        pool: address,
        coinIn: 0x1::type_name::TypeName,
        coinOut: 0x1::type_name::TypeName,
        amountIn: u64,
        amountOut: u64,
        fee: u64,
        new_balances: vector<u256>,
    }

    struct AddLiquidity has copy, drop {
        pool: address,
        coins: vector<0x1::type_name::TypeName>,
        amounts_sent: vector<u64>,
        old_balances: vector<u256>,
        new_balances: vector<u256>,
        mint_amount: u64,
    }

    struct RemoveLiquidity has copy, drop {
        pool: address,
        coins: vector<0x1::type_name::TypeName>,
        lp_coin_value: u64,
        amounts_removed: vector<u64>,
        new_balances: vector<u256>,
    }

    struct RemoveLiquidityOneCoin has copy, drop {
        pool: address,
        coin_out: 0x1::type_name::TypeName,
        lp_coin_value: u64,
        amount_removed: u64,
        fee_out: u64,
        new_balances: vector<u256>,
    }

    struct RampA has copy, drop {
        pool: address,
        current_a: u256,
        current_a_time: u256,
        future_a: u256,
        future_a_time: u256,
    }

    struct StopRampA has copy, drop {
        pool: address,
        current_a: u256,
        current_a_time: u64,
    }

    struct CommitStableFee has copy, drop {
        pool: address,
        future_fee: 0x1::option::Option<u256>,
        future_admin_fee: 0x1::option::Option<u256>,
    }

    struct UpdateStableFee has copy, drop {
        pool: address,
        fee: u256,
        admin_fee: u256,
    }

    struct TakeFees has copy, drop {
        pool: address,
        coin: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct Paused has copy, drop {
        pos0: address,
    }

    struct Unpaused has copy, drop {
        pos0: address,
    }

    struct NewAdmin has copy, drop {
        pos0: address,
    }

    struct RemoveAdmin has copy, drop {
        pos0: address,
    }

    struct StartSuperAdminTransfer has copy, drop {
        new_admin: address,
        deadline: u64,
    }

    struct FinishSuperAdminTransfer has copy, drop {
        pos0: address,
    }

    public(friend) fun swap(arg0: address, arg1: 0x1::type_name::TypeName, arg2: 0x1::type_name::TypeName, arg3: u64, arg4: u64, arg5: u64, arg6: vector<u256>) {
        let v0 = Swap{
            pool         : arg0,
            coinIn       : arg1,
            coinOut      : arg2,
            amountIn     : arg3,
            amountOut    : arg4,
            fee          : arg5,
            new_balances : arg6,
        };
        0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::event_wrapper::emit_event<Swap>(v0);
    }

    public(friend) fun add_liquidity(arg0: address, arg1: vector<0x1::type_name::TypeName>, arg2: vector<u64>, arg3: vector<u256>, arg4: vector<u256>, arg5: u64) {
        let v0 = AddLiquidity{
            pool         : arg0,
            coins        : arg1,
            amounts_sent : arg2,
            old_balances : arg3,
            new_balances : arg4,
            mint_amount  : arg5,
        };
        0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::event_wrapper::emit_event<AddLiquidity>(v0);
    }

    public(friend) fun commit_stable_fee(arg0: address, arg1: 0x1::option::Option<u256>, arg2: 0x1::option::Option<u256>) {
        let v0 = CommitStableFee{
            pool             : arg0,
            future_fee       : arg1,
            future_admin_fee : arg2,
        };
        0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::event_wrapper::emit_event<CommitStableFee>(v0);
    }

    public(friend) fun finish_super_admin_transfer(arg0: address) {
        let v0 = FinishSuperAdminTransfer{pos0: arg0};
        0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::event_wrapper::emit_event<FinishSuperAdminTransfer>(v0);
    }

    public(friend) fun new_admin(arg0: address) {
        let v0 = NewAdmin{pos0: arg0};
        0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::event_wrapper::emit_event<NewAdmin>(v0);
    }

    public(friend) fun new_pool(arg0: address, arg1: address, arg2: vector<0x1::type_name::TypeName>, arg3: 0x1::type_name::TypeName, arg4: u256) {
        let v0 = NewPool{
            pool   : arg0,
            state  : arg1,
            coins  : arg2,
            lpCoin : arg3,
            a      : arg4,
        };
        0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::event_wrapper::emit_event<NewPool>(v0);
    }

    public(friend) fun pause(arg0: address) {
        let v0 = Paused{pos0: arg0};
        0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::event_wrapper::emit_event<Paused>(v0);
    }

    public(friend) fun ramp_a(arg0: address, arg1: u256, arg2: u256, arg3: u256, arg4: u256) {
        let v0 = RampA{
            pool           : arg0,
            current_a      : arg1,
            current_a_time : arg2,
            future_a       : arg3,
            future_a_time  : arg4,
        };
        0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::event_wrapper::emit_event<RampA>(v0);
    }

    public(friend) fun remove_admin(arg0: address) {
        let v0 = RemoveAdmin{pos0: arg0};
        0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::event_wrapper::emit_event<RemoveAdmin>(v0);
    }

    public(friend) fun remove_liquidity(arg0: address, arg1: vector<0x1::type_name::TypeName>, arg2: u64, arg3: vector<u64>, arg4: vector<u256>) {
        let v0 = RemoveLiquidity{
            pool            : arg0,
            coins           : arg1,
            lp_coin_value   : arg2,
            amounts_removed : arg3,
            new_balances    : arg4,
        };
        0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::event_wrapper::emit_event<RemoveLiquidity>(v0);
    }

    public(friend) fun remove_liquidity_one_coin(arg0: address, arg1: 0x1::type_name::TypeName, arg2: u64, arg3: u64, arg4: u64, arg5: vector<u256>) {
        let v0 = RemoveLiquidityOneCoin{
            pool           : arg0,
            coin_out       : arg1,
            lp_coin_value  : arg2,
            amount_removed : arg3,
            fee_out        : arg4,
            new_balances   : arg5,
        };
        0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::event_wrapper::emit_event<RemoveLiquidityOneCoin>(v0);
    }

    public(friend) fun start_super_admin_transfer(arg0: address, arg1: u64) {
        let v0 = StartSuperAdminTransfer{
            new_admin : arg0,
            deadline  : arg1,
        };
        0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::event_wrapper::emit_event<StartSuperAdminTransfer>(v0);
    }

    public(friend) fun stop_ramp_a(arg0: address, arg1: u256, arg2: u64) {
        let v0 = StopRampA{
            pool           : arg0,
            current_a      : arg1,
            current_a_time : arg2,
        };
        0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::event_wrapper::emit_event<StopRampA>(v0);
    }

    public(friend) fun take_fees(arg0: address, arg1: 0x1::type_name::TypeName, arg2: u64) {
        let v0 = TakeFees{
            pool   : arg0,
            coin   : arg1,
            amount : arg2,
        };
        0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::event_wrapper::emit_event<TakeFees>(v0);
    }

    public(friend) fun unpause(arg0: address) {
        let v0 = Unpaused{pos0: arg0};
        0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::event_wrapper::emit_event<Unpaused>(v0);
    }

    public(friend) fun update_stable_fee(arg0: address, arg1: u256, arg2: u256) {
        let v0 = UpdateStableFee{
            pool      : arg0,
            fee       : arg1,
            admin_fee : arg2,
        };
        0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::event_wrapper::emit_event<UpdateStableFee>(v0);
    }

    // decompiled from Move bytecode v6
}

