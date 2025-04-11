module 0x136fe1254dee4a8584d07494f86bbaa96a43446fa1c95a73136fb7983710fde4::house {
    struct HOUSE has drop {
        dummy_field: bool,
    }

    struct House has key {
        id: 0x2::object::UID,
        admin_cap_id: 0x2::object::ID,
        private: bool,
        target_balance: u64,
        house_fee_bps: u64,
        referral_fee_bps: u64,
        tx_allow_listed: 0x2::vec_set::VecSet<0x2::object::ID>,
        vault: 0x136fe1254dee4a8584d07494f86bbaa96a43446fa1c95a73136fb7983710fde4::vault::Vault,
        state: 0x136fe1254dee4a8584d07494f86bbaa96a43446fa1c95a73136fb7983710fde4::state::State,
    }

    struct HouseAdminCap has store, key {
        id: 0x2::object::UID,
        house_id: 0x2::object::ID,
    }

    struct HouseTransactionCap {
        house_id: 0x2::object::ID,
        game_id: 0x2::object::ID,
    }

    struct Fees has copy, drop {
        protocol_fee: u64,
        house_fee: u64,
        referral_fee: u64,
    }

    struct HouseCreatedEvent has copy, drop {
        house_id: 0x2::object::ID,
        admin_cap_id: 0x2::object::ID,
    }

    struct TransactionsProcessedEvent has copy, drop {
        house_id: 0x2::object::ID,
        game_id: 0x2::object::ID,
        balance_manager_id: 0x2::object::ID,
        referral_id: 0x1::option::Option<0x2::object::ID>,
        transactions: vector<0x136fe1254dee4a8584d07494f86bbaa96a43446fa1c95a73136fb7983710fde4::transaction::Transaction>,
        fees: Fees,
    }

    struct GameTransactionsAllowedEvent has copy, drop {
        house_id: 0x2::object::ID,
        game_id: 0x2::object::ID,
    }

    struct GameTransactionsRevokedEvent has copy, drop {
        house_id: 0x2::object::ID,
        game_id: 0x2::object::ID,
    }

    struct ProtocolFeesClaimedEvent has copy, drop {
        house_id: 0x2::object::ID,
        amount: u64,
    }

    struct ReferralFeesClaimedEvent has copy, drop {
        house_id: 0x2::object::ID,
        referral_id: 0x2::object::ID,
        amount: u64,
    }

    struct HouseFeesClaimedEvent has copy, drop {
        house_id: 0x2::object::ID,
        amount: u64,
    }

    public fun new(arg0: bool, arg1: u64, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (House, HouseAdminCap) {
        assert!(arg2 + arg3 + arg3 < 0x136fe1254dee4a8584d07494f86bbaa96a43446fa1c95a73136fb7983710fde4::constants::max_bps(), 10);
        let v0 = 0x2::object::new(arg4);
        let v1 = House{
            id               : 0x2::object::new(arg4),
            admin_cap_id     : 0x2::object::uid_to_inner(&v0),
            private          : arg0,
            target_balance   : arg1,
            house_fee_bps    : arg2,
            referral_fee_bps : arg3,
            tx_allow_listed  : 0x2::vec_set::empty<0x2::object::ID>(),
            vault            : 0x136fe1254dee4a8584d07494f86bbaa96a43446fa1c95a73136fb7983710fde4::vault::empty(arg4),
            state            : 0x136fe1254dee4a8584d07494f86bbaa96a43446fa1c95a73136fb7983710fde4::state::new(arg4),
        };
        let v2 = HouseAdminCap{
            id       : v0,
            house_id : id(&v1),
        };
        let v3 = HouseCreatedEvent{
            house_id     : id(&v1),
            admin_cap_id : 0x2::object::uid_to_inner(&v2.id),
        };
        0x2::event::emit<HouseCreatedEvent>(v3);
        (v1, v2)
    }

    public fun id(arg0: &House) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    fun activate_if_possible(arg0: &mut House, arg1: &0x2::tx_context::TxContext) {
        if (0x136fe1254dee4a8584d07494f86bbaa96a43446fa1c95a73136fb7983710fde4::state::is_active(&arg0.state)) {
            return
        };
        if (0x136fe1254dee4a8584d07494f86bbaa96a43446fa1c95a73136fb7983710fde4::state::maybe_activate(&mut arg0.state, arg0.target_balance, arg1)) {
            0x136fe1254dee4a8584d07494f86bbaa96a43446fa1c95a73136fb7983710fde4::vault::fund_play_balance(&mut arg0.vault, arg0.target_balance);
        };
    }

    public fun admin_add_tx_allowed(arg0: &mut House, arg1: &HouseAdminCap, arg2: 0x2::object::ID) {
        assert_valid_admin_cap(arg0, arg1);
        assert!(0x2::vec_set::size<0x2::object::ID>(&arg0.tx_allow_listed) < 1000, 7);
        0x2::vec_set::insert<0x2::object::ID>(&mut arg0.tx_allow_listed, arg2);
        let v0 = GameTransactionsAllowedEvent{
            house_id : id(arg0),
            game_id  : arg2,
        };
        0x2::event::emit<GameTransactionsAllowedEvent>(v0);
    }

    public fun admin_cap_house_id(arg0: &HouseAdminCap) : 0x2::object::ID {
        arg0.house_id
    }

    public fun admin_claim_house_fees(arg0: &mut House, arg1: &HouseAdminCap, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert_valid_admin_cap(arg0, arg1);
        let v0 = 0x2::coin::from_balance<0x2::sui::SUI>(0x136fe1254dee4a8584d07494f86bbaa96a43446fa1c95a73136fb7983710fde4::vault::withdraw_house_fees(&mut arg0.vault), arg2);
        let v1 = HouseFeesClaimedEvent{
            house_id : id(arg0),
            amount   : 0x2::coin::value<0x2::sui::SUI>(&v0),
        };
        0x2::event::emit<HouseFeesClaimedEvent>(v1);
        v0
    }

    public fun admin_new_participation(arg0: &House, arg1: &HouseAdminCap, arg2: &mut 0x2::tx_context::TxContext) : 0x136fe1254dee4a8584d07494f86bbaa96a43446fa1c95a73136fb7983710fde4::participation::Participation {
        assert_valid_admin_cap(arg0, arg1);
        0x136fe1254dee4a8584d07494f86bbaa96a43446fa1c95a73136fb7983710fde4::participation::empty(0x2::object::uid_to_inner(&arg0.id), arg2)
    }

    public fun admin_revoke_tx_allowed(arg0: &mut House, arg1: &HouseAdminCap, arg2: &0x2::object::ID) {
        assert_valid_admin_cap(arg0, arg1);
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.tx_allow_listed, arg2), 12);
        0x2::vec_set::remove<0x2::object::ID>(&mut arg0.tx_allow_listed, arg2);
        let v0 = GameTransactionsRevokedEvent{
            house_id : id(arg0),
            game_id  : *arg2,
        };
        0x2::event::emit<GameTransactionsRevokedEvent>(v0);
    }

    fun assert_not_private(arg0: &House) {
        assert!(private(arg0) == false, 6);
    }

    fun assert_referral_active(arg0: &House) {
        assert!(arg0.referral_fee_bps > 0, 5);
    }

    fun assert_valid_admin_cap(arg0: &House, arg1: &HouseAdminCap) {
        assert!(id(arg0) == arg1.house_id, 9);
    }

    fun assert_valid_participation(arg0: &House, arg1: &0x136fe1254dee4a8584d07494f86bbaa96a43446fa1c95a73136fb7983710fde4::participation::Participation) {
        assert!(id(arg0) == 0x136fe1254dee4a8584d07494f86bbaa96a43446fa1c95a73136fb7983710fde4::participation::house_id(arg1), 3);
    }

    fun assert_valid_tx_cap(arg0: &House, arg1: HouseTransactionCap) {
        let HouseTransactionCap {
            house_id : v0,
            game_id  : v1,
        } = arg1;
        let v2 = v1;
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.tx_allow_listed, &v2), 2);
        assert!(id(arg0) == v0, 2);
    }

    public fun borrow_tx_cap(arg0: &House, arg1: &mut 0x2::object::UID) : HouseTransactionCap {
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.tx_allow_listed, 0x2::object::uid_as_inner(arg1)), 11);
        HouseTransactionCap{
            house_id : id(arg0),
            game_id  : 0x2::object::uid_to_inner(arg1),
        }
    }

    public fun claim_all(arg0: &mut House, arg1: &mut 0x136fe1254dee4a8584d07494f86bbaa96a43446fa1c95a73136fb7983710fde4::participation::Participation, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert_valid_participation(arg0, arg1);
        process_end_of_day(arg0, arg2);
        0x2::coin::from_balance<0x2::sui::SUI>(0x136fe1254dee4a8584d07494f86bbaa96a43446fa1c95a73136fb7983710fde4::vault::withdraw(&mut arg0.vault, 0x136fe1254dee4a8584d07494f86bbaa96a43446fa1c95a73136fb7983710fde4::participation::claim_all(arg1, arg2)), arg2)
    }

    public fun ensure_sufficient_funds(arg0: &mut House, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        process_end_of_day(arg0, arg2);
        assert!(0x136fe1254dee4a8584d07494f86bbaa96a43446fa1c95a73136fb7983710fde4::state::is_active(&arg0.state), 4);
        assert!(0x136fe1254dee4a8584d07494f86bbaa96a43446fa1c95a73136fb7983710fde4::vault::play_balance(&arg0.vault) >= arg1, 1);
    }

    public fun house_fee_factor(arg0: &House) : 0x1::uq32_32::UQ32_32 {
        0x1::uq32_32::from_quotient(arg0.house_fee_bps, 10000)
    }

    public fun is_active(arg0: &mut House, arg1: &0x2::tx_context::TxContext) : bool {
        process_end_of_day(arg0, arg1);
        0x136fe1254dee4a8584d07494f86bbaa96a43446fa1c95a73136fb7983710fde4::state::is_active(&arg0.state)
    }

    public fun new_participation(arg0: &House, arg1: &mut 0x2::tx_context::TxContext) : 0x136fe1254dee4a8584d07494f86bbaa96a43446fa1c95a73136fb7983710fde4::participation::Participation {
        assert_not_private(arg0);
        0x136fe1254dee4a8584d07494f86bbaa96a43446fa1c95a73136fb7983710fde4::participation::empty(0x2::object::uid_to_inner(&arg0.id), arg1)
    }

    public fun new_referral(arg0: &House, arg1: &mut 0x2::tx_context::TxContext) : 0x136fe1254dee4a8584d07494f86bbaa96a43446fa1c95a73136fb7983710fde4::referral::ReferralCap {
        assert_referral_active(arg0);
        let (v0, v1) = 0x136fe1254dee4a8584d07494f86bbaa96a43446fa1c95a73136fb7983710fde4::referral::new(id(arg0), arg1);
        0x136fe1254dee4a8584d07494f86bbaa96a43446fa1c95a73136fb7983710fde4::referral::share(v0);
        v1
    }

    public fun openplay_admin_claim_protocol_fees(arg0: &mut House, arg1: &0x136fe1254dee4a8584d07494f86bbaa96a43446fa1c95a73136fb7983710fde4::registry::OpenPlayAdminCap, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x2::coin::from_balance<0x2::sui::SUI>(0x136fe1254dee4a8584d07494f86bbaa96a43446fa1c95a73136fb7983710fde4::vault::withdraw_protocol_fees(&mut arg0.vault), arg2);
        let v1 = ProtocolFeesClaimedEvent{
            house_id : id(arg0),
            amount   : 0x2::coin::value<0x2::sui::SUI>(&v0),
        };
        0x2::event::emit<ProtocolFeesClaimedEvent>(v1);
        v0
    }

    public fun play_balance(arg0: &mut House, arg1: &mut 0x2::tx_context::TxContext) : u64 {
        process_end_of_day(arg0, arg1);
        0x136fe1254dee4a8584d07494f86bbaa96a43446fa1c95a73136fb7983710fde4::vault::play_balance(&arg0.vault)
    }

    public fun private(arg0: &House) : bool {
        arg0.private
    }

    fun process_end_of_day(arg0: &mut House, arg1: &0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x136fe1254dee4a8584d07494f86bbaa96a43446fa1c95a73136fb7983710fde4::vault::process_end_of_day(&mut arg0.vault, arg1);
        if (v0) {
            let (v3, v4) = if (0x136fe1254dee4a8584d07494f86bbaa96a43446fa1c95a73136fb7983710fde4::state::epoch_active(&arg0.state, v1)) {
                if (v2 > arg0.target_balance) {
                    (0, v2 - arg0.target_balance)
                } else {
                    (arg0.target_balance - v2, 0)
                }
            } else {
                (0, 0)
            };
            0x136fe1254dee4a8584d07494f86bbaa96a43446fa1c95a73136fb7983710fde4::state::process_end_of_day(&mut arg0.state, v1, v4, v3, arg1);
            activate_if_possible(arg0, arg1);
        };
    }

    public fun referral_admin_claim_referral_fees(arg0: &mut House, arg1: &0x136fe1254dee4a8584d07494f86bbaa96a43446fa1c95a73136fb7983710fde4::referral::ReferralCap, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x2::coin::from_balance<0x2::sui::SUI>(0x136fe1254dee4a8584d07494f86bbaa96a43446fa1c95a73136fb7983710fde4::vault::withdraw_referral_fees(&mut arg0.vault, 0x136fe1254dee4a8584d07494f86bbaa96a43446fa1c95a73136fb7983710fde4::referral::referral_id(arg1)), arg2);
        let v1 = ReferralFeesClaimedEvent{
            house_id    : id(arg0),
            referral_id : 0x136fe1254dee4a8584d07494f86bbaa96a43446fa1c95a73136fb7983710fde4::referral::referral_id(arg1),
            amount      : 0x2::coin::value<0x2::sui::SUI>(&v0),
        };
        0x2::event::emit<ReferralFeesClaimedEvent>(v1);
        v0
    }

    public fun referral_fee_factor(arg0: &House) : 0x1::uq32_32::UQ32_32 {
        0x1::uq32_32::from_quotient(arg0.referral_fee_bps, 10000)
    }

    public fun reserve_balance(arg0: &mut House, arg1: &mut 0x2::tx_context::TxContext) : u64 {
        process_end_of_day(arg0, arg1);
        0x136fe1254dee4a8584d07494f86bbaa96a43446fa1c95a73136fb7983710fde4::vault::reserve_balance(&arg0.vault)
    }

    public fun share(arg0: &mut 0x136fe1254dee4a8584d07494f86bbaa96a43446fa1c95a73136fb7983710fde4::registry::Registry, arg1: House) {
        0x136fe1254dee4a8584d07494f86bbaa96a43446fa1c95a73136fb7983710fde4::registry::register_house(arg0, id(&arg1));
        0x2::transfer::share_object<House>(arg1);
    }

    public fun stake(arg0: &mut House, arg1: &mut 0x136fe1254dee4a8584d07494f86bbaa96a43446fa1c95a73136fb7983710fde4::participation::Participation, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        assert_valid_participation(arg0, arg1);
        process_end_of_day(arg0, arg3);
        0x136fe1254dee4a8584d07494f86bbaa96a43446fa1c95a73136fb7983710fde4::state::process_stake(&mut arg0.state, 0x2::coin::value<0x2::sui::SUI>(&arg2), arg3);
        0x136fe1254dee4a8584d07494f86bbaa96a43446fa1c95a73136fb7983710fde4::participation::add_stake(arg1, 0x2::coin::value<0x2::sui::SUI>(&arg2), 0x136fe1254dee4a8584d07494f86bbaa96a43446fa1c95a73136fb7983710fde4::state::is_active(&arg0.state), arg3);
        0x136fe1254dee4a8584d07494f86bbaa96a43446fa1c95a73136fb7983710fde4::vault::deposit(&mut arg0.vault, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        activate_if_possible(arg0, arg3);
    }

    public fun transaction_cap_house_id(arg0: &HouseTransactionCap) : 0x2::object::ID {
        arg0.house_id
    }

    public fun tx_admin_process_transactions(arg0: &mut House, arg1: &0x136fe1254dee4a8584d07494f86bbaa96a43446fa1c95a73136fb7983710fde4::registry::Registry, arg2: HouseTransactionCap, arg3: &mut 0x136fe1254dee4a8584d07494f86bbaa96a43446fa1c95a73136fb7983710fde4::balance_manager::BalanceManager, arg4: &vector<0x136fe1254dee4a8584d07494f86bbaa96a43446fa1c95a73136fb7983710fde4::transaction::Transaction>, arg5: &0x136fe1254dee4a8584d07494f86bbaa96a43446fa1c95a73136fb7983710fde4::balance_manager::PlayCap, arg6: &0x2::tx_context::TxContext) {
        assert_valid_tx_cap(arg0, arg2);
        let v0 = 0x136fe1254dee4a8584d07494f86bbaa96a43446fa1c95a73136fb7983710fde4::balance_manager::generate_proof_as_player(arg3, arg5, arg6);
        let v1 = house_fee_factor(arg0);
        process_end_of_day(arg0, arg6);
        let (v2, v3, v4, v5, _) = 0x136fe1254dee4a8584d07494f86bbaa96a43446fa1c95a73136fb7983710fde4::state::process_transactions(&mut arg0.state, arg4, 0x136fe1254dee4a8584d07494f86bbaa96a43446fa1c95a73136fb7983710fde4::balance_manager::id(arg3), v1, 0x136fe1254dee4a8584d07494f86bbaa96a43446fa1c95a73136fb7983710fde4::registry::protocol_fee_factor(arg1), 0x1::option::none<0x1::uq32_32::UQ32_32>(), arg6);
        0x136fe1254dee4a8584d07494f86bbaa96a43446fa1c95a73136fb7983710fde4::vault::settle_balance_manager(&mut arg0.vault, v2, v3, arg3, &v0);
        0x136fe1254dee4a8584d07494f86bbaa96a43446fa1c95a73136fb7983710fde4::vault::process_house_fee(&mut arg0.vault, v4);
        0x136fe1254dee4a8584d07494f86bbaa96a43446fa1c95a73136fb7983710fde4::vault::process_protocol_fee(&mut arg0.vault, v5);
        let v7 = Fees{
            protocol_fee : v5,
            house_fee    : v4,
            referral_fee : 0,
        };
        let v8 = TransactionsProcessedEvent{
            house_id           : id(arg0),
            game_id            : arg2.game_id,
            balance_manager_id : 0x136fe1254dee4a8584d07494f86bbaa96a43446fa1c95a73136fb7983710fde4::balance_manager::id(arg3),
            referral_id        : 0x1::option::none<0x2::object::ID>(),
            transactions       : *arg4,
            fees               : v7,
        };
        0x2::event::emit<TransactionsProcessedEvent>(v8);
    }

    public fun tx_admin_process_transactions_with_referral(arg0: &mut House, arg1: &0x136fe1254dee4a8584d07494f86bbaa96a43446fa1c95a73136fb7983710fde4::registry::Registry, arg2: HouseTransactionCap, arg3: &mut 0x136fe1254dee4a8584d07494f86bbaa96a43446fa1c95a73136fb7983710fde4::balance_manager::BalanceManager, arg4: &vector<0x136fe1254dee4a8584d07494f86bbaa96a43446fa1c95a73136fb7983710fde4::transaction::Transaction>, arg5: &0x136fe1254dee4a8584d07494f86bbaa96a43446fa1c95a73136fb7983710fde4::balance_manager::PlayCap, arg6: &0x136fe1254dee4a8584d07494f86bbaa96a43446fa1c95a73136fb7983710fde4::referral::Referral, arg7: &0x2::tx_context::TxContext) {
        assert_valid_tx_cap(arg0, arg2);
        let v0 = 0x136fe1254dee4a8584d07494f86bbaa96a43446fa1c95a73136fb7983710fde4::balance_manager::generate_proof_as_player(arg3, arg5, arg7);
        assert_referral_active(arg0);
        process_end_of_day(arg0, arg7);
        let (v1, v2, v3, v4, v5) = 0x136fe1254dee4a8584d07494f86bbaa96a43446fa1c95a73136fb7983710fde4::state::process_transactions(&mut arg0.state, arg4, 0x136fe1254dee4a8584d07494f86bbaa96a43446fa1c95a73136fb7983710fde4::balance_manager::id(arg3), house_fee_factor(arg0), 0x136fe1254dee4a8584d07494f86bbaa96a43446fa1c95a73136fb7983710fde4::registry::protocol_fee_factor(arg1), 0x1::option::some<0x1::uq32_32::UQ32_32>(referral_fee_factor(arg0)), arg7);
        0x136fe1254dee4a8584d07494f86bbaa96a43446fa1c95a73136fb7983710fde4::vault::settle_balance_manager(&mut arg0.vault, v1, v2, arg3, &v0);
        0x136fe1254dee4a8584d07494f86bbaa96a43446fa1c95a73136fb7983710fde4::vault::process_house_fee(&mut arg0.vault, v3);
        0x136fe1254dee4a8584d07494f86bbaa96a43446fa1c95a73136fb7983710fde4::vault::process_referral_fee(&mut arg0.vault, 0x136fe1254dee4a8584d07494f86bbaa96a43446fa1c95a73136fb7983710fde4::referral::id(arg6), v5);
        0x136fe1254dee4a8584d07494f86bbaa96a43446fa1c95a73136fb7983710fde4::vault::process_protocol_fee(&mut arg0.vault, v4);
        let v6 = Fees{
            protocol_fee : v4,
            house_fee    : v3,
            referral_fee : v5,
        };
        let v7 = TransactionsProcessedEvent{
            house_id           : id(arg0),
            game_id            : arg2.game_id,
            balance_manager_id : 0x136fe1254dee4a8584d07494f86bbaa96a43446fa1c95a73136fb7983710fde4::balance_manager::id(arg3),
            referral_id        : 0x1::option::some<0x2::object::ID>(0x136fe1254dee4a8584d07494f86bbaa96a43446fa1c95a73136fb7983710fde4::referral::id(arg6)),
            transactions       : *arg4,
            fees               : v6,
        };
        0x2::event::emit<TransactionsProcessedEvent>(v7);
    }

    public fun unstake(arg0: &mut House, arg1: &mut 0x136fe1254dee4a8584d07494f86bbaa96a43446fa1c95a73136fb7983710fde4::participation::Participation, arg2: &mut 0x2::tx_context::TxContext) {
        assert_valid_participation(arg0, arg1);
        process_end_of_day(arg0, arg2);
        let (v0, v1) = 0x136fe1254dee4a8584d07494f86bbaa96a43446fa1c95a73136fb7983710fde4::participation::unstake(arg1, 0x136fe1254dee4a8584d07494f86bbaa96a43446fa1c95a73136fb7983710fde4::state::is_active(&arg0.state), arg2);
        0x136fe1254dee4a8584d07494f86bbaa96a43446fa1c95a73136fb7983710fde4::state::process_unstake(&mut arg0.state, v0, v1, arg2);
    }

    public fun update_participation(arg0: &mut House, arg1: &mut 0x136fe1254dee4a8584d07494f86bbaa96a43446fa1c95a73136fb7983710fde4::participation::Participation, arg2: &mut 0x2::tx_context::TxContext) {
        assert_valid_participation(arg0, arg1);
        process_end_of_day(arg0, arg2);
        0x136fe1254dee4a8584d07494f86bbaa96a43446fa1c95a73136fb7983710fde4::state::refresh(&arg0.state, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

