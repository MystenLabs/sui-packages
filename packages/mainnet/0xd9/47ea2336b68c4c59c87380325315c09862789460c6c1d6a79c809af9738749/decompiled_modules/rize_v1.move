module 0xd947ea2336b68c4c59c87380325315c09862789460c6c1d6a79c809af9738749::rize_v1 {
    struct RizeV1 has store, key {
        id: 0x2::object::UID,
        vault: 0xd947ea2336b68c4c59c87380325315c09862789460c6c1d6a79c809af9738749::vault::Vault,
        role: 0xd947ea2336b68c4c59c87380325315c09862789460c6c1d6a79c809af9738749::role::Role,
        version: 0xd947ea2336b68c4c59c87380325315c09862789460c6c1d6a79c809af9738749::version::Version,
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

    public fun accept_admin(arg0: &mut RizeV1, arg1: &0x2::tx_context::TxContext) : 0xd947ea2336b68c4c59c87380325315c09862789460c6c1d6a79c809af9738749::role::AdminCap {
        check_version(arg0);
        let (v0, v1) = 0xd947ea2336b68c4c59c87380325315c09862789460c6c1d6a79c809af9738749::role::accept_admin(&mut arg0.role, arg1);
        let v2 = AdminTransferredEvent{
            prev : v0,
            new  : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<AdminTransferredEvent>(v2);
        v1
    }

    public fun admin_withdraw_balance<T0>(arg0: &mut RizeV1, arg1: &0xd947ea2336b68c4c59c87380325315c09862789460c6c1d6a79c809af9738749::role::AdminCap, arg2: u64) : 0x2::balance::Balance<T0> {
        check_version(arg0);
        assert_withdraw(arg0);
        0xd947ea2336b68c4c59c87380325315c09862789460c6c1d6a79c809af9738749::vault::take_balance<T0>(&mut arg0.vault, arg2)
    }

    public fun admin_withdraw_object<T0: copy + drop + store, T1: store + key>(arg0: &mut RizeV1, arg1: T0) : T1 {
        check_version(arg0);
        assert_withdraw(arg0);
        0xd947ea2336b68c4c59c87380325315c09862789460c6c1d6a79c809af9738749::vault::take_object<T0, T1>(&mut arg0.vault, arg1)
    }

    fun assert_withdraw(arg0: &RizeV1) {
        assert!(arg0.withdraw == true, 1);
    }

    fun check_version(arg0: &RizeV1) {
        0xd947ea2336b68c4c59c87380325315c09862789460c6c1d6a79c809af9738749::version::check_version(&arg0.version);
    }

    public fun get_operator(arg0: &RizeV1) : address {
        check_version(arg0);
        0xd947ea2336b68c4c59c87380325315c09862789460c6c1d6a79c809af9738749::role::get_operator(&arg0.role)
    }

    public fun get_pending_admin_transfer(arg0: &RizeV1) : (address, address) {
        check_version(arg0);
        0xd947ea2336b68c4c59c87380325315c09862789460c6c1d6a79c809af9738749::role::get_pending_transfer(&arg0.role)
    }

    public fun get_vault_balance<T0>(arg0: &RizeV1) : u64 {
        check_version(arg0);
        0xd947ea2336b68c4c59c87380325315c09862789460c6c1d6a79c809af9738749::vault::get_balance<T0>(&arg0.vault)
    }

    fun init(arg0: RIZE_V1, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::types::is_one_time_witness<RIZE_V1>(&arg0), 0);
        let (v0, v1) = 0xd947ea2336b68c4c59c87380325315c09862789460c6c1d6a79c809af9738749::role::init_role(arg1);
        let v2 = 0xd947ea2336b68c4c59c87380325315c09862789460c6c1d6a79c809af9738749::vault::create_vault(arg1);
        0xd947ea2336b68c4c59c87380325315c09862789460c6c1d6a79c809af9738749::navi::setup(&mut v2, arg1);
        let v3 = RizeV1{
            id       : 0x2::object::new(arg1),
            vault    : v2,
            role     : v0,
            version  : 0xd947ea2336b68c4c59c87380325315c09862789460c6c1d6a79c809af9738749::version::init_version(),
            withdraw : false,
        };
        0x2::transfer::share_object<RizeV1>(v3);
        0x2::transfer::public_transfer<0xd947ea2336b68c4c59c87380325315c09862789460c6c1d6a79c809af9738749::role::AdminCap>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun init_transfer_admin(arg0: &mut RizeV1, arg1: 0xd947ea2336b68c4c59c87380325315c09862789460c6c1d6a79c809af9738749::role::AdminCap, arg2: address, arg3: &0x2::tx_context::TxContext) {
        check_version(arg0);
        0xd947ea2336b68c4c59c87380325315c09862789460c6c1d6a79c809af9738749::role::init_transfer_admin(&mut arg0.role, arg1, arg2, arg3);
        let v0 = InitTransferAdminEvent{
            prev : 0x2::tx_context::sender(arg3),
            new  : arg2,
        };
        0x2::event::emit<InitTransferAdminEvent>(v0);
    }

    public fun is_admin_transfer_in_progress(arg0: &RizeV1) : bool {
        check_version(arg0);
        0xd947ea2336b68c4c59c87380325315c09862789460c6c1d6a79c809af9738749::role::is_transfer_in_progress(&arg0.role)
    }

    public fun is_withdraw(arg0: &mut RizeV1) : bool {
        check_version(arg0);
        arg0.withdraw
    }

    public fun navi_address(arg0: &RizeV1) : address {
        check_version(arg0);
        0xd947ea2336b68c4c59c87380325315c09862789460c6c1d6a79c809af9738749::navi::account_cap_address(&arg0.vault)
    }

    public fun navi_balance(arg0: &RizeV1, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: u8) : (u256, u256) {
        check_version(arg0);
        0xd947ea2336b68c4c59c87380325315c09862789460c6c1d6a79c809af9738749::navi::balance(&arg0.vault, arg1, arg2)
    }

    public fun navi_claim<T0>(arg0: &mut RizeV1, arg1: &0x2::clock::Clock, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::IncentiveFundsPool<T0>, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg5: u8, arg6: u8, arg7: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        0xd947ea2336b68c4c59c87380325315c09862789460c6c1d6a79c809af9738749::role::only_operator(&arg0.role, arg7);
        let v0 = 0xd947ea2336b68c4c59c87380325315c09862789460c6c1d6a79c809af9738749::navi::claim_reward<T0>(&arg0.vault, arg1, arg2, arg3, arg4, arg5, arg6);
        0xd947ea2336b68c4c59c87380325315c09862789460c6c1d6a79c809af9738749::vault::put_balance<T0>(&mut arg0.vault, v0, arg7);
        let v1 = NaviClaimEvent<T0>{amount: 0x2::balance::value<T0>(&v0)};
        0x2::event::emit<NaviClaimEvent<T0>>(v1);
    }

    public fun navi_deposit<T0>(arg0: &mut RizeV1, arg1: &0x2::clock::Clock, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg4: u8, arg5: u64, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg8: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        0xd947ea2336b68c4c59c87380325315c09862789460c6c1d6a79c809af9738749::role::only_operator(&arg0.role, arg8);
        0xd947ea2336b68c4c59c87380325315c09862789460c6c1d6a79c809af9738749::navi::deposit<T0>(&arg0.vault, arg1, arg2, arg3, arg4, 0x2::coin::from_balance<T0>(0xd947ea2336b68c4c59c87380325315c09862789460c6c1d6a79c809af9738749::vault::take_balance<T0>(&mut arg0.vault, arg5), arg8), arg6, arg7);
        let v0 = NaviDepositEvent<T0>{amount: arg5};
        0x2::event::emit<NaviDepositEvent<T0>>(v0);
    }

    public fun navi_withdraw<T0>(arg0: &mut RizeV1, arg1: &0x2::clock::Clock, arg2: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: u8, arg6: u64, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg9: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        0xd947ea2336b68c4c59c87380325315c09862789460c6c1d6a79c809af9738749::role::only_operator(&arg0.role, arg9);
        0xd947ea2336b68c4c59c87380325315c09862789460c6c1d6a79c809af9738749::vault::put_balance<T0>(&mut arg0.vault, 0xd947ea2336b68c4c59c87380325315c09862789460c6c1d6a79c809af9738749::navi::withdraw<T0>(&arg0.vault, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8), arg9);
        let v0 = NaviWithdrawEvent<T0>{amount: arg6};
        0x2::event::emit<NaviWithdrawEvent<T0>>(v0);
    }

    public fun receive_coin<T0>(arg0: &mut RizeV1, arg1: 0x2::transfer::Receiving<0x2::coin::Coin<T0>>, arg2: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        let v0 = 0x2::transfer::public_receive<0x2::coin::Coin<T0>>(&mut arg0.id, arg1);
        0xd947ea2336b68c4c59c87380325315c09862789460c6c1d6a79c809af9738749::vault::put_balance<T0>(&mut arg0.vault, 0x2::coin::into_balance<T0>(v0), arg2);
        let v1 = ReceivedCoinEvent<T0>{amount: 0x2::coin::value<T0>(&v0)};
        0x2::event::emit<ReceivedCoinEvent<T0>>(v1);
    }

    public fun reclaim_admin(arg0: &mut RizeV1, arg1: &0x2::tx_context::TxContext) : 0xd947ea2336b68c4c59c87380325315c09862789460c6c1d6a79c809af9738749::role::AdminCap {
        check_version(arg0);
        let v0 = ReclaimAdminEvent{admin: 0x2::tx_context::sender(arg1)};
        0x2::event::emit<ReclaimAdminEvent>(v0);
        0xd947ea2336b68c4c59c87380325315c09862789460c6c1d6a79c809af9738749::role::reclaim_admin(&mut arg0.role, arg1)
    }

    public fun set_operator(arg0: &mut RizeV1, arg1: &0xd947ea2336b68c4c59c87380325315c09862789460c6c1d6a79c809af9738749::role::AdminCap, arg2: address) {
        check_version(arg0);
        let v0 = SetOperatorEvent{
            prev : 0xd947ea2336b68c4c59c87380325315c09862789460c6c1d6a79c809af9738749::role::set_operator(&mut arg0.role, arg1, arg2),
            new  : arg2,
        };
        0x2::event::emit<SetOperatorEvent>(v0);
    }

    public fun set_withdraw(arg0: &mut RizeV1, arg1: &0xd947ea2336b68c4c59c87380325315c09862789460c6c1d6a79c809af9738749::role::AdminCap, arg2: bool) {
        check_version(arg0);
        arg0.withdraw = arg2;
        let v0 = SetWithdrawEvent{withdraw: arg2};
        0x2::event::emit<SetWithdrawEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

