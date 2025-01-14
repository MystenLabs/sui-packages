module 0x135c1ded4293f13aabc8704d7c7a9b67b7647465ade0ede5732862a5e717669::mantv_token_release {
    struct SuperAdminCap has key {
        id: 0x2::object::UID,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        admins: vector<address>,
    }

    struct CreditAddress has copy, drop, store {
        beneficiary: address,
        total_amount: u64,
    }

    struct CreatorCap has store, key {
        id: 0x2::object::UID,
        wallet_id: 0x2::object::ID,
    }

    struct ContractWallet has store, key {
        id: 0x2::object::UID,
        beneficiary_addresses: vector<CreditAddress>,
        instant_credit_amount: u64,
        creator: address,
        identifier: 0x1::string::String,
        total_amount: u64,
        vesting_amount_per_period: u64,
        withdrawn_amount: u64,
        balance: 0x2::balance::Balance<0x5b2c8bbf1c0a48a6131159e9acd89d099151617150aed81a3c96d563dffe2228::man::MAN>,
        cliff_amount: u64,
        cliff_date: u64,
        vesting_start_date: u64,
        vesting_duration: u64,
        vesting_period: u64,
        last_withdrawn_at: u64,
        created_at: u64,
        vesting_end_date: u64,
        clawbacked: u64,
        freezable: bool,
        freezed: bool,
    }

    struct AdminAdded has copy, drop {
        admin: address,
    }

    struct AdminRemoved has copy, drop {
        admin: address,
    }

    struct CoinReleased has copy, drop {
        beneficiary: address,
        amount: u64,
    }

    struct VestingEvent has copy, drop {
        beneficiary: address,
        identifier: 0x1::string::String,
        amount: u64,
        withdrawn_amount: u64,
        cliff_amount: u64,
        vesting_start_date: u64,
        vesting_duration: u64,
        vesting_period: u64,
        last_withdrawn_at: u64,
        created_at: u64,
        vesting_end_date: u64,
        clawbacked: u64,
    }

    public fun add_admin(arg0: &SuperAdminCap, arg1: &mut AdminCap, arg2: address) {
        assert!(!isAdmin(arg1, arg2), 8);
        0x1::vector::push_back<address>(&mut arg1.admins, arg2);
        let v0 = AdminAdded{admin: arg2};
        0x2::event::emit<AdminAdded>(v0);
    }

    public fun add_new_vesting_contract(arg0: &mut AdminCap, arg1: vector<address>, arg2: vector<u64>, arg3: 0x1::string::String, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: 0x2::coin::Coin<0x5b2c8bbf1c0a48a6131159e9acd89d099151617150aed81a3c96d563dffe2228::man::MAN>, arg9: u64, arg10: u64, arg11: bool, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : CreatorCap {
        let v0 = 0x2::clock::timestamp_ms(arg12);
        let v1 = 0x2::coin::value<0x5b2c8bbf1c0a48a6131159e9acd89d099151617150aed81a3c96d563dffe2228::man::MAN>(&arg8);
        assert!(isAdmin(arg0, 0x2::tx_context::sender(arg13)), 2);
        assert!(arg4 > v0, 5);
        assert!(arg9 + arg10 <= v1, 7);
        let v2 = 0;
        if (arg6 > 0) {
            v2 = arg5 / arg6;
        };
        let v3 = if (v2 > 0) {
            (v1 - arg9 - arg10) / v2
        } else {
            v1 - arg9 - arg10
        };
        let v4 = 0x1::vector::empty<CreditAddress>();
        let v5 = 0;
        let v6 = 0;
        while (v5 < 0x1::vector::length<address>(&arg1)) {
            let v7 = *0x1::vector::borrow<u64>(&arg2, v5);
            let v8 = CreditAddress{
                beneficiary  : *0x1::vector::borrow<address>(&arg1, v5),
                total_amount : v7,
            };
            0x1::vector::push_back<CreditAddress>(&mut v4, v8);
            v5 = v5 + 1;
            v6 = v6 + v7;
        };
        assert!(v6 == 0x2::coin::value<0x5b2c8bbf1c0a48a6131159e9acd89d099151617150aed81a3c96d563dffe2228::man::MAN>(&arg8), 10);
        let v9 = ContractWallet{
            id                        : 0x2::object::new(arg13),
            beneficiary_addresses     : v4,
            instant_credit_amount     : arg10,
            creator                   : 0x2::tx_context::sender(arg13),
            identifier                : arg3,
            total_amount              : v6,
            vesting_amount_per_period : v3,
            withdrawn_amount          : 0,
            balance                   : 0x2::coin::into_balance<0x5b2c8bbf1c0a48a6131159e9acd89d099151617150aed81a3c96d563dffe2228::man::MAN>(arg8),
            cliff_amount              : arg9,
            cliff_date                : arg7,
            vesting_start_date        : arg4,
            vesting_duration          : arg5,
            vesting_period            : arg6,
            last_withdrawn_at         : 0,
            created_at                : v0,
            vesting_end_date          : arg4 + arg5,
            clawbacked                : 0,
            freezable                 : arg11,
            freezed                   : false,
        };
        let v10 = CreatorCap{
            id        : 0x2::object::new(arg13),
            wallet_id : 0x2::object::id<ContractWallet>(&v9),
        };
        0x2::transfer::share_object<ContractWallet>(v9);
        v10
    }

    public fun claim_coins_to_contract(arg0: &CreatorCap, arg1: &mut ContractWallet, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.wallet_id == 0x2::object::id<ContractWallet>(arg1), 4);
        assert!(arg1.freezed == false, 6);
        let v0 = vested_amount_contract(arg1, arg2) - arg1.withdrawn_amount;
        let v1 = v0;
        assert!(v0 > 0, 1);
        let v2 = 0x2::balance::value<0x5b2c8bbf1c0a48a6131159e9acd89d099151617150aed81a3c96d563dffe2228::man::MAN>(&arg1.balance);
        if (v2 < v0) {
            v1 = v2;
        };
        let v3 = 0x1::vector::length<CreditAddress>(&arg1.beneficiary_addresses);
        while (v3 > 0) {
            v3 = v3 - 1;
            let v4 = 0x1::vector::borrow<CreditAddress>(&arg1.beneficiary_addresses, v3);
            let v5 = (((v1 as u256) * (v4.total_amount as u256) / (arg1.total_amount as u256)) as u64);
            if (v5 > 0) {
                assert!(0x2::balance::value<0x5b2c8bbf1c0a48a6131159e9acd89d099151617150aed81a3c96d563dffe2228::man::MAN>(&arg1.balance) >= v5, 1);
                0x2::transfer::public_transfer<0x2::coin::Coin<0x5b2c8bbf1c0a48a6131159e9acd89d099151617150aed81a3c96d563dffe2228::man::MAN>>(0x2::coin::from_balance<0x5b2c8bbf1c0a48a6131159e9acd89d099151617150aed81a3c96d563dffe2228::man::MAN>(0x2::balance::split<0x5b2c8bbf1c0a48a6131159e9acd89d099151617150aed81a3c96d563dffe2228::man::MAN>(&mut arg1.balance, v5), arg3), v4.beneficiary);
                arg1.withdrawn_amount = arg1.withdrawn_amount + v5;
                arg1.last_withdrawn_at = 0x2::clock::timestamp_ms(arg2);
                let v6 = CoinReleased{
                    beneficiary : v4.beneficiary,
                    amount      : v5,
                };
                0x2::event::emit<CoinReleased>(v6);
                continue
            };
        };
    }

    public fun clawback_contract(arg0: &mut AdminCap, arg1: &mut ContractWallet, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(isAdmin(arg0, 0x2::tx_context::sender(arg3)), 2);
        assert!(arg1.creator == 0x2::tx_context::sender(arg3), 4);
        let v0 = arg1.total_amount - vested_amount_contract(arg1, arg2);
        let v1 = v0;
        assert!(v0 > 0, 1);
        if (v0 > 0x2::balance::value<0x5b2c8bbf1c0a48a6131159e9acd89d099151617150aed81a3c96d563dffe2228::man::MAN>(&arg1.balance)) {
            v1 = 0x2::balance::value<0x5b2c8bbf1c0a48a6131159e9acd89d099151617150aed81a3c96d563dffe2228::man::MAN>(&arg1.balance);
        };
        arg1.clawbacked = v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x5b2c8bbf1c0a48a6131159e9acd89d099151617150aed81a3c96d563dffe2228::man::MAN>>(0x2::coin::from_balance<0x5b2c8bbf1c0a48a6131159e9acd89d099151617150aed81a3c96d563dffe2228::man::MAN>(0x2::balance::split<0x5b2c8bbf1c0a48a6131159e9acd89d099151617150aed81a3c96d563dffe2228::man::MAN>(&mut arg1.balance, v1), arg3), arg1.creator);
    }

    public fun freeze_assets_contract(arg0: &mut AdminCap, arg1: &mut ContractWallet, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(isAdmin(arg0, 0x2::tx_context::sender(arg2)), 2);
        assert!(arg1.creator == 0x2::tx_context::sender(arg2), 4);
        assert!(arg1.freezable == true, 0);
        arg1.freezed = true;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SuperAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<SuperAdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v1, 0x2::tx_context::sender(arg0));
        let v2 = AdminCap{
            id     : 0x2::object::new(arg0),
            admins : v1,
        };
        0x2::transfer::share_object<AdminCap>(v2);
    }

    fun isAdmin(arg0: &AdminCap, arg1: address) : bool {
        let (v0, _) = 0x1::vector::index_of<address>(&arg0.admins, &arg1);
        v0
    }

    public fun remove_admin(arg0: &SuperAdminCap, arg1: &mut AdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(isAdmin(arg1, arg2), 2);
        assert!(arg2 != 0x2::tx_context::sender(arg3), 9);
        let (_, v1) = 0x1::vector::index_of<address>(&arg1.admins, &arg2);
        0x1::vector::remove<address>(&mut arg1.admins, v1);
        let v2 = AdminRemoved{admin: arg2};
        0x2::event::emit<AdminRemoved>(v2);
    }

    public fun unfreeze_assets_contract(arg0: &mut AdminCap, arg1: &mut ContractWallet, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(isAdmin(arg0, 0x2::tx_context::sender(arg2)), 2);
        assert!(arg1.creator == 0x2::tx_context::sender(arg2), 4);
        arg1.freezed = false;
    }

    public fun vested_amount_contract(arg0: &ContractWallet, arg1: &0x2::clock::Clock) : u64 {
        let v0 = arg0.instant_credit_amount;
        let v1 = v0;
        let v2 = 0x2::clock::timestamp_ms(arg1);
        if (v2 > arg0.cliff_date) {
            v1 = v0 + arg0.cliff_amount;
        };
        if (v2 < arg0.vesting_start_date) {
            return v1
        };
        if (v2 >= arg0.vesting_end_date) {
            return arg0.total_amount
        };
        let v3 = (v2 - arg0.vesting_start_date) / arg0.vesting_period;
        if (v3 > 0) {
            v1 = v1 + v3 * arg0.vesting_amount_per_period;
        };
        v1
    }

    // decompiled from Move bytecode v6
}

