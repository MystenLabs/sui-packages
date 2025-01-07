module 0x5cf159eededc6f5094ff5f0efe01a4cfa5b6b56a814927f87f2f825f5c3b16df::event {
    struct AddedEvent has copy, drop {
        global: 0x2::object::ID,
        lp_name: 0x1::string::String,
        coin_x_val: u64,
        coin_y_val: u64,
        lp_val: u64,
    }

    struct RemovedEvent has copy, drop {
        global: 0x2::object::ID,
        lp_name: 0x1::string::String,
        coin_x_val: u64,
        coin_y_val: u64,
        lp_val: u64,
    }

    struct SwappedEvent has copy, drop {
        global: 0x2::object::ID,
        lp_name: 0x1::string::String,
        coin_x_in: u64,
        coin_x_out: u64,
        coin_y_in: u64,
        coin_y_out: u64,
    }

    struct NewVaultEvent has copy, drop {
        global: 0x2::object::ID,
        vault_name: 0x1::string::String,
        created_epoch: u64,
        started_epoch: u64,
        maturity_epoch: u64,
        initial_apy: u64,
    }

    struct UpdateVaultApy has copy, drop {
        global: 0x2::object::ID,
        vault_name: 0x1::string::String,
        vault_apy: u64,
        epoch: u64,
    }

    struct MintEvent has copy, drop {
        vault_name: 0x1::string::String,
        pool_id: 0x2::object::ID,
        input_amount: u64,
        pt_issued: u64,
        asset_object_id: 0x2::object::ID,
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
        deposit_id: u64,
        asset_object_id: 0x2::object::ID,
        pt_burned: u64,
        yt_received: u64,
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

    struct RemoveOrderEvent has copy, drop {
        marketplace: 0x2::object::ID,
        order_id: u64,
        owner: address,
    }

    struct UpdateOrderEvent has copy, drop {
        marketplace: 0x2::object::ID,
        order_id: u64,
        updated_price: u64,
        owner: address,
    }

    struct TradeEvent has copy, drop {
        marketplace: 0x2::object::ID,
        from_token: 0x1::string::String,
        to_token: 0x1::string::String,
        input_amount: u64,
        output_amount: u64,
        sender: address,
    }

    struct NewOrderEvent has copy, drop {
        marketplace: 0x2::object::ID,
        order_id: u64,
        is_bid: bool,
        base_token: 0x1::string::String,
        quote_token: 0x1::string::String,
        amount: u64,
        unit_price: u64,
        owner: address,
    }

    struct Rebalance has copy, drop {
        vault_name: 0x1::string::String,
        minted_pt: u64,
        liquidity_amount: u64,
        conversion_rate: u64,
        epoch: u64,
    }

    public(friend) fun added_event(arg0: 0x2::object::ID, arg1: 0x1::string::String, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = AddedEvent{
            global     : arg0,
            lp_name    : arg1,
            coin_x_val : arg2,
            coin_y_val : arg3,
            lp_val     : arg4,
        };
        0x2::event::emit<AddedEvent>(v0);
    }

    public(friend) fun exit_event(arg0: 0x1::string::String, arg1: u64, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: address, arg6: u64) {
        let v0 = ExitEvent{
            vault_name      : arg0,
            deposit_id      : arg1,
            asset_object_id : arg2,
            pt_burned       : arg3,
            yt_received     : arg4,
            sender          : arg5,
            epoch           : arg6,
        };
        0x2::event::emit<ExitEvent>(v0);
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

    public(friend) fun mint_event(arg0: 0x1::string::String, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: 0x2::object::ID, arg5: address, arg6: u64) {
        let v0 = MintEvent{
            vault_name      : arg0,
            pool_id         : arg1,
            input_amount    : arg2,
            pt_issued       : arg3,
            asset_object_id : arg4,
            sender          : arg5,
            epoch           : arg6,
        };
        0x2::event::emit<MintEvent>(v0);
    }

    public(friend) fun new_order_event(arg0: 0x2::object::ID, arg1: u64, arg2: bool, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u64, arg6: u64, arg7: address) {
        let v0 = NewOrderEvent{
            marketplace : arg0,
            order_id    : arg1,
            is_bid      : arg2,
            base_token  : arg3,
            quote_token : arg4,
            amount      : arg5,
            unit_price  : arg6,
            owner       : arg7,
        };
        0x2::event::emit<NewOrderEvent>(v0);
    }

    public(friend) fun new_vault_event(arg0: 0x2::object::ID, arg1: 0x1::string::String, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = NewVaultEvent{
            global         : arg0,
            vault_name     : arg1,
            created_epoch  : arg2,
            started_epoch  : arg3,
            maturity_epoch : arg4,
            initial_apy    : arg5,
        };
        0x2::event::emit<NewVaultEvent>(v0);
    }

    public(friend) fun rebalance_event(arg0: 0x1::string::String, arg1: u64, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = Rebalance{
            vault_name       : arg0,
            minted_pt        : arg1,
            liquidity_amount : arg2,
            conversion_rate  : arg3,
            epoch            : arg4,
        };
        0x2::event::emit<Rebalance>(v0);
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

    public(friend) fun remove_order_event(arg0: 0x2::object::ID, arg1: u64, arg2: address) {
        let v0 = RemoveOrderEvent{
            marketplace : arg0,
            order_id    : arg1,
            owner       : arg2,
        };
        0x2::event::emit<RemoveOrderEvent>(v0);
    }

    public(friend) fun removed_event(arg0: 0x2::object::ID, arg1: 0x1::string::String, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = RemovedEvent{
            global     : arg0,
            lp_name    : arg1,
            coin_x_val : arg2,
            coin_y_val : arg3,
            lp_val     : arg4,
        };
        0x2::event::emit<RemovedEvent>(v0);
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

    public(friend) fun trade_event(arg0: 0x2::object::ID, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u64, arg4: u64, arg5: address) {
        let v0 = TradeEvent{
            marketplace   : arg0,
            from_token    : arg1,
            to_token      : arg2,
            input_amount  : arg3,
            output_amount : arg4,
            sender        : arg5,
        };
        0x2::event::emit<TradeEvent>(v0);
    }

    public(friend) fun update_order_event(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: address) {
        let v0 = UpdateOrderEvent{
            marketplace   : arg0,
            order_id      : arg1,
            updated_price : arg2,
            owner         : arg3,
        };
        0x2::event::emit<UpdateOrderEvent>(v0);
    }

    public(friend) fun update_vault_apy_event(arg0: 0x2::object::ID, arg1: 0x1::string::String, arg2: u64, arg3: u64) {
        let v0 = UpdateVaultApy{
            global     : arg0,
            vault_name : arg1,
            vault_apy  : arg2,
            epoch      : arg3,
        };
        0x2::event::emit<UpdateVaultApy>(v0);
    }

    // decompiled from Move bytecode v6
}

