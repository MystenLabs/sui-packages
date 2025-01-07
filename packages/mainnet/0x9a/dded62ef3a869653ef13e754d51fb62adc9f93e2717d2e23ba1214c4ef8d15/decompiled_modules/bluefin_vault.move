module 0x9added62ef3a869653ef13e754d51fb62adc9f93e2717d2e23ba1214c4ef8d15::bluefin_vault {
    struct User has drop, store {
        amount_locked: u64,
        pending_withdrawal: u64,
        shares: u64,
    }

    struct Vault<phantom T0> has key {
        id: 0x2::object::UID,
        bank: 0x2::object::ID,
        bank_account: address,
        name: 0x1::string::String,
        claims_manager: address,
        operator: address,
        holding_account: address,
        deposit_paused: bool,
        withdraw_paused: bool,
        claims_paused: bool,
        users: 0x2::table::Table<address, User>,
        total_locked_amount: u64,
        coin_balance: 0x2::balance::Balance<T0>,
        total_amount_to_be_withdrawn: u64,
        pending_profit_amount: u64,
        max_cap: u64,
        claimed: 0x2::table::Table<u128, bool>,
        sequence_number: u128,
        type: u8,
        version: u64,
    }

    entry fun claim_withdrawn_funds<T0>(arg0: &mut Vault<T0>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 0x9added62ef3a869653ef13e754d51fb62adc9f93e2717d2e23ba1214c4ef8d15::constants::get_version(), 0x9added62ef3a869653ef13e754d51fb62adc9f93e2717d2e23ba1214c4ef8d15::errors::version_mismatch());
        assert!(arg0.type == 0x9added62ef3a869653ef13e754d51fb62adc9f93e2717d2e23ba1214c4ef8d15::constants::no_pnl_sharing_vault_type(), 0x9added62ef3a869653ef13e754d51fb62adc9f93e2717d2e23ba1214c4ef8d15::errors::invalid_vault_type());
        assert!(!arg0.claims_paused, 0x9added62ef3a869653ef13e754d51fb62adc9f93e2717d2e23ba1214c4ef8d15::errors::claim_paused());
        let v0 = 0x9added62ef3a869653ef13e754d51fb62adc9f93e2717d2e23ba1214c4ef8d15::utils::verify_signature(arg1, arg2, arg0.claims_manager, 0x2::object::uid_to_address(&arg0.id), 0x9added62ef3a869653ef13e754d51fb62adc9f93e2717d2e23ba1214c4ef8d15::constants::claim_funds_payload_type());
        let v1 = 0x9added62ef3a869653ef13e754d51fb62adc9f93e2717d2e23ba1214c4ef8d15::utils::payload_receiver(v0);
        let v2 = 0x9added62ef3a869653ef13e754d51fb62adc9f93e2717d2e23ba1214c4ef8d15::utils::payload_amount(v0);
        let v3 = 0x9added62ef3a869653ef13e754d51fb62adc9f93e2717d2e23ba1214c4ef8d15::utils::payload_nonce(v0);
        assert!(!0x2::table::contains<u128, bool>(&arg0.claimed, v3), 0x9added62ef3a869653ef13e754d51fb62adc9f93e2717d2e23ba1214c4ef8d15::errors::already_claimed());
        assert!(0x2::table::contains<address, User>(&arg0.users, v1), 0x9added62ef3a869653ef13e754d51fb62adc9f93e2717d2e23ba1214c4ef8d15::errors::claiming_more_than_requested());
        let v4 = 0x2::table::borrow_mut<address, User>(&mut arg0.users, v1);
        assert!(v2 <= v4.pending_withdrawal, 0x9added62ef3a869653ef13e754d51fb62adc9f93e2717d2e23ba1214c4ef8d15::errors::claiming_more_than_requested());
        v4.pending_withdrawal = v4.pending_withdrawal - v2;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.coin_balance, v2, arg3), v1);
        0x2::table::add<u128, bool>(&mut arg0.claimed, v3, true);
        arg0.sequence_number = arg0.sequence_number + 1;
        0x9added62ef3a869653ef13e754d51fb62adc9f93e2717d2e23ba1214c4ef8d15::events::emit_funds_claimed_event(0x2::object::uid_to_inner(&arg0.id), 0x2::tx_context::sender(arg3), v1, v2, v4.pending_withdrawal, 0x2::balance::value<T0>(&arg0.coin_balance), v3, arg0.sequence_number);
        if (v4.pending_withdrawal == 0 && v4.amount_locked == 0) {
            0x2::table::remove<address, User>(&mut arg0.users, v1);
        };
    }

    fun create_tx_hash(arg0: &mut 0x2::tx_context::TxContext) : vector<u8> {
        let v0 = 0x2::object::new(arg0);
        0x2::object::delete(v0);
        0x2::object::uid_to_bytes(&v0)
    }

    fun create_user() : User {
        User{
            amount_locked      : 0,
            pending_withdrawal : 0,
            shares             : 0,
        }
    }

    entry fun create_vault<T0>(arg0: &0x9added62ef3a869653ef13e754d51fb62adc9f93e2717d2e23ba1214c4ef8d15::roles::AdminCap, arg1: &mut 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::SubAccountsV2, arg2: &mut 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::margin_bank::BankV2<T0>, arg3: &mut 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::vaults::VaultStore, arg4: vector<u8>, arg5: address, arg6: address, arg7: address, arg8: u64, arg9: u8, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::vaults::create_vault_bank_account<T0>(arg2, arg1, arg3, arg5, arg10);
        let v1 = 0x2::object::new(arg10);
        let v2 = 0x1::string::utf8(arg4);
        assert!(arg5 != @0x0, 0x9added62ef3a869653ef13e754d51fb62adc9f93e2717d2e23ba1214c4ef8d15::errors::zero_address());
        assert!(arg6 != @0x0, 0x9added62ef3a869653ef13e754d51fb62adc9f93e2717d2e23ba1214c4ef8d15::errors::zero_address());
        assert!(arg9 == 0x9added62ef3a869653ef13e754d51fb62adc9f93e2717d2e23ba1214c4ef8d15::constants::pnl_sharing_vault_type() || arg9 == 0x9added62ef3a869653ef13e754d51fb62adc9f93e2717d2e23ba1214c4ef8d15::constants::no_pnl_sharing_vault_type(), 0x9added62ef3a869653ef13e754d51fb62adc9f93e2717d2e23ba1214c4ef8d15::errors::invalid_vault_type());
        let v3 = Vault<T0>{
            id                           : v1,
            bank                         : 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::margin_bank::get_bank_id<T0>(arg2),
            bank_account                 : v0,
            name                         : v2,
            claims_manager               : arg7,
            operator                     : arg5,
            holding_account              : arg6,
            deposit_paused               : false,
            withdraw_paused              : false,
            claims_paused                : false,
            users                        : 0x2::table::new<address, User>(arg10),
            total_locked_amount          : 0,
            coin_balance                 : 0x2::balance::zero<T0>(),
            total_amount_to_be_withdrawn : 0,
            pending_profit_amount        : 0,
            max_cap                      : arg8,
            claimed                      : 0x2::table::new<u128, bool>(arg10),
            sequence_number              : 0,
            type                         : arg9,
            version                      : 0x9added62ef3a869653ef13e754d51fb62adc9f93e2717d2e23ba1214c4ef8d15::constants::get_version(),
        };
        0x2::transfer::share_object<Vault<T0>>(v3);
        0x9added62ef3a869653ef13e754d51fb62adc9f93e2717d2e23ba1214c4ef8d15::events::emit_created_vault_event(0x2::object::uid_to_inner(&v1), v0, v2, arg8, arg5, arg6, arg7, arg9);
    }

    entry fun deposit_to_vault<T0>(arg0: &mut 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::margin_bank::BankV2<T0>, arg1: &mut 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::Sequencer, arg2: &mut Vault<T0>, arg3: &mut 0x2::coin::Coin<T0>, arg4: u64, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.version == 0x9added62ef3a869653ef13e754d51fb62adc9f93e2717d2e23ba1214c4ef8d15::constants::get_version(), 0x9added62ef3a869653ef13e754d51fb62adc9f93e2717d2e23ba1214c4ef8d15::errors::version_mismatch());
        assert!(arg2.type == 0x9added62ef3a869653ef13e754d51fb62adc9f93e2717d2e23ba1214c4ef8d15::constants::no_pnl_sharing_vault_type(), 0x9added62ef3a869653ef13e754d51fb62adc9f93e2717d2e23ba1214c4ef8d15::errors::invalid_vault_type());
        assert!(!arg2.deposit_paused, 0x9added62ef3a869653ef13e754d51fb62adc9f93e2717d2e23ba1214c4ef8d15::errors::deposit_paused());
        assert!(arg2.bank == 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::margin_bank::get_bank_id<T0>(arg0), 0x9added62ef3a869653ef13e754d51fb62adc9f93e2717d2e23ba1214c4ef8d15::errors::bluefin_bank_mismatch());
        arg2.total_locked_amount = arg2.total_locked_amount + arg4;
        assert!(arg2.total_locked_amount < arg2.max_cap, 0x9added62ef3a869653ef13e754d51fb62adc9f93e2717d2e23ba1214c4ef8d15::errors::vault_max_cap_reached());
        if (!0x2::table::contains<address, User>(&arg2.users, arg5)) {
            0x2::table::add<address, User>(&mut arg2.users, arg5, create_user());
        };
        let v0 = 0x2::table::borrow_mut<address, User>(&mut arg2.users, arg5);
        v0.amount_locked = v0.amount_locked + arg4;
        let v1 = 0x2::tx_context::sender(arg6);
        assert!(arg4 <= 0x2::coin::value<T0>(arg3), 0x9added62ef3a869653ef13e754d51fb62adc9f93e2717d2e23ba1214c4ef8d15::errors::insufficient_funds());
        let v2 = 0x2::coin::take<T0>(0x2::coin::balance_mut<T0>(arg3), arg4, arg6);
        let v3 = create_tx_hash(arg6);
        0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::margin_bank::deposit_to_bank<T0>(arg0, arg1, v3, arg2.bank_account, arg4, &mut v2, arg6);
        0x2::coin::destroy_zero<T0>(v2);
        arg2.sequence_number = arg2.sequence_number + 1;
        0x9added62ef3a869653ef13e754d51fb62adc9f93e2717d2e23ba1214c4ef8d15::events::emit_funds_deposited_event(0x2::object::uid_to_inner(&arg2.id), v1, arg5, arg4, v0.amount_locked, arg2.total_locked_amount, arg2.sequence_number);
    }

    entry fun move_profit_withdrawal_funds_to_holding_account<T0>(arg0: &mut 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::margin_bank::BankV2<T0>, arg1: &0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::vaults::VaultStore, arg2: &mut 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::Sequencer, arg3: &mut Vault<T0>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg3.version == 0x9added62ef3a869653ef13e754d51fb62adc9f93e2717d2e23ba1214c4ef8d15::constants::get_version(), 0x9added62ef3a869653ef13e754d51fb62adc9f93e2717d2e23ba1214c4ef8d15::errors::version_mismatch());
        assert!(arg3.type == 0x9added62ef3a869653ef13e754d51fb62adc9f93e2717d2e23ba1214c4ef8d15::constants::no_pnl_sharing_vault_type(), 0x9added62ef3a869653ef13e754d51fb62adc9f93e2717d2e23ba1214c4ef8d15::errors::invalid_vault_type());
        assert!(arg3.bank == 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::margin_bank::get_bank_id<T0>(arg0), 0x9added62ef3a869653ef13e754d51fb62adc9f93e2717d2e23ba1214c4ef8d15::errors::bluefin_bank_mismatch());
        assert!(arg3.pending_profit_amount >= arg4, 0x9added62ef3a869653ef13e754d51fb62adc9f93e2717d2e23ba1214c4ef8d15::errors::insufficient_funds());
        let v0 = create_tx_hash(arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::vaults::withdraw_coins_from_vault<T0>(arg0, arg2, arg1, v0, arg3.bank_account, (arg4 as u128), arg5), arg3.holding_account);
        arg3.pending_profit_amount = arg3.pending_profit_amount - arg4;
        arg3.sequence_number = arg3.sequence_number + 1;
        0x9added62ef3a869653ef13e754d51fb62adc9f93e2717d2e23ba1214c4ef8d15::events::emit_profits_moved_to_holding_account(0x2::object::uid_to_inner(&arg3.id), arg4, arg3.pending_profit_amount, arg3.sequence_number);
    }

    entry fun move_user_withdrawal_funds_to_vault<T0>(arg0: &mut 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::margin_bank::BankV2<T0>, arg1: &0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::vaults::VaultStore, arg2: &mut 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::Sequencer, arg3: &mut Vault<T0>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg3.version == 0x9added62ef3a869653ef13e754d51fb62adc9f93e2717d2e23ba1214c4ef8d15::constants::get_version(), 0x9added62ef3a869653ef13e754d51fb62adc9f93e2717d2e23ba1214c4ef8d15::errors::version_mismatch());
        assert!(arg3.type == 0x9added62ef3a869653ef13e754d51fb62adc9f93e2717d2e23ba1214c4ef8d15::constants::no_pnl_sharing_vault_type(), 0x9added62ef3a869653ef13e754d51fb62adc9f93e2717d2e23ba1214c4ef8d15::errors::invalid_vault_type());
        assert!(arg3.bank == 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::margin_bank::get_bank_id<T0>(arg0), 0x9added62ef3a869653ef13e754d51fb62adc9f93e2717d2e23ba1214c4ef8d15::errors::bluefin_bank_mismatch());
        assert!(arg3.total_amount_to_be_withdrawn >= arg4, 0x9added62ef3a869653ef13e754d51fb62adc9f93e2717d2e23ba1214c4ef8d15::errors::insufficient_funds());
        let v0 = create_tx_hash(arg5);
        0x2::coin::put<T0>(&mut arg3.coin_balance, 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::vaults::withdraw_coins_from_vault<T0>(arg0, arg2, arg1, v0, arg3.bank_account, (arg4 as u128), arg5));
        arg3.total_amount_to_be_withdrawn = arg3.total_amount_to_be_withdrawn - arg4;
        arg3.total_locked_amount = arg3.total_locked_amount - arg4;
        arg3.sequence_number = arg3.sequence_number + 1;
        0x9added62ef3a869653ef13e754d51fb62adc9f93e2717d2e23ba1214c4ef8d15::events::emit_funds_moved_to_vault_event(0x2::object::uid_to_inner(&arg3.id), arg4, arg3.total_amount_to_be_withdrawn, arg3.total_locked_amount, 0x2::balance::value<T0>(&arg3.coin_balance), arg3.sequence_number);
    }

    entry fun pause_vault<T0>(arg0: &0x9added62ef3a869653ef13e754d51fb62adc9f93e2717d2e23ba1214c4ef8d15::roles::AdminCap, arg1: &mut Vault<T0>, arg2: bool, arg3: bool, arg4: bool) {
        assert!(arg1.version == 0x9added62ef3a869653ef13e754d51fb62adc9f93e2717d2e23ba1214c4ef8d15::constants::get_version(), 0x9added62ef3a869653ef13e754d51fb62adc9f93e2717d2e23ba1214c4ef8d15::errors::version_mismatch());
        arg1.deposit_paused = arg2;
        arg1.withdraw_paused = arg3;
        arg1.claims_paused = arg4;
        0x9added62ef3a869653ef13e754d51fb62adc9f93e2717d2e23ba1214c4ef8d15::events::emit_vault_pause_update_event(0x2::object::uid_to_inner(&arg1.id), arg2, arg3, arg4);
    }

    entry fun request_profit_withdraw_from_vault<T0>(arg0: &0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::margin_bank::BankV2<T0>, arg1: &mut Vault<T0>, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1.version == 0x9added62ef3a869653ef13e754d51fb62adc9f93e2717d2e23ba1214c4ef8d15::constants::get_version(), 0x9added62ef3a869653ef13e754d51fb62adc9f93e2717d2e23ba1214c4ef8d15::errors::version_mismatch());
        assert!(arg1.type == 0x9added62ef3a869653ef13e754d51fb62adc9f93e2717d2e23ba1214c4ef8d15::constants::no_pnl_sharing_vault_type(), 0x9added62ef3a869653ef13e754d51fb62adc9f93e2717d2e23ba1214c4ef8d15::errors::invalid_vault_type());
        assert!(arg1.bank == 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::margin_bank::get_bank_id<T0>(arg0), 0x9added62ef3a869653ef13e754d51fb62adc9f93e2717d2e23ba1214c4ef8d15::errors::bluefin_bank_mismatch());
        assert!(0x2::tx_context::sender(arg3) == arg1.holding_account, 0x9added62ef3a869653ef13e754d51fb62adc9f93e2717d2e23ba1214c4ef8d15::errors::holding_account_mismatch());
        assert!(arg2 <= 0x9added62ef3a869653ef13e754d51fb62adc9f93e2717d2e23ba1214c4ef8d15::utils::convert_to_usdc_base(0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::margin_bank::get_balance_v2<T0>(arg0, arg1.bank_account)) - arg1.total_locked_amount, 0x9added62ef3a869653ef13e754d51fb62adc9f93e2717d2e23ba1214c4ef8d15::errors::insufficient_funds());
        arg1.pending_profit_amount = arg1.pending_profit_amount + arg2;
        arg1.sequence_number = arg1.sequence_number + 1;
        0x9added62ef3a869653ef13e754d51fb62adc9f93e2717d2e23ba1214c4ef8d15::events::emit_profit_withdraw_request(0x2::object::uid_to_inner(&arg1.id), arg2, arg1.pending_profit_amount, arg1.sequence_number);
    }

    entry fun request_withdraw_from_vault<T0>(arg0: &mut Vault<T0>, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.version == 0x9added62ef3a869653ef13e754d51fb62adc9f93e2717d2e23ba1214c4ef8d15::constants::get_version(), 0x9added62ef3a869653ef13e754d51fb62adc9f93e2717d2e23ba1214c4ef8d15::errors::version_mismatch());
        assert!(arg0.type == 0x9added62ef3a869653ef13e754d51fb62adc9f93e2717d2e23ba1214c4ef8d15::constants::no_pnl_sharing_vault_type(), 0x9added62ef3a869653ef13e754d51fb62adc9f93e2717d2e23ba1214c4ef8d15::errors::invalid_vault_type());
        assert!(!arg0.withdraw_paused, 0x9added62ef3a869653ef13e754d51fb62adc9f93e2717d2e23ba1214c4ef8d15::errors::withdraw_paused());
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<address, User>(&arg0.users, v0), 0x9added62ef3a869653ef13e754d51fb62adc9f93e2717d2e23ba1214c4ef8d15::errors::insufficient_funds());
        let v1 = 0x2::table::borrow_mut<address, User>(&mut arg0.users, v0);
        assert!(v1.amount_locked >= arg1, 0x9added62ef3a869653ef13e754d51fb62adc9f93e2717d2e23ba1214c4ef8d15::errors::insufficient_funds());
        v1.amount_locked = v1.amount_locked - arg1;
        v1.pending_withdrawal = v1.pending_withdrawal + arg1;
        arg0.total_amount_to_be_withdrawn = arg0.total_amount_to_be_withdrawn + arg1;
        arg0.sequence_number = arg0.sequence_number + 1;
        0x9added62ef3a869653ef13e754d51fb62adc9f93e2717d2e23ba1214c4ef8d15::events::emit_funds_withdrawn_event(0x2::object::uid_to_inner(&arg0.id), v0, arg1, v1.pending_withdrawal, v1.amount_locked, arg0.total_amount_to_be_withdrawn, arg0.sequence_number);
    }

    entry fun update_vault_claims_manager_account<T0>(arg0: &0x9added62ef3a869653ef13e754d51fb62adc9f93e2717d2e23ba1214c4ef8d15::roles::AdminCap, arg1: &mut Vault<T0>, arg2: address) {
        assert!(arg1.version == 0x9added62ef3a869653ef13e754d51fb62adc9f93e2717d2e23ba1214c4ef8d15::constants::get_version(), 0x9added62ef3a869653ef13e754d51fb62adc9f93e2717d2e23ba1214c4ef8d15::errors::version_mismatch());
        assert!(arg2 != @0x0, 0x9added62ef3a869653ef13e754d51fb62adc9f93e2717d2e23ba1214c4ef8d15::errors::zero_address());
        arg1.claims_manager = arg2;
        0x9added62ef3a869653ef13e754d51fb62adc9f93e2717d2e23ba1214c4ef8d15::events::emit_vault_claims_manager_update_event(0x2::object::uid_to_inner(&arg1.id), arg2);
    }

    entry fun update_vault_holding_account<T0>(arg0: &0x9added62ef3a869653ef13e754d51fb62adc9f93e2717d2e23ba1214c4ef8d15::roles::AdminCap, arg1: &mut Vault<T0>, arg2: address) {
        assert!(arg1.version == 0x9added62ef3a869653ef13e754d51fb62adc9f93e2717d2e23ba1214c4ef8d15::constants::get_version(), 0x9added62ef3a869653ef13e754d51fb62adc9f93e2717d2e23ba1214c4ef8d15::errors::version_mismatch());
        assert!(arg2 != @0x0, 0x9added62ef3a869653ef13e754d51fb62adc9f93e2717d2e23ba1214c4ef8d15::errors::zero_address());
        arg1.holding_account = arg2;
        0x9added62ef3a869653ef13e754d51fb62adc9f93e2717d2e23ba1214c4ef8d15::events::emit_vault_holding_account_update_event(0x2::object::uid_to_inner(&arg1.id), arg2);
    }

    entry fun update_vault_max_cap<T0>(arg0: &0x9added62ef3a869653ef13e754d51fb62adc9f93e2717d2e23ba1214c4ef8d15::roles::AdminCap, arg1: &mut Vault<T0>, arg2: u64) {
        assert!(arg1.version == 0x9added62ef3a869653ef13e754d51fb62adc9f93e2717d2e23ba1214c4ef8d15::constants::get_version(), 0x9added62ef3a869653ef13e754d51fb62adc9f93e2717d2e23ba1214c4ef8d15::errors::version_mismatch());
        arg1.max_cap = arg2;
        0x9added62ef3a869653ef13e754d51fb62adc9f93e2717d2e23ba1214c4ef8d15::events::emit_vault_max_cap_updated(0x2::object::uid_to_inner(&arg1.id), arg2);
    }

    entry fun update_vault_operator<T0>(arg0: &0x9added62ef3a869653ef13e754d51fb62adc9f93e2717d2e23ba1214c4ef8d15::roles::AdminCap, arg1: &mut Vault<T0>, arg2: &mut 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::SubAccountsV2, arg3: &mut 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::vaults::VaultStore, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 0x9added62ef3a869653ef13e754d51fb62adc9f93e2717d2e23ba1214c4ef8d15::constants::get_version(), 0x9added62ef3a869653ef13e754d51fb62adc9f93e2717d2e23ba1214c4ef8d15::errors::version_mismatch());
        0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::vaults::set_vault_sub_account(arg2, arg3, arg1.bank_account, arg1.operator, false, arg5);
        arg1.operator = arg4;
        0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::vaults::set_vault_sub_account(arg2, arg3, arg1.bank_account, arg1.operator, true, arg5);
        0x9added62ef3a869653ef13e754d51fb62adc9f93e2717d2e23ba1214c4ef8d15::events::emit_vault_operator_update_event(0x2::object::uid_to_inner(&arg1.id), arg4);
    }

    entry fun update_version_for_vault<T0>(arg0: &0x9added62ef3a869653ef13e754d51fb62adc9f93e2717d2e23ba1214c4ef8d15::roles::AdminCap, arg1: &mut Vault<T0>) {
        arg1.version = arg1.version + 1;
    }

    // decompiled from Move bytecode v6
}

