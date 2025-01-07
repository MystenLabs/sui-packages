module 0xfadc2a695e4d92612a203f5bfc48e9f0a5be4d6bad9d08b1e8f06ce9be7a3f5a::bluefin_vault {
    struct Vault<phantom T0> has key {
        id: 0x2::object::UID,
        bank: 0x2::object::ID,
        bank_account: address,
        perpetual_id: 0x2::object::ID,
        operator: address,
        deposit_paused: bool,
        withdraw_paused: bool,
        claims_paused: bool,
        user_shares: 0x2::table::Table<address, u64>,
        total_shares: u64,
        coin_balance: 0x2::balance::Balance<T0>,
        user_pending_withdrawals: 0x2::table::Table<address, u64>,
        amount_to_be_withdrawn: u64,
        version: u64,
    }

    entry fun claim_withdrawn_funds<T0>(arg0: &mut Vault<T0>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 0xfadc2a695e4d92612a203f5bfc48e9f0a5be4d6bad9d08b1e8f06ce9be7a3f5a::constants::get_version(), 0xfadc2a695e4d92612a203f5bfc48e9f0a5be4d6bad9d08b1e8f06ce9be7a3f5a::errors::version_mismatch());
        assert!(!arg0.claims_paused, 0xfadc2a695e4d92612a203f5bfc48e9f0a5be4d6bad9d08b1e8f06ce9be7a3f5a::errors::claim_paused());
        assert!(0x2::table::contains<address, u64>(&arg0.user_pending_withdrawals, arg1), 0xfadc2a695e4d92612a203f5bfc48e9f0a5be4d6bad9d08b1e8f06ce9be7a3f5a::errors::claiming_more_than_requested());
        let v0 = 0x2::table::borrow_mut<address, u64>(&mut arg0.user_pending_withdrawals, arg1);
        if (arg2 == 0) {
            arg2 = *v0;
        };
        assert!(arg2 <= *v0, 0xfadc2a695e4d92612a203f5bfc48e9f0a5be4d6bad9d08b1e8f06ce9be7a3f5a::errors::claiming_more_than_requested());
        *v0 = *v0 - arg2;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.coin_balance, arg2, arg3), arg1);
        0xfadc2a695e4d92612a203f5bfc48e9f0a5be4d6bad9d08b1e8f06ce9be7a3f5a::events::emit_funds_claimed_event(0x2::object::uid_to_inner(&arg0.id), 0x2::tx_context::sender(arg3), arg1, arg2);
    }

    fun create_tx_hash(arg0: &mut 0x2::tx_context::TxContext) : vector<u8> {
        let v0 = 0x2::object::new(arg0);
        0x2::object::delete(v0);
        0x2::object::uid_to_bytes(&v0)
    }

    entry fun create_vault<T0>(arg0: &0xfadc2a695e4d92612a203f5bfc48e9f0a5be4d6bad9d08b1e8f06ce9be7a3f5a::roles::AdminCap, arg1: &mut 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::SubAccountsV2, arg2: &mut 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::margin_bank::BankV2<T0>, arg3: &mut 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::vaults::VaultStore, arg4: 0x2::object::ID, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::vaults::create_vault_bank_account<T0>(arg2, arg1, arg3, arg5, arg6);
        let v1 = 0x2::object::new(arg6);
        let v2 = Vault<T0>{
            id                       : v1,
            bank                     : 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::margin_bank::get_bank_id<T0>(arg2),
            bank_account             : v0,
            perpetual_id             : arg4,
            operator                 : arg5,
            deposit_paused           : false,
            withdraw_paused          : false,
            claims_paused            : false,
            user_shares              : 0x2::table::new<address, u64>(arg6),
            total_shares             : 0,
            coin_balance             : 0x2::balance::zero<T0>(),
            user_pending_withdrawals : 0x2::table::new<address, u64>(arg6),
            amount_to_be_withdrawn   : 0,
            version                  : 0xfadc2a695e4d92612a203f5bfc48e9f0a5be4d6bad9d08b1e8f06ce9be7a3f5a::constants::get_version(),
        };
        0x2::transfer::share_object<Vault<T0>>(v2);
        0xfadc2a695e4d92612a203f5bfc48e9f0a5be4d6bad9d08b1e8f06ce9be7a3f5a::events::emit_created_vault_event(0x2::object::uid_to_inner(&v1), v0, arg4, arg5);
    }

    entry fun deposit_to_vault<T0>(arg0: &0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::perpetual::PerpetualV2, arg1: &mut 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::margin_bank::BankV2<T0>, arg2: &mut 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::Sequencer, arg3: &mut Vault<T0>, arg4: &mut 0x2::coin::Coin<T0>, arg5: u64, arg6: address, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg3.version == 0xfadc2a695e4d92612a203f5bfc48e9f0a5be4d6bad9d08b1e8f06ce9be7a3f5a::constants::get_version(), 0xfadc2a695e4d92612a203f5bfc48e9f0a5be4d6bad9d08b1e8f06ce9be7a3f5a::errors::version_mismatch());
        assert!(!arg3.deposit_paused, 0xfadc2a695e4d92612a203f5bfc48e9f0a5be4d6bad9d08b1e8f06ce9be7a3f5a::errors::deposit_paused());
        assert!(arg3.perpetual_id == 0x2::object::uid_to_inner(0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::perpetual::id_v2(arg0)), 0xfadc2a695e4d92612a203f5bfc48e9f0a5be4d6bad9d08b1e8f06ce9be7a3f5a::errors::perp_not_supported());
        assert!(arg3.bank == 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::margin_bank::get_bank_id<T0>(arg1), 0xfadc2a695e4d92612a203f5bfc48e9f0a5be4d6bad9d08b1e8f06ce9be7a3f5a::errors::bluefin_bank_mismatch());
        if (!0x2::table::contains<address, u64>(&arg3.user_shares, arg6)) {
            0x2::table::add<address, u64>(&mut arg3.user_shares, arg6, 0);
        };
        let v0 = 0x2::table::borrow_mut<address, u64>(&mut arg3.user_shares, arg6);
        let v1 = vault_balance<T0>(arg3.bank_account, arg3.amount_to_be_withdrawn, arg1, arg0);
        let v2 = arg5;
        if (v1 > 0 && arg3.total_shares > 0) {
            v2 = arg5 * arg3.total_shares / v1;
        };
        assert!(v2 > 0, 0xfadc2a695e4d92612a203f5bfc48e9f0a5be4d6bad9d08b1e8f06ce9be7a3f5a::errors::can_not_be_zero());
        *v0 = *v0 + v2;
        if (arg3.total_shares == 0) {
            *v0 = *v0 - 0xfadc2a695e4d92612a203f5bfc48e9f0a5be4d6bad9d08b1e8f06ce9be7a3f5a::constants::min_shares();
        };
        arg3.total_shares = arg3.total_shares + v2;
        let v3 = 0x2::tx_context::sender(arg7);
        assert!(arg5 <= 0x2::coin::value<T0>(arg4), 0xfadc2a695e4d92612a203f5bfc48e9f0a5be4d6bad9d08b1e8f06ce9be7a3f5a::errors::insufficient_funds());
        let v4 = 0x2::coin::take<T0>(0x2::coin::balance_mut<T0>(arg4), arg5, arg7);
        let v5 = create_tx_hash(arg7);
        0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::margin_bank::deposit_to_bank<T0>(arg1, arg2, v5, arg3.bank_account, arg5, &mut v4, arg7);
        0x2::coin::destroy_zero<T0>(v4);
        0xfadc2a695e4d92612a203f5bfc48e9f0a5be4d6bad9d08b1e8f06ce9be7a3f5a::events::emit_funds_deposited_event(0x2::object::uid_to_inner(&arg3.id), v3, arg6, arg5, v2, *v0, arg3.total_shares, v1 + arg5);
    }

    entry fun move_vault_balance_from_bank<T0>(arg0: &mut 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::margin_bank::BankV2<T0>, arg1: &0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::vaults::VaultStore, arg2: &mut 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::Sequencer, arg3: &mut Vault<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg3.version == 0xfadc2a695e4d92612a203f5bfc48e9f0a5be4d6bad9d08b1e8f06ce9be7a3f5a::constants::get_version(), 0xfadc2a695e4d92612a203f5bfc48e9f0a5be4d6bad9d08b1e8f06ce9be7a3f5a::errors::version_mismatch());
        assert!(arg3.bank == 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::margin_bank::get_bank_id<T0>(arg0), 0xfadc2a695e4d92612a203f5bfc48e9f0a5be4d6bad9d08b1e8f06ce9be7a3f5a::errors::bluefin_bank_mismatch());
        let v0 = create_tx_hash(arg4);
        0x2::coin::put<T0>(&mut arg3.coin_balance, 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::vaults::withdraw_coins_from_vault<T0>(arg0, arg2, arg1, v0, arg3.bank_account, (arg3.amount_to_be_withdrawn as u128), arg4));
        arg3.amount_to_be_withdrawn = 0;
    }

    entry fun pause_vault<T0>(arg0: &0xfadc2a695e4d92612a203f5bfc48e9f0a5be4d6bad9d08b1e8f06ce9be7a3f5a::roles::AdminCap, arg1: &mut Vault<T0>, arg2: bool, arg3: bool, arg4: bool) {
        assert!(arg1.version == 0xfadc2a695e4d92612a203f5bfc48e9f0a5be4d6bad9d08b1e8f06ce9be7a3f5a::constants::get_version(), 0xfadc2a695e4d92612a203f5bfc48e9f0a5be4d6bad9d08b1e8f06ce9be7a3f5a::errors::version_mismatch());
        arg1.deposit_paused = arg2;
        arg1.withdraw_paused = arg3;
        arg1.claims_paused = arg4;
        0xfadc2a695e4d92612a203f5bfc48e9f0a5be4d6bad9d08b1e8f06ce9be7a3f5a::events::emit_vault_pause_update_event(0x2::object::uid_to_inner(&arg1.id), arg2, arg3, arg4);
    }

    entry fun update_vault_operator<T0>(arg0: &0xfadc2a695e4d92612a203f5bfc48e9f0a5be4d6bad9d08b1e8f06ce9be7a3f5a::roles::AdminCap, arg1: &mut Vault<T0>, arg2: &mut 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::SubAccountsV2, arg3: &mut 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::vaults::VaultStore, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 0xfadc2a695e4d92612a203f5bfc48e9f0a5be4d6bad9d08b1e8f06ce9be7a3f5a::constants::get_version(), 0xfadc2a695e4d92612a203f5bfc48e9f0a5be4d6bad9d08b1e8f06ce9be7a3f5a::errors::version_mismatch());
        0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::vaults::set_vault_sub_account(arg2, arg3, arg1.bank_account, arg1.operator, false, arg5);
        arg1.operator = arg4;
        0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::vaults::set_vault_sub_account(arg2, arg3, arg1.bank_account, arg1.operator, true, arg5);
        0xfadc2a695e4d92612a203f5bfc48e9f0a5be4d6bad9d08b1e8f06ce9be7a3f5a::events::emit_vault_operator_update_event(0x2::object::uid_to_inner(&arg1.id), arg4);
    }

    entry fun update_version_for_vault<T0>(arg0: &0xfadc2a695e4d92612a203f5bfc48e9f0a5be4d6bad9d08b1e8f06ce9be7a3f5a::roles::AdminCap, arg1: &mut Vault<T0>) {
        arg1.version = arg1.version + 1;
    }

    fun vault_balance<T0>(arg0: address, arg1: u64, arg2: &0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::margin_bank::BankV2<T0>, arg3: &0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::perpetual::PerpetualV2) : u64 {
        0xfadc2a695e4d92612a203f5bfc48e9f0a5be4d6bad9d08b1e8f06ce9be7a3f5a::maths::convert_to_usdc_base(0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::margin_bank::get_balance_v2<T0>(arg2, arg0) + 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::position::margin(0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::perpetual::get_user_position(arg3, arg0))) - arg1
    }

    entry fun withdraw_from_vault<T0>(arg0: &0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::perpetual::PerpetualV2, arg1: &0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::margin_bank::BankV2<T0>, arg2: &mut Vault<T0>, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        assert!(arg2.version == 0xfadc2a695e4d92612a203f5bfc48e9f0a5be4d6bad9d08b1e8f06ce9be7a3f5a::constants::get_version(), 0xfadc2a695e4d92612a203f5bfc48e9f0a5be4d6bad9d08b1e8f06ce9be7a3f5a::errors::version_mismatch());
        assert!(!arg2.withdraw_paused, 0xfadc2a695e4d92612a203f5bfc48e9f0a5be4d6bad9d08b1e8f06ce9be7a3f5a::errors::withdraw_paused());
        assert!(arg2.perpetual_id == 0x2::object::uid_to_inner(0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::perpetual::id_v2(arg0)), 0xfadc2a695e4d92612a203f5bfc48e9f0a5be4d6bad9d08b1e8f06ce9be7a3f5a::errors::perp_not_supported());
        assert!(arg2.bank == 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::margin_bank::get_bank_id<T0>(arg1), 0xfadc2a695e4d92612a203f5bfc48e9f0a5be4d6bad9d08b1e8f06ce9be7a3f5a::errors::bluefin_bank_mismatch());
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x2::table::contains<address, u64>(&arg2.user_shares, v0), 0xfadc2a695e4d92612a203f5bfc48e9f0a5be4d6bad9d08b1e8f06ce9be7a3f5a::errors::insufficient_shares());
        let v1 = 0x2::table::borrow_mut<address, u64>(&mut arg2.user_shares, v0);
        assert!(*v1 >= arg3, 0xfadc2a695e4d92612a203f5bfc48e9f0a5be4d6bad9d08b1e8f06ce9be7a3f5a::errors::insufficient_shares());
        let v2 = vault_balance<T0>(arg2.bank_account, arg2.amount_to_be_withdrawn, arg1, arg0);
        let v3 = arg3 * v2 / arg2.total_shares;
        assert!(v3 > 0, 0xfadc2a695e4d92612a203f5bfc48e9f0a5be4d6bad9d08b1e8f06ce9be7a3f5a::errors::can_not_be_zero());
        *v1 = *v1 - arg3;
        arg2.total_shares = arg2.total_shares - arg3;
        if (!0x2::table::contains<address, u64>(&arg2.user_pending_withdrawals, v0)) {
            0x2::table::add<address, u64>(&mut arg2.user_pending_withdrawals, v0, 0);
        };
        let v4 = 0x2::table::borrow_mut<address, u64>(&mut arg2.user_pending_withdrawals, v0);
        *v4 = *v4 + v3;
        arg2.amount_to_be_withdrawn = arg2.amount_to_be_withdrawn + v3;
        0xfadc2a695e4d92612a203f5bfc48e9f0a5be4d6bad9d08b1e8f06ce9be7a3f5a::events::emit_funds_withdrawn_event(0x2::object::uid_to_inner(&arg2.id), v0, v3, arg3, *v1, arg2.total_shares, v2 - v3);
    }

    // decompiled from Move bytecode v6
}

