module 0xd683b01fe412e8a50e2bf6087caa55a676af341f87e2c1c5a9681fe680ee7fb5::vault {
    struct Vault<phantom T0> has key {
        id: 0x2::object::UID,
        withdraw_seq: u64,
        daily_balance: 0x2::balance::Balance<T0>,
        weekly_balance: 0x2::balance::Balance<T0>,
        monthly_balance: 0x2::balance::Balance<T0>,
        yearly_balance: 0x2::balance::Balance<T0>,
    }

    struct VaultCap<phantom T0> has key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
    }

    struct VaultInfo has copy, drop, store {
        daily_balance_value: u64,
        monthly_balance_value: u64,
        yearly_balance_value: u64,
    }

    struct VaultWithdrawInfo has copy, drop, store {
        seq: u64,
        tx_hash: 0x1::ascii::String,
        vault_id: 0x2::object::ID,
        withdraw_amount: u64,
        pool_type: 0x1::ascii::String,
        borrower: address,
        borrow_time: u64,
        repay_amount: u64,
        repayer: 0x1::option::Option<address>,
        repay_time: 0x1::option::Option<u64>,
    }

    struct WithdrawResult<phantom T0> has store {
        balance: 0x2::balance::Balance<T0>,
        info: VaultWithdrawInfo,
    }

    struct VaultTransferred has copy, drop {
        vault_id: 0x2::object::ID,
        old_owner: address,
        new_owner: address,
        transferred_time: u64,
    }

    struct VaultWithdrawn has copy, drop {
        withdraw_info: VaultWithdrawInfo,
    }

    struct VaultRepayed has copy, drop {
        withdraw_info: VaultWithdrawInfo,
    }

    public fun as_vault_info<T0>(arg0: &Vault<T0>) : VaultInfo {
        VaultInfo{
            daily_balance_value   : 0x2::balance::value<T0>(&arg0.daily_balance),
            monthly_balance_value : 0x2::balance::value<T0>(&arg0.monthly_balance),
            yearly_balance_value  : 0x2::balance::value<T0>(&arg0.yearly_balance),
        }
    }

    public fun create_and_transfer_vault<T0>(arg0: address, arg1: &mut 0x2::tx_context::TxContext) : 0xd683b01fe412e8a50e2bf6087caa55a676af341f87e2c1c5a9681fe680ee7fb5::helper::CapInfo {
        let (v0, v1) = create_vault<T0>(arg1);
        let v2 = v1;
        transfer_vault<T0>(v0, arg0, arg1);
        transfer_vault_cap<T0>(v2, arg0);
        0xd683b01fe412e8a50e2bf6087caa55a676af341f87e2c1c5a9681fe680ee7fb5::helper::create_cap_info<T0>(0x2::object::id<VaultCap<T0>>(&v2))
    }

    public fun create_vault<T0>(arg0: &mut 0x2::tx_context::TxContext) : (Vault<T0>, VaultCap<T0>) {
        let v0 = Vault<T0>{
            id              : 0x2::object::new(arg0),
            withdraw_seq    : 0,
            daily_balance   : 0x2::balance::zero<T0>(),
            weekly_balance  : 0x2::balance::zero<T0>(),
            monthly_balance : 0x2::balance::zero<T0>(),
            yearly_balance  : 0x2::balance::zero<T0>(),
        };
        let v1 = VaultCap<T0>{
            id       : 0x2::object::new(arg0),
            vault_id : 0x2::object::id<Vault<T0>>(&v0),
        };
        (v0, v1)
    }

    public fun create_vault_info(arg0: u64, arg1: u64, arg2: u64) : VaultInfo {
        VaultInfo{
            daily_balance_value   : arg0,
            monthly_balance_value : arg1,
            yearly_balance_value  : arg2,
        }
    }

    public fun create_withdraw_vault_info(arg0: 0x1::ascii::String, arg1: u64, arg2: 0x2::object::ID, arg3: u64, arg4: 0x1::ascii::String, arg5: address, arg6: u64) : VaultWithdrawInfo {
        VaultWithdrawInfo{
            seq             : arg1,
            tx_hash         : arg0,
            vault_id        : arg2,
            withdraw_amount : arg3,
            pool_type       : arg4,
            borrower        : arg5,
            borrow_time     : arg6,
            repay_amount    : 0,
            repayer         : 0x1::option::none<address>(),
            repay_time      : 0x1::option::none<u64>(),
        }
    }

    public(friend) fun deposit_vault<T0>(arg0: &mut Vault<T0>, arg1: 0x2::balance::Balance<T0>, arg2: 0x1::ascii::String, arg3: VaultWithdrawInfo, arg4: address, arg5: u64) : u64 {
        assert!(arg2 == 0x1::ascii::string(b"monthly") || arg2 == 0x1::ascii::string(b"yearly"), 0);
        let v0 = VaultWithdrawInfo{
            seq             : arg3.seq,
            tx_hash         : arg3.tx_hash,
            vault_id        : arg3.vault_id,
            withdraw_amount : arg3.withdraw_amount,
            pool_type       : arg3.pool_type,
            borrower        : arg3.borrower,
            borrow_time     : arg3.borrow_time,
            repay_amount    : 0x2::balance::value<T0>(&arg1) + arg3.repay_amount,
            repayer         : 0x1::option::some<address>(arg4),
            repay_time      : 0x1::option::some<u64>(arg5),
        };
        let v1 = if (arg2 == 0x1::ascii::string(b"monthly")) {
            0x2::balance::join<T0>(&mut arg0.monthly_balance, arg1)
        } else {
            0x2::balance::join<T0>(&mut arg0.yearly_balance, arg1)
        };
        emit_vault_deposited_event(v0);
        v1
    }

    public(friend) fun deposit_vault_monthly<T0>(arg0: &mut Vault<T0>, arg1: 0x2::balance::Balance<T0>, arg2: VaultWithdrawInfo, arg3: address, arg4: u64) : u64 {
        deposit_vault<T0>(arg0, arg1, 0x1::ascii::string(b"monthly"), arg2, arg3, arg4)
    }

    public(friend) fun deposit_vault_yearly<T0>(arg0: &mut Vault<T0>, arg1: 0x2::balance::Balance<T0>, arg2: VaultWithdrawInfo, arg3: address, arg4: u64) : u64 {
        deposit_vault<T0>(arg0, arg1, 0x1::ascii::string(b"yearly"), arg2, arg3, arg4)
    }

    public(friend) fun emit_vault_deposited_event(arg0: VaultWithdrawInfo) {
        let v0 = VaultRepayed{withdraw_info: arg0};
        0x2::event::emit<VaultRepayed>(v0);
    }

    public(friend) fun emit_vault_transferred_event(arg0: 0x2::object::ID, arg1: address, arg2: address, arg3: u64) {
        let v0 = VaultTransferred{
            vault_id         : arg0,
            old_owner        : arg1,
            new_owner        : arg2,
            transferred_time : arg3,
        };
        0x2::event::emit<VaultTransferred>(v0);
    }

    public(friend) fun emit_vault_withdrawn_event(arg0: VaultWithdrawInfo) {
        let v0 = VaultWithdrawn{withdraw_info: arg0};
        0x2::event::emit<VaultWithdrawn>(v0);
    }

    public fun get_balance_value<T0>(arg0: &WithdrawResult<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun get_cap_id<T0>(arg0: &VaultCap<T0>) : 0x2::object::ID {
        0x2::object::id<VaultCap<T0>>(arg0)
    }

    public fun get_daily_balance<T0>(arg0: &Vault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.daily_balance)
    }

    public fun get_monthly_balance<T0>(arg0: &Vault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.monthly_balance)
    }

    public fun get_vault_id<T0>(arg0: &VaultCap<T0>) : 0x2::object::ID {
        arg0.vault_id
    }

    public fun get_withdraw_info<T0>(arg0: &WithdrawResult<T0>) : VaultWithdrawInfo {
        arg0.info
    }

    public fun get_withdraw_seq<T0>(arg0: &WithdrawResult<T0>) : u64 {
        arg0.info.seq
    }

    public fun get_yearly_balance<T0>(arg0: &Vault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.yearly_balance)
    }

    public fun join_daily<T0>(arg0: &mut Vault<T0>, arg1: 0x2::balance::Balance<T0>) : u64 {
        0x2::balance::join<T0>(&mut arg0.daily_balance, arg1)
    }

    public fun join_monthly<T0>(arg0: &mut Vault<T0>, arg1: 0x2::balance::Balance<T0>) : u64 {
        0x2::balance::join<T0>(&mut arg0.monthly_balance, arg1)
    }

    public fun join_weekly<T0>(arg0: &mut Vault<T0>, arg1: 0x2::balance::Balance<T0>) : u64 {
        0x2::balance::join<T0>(&mut arg0.weekly_balance, arg1)
    }

    public fun join_yearly<T0>(arg0: &mut Vault<T0>, arg1: 0x2::balance::Balance<T0>) : u64 {
        0x2::balance::join<T0>(&mut arg0.yearly_balance, arg1)
    }

    public(friend) fun take_balance_and_destroy<T0>(arg0: WithdrawResult<T0>) : 0x2::balance::Balance<T0> {
        let WithdrawResult {
            balance : v0,
            info    : _,
        } = arg0;
        v0
    }

    public(friend) fun transfer_vault<T0>(arg0: Vault<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0x2::transfer::transfer<Vault<T0>>(arg0, arg1);
        emit_vault_transferred_event(0x2::object::id<Vault<T0>>(&arg0), 0x2::tx_context::sender(arg2), arg1, 0x2::tx_context::epoch_timestamp_ms(arg2));
    }

    public(friend) fun transfer_vault_cap<T0>(arg0: VaultCap<T0>, arg1: address) {
        0x2::transfer::transfer<VaultCap<T0>>(arg0, arg1);
    }

    public fun valid_vault_cap<T0>(arg0: &VaultCap<T0>, arg1: &Vault<T0>) : bool {
        get_vault_id<T0>(arg0) == 0x2::object::id<Vault<T0>>(arg1)
    }

    public(friend) fun withdraw_by_pool_type<T0>(arg0: &mut Vault<T0>, arg1: &0x1::ascii::String) : 0x2::balance::Balance<T0> {
        assert!(0xd683b01fe412e8a50e2bf6087caa55a676af341f87e2c1c5a9681fe680ee7fb5::helper::validate_pool_type(arg1), 0);
        let v0 = 0x1::ascii::into_bytes(0x1::ascii::to_lowercase(arg1));
        if (v0 == b"daily") {
            0x2::balance::withdraw_all<T0>(&mut arg0.daily_balance)
        } else if (v0 == b"monthly") {
            0x2::balance::withdraw_all<T0>(&mut arg0.monthly_balance)
        } else if (v0 == b"yearly") {
            0x2::balance::withdraw_all<T0>(&mut arg0.yearly_balance)
        } else {
            0x2::balance::zero<T0>()
        }
    }

    public(friend) fun withdraw_vault<T0>(arg0: &mut Vault<T0>, arg1: u64, arg2: 0x1::ascii::String, arg3: &0x2::tx_context::TxContext) : WithdrawResult<T0> {
        assert!(arg2 == 0x1::ascii::string(b"monthly") || arg2 == 0x1::ascii::string(b"yearly"), 0);
        let v0 = arg2 == 0x1::ascii::string(b"monthly");
        let v1 = if (v0) {
            get_monthly_balance<T0>(arg0)
        } else {
            get_yearly_balance<T0>(arg0)
        };
        assert!(arg1 <= v1, 1);
        let v2 = arg0.withdraw_seq + 1;
        arg0.withdraw_seq = v2;
        let v3 = create_withdraw_vault_info(0x1::ascii::string(*0x2::tx_context::digest(arg3)), v2, 0x2::object::id<Vault<T0>>(arg0), arg1, arg2, 0x2::tx_context::sender(arg3), 0x2::tx_context::epoch_timestamp_ms(arg3));
        let v4 = if (v0) {
            0x2::balance::split<T0>(&mut arg0.monthly_balance, arg1)
        } else {
            0x2::balance::split<T0>(&mut arg0.yearly_balance, arg1)
        };
        emit_vault_withdrawn_event(v3);
        WithdrawResult<T0>{
            balance : v4,
            info    : v3,
        }
    }

    public(friend) fun withdraw_vault_monthly<T0>(arg0: &mut Vault<T0>, arg1: u64, arg2: &0x2::tx_context::TxContext) : WithdrawResult<T0> {
        withdraw_vault<T0>(arg0, arg1, 0x1::ascii::string(b"monthly"), arg2)
    }

    public(friend) fun withdraw_vault_yearly<T0>(arg0: &mut Vault<T0>, arg1: u64, arg2: &0x2::tx_context::TxContext) : WithdrawResult<T0> {
        withdraw_vault<T0>(arg0, arg1, 0x1::ascii::string(b"yearly"), arg2)
    }

    public fun zero_vault_info() : VaultInfo {
        VaultInfo{
            daily_balance_value   : 0,
            monthly_balance_value : 0,
            yearly_balance_value  : 0,
        }
    }

    // decompiled from Move bytecode v6
}

