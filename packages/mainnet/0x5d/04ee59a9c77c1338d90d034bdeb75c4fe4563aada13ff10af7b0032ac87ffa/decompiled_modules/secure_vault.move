module 0x5d04ee59a9c77c1338d90d034bdeb75c4fe4563aada13ff10af7b0032ac87ffa::secure_vault {
    struct SecureVault<phantom T0> has store, key {
        id: 0x2::object::UID,
        version: u64,
        balance: 0x2::balance::Balance<T0>,
        disabled_operators: 0x2::table::Table<address, bool>,
        current_epoch: u64,
        epoch_max_amount: u64,
        epoch_current_amount: u64,
    }

    struct SecureOwnerCap has store, key {
        id: 0x2::object::UID,
    }

    struct SecureOperatorCap has store, key {
        id: 0x2::object::UID,
    }

    struct SecureVaultCreated has copy, drop {
        vault_id: address,
    }

    struct SecureOperatorCapCreated has copy, drop {
        cap_id: address,
        recipient: address,
    }

    struct WithdrawnFromSecureVault has copy, drop {
        vault_id: address,
        amount: u64,
    }

    struct AdminWithdrawnFromSecureVault has copy, drop {
        vault_id: address,
        amount: u64,
    }

    struct OperatorEpochMaxAmountSet has copy, drop {
        vault_id: address,
        amount: u64,
    }

    struct OperatorDisableSet has copy, drop {
        vault_id: address,
        operator: address,
        disable: bool,
    }

    struct SecureVaultDeposited has copy, drop {
        vault_id: address,
        amount: u64,
    }

    public fun admin_withdraw_secure_vault<T0>(arg0: &mut SecureVault<T0>, arg1: &SecureOwnerCap, arg2: u64) : 0x2::balance::Balance<T0> {
        secure_vault_version_verification<T0>(arg0);
        assert!(arg2 <= 0x2::balance::value<T0>(&arg0.balance), 20007);
        let v0 = AdminWithdrawnFromSecureVault{
            vault_id : 0x2::object::uid_to_address(&arg0.id),
            amount   : arg2,
        };
        0x2::event::emit<AdminWithdrawnFromSecureVault>(v0);
        0x2::balance::split<T0>(&mut arg0.balance, arg2)
    }

    public fun assert_operator_enabled<T0>(arg0: &SecureVault<T0>, arg1: &SecureOperatorCap) {
        assert!(!0x2::table::contains<address, bool>(&arg0.disabled_operators, 0x2::object::uid_to_address(&arg1.id)) || !*0x2::table::borrow<address, bool>(&arg0.disabled_operators, 0x2::object::uid_to_address(&arg1.id)), 20009);
    }

    public fun balance_value<T0>(arg0: &SecureVault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public entry fun create_operator_cap(arg0: &SecureOwnerCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = SecureOperatorCap{id: 0x2::object::new(arg2)};
        let v1 = SecureOperatorCapCreated{
            cap_id    : 0x2::object::uid_to_address(&v0.id),
            recipient : arg1,
        };
        0x2::event::emit<SecureOperatorCapCreated>(v1);
        0x2::transfer::public_transfer<SecureOperatorCap>(v0, arg1);
    }

    public(friend) fun create_vault<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SecureVault<T0>{
            id                   : 0x2::object::new(arg0),
            version              : 0,
            balance              : 0x2::balance::zero<T0>(),
            disabled_operators   : 0x2::table::new<address, bool>(arg0),
            current_epoch        : 0,
            epoch_max_amount     : 0,
            epoch_current_amount : 0,
        };
        let v1 = SecureVaultCreated{vault_id: 0x2::object::uid_to_address(&v0.id)};
        0x2::event::emit<SecureVaultCreated>(v1);
        0x2::transfer::public_share_object<SecureVault<T0>>(v0);
    }

    public(friend) fun deposit_secure_vault<T0>(arg0: &mut SecureVault<T0>, arg1: 0x2::balance::Balance<T0>) {
        secure_vault_version_verification<T0>(arg0);
        0x2::balance::join<T0>(&mut arg0.balance, arg1);
        let v0 = SecureVaultDeposited{
            vault_id : 0x2::object::uid_to_address(&arg0.id),
            amount   : 0x2::balance::value<T0>(&arg1),
        };
        0x2::event::emit<SecureVaultDeposited>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SecureOwnerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<SecureOwnerCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = SecureOperatorCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<SecureOperatorCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public(friend) fun secure_vault_version_migrate<T0>(arg0: &mut SecureVault<T0>) {
        assert!(arg0.version < 0, 20010);
        arg0.version = 0;
    }

    public(friend) fun secure_vault_version_verification<T0>(arg0: &SecureVault<T0>) {
        assert!(arg0.version == 0, 20010);
    }

    public fun set_disable_operator<T0>(arg0: &mut SecureVault<T0>, arg1: &SecureOwnerCap, arg2: address, arg3: bool) {
        secure_vault_version_verification<T0>(arg0);
        if (0x2::table::contains<address, bool>(&arg0.disabled_operators, arg2)) {
            *0x2::table::borrow_mut<address, bool>(&mut arg0.disabled_operators, arg2) = arg3;
        } else {
            0x2::table::add<address, bool>(&mut arg0.disabled_operators, arg2, arg3);
        };
        let v0 = OperatorDisableSet{
            vault_id : 0x2::object::uid_to_address(&arg0.id),
            operator : arg2,
            disable  : arg3,
        };
        0x2::event::emit<OperatorDisableSet>(v0);
    }

    public fun set_operator_epoch_max_amount<T0>(arg0: &mut SecureVault<T0>, arg1: &SecureOwnerCap, arg2: u64) {
        secure_vault_version_verification<T0>(arg0);
        arg0.epoch_max_amount = arg2;
        let v0 = OperatorEpochMaxAmountSet{
            vault_id : 0x2::object::uid_to_address(&arg0.id),
            amount   : arg2,
        };
        0x2::event::emit<OperatorEpochMaxAmountSet>(v0);
    }

    public fun to_address<T0>(arg0: &SecureVault<T0>) : address {
        0x2::object::uid_to_address(&arg0.id)
    }

    public(friend) fun withdraw_secure_vault<T0>(arg0: &mut SecureVault<T0>, arg1: u64, arg2: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        secure_vault_version_verification<T0>(arg0);
        assert!(arg1 <= 0x2::balance::value<T0>(&arg0.balance), 20007);
        if (0x2::tx_context::epoch(arg2) > arg0.current_epoch) {
            arg0.current_epoch = 0x2::tx_context::epoch(arg2);
            arg0.epoch_current_amount = 0;
        };
        arg0.epoch_current_amount = arg0.epoch_current_amount + arg1;
        assert!(arg0.epoch_max_amount == 0 || arg0.epoch_current_amount <= arg0.epoch_max_amount, 20008);
        let v0 = WithdrawnFromSecureVault{
            vault_id : 0x2::object::uid_to_address(&arg0.id),
            amount   : arg1,
        };
        0x2::event::emit<WithdrawnFromSecureVault>(v0);
        0x2::balance::split<T0>(&mut arg0.balance, arg1)
    }

    // decompiled from Move bytecode v6
}

