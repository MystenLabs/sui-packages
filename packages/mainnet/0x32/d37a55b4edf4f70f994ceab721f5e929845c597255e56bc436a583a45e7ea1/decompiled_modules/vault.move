module 0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::vault {
    struct SponsorVault has key {
        id: 0x2::object::UID,
        owner_account_id: 0x2::object::ID,
        vault_balance: u64,
        total_shares: u64,
        sponsors: 0x2::table::Table<address, SponsorContribution>,
        sponsor_addresses: vector<address>,
        total_contributions: u64,
        lifetime_deposits: u64,
        lifetime_used: u64,
        lifetime_won: u64,
        lifetime_lost: u64,
        vault_funded_wins: u64,
        vault_funded_losses: u64,
        last_used_at: u64,
        pending_sponsor_withdrawals: 0x2::table::Table<address, SponsorWithdrawalRequest>,
        created_at: u64,
        updated_at: u64,
    }

    struct SponsorContribution has drop, store {
        sponsor_address: address,
        shares: u64,
        amount_contributed: u64,
        contribution_timestamp: u64,
        last_used_timestamp: u64,
    }

    struct SponsorWithdrawalRequest has drop, store {
        sponsor_address: address,
        requested_at: u64,
        executable_at: u64,
    }

    struct SponsorPosition has key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
        original_sponsor: address,
        shares: u64,
        amount_contributed: u64,
        funding_source: 0x1::string::String,
        created_at: u64,
        last_deposit_at: u64,
    }

    struct VaultCreated has copy, drop {
        vault_id: 0x2::object::ID,
        owner_account_id: 0x2::object::ID,
        created_at: u64,
    }

    struct SponsorDeposit has copy, drop {
        vault_id: 0x2::object::ID,
        sponsor_account_id: 0x2::object::ID,
        sponsor: address,
        amount: u64,
        shares_issued: u64,
        share_price: u64,
        new_vault_balance: u64,
        new_total_shares: u64,
        timestamp: u64,
    }

    struct VaultFundsUsed has copy, drop {
        vault_id: 0x2::object::ID,
        amount: u64,
        usage_type: 0x1::string::String,
        new_vault_balance: u64,
        timestamp: u64,
    }

    struct WinningsDistributed has copy, drop {
        vault_id: 0x2::object::ID,
        stake: u64,
        prize: u64,
        profit: u64,
        sponsors_share: u64,
        new_vault_balance: u64,
        timestamp: u64,
    }

    struct LossRecorded has copy, drop {
        vault_id: 0x2::object::ID,
        amount_lost: u64,
        timestamp: u64,
    }

    struct FundsReturnedToVault has copy, drop {
        vault_id: 0x2::object::ID,
        amount: u64,
        new_vault_balance: u64,
        timestamp: u64,
    }

    struct SponsorRecall has copy, drop {
        vault_id: 0x2::object::ID,
        sponsor: address,
        amount: u64,
        timestamp: u64,
    }

    struct SponsorWithdrawalRequested has copy, drop {
        vault_id: 0x2::object::ID,
        sponsor: address,
        proportional_share: u64,
        executable_at: u64,
        timestamp: u64,
    }

    struct SponsorWithdrawal has copy, drop {
        vault_id: 0x2::object::ID,
        sponsor: address,
        amount: u64,
        timestamp: u64,
    }

    struct SponsorPositionCreated has copy, drop {
        position_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        sponsor: address,
        amount: u64,
        shares: u64,
        funding_source: 0x1::string::String,
        timestamp: u64,
    }

    struct SponsorPositionBurned has copy, drop {
        position_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        original_sponsor: address,
        withdrawn_by: address,
        shares_burned: u64,
        amount_contributed: u64,
        amount_withdrawn: u64,
        timestamp: u64,
    }

    struct SponsorContributionUpdated has copy, drop {
        vault_id: 0x2::object::ID,
        sponsor: address,
        new_shares: u64,
        new_amount_contributed: u64,
        timestamp: u64,
    }

    public fun id(arg0: &SponsorVault) : 0x2::object::ID {
        0x2::object::id<SponsorVault>(arg0)
    }

    fun calculate_share_value(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg1 == 0 && arg2 == 0 || arg1 > 0 && arg2 > 0, 12);
        if (arg1 == 0) {
            0
        } else {
            arg0 * arg2 / arg1
        }
    }

    public fun can_recall_immediately(arg0: &SponsorVault, arg1: address, arg2: &0x2::tx_context::TxContext) : bool {
        if (!0x2::table::contains<address, SponsorContribution>(&arg0.sponsors, arg1)) {
            return false
        };
        let v0 = 0x2::table::borrow<address, SponsorContribution>(&arg0.sponsors, arg1);
        v0.last_used_timestamp == 0 && 0x2::tx_context::epoch_timestamp_ms(arg2) - v0.contribution_timestamp <= 604800000 || 0x2::tx_context::epoch_timestamp_ms(arg2) - v0.last_used_timestamp <= 604800000
    }

    public fun create_vault(arg0: &mut 0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::Account, arg1: &0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::AccountAuth, arg2: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::verify_auth(arg0, arg1);
        let v0 = 0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::sponsor_vault_id(arg0);
        assert!(0x1::option::is_none<0x2::object::ID>(&v0), 8);
        let v1 = 0x2::tx_context::epoch_timestamp_ms(arg2);
        let v2 = SponsorVault{
            id                          : 0x2::object::new(arg2),
            owner_account_id            : 0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::id(arg0),
            vault_balance               : 0,
            total_shares                : 0,
            sponsors                    : 0x2::table::new<address, SponsorContribution>(arg2),
            sponsor_addresses           : vector[],
            total_contributions         : 0,
            lifetime_deposits           : 0,
            lifetime_used               : 0,
            lifetime_won                : 0,
            lifetime_lost               : 0,
            vault_funded_wins           : 0,
            vault_funded_losses         : 0,
            last_used_at                : 0,
            pending_sponsor_withdrawals : 0x2::table::new<address, SponsorWithdrawalRequest>(arg2),
            created_at                  : v1,
            updated_at                  : v1,
        };
        let v3 = 0x2::object::id<SponsorVault>(&v2);
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::set_sponsor_vault(arg0, v3, arg2);
        let v4 = VaultCreated{
            vault_id         : v3,
            owner_account_id : 0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::id(arg0),
            created_at       : v1,
        };
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::events::emit_event<VaultCreated>(v4);
        0x2::transfer::share_object<SponsorVault>(v2);
        v3
    }

    public(friend) fun distribute_winnings(arg0: &mut SponsorVault, arg1: u64, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch_timestamp_ms(arg3);
        let v1 = if (arg2 > arg1) {
            arg2 - arg1
        } else {
            0
        };
        arg0.vault_balance = arg0.vault_balance + arg2;
        arg0.lifetime_won = arg0.lifetime_won + arg2;
        arg0.vault_funded_wins = arg0.vault_funded_wins + 1;
        arg0.updated_at = v0;
        let v2 = WinningsDistributed{
            vault_id          : 0x2::object::id<SponsorVault>(arg0),
            stake             : arg1,
            prize             : arg2,
            profit            : v1,
            sponsors_share    : v1,
            new_vault_balance : arg0.vault_balance,
            timestamp         : v0,
        };
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::events::emit_event<WinningsDistributed>(v2);
    }

    public fun has_pending_sponsor_withdrawal(arg0: &SponsorVault, arg1: address) : bool {
        0x2::table::contains<address, SponsorWithdrawalRequest>(&arg0.pending_sponsor_withdrawals, arg1)
    }

    public fun owner_account_id(arg0: &SponsorVault) : 0x2::object::ID {
        arg0.owner_account_id
    }

    public fun player_share_bps() : u64 {
        5000
    }

    public fun position_amount(arg0: &SponsorPosition) : u64 {
        arg0.amount_contributed
    }

    public fun position_current_value(arg0: &SponsorVault, arg1: &SponsorPosition) : u64 {
        assert!(arg1.vault_id == 0x2::object::id<SponsorVault>(arg0), 9);
        calculate_share_value(arg1.shares, arg0.total_shares, arg0.vault_balance)
    }

    public fun position_info(arg0: &SponsorPosition) : (0x2::object::ID, address, u64, u64, 0x1::string::String, u64) {
        (arg0.vault_id, arg0.original_sponsor, arg0.shares, arg0.amount_contributed, arg0.funding_source, arg0.created_at)
    }

    public fun position_original_sponsor(arg0: &SponsorPosition) : address {
        arg0.original_sponsor
    }

    public fun position_pnl_bps(arg0: &SponsorVault, arg1: &SponsorPosition) : (bool, u64) {
        let v0 = position_current_value(arg0, arg1);
        let v1 = arg1.amount_contributed;
        if (v0 > v1) {
            (true, (v0 - v1) * 10000 / v1)
        } else if (v0 < v1) {
            (false, (v1 - v0) * 10000 / v1)
        } else {
            (true, 0)
        }
    }

    public fun position_shares(arg0: &SponsorPosition) : u64 {
        arg0.shares
    }

    public fun position_vault_id(arg0: &SponsorPosition) : 0x2::object::ID {
        arg0.vault_id
    }

    fun process_vault_deposit_internal(arg0: &mut SponsorVault, arg1: address, arg2: 0x2::object::ID, arg3: u64, arg4: 0x1::string::String, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : SponsorPosition {
        let v0 = if (arg0.total_shares == 0 && arg0.vault_balance == 0) {
            assert!(arg3 >= 1000, 11);
            arg0.total_shares = 1000000;
            arg3
        } else {
            if (arg0.total_shares == 0 || arg0.vault_balance == 0) {
                abort 12
            };
            arg3 * arg0.total_shares / arg0.vault_balance
        };
        let v1 = if (arg0.total_shares == 0) {
            1000000
        } else {
            arg0.vault_balance * 1000000 / arg0.total_shares
        };
        assert!(v0 > 0, 6);
        arg0.vault_balance = arg0.vault_balance + arg3;
        arg0.total_shares = arg0.total_shares + v0;
        if (0x2::table::contains<address, SponsorContribution>(&arg0.sponsors, arg1)) {
            let v2 = 0x2::table::borrow_mut<address, SponsorContribution>(&mut arg0.sponsors, arg1);
            v2.shares = v2.shares + v0;
            v2.amount_contributed = v2.amount_contributed + arg3;
        } else {
            let v3 = SponsorContribution{
                sponsor_address        : arg1,
                shares                 : v0,
                amount_contributed     : arg3,
                contribution_timestamp : arg5,
                last_used_timestamp    : 0,
            };
            0x2::table::add<address, SponsorContribution>(&mut arg0.sponsors, arg1, v3);
            0x1::vector::push_back<address>(&mut arg0.sponsor_addresses, arg1);
        };
        let v4 = 0x2::table::borrow<address, SponsorContribution>(&arg0.sponsors, arg1);
        let v5 = SponsorContributionUpdated{
            vault_id               : 0x2::object::id<SponsorVault>(arg0),
            sponsor                : arg1,
            new_shares             : v4.shares,
            new_amount_contributed : v4.amount_contributed,
            timestamp              : arg5,
        };
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::events::emit_event<SponsorContributionUpdated>(v5);
        arg0.total_contributions = arg0.total_contributions + arg3;
        arg0.lifetime_deposits = arg0.lifetime_deposits + arg3;
        arg0.updated_at = arg5;
        let v6 = SponsorPosition{
            id                 : 0x2::object::new(arg6),
            vault_id           : 0x2::object::id<SponsorVault>(arg0),
            original_sponsor   : arg1,
            shares             : v0,
            amount_contributed : arg3,
            funding_source     : arg4,
            created_at         : arg5,
            last_deposit_at    : arg5,
        };
        let v7 = SponsorDeposit{
            vault_id           : 0x2::object::id<SponsorVault>(arg0),
            sponsor_account_id : arg2,
            sponsor            : arg1,
            amount             : arg3,
            shares_issued      : v0,
            share_price        : v1,
            new_vault_balance  : arg0.vault_balance,
            new_total_shares   : arg0.total_shares,
            timestamp          : arg5,
        };
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::events::emit_event<SponsorDeposit>(v7);
        let v8 = SponsorPositionCreated{
            position_id    : 0x2::object::id<SponsorPosition>(&v6),
            vault_id       : 0x2::object::id<SponsorVault>(arg0),
            sponsor        : arg1,
            amount         : arg3,
            shares         : v0,
            funding_source : arg4,
            timestamp      : arg5,
        };
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::events::emit_event<SponsorPositionCreated>(v8);
        v6
    }

    public(friend) fun record_loss(arg0: &mut SponsorVault, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 6);
        let v0 = 0x2::tx_context::epoch_timestamp_ms(arg2);
        arg0.lifetime_lost = arg0.lifetime_lost + arg1;
        arg0.vault_funded_losses = arg0.vault_funded_losses + 1;
        arg0.updated_at = v0;
        let v1 = LossRecorded{
            vault_id    : 0x2::object::id<SponsorVault>(arg0),
            amount_lost : arg1,
            timestamp   : v0,
        };
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::events::emit_event<LossRecorded>(v1);
    }

    public(friend) fun return_to_vault(arg0: &mut SponsorVault, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch_timestamp_ms(arg2);
        arg0.vault_balance = arg0.vault_balance + arg1;
        arg0.updated_at = v0;
        let v1 = FundsReturnedToVault{
            vault_id          : 0x2::object::id<SponsorVault>(arg0),
            amount            : arg1,
            new_vault_balance : arg0.vault_balance,
            timestamp         : v0,
        };
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::events::emit_event<FundsReturnedToVault>(v1);
    }

    public fun share_price(arg0: &SponsorVault) : u64 {
        if (arg0.total_shares == 0) {
            1000000
        } else {
            arg0.vault_balance * 1000000 / arg0.total_shares
        }
    }

    public fun sponsor_contribution(arg0: &SponsorVault, arg1: address) : u64 {
        if (0x2::table::contains<address, SponsorContribution>(&arg0.sponsors, arg1)) {
            0x2::table::borrow<address, SponsorContribution>(&arg0.sponsors, arg1).amount_contributed
        } else {
            0
        }
    }

    public fun sponsor_count(arg0: &SponsorVault) : u64 {
        0x1::vector::length<address>(&arg0.sponsor_addresses)
    }

    public fun sponsor_current_share(arg0: &SponsorVault, arg1: address) : u64 {
        calculate_share_value(sponsor_shares(arg0, arg1), arg0.total_shares, arg0.vault_balance)
    }

    public fun sponsor_deposit(arg0: &0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::zenko::ZenkoRegistry, arg1: &0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::access::RoleRegistry, arg2: &mut SponsorVault, arg3: &mut 0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::Account, arg4: &0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::AccountAuth, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::zenko::assert_not_paused(arg0);
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::verify_auth(arg3, arg4);
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::access::assert_not_blacklisted(arg1, 0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::owner_address(arg3));
        assert!(arg2.owner_account_id != 0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::id(arg3), 10);
        assert!(arg5 > 0, 6);
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::spend_purchased_credits_only(arg3, arg5, 0x1::string::utf8(b"vault_deposit"), arg6);
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::tx_context::epoch_timestamp_ms(arg6);
        0x2::transfer::transfer<SponsorPosition>(process_vault_deposit_internal(arg2, v0, 0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::id(arg3), arg5, 0x1::string::utf8(b"purchased"), v1, arg6), v0);
    }

    public fun sponsor_deposit_with_purchased_credits(arg0: &0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::zenko::ZenkoRegistry, arg1: &0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::access::RoleRegistry, arg2: &mut SponsorVault, arg3: &mut 0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::Account, arg4: &0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::AccountAuth, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::zenko::assert_not_paused(arg0);
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::verify_auth(arg3, arg4);
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::access::assert_not_blacklisted(arg1, 0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::owner_address(arg3));
        assert!(arg2.owner_account_id != 0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::id(arg3), 10);
        assert!(arg5 > 0, 6);
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::spend_purchased_credits_only(arg3, arg5, 0x1::string::utf8(b"vault_sponsorship"), arg6);
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::tx_context::epoch_timestamp_ms(arg6);
        0x2::transfer::transfer<SponsorPosition>(process_vault_deposit_internal(arg2, v0, 0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::id(arg3), arg5, 0x1::string::utf8(b"purchased"), v1, arg6), v0);
    }

    public fun sponsor_deposit_with_tokens(arg0: &0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::zenko::ZenkoRegistry, arg1: &0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::access::RoleRegistry, arg2: &mut SponsorVault, arg3: &0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::Account, arg4: &0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::AccountAuth, arg5: &mut 0x2::token::TokenPolicy<0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::zenko_credits::ZENKO_CREDITS>, arg6: 0x2::token::Token<0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::zenko_credits::ZENKO_CREDITS>, arg7: &mut 0x2::tx_context::TxContext) {
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::zenko::assert_not_paused(arg0);
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::verify_auth(arg3, arg4);
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::access::assert_not_blacklisted(arg1, 0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::owner_address(arg3));
        assert!(arg2.owner_account_id != 0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::id(arg3), 10);
        let v0 = 0x2::token::value<0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::zenko_credits::ZENKO_CREDITS>(&arg6);
        assert!(v0 > 0, 6);
        let (_, _, _, _) = 0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::zenko_credits::confirm_spend_for_vault(arg5, 0x2::token::spend<0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::zenko_credits::ZENKO_CREDITS>(arg6, arg7), arg7);
        let v5 = 0x2::tx_context::sender(arg7);
        let v6 = 0x2::tx_context::epoch_timestamp_ms(arg7);
        0x2::transfer::transfer<SponsorPosition>(process_vault_deposit_internal(arg2, v5, 0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::id(arg3), v0, 0x1::string::utf8(b"earned"), v6, arg7), v5);
    }

    public fun sponsor_deposit_with_usdsui(arg0: &0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::zenko::ZenkoRegistry, arg1: &0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::access::RoleRegistry, arg2: &mut SponsorVault, arg3: &0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::Account, arg4: &0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::AccountAuth, arg5: &mut 0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::zenko_credits::CreditsStore, arg6: 0x2::coin::Coin<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>, arg7: &mut 0x2::tx_context::TxContext) {
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::zenko::assert_not_paused(arg0);
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::verify_auth(arg3, arg4);
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::access::assert_not_blacklisted(arg1, 0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::owner_address(arg3));
        assert!(arg2.owner_account_id != 0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::id(arg3), 10);
        let v0 = 0x2::coin::value<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(&arg6);
        assert!(v0 > 0, 6);
        let v1 = v0 * 0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::config::credits_per_usdsui() / 1000000;
        let v2 = if (v1 == 0) {
            1
        } else {
            v1
        };
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::zenko_credits::add_sponsor_liquidity(arg5, arg6, arg7);
        let v3 = 0x2::tx_context::sender(arg7);
        let v4 = 0x2::tx_context::epoch_timestamp_ms(arg7);
        0x2::transfer::transfer<SponsorPosition>(process_vault_deposit_internal(arg2, v3, 0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::id(arg3), v2, 0x1::string::utf8(b"usdsui"), v4, arg7), v3);
    }

    public fun sponsor_execute_withdrawal(arg0: &mut SponsorVault, arg1: &mut 0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::zenko_credits::CreditsStore, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::tx_context::epoch_timestamp_ms(arg2);
        assert!(0x2::table::contains<address, SponsorWithdrawalRequest>(&arg0.pending_sponsor_withdrawals, v0), 3);
        assert!(v1 >= 0x2::table::borrow<address, SponsorWithdrawalRequest>(&arg0.pending_sponsor_withdrawals, v0).executable_at, 4);
        let v2 = 0x2::table::borrow<address, SponsorContribution>(&arg0.sponsors, v0);
        let v3 = v2.shares;
        let v4 = calculate_share_value(v2.shares, arg0.total_shares, arg0.vault_balance);
        assert!(v4 <= arg0.vault_balance, 1);
        arg0.vault_balance = arg0.vault_balance - v4;
        arg0.total_shares = arg0.total_shares - v3;
        if (arg0.vault_balance == 0) {
            arg0.total_shares = 0;
        };
        if (v4 > 0) {
            0x2::token::keep<0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::zenko_credits::ZENKO_CREDITS>(0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::zenko_credits::mint_earnings(arg1, v4, 0x1::string::utf8(b"vault_sponsor_withdrawal"), arg2), arg2);
        };
        arg0.total_contributions = arg0.total_contributions - 0x2::table::borrow<address, SponsorContribution>(&arg0.sponsors, v0).amount_contributed;
        0x2::table::remove<address, SponsorContribution>(&mut arg0.sponsors, v0);
        0x2::table::remove<address, SponsorWithdrawalRequest>(&mut arg0.pending_sponsor_withdrawals, v0);
        let (v5, v6) = 0x1::vector::index_of<address>(&arg0.sponsor_addresses, &v0);
        if (v5) {
            0x1::vector::remove<address>(&mut arg0.sponsor_addresses, v6);
        };
        arg0.updated_at = v1;
        let v7 = SponsorWithdrawal{
            vault_id  : 0x2::object::id<SponsorVault>(arg0),
            sponsor   : v0,
            amount    : v4,
            timestamp : v1,
        };
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::events::emit_event<SponsorWithdrawal>(v7);
    }

    public fun sponsor_ownership_bps(arg0: &SponsorVault, arg1: address) : u64 {
        if (arg0.total_shares == 0) {
            return 0
        };
        sponsor_shares(arg0, arg1) * 10000 / arg0.total_shares
    }

    public fun sponsor_recall_unused(arg0: &0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::zenko::ZenkoRegistry, arg1: &mut SponsorVault, arg2: &mut 0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::Account, arg3: &0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::AccountAuth, arg4: &mut 0x2::tx_context::TxContext) {
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::zenko::assert_not_paused(arg0);
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::verify_auth(arg2, arg3);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::tx_context::epoch_timestamp_ms(arg4);
        assert!(0x2::table::contains<address, SponsorContribution>(&arg1.sponsors, v0), 5);
        let v2 = 0x2::table::borrow<address, SponsorContribution>(&arg1.sponsors, v0);
        assert!(v2.last_used_timestamp == 0 && v1 - v2.contribution_timestamp <= 604800000 || v1 - v2.last_used_timestamp <= 604800000, 7);
        let v3 = v2.amount_contributed;
        assert!(v3 <= arg1.vault_balance, 1);
        arg1.vault_balance = arg1.vault_balance - v3;
        arg1.total_shares = arg1.total_shares - v2.shares;
        if (arg1.vault_balance == 0) {
            arg1.total_shares = 0;
        };
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::return_purchased_credits(arg2, v3, 0x1::string::utf8(b"vault_recall"), arg4);
        arg1.total_contributions = arg1.total_contributions - v3;
        0x2::table::remove<address, SponsorContribution>(&mut arg1.sponsors, v0);
        let (v4, v5) = 0x1::vector::index_of<address>(&arg1.sponsor_addresses, &v0);
        if (v4) {
            0x1::vector::remove<address>(&mut arg1.sponsor_addresses, v5);
        };
        arg1.updated_at = v1;
        let v6 = SponsorRecall{
            vault_id  : 0x2::object::id<SponsorVault>(arg1),
            sponsor   : v0,
            amount    : v3,
            timestamp : v1,
        };
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::events::emit_event<SponsorRecall>(v6);
    }

    public fun sponsor_request_withdrawal(arg0: &mut SponsorVault, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x2::tx_context::epoch_timestamp_ms(arg1);
        assert!(0x2::table::contains<address, SponsorContribution>(&arg0.sponsors, v0), 5);
        let v2 = v1 + 86400000;
        if (0x2::table::contains<address, SponsorWithdrawalRequest>(&arg0.pending_sponsor_withdrawals, v0)) {
            let v3 = 0x2::table::borrow_mut<address, SponsorWithdrawalRequest>(&mut arg0.pending_sponsor_withdrawals, v0);
            v3.requested_at = v1;
            v3.executable_at = v2;
        } else {
            let v4 = SponsorWithdrawalRequest{
                sponsor_address : v0,
                requested_at    : v1,
                executable_at   : v2,
            };
            0x2::table::add<address, SponsorWithdrawalRequest>(&mut arg0.pending_sponsor_withdrawals, v0, v4);
        };
        arg0.updated_at = v1;
        let v5 = SponsorWithdrawalRequested{
            vault_id           : 0x2::object::id<SponsorVault>(arg0),
            sponsor            : v0,
            proportional_share : calculate_share_value(0x2::table::borrow<address, SponsorContribution>(&arg0.sponsors, v0).shares, arg0.total_shares, arg0.vault_balance),
            executable_at      : v2,
            timestamp          : v1,
        };
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::events::emit_event<SponsorWithdrawalRequested>(v5);
    }

    public fun sponsor_shares(arg0: &SponsorVault, arg1: address) : u64 {
        if (0x2::table::contains<address, SponsorContribution>(&arg0.sponsors, arg1)) {
            0x2::table::borrow<address, SponsorContribution>(&arg0.sponsors, arg1).shares
        } else {
            0
        }
    }

    public fun sponsor_withdraw_with_position(arg0: &mut SponsorVault, arg1: SponsorPosition, arg2: &mut 0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::zenko_credits::CreditsStore, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch_timestamp_ms(arg3);
        let v1 = 0x2::tx_context::sender(arg3);
        assert!(arg1.vault_id == 0x2::object::id<SponsorVault>(arg0), 9);
        assert!(v0 >= arg1.last_deposit_at + 86400000, 4);
        let v2 = arg1.original_sponsor;
        let v3 = arg1.shares;
        let v4 = calculate_share_value(arg1.shares, arg0.total_shares, arg0.vault_balance);
        assert!(v4 <= arg0.vault_balance, 1);
        arg0.vault_balance = arg0.vault_balance - v4;
        arg0.total_shares = arg0.total_shares - v3;
        arg0.total_contributions = arg0.total_contributions - arg1.amount_contributed;
        if (arg0.vault_balance == 0) {
            arg0.total_shares = 0;
        };
        if (0x2::table::contains<address, SponsorContribution>(&arg0.sponsors, v2)) {
            let v5 = 0x2::table::borrow_mut<address, SponsorContribution>(&mut arg0.sponsors, v2);
            if (v5.shares >= arg1.shares) {
                v5.shares = v5.shares - arg1.shares;
            } else {
                v5.shares = 0;
            };
            if (v5.amount_contributed >= arg1.amount_contributed) {
                v5.amount_contributed = v5.amount_contributed - arg1.amount_contributed;
            } else {
                v5.amount_contributed = 0;
            };
            if (v5.shares == 0) {
                0x2::table::remove<address, SponsorContribution>(&mut arg0.sponsors, v2);
                let (v6, v7) = 0x1::vector::index_of<address>(&arg0.sponsor_addresses, &v2);
                if (v6) {
                    0x1::vector::remove<address>(&mut arg0.sponsor_addresses, v7);
                };
            };
        };
        let SponsorPosition {
            id                 : v8,
            vault_id           : _,
            original_sponsor   : _,
            shares             : _,
            amount_contributed : _,
            funding_source     : _,
            created_at         : _,
            last_deposit_at    : _,
        } = arg1;
        0x2::object::delete(v8);
        if (v4 > 0) {
            0x2::token::keep<0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::zenko_credits::ZENKO_CREDITS>(0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::zenko_credits::mint_earnings(arg2, v4, 0x1::string::utf8(b"vault_position_withdrawal"), arg3), arg3);
        };
        arg0.updated_at = v0;
        let v16 = SponsorPositionBurned{
            position_id        : 0x2::object::id<SponsorPosition>(&arg1),
            vault_id           : 0x2::object::id<SponsorVault>(arg0),
            original_sponsor   : v2,
            withdrawn_by       : v1,
            shares_burned      : v3,
            amount_contributed : arg1.amount_contributed,
            amount_withdrawn   : v4,
            timestamp          : v0,
        };
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::events::emit_event<SponsorPositionBurned>(v16);
        let v17 = SponsorWithdrawal{
            vault_id  : 0x2::object::id<SponsorVault>(arg0),
            sponsor   : v1,
            amount    : v4,
            timestamp : v0,
        };
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::events::emit_event<SponsorWithdrawal>(v17);
    }

    public fun total_contributions(arg0: &SponsorVault) : u64 {
        arg0.total_contributions
    }

    public fun total_shares(arg0: &SponsorVault) : u64 {
        arg0.total_shares
    }

    public(friend) fun use_vault_for_entry(arg0: &mut SponsorVault, arg1: &0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::Account, arg2: &0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::AccountAuth, arg3: u64, arg4: 0x1::string::String, arg5: &0x2::tx_context::TxContext) : u64 {
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::verify_auth(arg1, arg2);
        use_vault_internal(arg0, arg1, arg3, arg4, 0x2::tx_context::epoch_timestamp_ms(arg5), arg5)
    }

    public(friend) fun use_vault_for_oracle_entry(arg0: &mut SponsorVault, arg1: &0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::Account, arg2: u64, arg3: 0x1::string::String, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) : u64 {
        use_vault_internal(arg0, arg1, arg2, arg3, 0x2::clock::timestamp_ms(arg4), arg5)
    }

    fun use_vault_internal(arg0: &mut SponsorVault, arg1: &0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::Account, arg2: u64, arg3: 0x1::string::String, arg4: u64, arg5: &0x2::tx_context::TxContext) : u64 {
        assert!(arg0.owner_account_id == 0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::id(arg1), 0);
        assert!(arg2 > 0, 6);
        assert!(arg2 <= arg0.vault_balance, 1);
        arg0.vault_balance = arg0.vault_balance - arg2;
        arg0.lifetime_used = arg0.lifetime_used + arg2;
        arg0.last_used_at = arg4;
        arg0.updated_at = arg4;
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg0.sponsor_addresses)) {
            0x2::table::borrow_mut<address, SponsorContribution>(&mut arg0.sponsors, *0x1::vector::borrow<address>(&arg0.sponsor_addresses, v0)).last_used_timestamp = arg4;
            v0 = v0 + 1;
        };
        let v1 = VaultFundsUsed{
            vault_id          : 0x2::object::id<SponsorVault>(arg0),
            amount            : arg2,
            usage_type        : arg3,
            new_vault_balance : arg0.vault_balance,
            timestamp         : arg4,
        };
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::events::emit_event<VaultFundsUsed>(v1);
        arg2
    }

    public fun vault_balance(arg0: &SponsorVault) : u64 {
        arg0.vault_balance
    }

    public fun vault_stats(arg0: &SponsorVault) : (u64, u64, u64, u64, u64, u64) {
        (arg0.lifetime_deposits, arg0.lifetime_used, arg0.lifetime_won, arg0.lifetime_lost, arg0.vault_funded_wins, arg0.vault_funded_losses)
    }

    // decompiled from Move bytecode v7
}

