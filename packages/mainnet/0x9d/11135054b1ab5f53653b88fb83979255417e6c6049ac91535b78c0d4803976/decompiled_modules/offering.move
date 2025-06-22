module 0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::offering {
    struct Offering has store, key {
        id: 0x2::object::UID,
        artwork_vault_id: 0x2::object::ID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        token_allocation: u64,
        tokens_sold: u64,
        token_price: u64,
        fee_rate_bps: u64,
        start_time: u64,
        end_time: u64,
        status: u8,
        proceeds: 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>,
        fees: 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>,
    }

    public(friend) fun new(arg0: 0x2::object::ID, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : Offering {
        Offering{
            id               : 0x2::object::new(arg6),
            artwork_vault_id : arg0,
            name             : arg1,
            description      : arg2,
            token_allocation : arg3,
            tokens_sold      : 0,
            token_price      : arg4,
            fee_rate_bps     : arg5,
            start_time       : 0,
            end_time         : 0,
            status           : 0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::constants::offering_draft_state(),
            proceeds         : 0x2::balance::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(),
            fees             : 0x2::balance::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(),
        }
    }

    public fun activate(arg0: &mut Offering, arg1: &0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::role_store::RoleProof<0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::role_store::Admin>, arg2: &0x2::clock::Clock, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::role_store::owner<0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::role_store::Admin>(arg1) == 0x2::tx_context::sender(arg4), 203);
        assert!(arg0.status == 0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::constants::offering_draft_state(), 201);
        arg0.start_time = 0x2::clock::timestamp_ms(arg2);
        arg0.status = 0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::constants::offering_active_state();
        arg0.end_time = arg3;
    }

    public fun available_tokens(arg0: &Offering) : u64 {
        arg0.token_allocation - arg0.tokens_sold
    }

    public fun cancel(arg0: &mut Offering, arg1: &0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::role_store::RoleProof<0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::role_store::Admin>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::role_store::owner<0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::role_store::Admin>(arg1) == 0x2::tx_context::sender(arg2), 203);
        assert!(arg0.status == 0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::constants::offering_draft_state(), 202);
        arg0.status = 0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::constants::offering_cancelled_state();
    }

    public(friend) fun collect_fee(arg0: &mut Offering, arg1: 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>) {
        0x2::balance::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.fees, arg1);
    }

    public fun correct_fee_rate(arg0: &mut Offering, arg1: &0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::role_store::RoleProof<0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::role_store::Admin>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::constants::offering_draft_state(), 204);
        assert!(0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::role_store::owner<0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::role_store::Admin>(arg1) == 0x2::tx_context::sender(arg3), 203);
        arg0.fee_rate_bps = arg2;
    }

    public fun correct_token_allocation(arg0: &mut Offering, arg1: &0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::role_store::RoleProof<0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::role_store::Admin>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::constants::offering_draft_state(), 204);
        assert!(0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::role_store::owner<0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::role_store::Admin>(arg1) == 0x2::tx_context::sender(arg3), 203);
        arg0.token_allocation = arg2;
    }

    public fun correct_token_price(arg0: &mut Offering, arg1: &0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::role_store::RoleProof<0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::role_store::Admin>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::constants::offering_draft_state(), 204);
        assert!(0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::role_store::owner<0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::role_store::Admin>(arg1) == 0x2::tx_context::sender(arg3), 203);
        arg0.token_price = arg2;
    }

    public(friend) fun deposit(arg0: &mut Offering, arg1: 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>) {
        0x2::balance::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.proceeds, arg1);
    }

    public fun description(arg0: &Offering) : 0x1::string::String {
        arg0.description
    }

    public fun end(arg0: &mut Offering, arg1: &0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::role_store::RoleProof<0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::role_store::Admin>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::role_store::owner<0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::role_store::Admin>(arg1) == 0x2::tx_context::sender(arg3), 203);
        assert!(arg0.status == 0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::constants::offering_active_state() && (0x2::clock::timestamp_ms(arg2) >= arg0.end_time || arg0.token_allocation - arg0.tokens_sold == 0), 205);
        arg0.status = 0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::constants::offering_completed_state();
    }

    public fun end_time(arg0: &Offering) : u64 {
        arg0.end_time
    }

    public fun fee_rate_bps(arg0: &Offering) : u64 {
        arg0.fee_rate_bps
    }

    public fun id(arg0: &Offering) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun is_closed(arg0: &Offering, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) >= arg0.end_time || arg0.tokens_sold == arg0.token_allocation
    }

    public fun is_state_active(arg0: &Offering) : bool {
        arg0.status == 0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::constants::offering_active_state()
    }

    public fun is_state_cancelled(arg0: &Offering) : bool {
        arg0.status == 0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::constants::offering_cancelled_state()
    }

    public fun is_state_completed(arg0: &Offering) : bool {
        arg0.status == 0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::constants::offering_completed_state()
    }

    public fun is_state_draft(arg0: &Offering) : bool {
        arg0.status == 0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::constants::offering_draft_state()
    }

    public fun name(arg0: &Offering) : 0x1::string::String {
        arg0.name
    }

    public fun start_time(arg0: &Offering) : u64 {
        arg0.start_time
    }

    public fun status(arg0: &Offering) : u8 {
        arg0.status
    }

    public fun token_allocation(arg0: &Offering) : u64 {
        arg0.token_allocation
    }

    public fun token_price(arg0: &Offering) : u64 {
        arg0.token_price
    }

    public fun tokens_sold(arg0: &Offering) : u64 {
        arg0.tokens_sold
    }

    public fun total_fees(arg0: &Offering) : u64 {
        0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg0.fees)
    }

    public fun total_proceeds(arg0: &Offering) : u64 {
        0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg0.proceeds)
    }

    public fun update_description(arg0: &mut Offering, arg1: &0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::role_store::RoleProof<0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::role_store::Admin>, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::role_store::owner<0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::role_store::Admin>(arg1) == 0x2::tx_context::sender(arg3), 203);
        arg0.description = arg2;
    }

    public fun update_end_time(arg0: &mut Offering, arg1: &0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::role_store::RoleProof<0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::role_store::Admin>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::constants::offering_draft_state() || arg0.status == 0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::constants::offering_active_state(), 204);
        assert!(0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::role_store::owner<0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::role_store::Admin>(arg1) == 0x2::tx_context::sender(arg3), 203);
        arg0.end_time = arg2;
    }

    public fun update_name(arg0: &mut Offering, arg1: &0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::role_store::RoleProof<0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::role_store::Admin>, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::role_store::owner<0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::role_store::Admin>(arg1) == 0x2::tx_context::sender(arg3), 203);
        arg0.name = arg2;
    }

    public(friend) fun update_tokens_sold(arg0: &mut Offering, arg1: u64) {
        arg0.tokens_sold = arg0.tokens_sold + arg1;
    }

    public fun withdraw_fees(arg0: &mut Offering, arg1: &0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::role_store::RoleProof<0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::role_store::SuperAdmin>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC> {
        assert!(0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::role_store::owner<0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::role_store::SuperAdmin>(arg1) == 0x2::tx_context::sender(arg2), 203);
        0x2::coin::from_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2::balance::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.fees, 0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg0.fees)), arg2)
    }

    public fun withdraw_proceeds(arg0: &mut Offering, arg1: &0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::role_store::RoleProof<0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::role_store::SuperAdmin>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC> {
        assert!(0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::role_store::owner<0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::role_store::SuperAdmin>(arg1) == 0x2::tx_context::sender(arg2), 203);
        0x2::coin::from_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2::balance::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.proceeds, 0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg0.proceeds)), arg2)
    }

    // decompiled from Move bytecode v6
}

