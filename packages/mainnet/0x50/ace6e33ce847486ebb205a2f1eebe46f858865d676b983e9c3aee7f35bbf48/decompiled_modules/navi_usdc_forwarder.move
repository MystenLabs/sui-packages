module 0x63b8b7819aee1715cd893fe9f876d01b9b6c6945b7a2e0cdb514391b7703d9ed::navi_usdc_forwarder {
    struct Position has key {
        id: 0x2::object::UID,
        record: PositionRecord,
        account_cap: 0x1::option::Option<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>,
    }

    struct PositionRecord has store {
        owner: address,
        payout_destination: address,
        storage_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        account_cap_id: 0x2::object::ID,
        principal_micros: u64,
        asset_id: u8,
        closed: bool,
    }

    struct Deposited has copy, drop {
        position_id: 0x2::object::ID,
        owner: address,
        storage_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        account_cap_id: 0x2::object::ID,
        principal_micros: u64,
        asset_id: u8,
    }

    struct Withdrawn has copy, drop {
        position_id: 0x2::object::ID,
        owner: address,
        payout_destination: address,
        storage_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        account_cap_id: 0x2::object::ID,
        principal_micros: u64,
        measured_return_micros: u64,
    }

    struct AccountCapRecovered has copy, drop {
        position_id: 0x2::object::ID,
        owner: address,
        storage_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        account_cap_id: 0x2::object::ID,
        principal_micros: u64,
    }

    public fun account_cap_id(arg0: &Position) : 0x2::object::ID {
        arg0.record.account_cap_id
    }

    fun assert_deposit_authority(arg0: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg1: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg2: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg3: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive) {
        assert!(0x2::object::id_address<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage>(arg0) == @0xbb4e2f4b6205c2e2a2db47aeb4f830796ec7c005f88537ee775986639bc442fe, 5);
        assert!(0x2::object::id_address<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(arg1) == @0xa3582097b4c57630046c0c49a88bfc6b202a3ec0a9db5597c31765f7563755a8, 8);
        assert!(0x2::object::id_address<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive>(arg2) == @0xf87a8acb8b81d14307894d12595541a73f19933f88e1326d5be349c7a6f7559c, 10);
        assert!(0x2::object::id_address<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive>(arg3) == @0x62982dad27fb10bb314b3384d5de8d2ac2d72ab2dbeae5d801dbdb9efa816c80, 10);
    }

    fun assert_exit_authority(arg0: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg1: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg2: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg3: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg4: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg5: &Position, arg6: &0x2::tx_context::TxContext) {
        assert_recorded_owner(arg5, 0x2::tx_context::sender(arg6));
        assert!(0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage>(arg0) == arg5.record.storage_id, 5);
        assert!(0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(arg1) == arg5.record.pool_id, 8);
        assert!(0x2::object::id_address<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage>(arg0) == @0xbb4e2f4b6205c2e2a2db47aeb4f830796ec7c005f88537ee775986639bc442fe, 5);
        assert!(0x2::object::id_address<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(arg1) == @0xa3582097b4c57630046c0c49a88bfc6b202a3ec0a9db5597c31765f7563755a8, 8);
        assert!(0x2::object::id_address<0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle>(arg2) == @0x1568865ed9a0b5ec414220e8f79b3d04c77acc82358f6e5ae4635687392ffbef, 12);
        assert!(0x2::object::id_address<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive>(arg3) == @0xf87a8acb8b81d14307894d12595541a73f19933f88e1326d5be349c7a6f7559c, 10);
        assert!(0x2::object::id_address<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive>(arg4) == @0x62982dad27fb10bb314b3384d5de8d2ac2d72ab2dbeae5d801dbdb9efa816c80, 10);
        assert!(arg5.record.asset_id == 10, 13);
        let v0 = 0x1::option::borrow<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(&arg5.account_cap);
        assert!(0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(v0) == arg5.record.account_cap_id, 13);
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(v0);
    }

    fun assert_nonzero_owner(arg0: address) {
        assert!(arg0 != @0x0, 11);
    }

    fun assert_nonzero_principal(arg0: u64) {
        assert!(arg0 > 0, 9);
    }

    fun assert_recorded_owner(arg0: &Position, arg1: address) {
        assert!(arg1 == arg0.record.owner, 6);
        assert!(!arg0.record.closed, 7);
    }

    public fun asset_id(arg0: &Position) : u8 {
        arg0.record.asset_id
    }

    fun close_and_take_cap(arg0: &mut Position) : (address, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap) {
        arg0.record.closed = true;
        (arg0.record.payout_destination, 0x1::option::extract<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(&mut arg0.account_cap))
    }

    public fun closed(arg0: &Position) : bool {
        arg0.record.closed
    }

    public fun deposit_usdc(arg0: &0x2::clock::Clock, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg5: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        deposit_usdc_for_owner(arg0, arg1, arg2, arg3, arg4, arg5, v0, arg6);
    }

    public fun deposit_usdc_for_owner(arg0: &0x2::clock::Clock, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg5: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg6: address, arg7: &mut 0x2::tx_context::TxContext) {
        assert_deposit_authority(arg1, arg2, arg3, arg4);
        assert_nonzero_owner(arg6);
        let v0 = 0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg5);
        assert_nonzero_principal(v0);
        let v1 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::create_account(arg7);
        let v2 = 0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(&v1);
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::deposit_with_account_cap<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg0, arg1, arg2, 10, arg5, arg3, arg4, &v1);
        let v3 = 0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage>(arg1);
        let v4 = 0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(arg2);
        let v5 = PositionRecord{
            owner              : arg6,
            payout_destination : arg6,
            storage_id         : v3,
            pool_id            : v4,
            account_cap_id     : v2,
            principal_micros   : v0,
            asset_id           : 10,
            closed             : false,
        };
        let v6 = Position{
            id          : 0x2::object::new(arg7),
            record      : v5,
            account_cap : 0x1::option::some<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(v1),
        };
        let v7 = Deposited{
            position_id      : 0x2::object::id<Position>(&v6),
            owner            : arg6,
            storage_id       : v3,
            pool_id          : v4,
            account_cap_id   : v2,
            principal_micros : v0,
            asset_id         : 10,
        };
        0x2::event::emit<Deposited>(v7);
        0x2::transfer::transfer<Position>(v6, arg6);
    }

    public fun owner(arg0: &Position) : address {
        arg0.record.owner
    }

    public fun payout_destination(arg0: &Position) : address {
        arg0.record.payout_destination
    }

    public fun pool_id(arg0: &Position) : 0x2::object::ID {
        arg0.record.pool_id
    }

    public fun principal_micros(arg0: &Position) : u64 {
        arg0.record.principal_micros
    }

    public fun recover_account_cap(arg0: &mut Position, arg1: &mut 0x2::tx_context::TxContext) {
        assert_recorded_owner(arg0, 0x2::tx_context::sender(arg1));
        let v0 = arg0.record.owner;
        let v1 = 0x2::object::id<Position>(arg0);
        let v2 = arg0.record.storage_id;
        let v3 = arg0.record.pool_id;
        let v4 = arg0.record.account_cap_id;
        let v5 = arg0.record.principal_micros;
        let (_, v7) = close_and_take_cap(arg0);
        let v8 = AccountCapRecovered{
            position_id      : v1,
            owner            : v0,
            storage_id       : v2,
            pool_id          : v3,
            account_cap_id   : v4,
            principal_micros : v5,
        };
        0x2::event::emit<AccountCapRecovered>(v8);
        0x2::transfer::public_transfer<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(v7, v0);
    }

    public fun storage_id(arg0: &Position) : 0x2::object::ID {
        arg0.record.storage_id
    }

    public fun withdraw_all_usdc(arg0: &0x2::clock::Clock, arg1: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg6: &mut Position, arg7: &mut 0x2::tx_context::TxContext) {
        assert_exit_authority(arg2, arg3, arg1, arg4, arg5, arg6, arg7);
        let v0 = 0x2::coin::from_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::withdraw_with_account_cap<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg0, arg1, arg2, arg3, arg6.record.asset_id, 18446744073709551615, arg4, arg5, 0x1::option::borrow<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(&arg6.account_cap)), arg7);
        let (v1, v2) = close_and_take_cap(arg6);
        let v3 = Withdrawn{
            position_id            : 0x2::object::id<Position>(arg6),
            owner                  : arg6.record.owner,
            payout_destination     : v1,
            storage_id             : arg6.record.storage_id,
            pool_id                : arg6.record.pool_id,
            account_cap_id         : arg6.record.account_cap_id,
            principal_micros       : arg6.record.principal_micros,
            measured_return_micros : 0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v0),
        };
        0x2::event::emit<Withdrawn>(v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(v0, v1);
        0x2::transfer::public_transfer<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(v2, arg6.record.owner);
    }

    // decompiled from Move bytecode v7
}

