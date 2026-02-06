module 0x2a93082fb51995e7626ed9a934694b90dbd257ea5606fd5afd244a620ccb1870::vault {
    struct Vault<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        vault_type: u8,
    }

    struct VaultConfig has key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
        max_loan_amount: u64,
        reserve: u64,
    }

    struct Receipt<phantom T0> {
        vault_id: 0x2::object::ID,
        repay_amount: u64,
    }

    struct VaultCreated has copy, drop {
        vault_id: 0x2::object::ID,
        coin_type: 0x1::ascii::String,
        vault_type: u8,
        creator: address,
    }

    struct VaultConfigCreated has copy, drop {
        vault_id: 0x2::object::ID,
        config_id: 0x2::object::ID,
    }

    struct ProfitTaken has copy, drop {
        vault_id: 0x2::object::ID,
        amount: u64,
    }

    public fun admin_withdraw<T0>(arg0: &0x2a93082fb51995e7626ed9a934694b90dbd257ea5606fd5afd244a620ccb1870::admin::AdminCap, arg1: &mut Vault<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        abort 404
    }

    public entry fun admin_withdraw_all<T0>(arg0: &0x2a93082fb51995e7626ed9a934694b90dbd257ea5606fd5afd244a620ccb1870::admin::AdminCap, arg1: &mut Vault<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance, 0x2::balance::value<T0>(&arg1.balance)), arg2), 0x2::tx_context::sender(arg2));
    }

    public fun admin_withdraw_amount<T0>(arg0: &0x2a93082fb51995e7626ed9a934694b90dbd257ea5606fd5afd244a620ccb1870::admin::AdminCap, arg1: &mut Vault<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance, arg2), arg3)
    }

    public entry fun create_vault<T0>(arg0: u8, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg1);
        let v1 = Vault<T0>{
            id         : v0,
            balance    : 0x2::balance::zero<T0>(),
            vault_type : arg0,
        };
        let v2 = VaultCreated{
            vault_id   : 0x2::object::uid_to_inner(&v0),
            coin_type  : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
            vault_type : arg0,
            creator    : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<VaultCreated>(v2);
        0x2::transfer::share_object<Vault<T0>>(v1);
    }

    public fun create_vault_config<T0>(arg0: &0x2a93082fb51995e7626ed9a934694b90dbd257ea5606fd5afd244a620ccb1870::admin::AdminCap, arg1: &Vault<T0>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = VaultConfig{
            id              : 0x2::object::new(arg4),
            vault_id        : 0x2::object::id<Vault<T0>>(arg1),
            max_loan_amount : arg2,
            reserve         : arg3,
        };
        let v1 = VaultConfigCreated{
            vault_id  : 0x2::object::id<Vault<T0>>(arg1),
            config_id : 0x2::object::id<VaultConfig>(&v0),
        };
        0x2::event::emit<VaultConfigCreated>(v1);
        0x2::transfer::share_object<VaultConfig>(v0);
    }

    public fun deposit<T0>(arg0: &mut Vault<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
    }

    public fun get_balance<T0>(arg0: &Vault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun loan<T0>(arg0: &0x2a93082fb51995e7626ed9a934694b90dbd257ea5606fd5afd244a620ccb1870::admin::Roles, arg1: &mut Vault<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, Receipt<T0>) {
        assert!(0x2a93082fb51995e7626ed9a934694b90dbd257ea5606fd5afd244a620ccb1870::admin::is_whitelisted(arg0, 0x2::tx_context::sender(arg3)), 4003);
        assert!(0x2::balance::value<T0>(&arg1.balance) >= arg2, 4002);
        let v0 = Receipt<T0>{
            vault_id     : 0x2::object::id<Vault<T0>>(arg1),
            repay_amount : arg2,
        };
        (0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance, arg2), arg3), v0)
    }

    public fun repay<T0>(arg0: &mut Vault<T0>, arg1: 0x2::coin::Coin<T0>, arg2: Receipt<T0>) {
        let Receipt {
            vault_id     : v0,
            repay_amount : v1,
        } = arg2;
        assert!(0x2::object::id<Vault<T0>>(arg0) == v0, 4005);
        assert!(0x2::coin::value<T0>(&arg1) >= v1, 4005);
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
    }

    public fun sponsor_withdraw(arg0: &mut Vault<0x2::sui::SUI>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(0x2::tx_context::sender(arg2) == @0xb4851d61511dcf8b2e885bd6dd354876c45bfc78ba54bcdb779a3c62323b9bb2, 4006);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.balance) >= arg1, 4002);
        assert!(arg1 < 200000000000, 4007);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, arg1), arg2)
    }

    public fun take_profit<T0>(arg0: &0x2a93082fb51995e7626ed9a934694b90dbd257ea5606fd5afd244a620ccb1870::admin::AdminCap, arg1: &mut Vault<T0>, arg2: &VaultConfig, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = if (arg2.reserve == 0) {
            0x2::balance::value<T0>(&arg1.balance)
        } else if (0x2::balance::value<T0>(&arg1.balance) <= arg2.reserve) {
            0
        } else {
            0x2::balance::value<T0>(&arg1.balance) - arg2.reserve
        };
        let v1 = ProfitTaken{
            vault_id : 0x2::object::id<Vault<T0>>(arg1),
            amount   : v0,
        };
        0x2::event::emit<ProfitTaken>(v1);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance, v0), arg3)
    }

    public fun update_vault_config<T0>(arg0: &0x2a93082fb51995e7626ed9a934694b90dbd257ea5606fd5afd244a620ccb1870::admin::AdminCap, arg1: &mut VaultConfig, arg2: &Vault<T0>, arg3: u64, arg4: u64) {
        assert!(arg1.vault_id == 0x2::object::id<Vault<T0>>(arg2), 4004);
        if (arg3 != 0) {
            arg1.max_loan_amount = arg3;
        };
        if (arg4 != 0) {
            arg1.reserve = arg4;
        };
    }

    public fun withdraw<T0>(arg0: &0x2a93082fb51995e7626ed9a934694b90dbd257ea5606fd5afd244a620ccb1870::admin::Roles, arg1: &mut Vault<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg1.vault_type == 1, 4004);
        assert!(0x2a93082fb51995e7626ed9a934694b90dbd257ea5606fd5afd244a620ccb1870::admin::is_whitelisted(arg0, 0x2::tx_context::sender(arg3)), 4003);
        assert!(0x2::balance::value<T0>(&arg1.balance) >= arg2, 4002);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance, arg2), arg3)
    }

    public fun withdraw_all<T0>(arg0: &0x2a93082fb51995e7626ed9a934694b90dbd257ea5606fd5afd244a620ccb1870::admin::Roles, arg1: &mut Vault<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::balance::value<T0>(&arg1.balance);
        withdraw<T0>(arg0, arg1, v0, arg2)
    }

    // decompiled from Move bytecode v6
}

