module 0xeaf86f0222e4d38d05e89cbbef5bf11df0b89b7a9f18a5deae29c75532f88e2b::vault {
    struct NaviConfig has store, key {
        id: 0x2::object::UID,
        storage: address,
        clock: address,
        oracle: address,
        incentive_v1: address,
        incentive_v2: address,
        incentive_v3: address,
        sui_pool: address,
        sui_index: u8,
    }

    struct Vault has store, key {
        id: 0x2::object::UID,
        account_cap: 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap,
        sui_index: u8,
    }

    struct PlatformVault has store, key {
        id: 0x2::object::UID,
        account_cap: 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap,
        sui_index: u8,
    }

    struct UserDeposit has store, key {
        id: 0x2::object::UID,
        user: address,
        amount: u64,
    }

    struct PlatformDeposits has store, key {
        id: 0x2::object::UID,
        deposits: vector<UserDeposit>,
    }

    struct DepositEvent has copy, drop {
        user: address,
        amount: u64,
    }

    struct WithdrawEvent has copy, drop {
        user: address,
        amount: u64,
    }

    public fun get_config(arg0: &NaviConfig) : (address, address, address, address, address, address, address, u8) {
        (arg0.storage, arg0.clock, arg0.oracle, arg0.incentive_v1, arg0.incentive_v2, arg0.incentive_v3, arg0.sui_pool, arg0.sui_index)
    }

    public fun get_platform_owner(arg0: &PlatformVault) : address {
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&arg0.account_cap)
    }

    public fun get_user_deposit(arg0: &PlatformDeposits, arg1: address) : u64 {
        let v0 = 0;
        while (v0 < 0x1::vector::length<UserDeposit>(&arg0.deposits)) {
            let v1 = 0x1::vector::borrow<UserDeposit>(&arg0.deposits, v0);
            if (v1.user == arg1) {
                return v1.amount
            };
            v0 = v0 + 1;
        };
        0
    }

    public fun init_navi_config(arg0: address, arg1: address, arg2: address, arg3: address, arg4: address, arg5: address, arg6: address, arg7: u8, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = NaviConfig{
            id           : 0x2::object::new(arg8),
            storage      : arg0,
            clock        : arg1,
            oracle       : arg2,
            incentive_v1 : arg3,
            incentive_v2 : arg4,
            incentive_v3 : arg5,
            sui_pool     : arg6,
            sui_index    : arg7,
        };
        0x2::transfer::public_share_object<NaviConfig>(v0);
    }

    public fun init_platform_deposits(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PlatformDeposits{
            id       : 0x2::object::new(arg0),
            deposits : 0x1::vector::empty<UserDeposit>(),
        };
        0x2::transfer::public_share_object<PlatformDeposits>(v0);
    }

    public fun platform_withdraw<T0>(arg0: &mut PlatformVault, arg1: &0x2::clock::Clock, arg2: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&arg0.account_cap);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::withdraw_with_account_cap<T0>(arg1, arg2, arg3, arg4, arg0.sui_index, arg7, arg5, arg6, &arg0.account_cap), arg8), v0);
        let v1 = WithdrawEvent{
            user   : v0,
            amount : arg7,
        };
        0x2::event::emit<WithdrawEvent>(v1);
    }

    public fun record_user_deposit(arg0: &mut PlatformDeposits, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        let v1 = false;
        while (v0 < 0x1::vector::length<UserDeposit>(&arg0.deposits)) {
            if (0x1::vector::borrow<UserDeposit>(&arg0.deposits, v0).user == arg1) {
                v1 = true;
                break
            };
            v0 = v0 + 1;
        };
        if (v1) {
            let v2 = 0x1::vector::borrow_mut<UserDeposit>(&mut arg0.deposits, v0);
            v2.amount = v2.amount + arg2;
        } else {
            let v3 = UserDeposit{
                id     : 0x2::object::new(arg3),
                user   : arg1,
                amount : arg2,
            };
            0x1::vector::push_back<UserDeposit>(&mut arg0.deposits, v3);
        };
    }

    public fun user_deposit_to_platform<T0>(arg0: &mut PlatformVault, arg1: &mut PlatformDeposits, arg2: &NaviConfig, arg3: &0x2::clock::Clock, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg8: 0x2::coin::Coin<T0>, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg10);
        let v1 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&arg0.account_cap);
        assert!(v1 == @0x630814b75b95971c98ac1763e466b1276c0eb5be36526c235497ca975dc0660c, 0);
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::entry_deposit_on_behalf_of_user<T0>(arg3, arg4, arg5, arg2.sui_index, arg8, arg9, v1, arg6, arg7, arg10);
        record_user_deposit(arg1, v0, arg9, arg10);
        let v2 = DepositEvent{
            user   : v0,
            amount : arg9,
        };
        0x2::event::emit<DepositEvent>(v2);
    }

    public fun withdraw<T0>(arg0: &mut Vault, arg1: &0x2::clock::Clock, arg2: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&arg0.account_cap);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::withdraw_with_account_cap<T0>(arg1, arg2, arg3, arg4, arg0.sui_index, arg7, arg5, arg6, &arg0.account_cap), arg8), v0);
        let v1 = WithdrawEvent{
            user   : v0,
            amount : arg7,
        };
        0x2::event::emit<WithdrawEvent>(v1);
    }

    // decompiled from Move bytecode v6
}

