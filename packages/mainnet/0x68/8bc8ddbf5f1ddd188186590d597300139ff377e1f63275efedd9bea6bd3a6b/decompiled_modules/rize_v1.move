module 0x688bc8ddbf5f1ddd188186590d597300139ff377e1f63275efedd9bea6bd3a6b::rize_v1 {
    struct RizeV1 has store, key {
        id: 0x2::object::UID,
        vault: 0x688bc8ddbf5f1ddd188186590d597300139ff377e1f63275efedd9bea6bd3a6b::vault::Vault,
        role: 0x688bc8ddbf5f1ddd188186590d597300139ff377e1f63275efedd9bea6bd3a6b::role::Role,
        version: 0x688bc8ddbf5f1ddd188186590d597300139ff377e1f63275efedd9bea6bd3a6b::version::Version,
        withdraw: bool,
    }

    struct RIZE_V1 has drop {
        dummy_field: bool,
    }

    struct SetOperatorEvent has copy, drop {
        prev: address,
        new: address,
    }

    struct InitTransferAdminEvent has copy, drop {
        prev: address,
        new: address,
    }

    struct ReclaimAdminEvent has copy, drop {
        admin: address,
    }

    struct AdminTransferredEvent has copy, drop {
        prev: address,
        new: address,
    }

    struct SetWithdrawEvent has copy, drop {
        withdraw: bool,
    }

    struct ReceivedCoinEvent<phantom T0> has copy, drop {
        amount: u64,
    }

    struct NaviDepositEvent<phantom T0> has copy, drop {
        amount: u64,
    }

    struct NaviWithdrawEvent<phantom T0> has copy, drop {
        amount: u64,
    }

    struct NaviClaimEvent<phantom T0> has copy, drop {
        amount: u64,
    }

    struct ScallopSetupEvent<phantom T0> has copy, drop {
        dummy_field: bool,
    }

    struct ScallopMintMarketEvent<phantom T0> has copy, drop {
        stake_amount: u64,
        mint_market_amount: u64,
    }

    struct ScallopRedeemMarketEvent<phantom T0> has copy, drop {
        burn_market_amount: u64,
        redeem_amount: u64,
    }

    struct ScallopStakeSpoolEvent<phantom T0> has copy, drop {
        amount: u64,
    }

    struct ScallopUnstakeSpoolEvent<phantom T0> has copy, drop {
        amount: u64,
    }

    struct ScallopRedeemRewardEvent<phantom T0, phantom T1> has copy, drop {
        amount: u64,
    }

    public fun accept_admin(arg0: &mut RizeV1, arg1: &0x2::tx_context::TxContext) : 0x688bc8ddbf5f1ddd188186590d597300139ff377e1f63275efedd9bea6bd3a6b::role::AdminCap {
        check_version(arg0);
        let (v0, v1) = 0x688bc8ddbf5f1ddd188186590d597300139ff377e1f63275efedd9bea6bd3a6b::role::accept_admin(&mut arg0.role, arg1);
        let v2 = AdminTransferredEvent{
            prev : v0,
            new  : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<AdminTransferredEvent>(v2);
        v1
    }

    public fun admin_withdraw_balance<T0>(arg0: &mut RizeV1, arg1: &0x688bc8ddbf5f1ddd188186590d597300139ff377e1f63275efedd9bea6bd3a6b::role::AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        check_version(arg0);
        assert_withdraw(arg0);
        0x2::coin::from_balance<T0>(0x688bc8ddbf5f1ddd188186590d597300139ff377e1f63275efedd9bea6bd3a6b::vault::take_balance<T0>(&mut arg0.vault, arg2), arg3)
    }

    public fun admin_withdraw_object<T0: copy + drop + store, T1: store + key>(arg0: &mut RizeV1, arg1: &0x688bc8ddbf5f1ddd188186590d597300139ff377e1f63275efedd9bea6bd3a6b::role::AdminCap, arg2: T0) : T1 {
        check_version(arg0);
        assert_withdraw(arg0);
        0x688bc8ddbf5f1ddd188186590d597300139ff377e1f63275efedd9bea6bd3a6b::vault::take_object<T0, T1>(&mut arg0.vault, arg2)
    }

    fun assert_withdraw(arg0: &RizeV1) {
        assert!(arg0.withdraw == true, 1);
    }

    fun check_version(arg0: &RizeV1) {
        0x688bc8ddbf5f1ddd188186590d597300139ff377e1f63275efedd9bea6bd3a6b::version::check_version(&arg0.version);
    }

    public fun get_operator(arg0: &RizeV1) : address {
        check_version(arg0);
        0x688bc8ddbf5f1ddd188186590d597300139ff377e1f63275efedd9bea6bd3a6b::role::get_operator(&arg0.role)
    }

    public fun get_pending_admin_transfer(arg0: &RizeV1) : (address, address) {
        check_version(arg0);
        0x688bc8ddbf5f1ddd188186590d597300139ff377e1f63275efedd9bea6bd3a6b::role::get_pending_transfer(&arg0.role)
    }

    public fun get_vault_balance<T0>(arg0: &RizeV1) : u64 {
        check_version(arg0);
        0x688bc8ddbf5f1ddd188186590d597300139ff377e1f63275efedd9bea6bd3a6b::vault::get_balance<T0>(&arg0.vault)
    }

    fun init(arg0: RIZE_V1, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::types::is_one_time_witness<RIZE_V1>(&arg0), 0);
        let (v0, v1) = 0x688bc8ddbf5f1ddd188186590d597300139ff377e1f63275efedd9bea6bd3a6b::role::init_role(arg1);
        let v2 = 0x688bc8ddbf5f1ddd188186590d597300139ff377e1f63275efedd9bea6bd3a6b::vault::create_vault(arg1);
        0x688bc8ddbf5f1ddd188186590d597300139ff377e1f63275efedd9bea6bd3a6b::navi::setup(&mut v2, arg1);
        let v3 = RizeV1{
            id       : 0x2::object::new(arg1),
            vault    : v2,
            role     : v0,
            version  : 0x688bc8ddbf5f1ddd188186590d597300139ff377e1f63275efedd9bea6bd3a6b::version::init_version(),
            withdraw : false,
        };
        0x2::transfer::share_object<RizeV1>(v3);
        0x2::transfer::public_transfer<0x688bc8ddbf5f1ddd188186590d597300139ff377e1f63275efedd9bea6bd3a6b::role::AdminCap>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun init_transfer_admin(arg0: &mut RizeV1, arg1: 0x688bc8ddbf5f1ddd188186590d597300139ff377e1f63275efedd9bea6bd3a6b::role::AdminCap, arg2: address, arg3: &0x2::tx_context::TxContext) {
        check_version(arg0);
        0x688bc8ddbf5f1ddd188186590d597300139ff377e1f63275efedd9bea6bd3a6b::role::init_transfer_admin(&mut arg0.role, arg1, arg2, arg3);
        let v0 = InitTransferAdminEvent{
            prev : 0x2::tx_context::sender(arg3),
            new  : arg2,
        };
        0x2::event::emit<InitTransferAdminEvent>(v0);
    }

    public fun is_admin_transfer_in_progress(arg0: &RizeV1) : bool {
        check_version(arg0);
        0x688bc8ddbf5f1ddd188186590d597300139ff377e1f63275efedd9bea6bd3a6b::role::is_transfer_in_progress(&arg0.role)
    }

    public fun is_withdraw(arg0: &mut RizeV1) : bool {
        check_version(arg0);
        arg0.withdraw
    }

    public fun navi_address(arg0: &RizeV1) : address {
        check_version(arg0);
        0x688bc8ddbf5f1ddd188186590d597300139ff377e1f63275efedd9bea6bd3a6b::navi::account_cap_address(&arg0.vault)
    }

    public fun navi_balance(arg0: &RizeV1, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: u8) : (u256, u256) {
        check_version(arg0);
        0x688bc8ddbf5f1ddd188186590d597300139ff377e1f63275efedd9bea6bd3a6b::navi::balance(&arg0.vault, arg1, arg2)
    }

    public fun navi_claim<T0>(arg0: &mut RizeV1, arg1: &0x2::clock::Clock, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::IncentiveFundsPool<T0>, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg5: u8, arg6: u8, arg7: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        0x688bc8ddbf5f1ddd188186590d597300139ff377e1f63275efedd9bea6bd3a6b::role::only_operator(&arg0.role, arg7);
        let v0 = 0x688bc8ddbf5f1ddd188186590d597300139ff377e1f63275efedd9bea6bd3a6b::navi::claim_reward<T0>(&arg0.vault, arg1, arg2, arg3, arg4, arg5, arg6);
        0x688bc8ddbf5f1ddd188186590d597300139ff377e1f63275efedd9bea6bd3a6b::vault::put_balance<T0>(&mut arg0.vault, v0, arg7);
        let v1 = NaviClaimEvent<T0>{amount: 0x2::balance::value<T0>(&v0)};
        0x2::event::emit<NaviClaimEvent<T0>>(v1);
    }

    public fun navi_deposit<T0>(arg0: &mut RizeV1, arg1: &0x2::clock::Clock, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg4: u8, arg5: u64, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg8: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        0x688bc8ddbf5f1ddd188186590d597300139ff377e1f63275efedd9bea6bd3a6b::role::only_operator(&arg0.role, arg8);
        0x688bc8ddbf5f1ddd188186590d597300139ff377e1f63275efedd9bea6bd3a6b::navi::deposit<T0>(&arg0.vault, arg1, arg2, arg3, arg4, 0x2::coin::from_balance<T0>(0x688bc8ddbf5f1ddd188186590d597300139ff377e1f63275efedd9bea6bd3a6b::vault::take_balance<T0>(&mut arg0.vault, arg5), arg8), arg6, arg7);
        let v0 = NaviDepositEvent<T0>{amount: arg5};
        0x2::event::emit<NaviDepositEvent<T0>>(v0);
    }

    public fun navi_withdraw<T0>(arg0: &mut RizeV1, arg1: &0x2::clock::Clock, arg2: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: u8, arg6: u64, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg9: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        0x688bc8ddbf5f1ddd188186590d597300139ff377e1f63275efedd9bea6bd3a6b::role::only_operator(&arg0.role, arg9);
        0x688bc8ddbf5f1ddd188186590d597300139ff377e1f63275efedd9bea6bd3a6b::vault::put_balance<T0>(&mut arg0.vault, 0x688bc8ddbf5f1ddd188186590d597300139ff377e1f63275efedd9bea6bd3a6b::navi::withdraw<T0>(&arg0.vault, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8), arg9);
        let v0 = NaviWithdrawEvent<T0>{amount: arg6};
        0x2::event::emit<NaviWithdrawEvent<T0>>(v0);
    }

    public fun receive_coin<T0>(arg0: &mut RizeV1, arg1: 0x2::transfer::Receiving<0x2::coin::Coin<T0>>, arg2: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        let v0 = 0x2::transfer::public_receive<0x2::coin::Coin<T0>>(&mut arg0.id, arg1);
        0x688bc8ddbf5f1ddd188186590d597300139ff377e1f63275efedd9bea6bd3a6b::vault::put_balance<T0>(&mut arg0.vault, 0x2::coin::into_balance<T0>(v0), arg2);
        let v1 = ReceivedCoinEvent<T0>{amount: 0x2::coin::value<T0>(&v0)};
        0x2::event::emit<ReceivedCoinEvent<T0>>(v1);
    }

    public fun reclaim_admin(arg0: &mut RizeV1, arg1: &0x2::tx_context::TxContext) : 0x688bc8ddbf5f1ddd188186590d597300139ff377e1f63275efedd9bea6bd3a6b::role::AdminCap {
        check_version(arg0);
        let v0 = ReclaimAdminEvent{admin: 0x2::tx_context::sender(arg1)};
        0x2::event::emit<ReclaimAdminEvent>(v0);
        0x688bc8ddbf5f1ddd188186590d597300139ff377e1f63275efedd9bea6bd3a6b::role::reclaim_admin(&mut arg0.role, arg1)
    }

    public fun redeem_reward_spool<T0, T1>(arg0: &mut RizeV1, arg1: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::rewards_pool::RewardsPool<T1>, arg2: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::Spool, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        0x688bc8ddbf5f1ddd188186590d597300139ff377e1f63275efedd9bea6bd3a6b::role::only_operator(&arg0.role, arg4);
        let v0 = ScallopRedeemRewardEvent<T0, T1>{amount: 0x688bc8ddbf5f1ddd188186590d597300139ff377e1f63275efedd9bea6bd3a6b::scallop::redeem_rewards_spool<T0, T1>(&mut arg0.vault, arg1, arg2, arg3, arg4)};
        0x2::event::emit<ScallopRedeemRewardEvent<T0, T1>>(v0);
    }

    public fun scallop_mint_market<T0>(arg0: &mut RizeV1, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : u64 {
        check_version(arg0);
        0x688bc8ddbf5f1ddd188186590d597300139ff377e1f63275efedd9bea6bd3a6b::role::only_operator(&arg0.role, arg5);
        let v0 = 0x688bc8ddbf5f1ddd188186590d597300139ff377e1f63275efedd9bea6bd3a6b::scallop::mint_market<T0>(&mut arg0.vault, arg1, arg2, arg3, arg4, arg5);
        let v1 = ScallopMintMarketEvent<T0>{
            stake_amount       : arg3,
            mint_market_amount : v0,
        };
        0x2::event::emit<ScallopMintMarketEvent<T0>>(v1);
        v0
    }

    public fun scallop_redeem_market<T0>(arg0: &mut RizeV1, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        0x688bc8ddbf5f1ddd188186590d597300139ff377e1f63275efedd9bea6bd3a6b::role::only_operator(&arg0.role, arg5);
        let v0 = ScallopRedeemMarketEvent<T0>{
            burn_market_amount : arg3,
            redeem_amount      : 0x688bc8ddbf5f1ddd188186590d597300139ff377e1f63275efedd9bea6bd3a6b::scallop::redeem_market<T0>(&mut arg0.vault, arg1, arg2, arg3, arg4, arg5),
        };
        0x2::event::emit<ScallopRedeemMarketEvent<T0>>(v0);
    }

    public fun scallop_setup<T0>(arg0: &mut RizeV1, arg1: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::Spool, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        0x688bc8ddbf5f1ddd188186590d597300139ff377e1f63275efedd9bea6bd3a6b::role::only_operator(&arg0.role, arg3);
        0x688bc8ddbf5f1ddd188186590d597300139ff377e1f63275efedd9bea6bd3a6b::scallop::setup<T0>(&mut arg0.vault, arg1, arg2, arg3);
        let v0 = ScallopSetupEvent<T0>{dummy_field: false};
        0x2::event::emit<ScallopSetupEvent<T0>>(v0);
    }

    public fun scallop_spool_account<T0>(arg0: &RizeV1) : &0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool_account::SpoolAccount<T0> {
        check_version(arg0);
        0x688bc8ddbf5f1ddd188186590d597300139ff377e1f63275efedd9bea6bd3a6b::scallop::borrow_spool_account<T0>(&arg0.vault)
    }

    public fun scallop_stake_spool<T0>(arg0: &mut RizeV1, arg1: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::Spool, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        0x688bc8ddbf5f1ddd188186590d597300139ff377e1f63275efedd9bea6bd3a6b::role::only_operator(&arg0.role, arg4);
        0x688bc8ddbf5f1ddd188186590d597300139ff377e1f63275efedd9bea6bd3a6b::scallop::stake_spool<T0>(&mut arg0.vault, arg1, arg2, arg3, arg4);
        let v0 = ScallopStakeSpoolEvent<T0>{amount: arg2};
        0x2::event::emit<ScallopStakeSpoolEvent<T0>>(v0);
    }

    public fun scallop_unstake_spool<T0>(arg0: &mut RizeV1, arg1: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::Spool, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : u64 {
        check_version(arg0);
        0x688bc8ddbf5f1ddd188186590d597300139ff377e1f63275efedd9bea6bd3a6b::role::only_operator(&arg0.role, arg4);
        let v0 = 0x688bc8ddbf5f1ddd188186590d597300139ff377e1f63275efedd9bea6bd3a6b::scallop::unstake_spool<T0>(&mut arg0.vault, arg1, arg2, arg3, arg4);
        let v1 = ScallopUnstakeSpoolEvent<T0>{amount: v0};
        0x2::event::emit<ScallopUnstakeSpoolEvent<T0>>(v1);
        v0
    }

    public fun set_operator(arg0: &mut RizeV1, arg1: &0x688bc8ddbf5f1ddd188186590d597300139ff377e1f63275efedd9bea6bd3a6b::role::AdminCap, arg2: address) {
        check_version(arg0);
        let v0 = SetOperatorEvent{
            prev : 0x688bc8ddbf5f1ddd188186590d597300139ff377e1f63275efedd9bea6bd3a6b::role::set_operator(&mut arg0.role, arg1, arg2),
            new  : arg2,
        };
        0x2::event::emit<SetOperatorEvent>(v0);
    }

    public fun set_withdraw(arg0: &mut RizeV1, arg1: &0x688bc8ddbf5f1ddd188186590d597300139ff377e1f63275efedd9bea6bd3a6b::role::AdminCap, arg2: bool) {
        check_version(arg0);
        arg0.withdraw = arg2;
        let v0 = SetWithdrawEvent{withdraw: arg2};
        0x2::event::emit<SetWithdrawEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

