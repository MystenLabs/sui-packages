module 0x22913eada7f742ef5714054f57b3f5cbe822e9ba3e809ba67a2ec3e900d23a32::stoken_concord_adapter {
    struct DepositParams has copy, drop {
        vault: address,
        min_shares_out: u64,
    }

    struct RedeemParams has copy, drop {
        vault: address,
        shares: u64,
        min_assets_out: u64,
    }

    struct ConcordAdapterAdminCap has store, key {
        id: 0x2::object::UID,
        adapter_id: 0x2::object::ID,
    }

    struct Position has copy, drop, store {
        deposited_amount: u64,
        shares_received: u64,
        created_at: u64,
    }

    struct ShareCustodyKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct ConcordAdapter<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        version: u64,
        escrow_id: 0x2::object::ID,
        admin: address,
        paused: bool,
        allowed_vaults: 0x2::table::Table<address, bool>,
        positions: 0x2::table::Table<address, Position>,
        share_bags: 0x2::table::Table<address, 0x2::bag::Bag>,
    }

    struct ConcordAdapterInitializedEvent has copy, drop {
        adapter_id: 0x2::object::ID,
        escrow_id: 0x2::object::ID,
    }

    struct ConcordAdapterAllowedVaultEvent has copy, drop {
        adapter_id: 0x2::object::ID,
        vault: address,
        allowed: bool,
    }

    struct ConcordAdapterPausedEvent has copy, drop {
        adapter_id: 0x2::object::ID,
    }

    struct ConcordAdapterUnpausedEvent has copy, drop {
        adapter_id: 0x2::object::ID,
    }

    struct ConcordDepositEvent has copy, drop {
        adapter_id: 0x2::object::ID,
        vault: address,
        amount: u64,
        shares_received: u64,
    }

    struct ConcordRedeemEvent has copy, drop {
        adapter_id: 0x2::object::ID,
        vault: address,
        shares_burned: u64,
        assets_quoted: u64,
    }

    public fun action_deposit() : u32 {
        1
    }

    public fun action_redeem() : u32 {
        2
    }

    public fun adapter_address<T0, T1>(arg0: &ConcordAdapter<T0, T1>) : address {
        let v0 = 0x2::object::id<ConcordAdapter<T0, T1>>(arg0);
        0x2::object::id_to_address(&v0)
    }

    public fun allocate_to_lending_vault<T0, T1, T2: key>(arg0: &mut ConcordAdapter<T0, T1>, arg1: &mut 0x22913eada7f742ef5714054f57b3f5cbe822e9ba3e809ba67a2ec3e900d23a32::stoken_cross_chain_asset_manager::CrossChainAssetManager<T0>, arg2: &0x22913eada7f742ef5714054f57b3f5cbe822e9ba3e809ba67a2ec3e900d23a32::stoken_cross_chain_asset_manager::CcamProcessorCap, arg3: &mut 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_lending_vault::LendingVault<T0, T1, T2>, arg4: &0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_offer_book::OfferBook, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<ConcordAdapter<T0, T1>>(arg0);
        let v1 = 0x22913eada7f742ef5714054f57b3f5cbe822e9ba3e809ba67a2ec3e900d23a32::stoken_cross_chain_asset_manager::push_to_adapter<T0>(arg1, arg2, 0x2::object::id_to_address(&v0), arg5, arg7, arg8);
        execute_deposit<T0, T1, T2>(arg0, arg1, arg3, arg4, v1, arg6, arg7, arg8);
    }

    fun assert_admin<T0, T1>(arg0: &ConcordAdapter<T0, T1>, arg1: &ConcordAdapterAdminCap, arg2: &0x2::tx_context::TxContext) {
        assert!(arg1.adapter_id == 0x2::object::id<ConcordAdapter<T0, T1>>(arg0), 0x22913eada7f742ef5714054f57b3f5cbe822e9ba3e809ba67a2ec3e900d23a32::stoken_errors::unauthorized());
        assert_version<T0, T1>(arg0);
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 0x22913eada7f742ef5714054f57b3f5cbe822e9ba3e809ba67a2ec3e900d23a32::stoken_errors::unauthorized());
    }

    fun assert_escrow_processor<T0, T1>(arg0: &ConcordAdapter<T0, T1>, arg1: &0x22913eada7f742ef5714054f57b3f5cbe822e9ba3e809ba67a2ec3e900d23a32::stoken_cross_chain_asset_manager::CrossChainAssetManager<T0>, arg2: &0x2::tx_context::TxContext) {
        assert_version<T0, T1>(arg0);
        assert!(arg0.escrow_id == 0x2::object::id<0x22913eada7f742ef5714054f57b3f5cbe822e9ba3e809ba67a2ec3e900d23a32::stoken_cross_chain_asset_manager::CrossChainAssetManager<T0>>(arg1), 0x22913eada7f742ef5714054f57b3f5cbe822e9ba3e809ba67a2ec3e900d23a32::stoken_errors::adapter_caller_not_escrow());
        assert!(0x2::tx_context::sender(arg2) == 0x22913eada7f742ef5714054f57b3f5cbe822e9ba3e809ba67a2ec3e900d23a32::stoken_cross_chain_asset_manager::get_processor<T0>(arg1), 0x22913eada7f742ef5714054f57b3f5cbe822e9ba3e809ba67a2ec3e900d23a32::stoken_errors::adapter_caller_not_escrow());
    }

    fun assert_version<T0, T1>(arg0: &ConcordAdapter<T0, T1>) {
        assert!(arg0.version == 5, 0x22913eada7f742ef5714054f57b3f5cbe822e9ba3e809ba67a2ec3e900d23a32::stoken_errors::wrong_version());
    }

    public fun create_adapter<T0, T1>(arg0: 0x2::object::ID, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : ConcordAdapterAdminCap {
        assert!(arg1 != @0x0, 0x22913eada7f742ef5714054f57b3f5cbe822e9ba3e809ba67a2ec3e900d23a32::stoken_errors::invalid_argument());
        let v0 = ConcordAdapter<T0, T1>{
            id             : 0x2::object::new(arg2),
            version        : 5,
            escrow_id      : arg0,
            admin          : arg1,
            paused         : false,
            allowed_vaults : 0x2::table::new<address, bool>(arg2),
            positions      : 0x2::table::new<address, Position>(arg2),
            share_bags     : 0x2::table::new<address, 0x2::bag::Bag>(arg2),
        };
        let v1 = 0x2::object::id<ConcordAdapter<T0, T1>>(&v0);
        0x2::transfer::share_object<ConcordAdapter<T0, T1>>(v0);
        let v2 = ConcordAdapterInitializedEvent{
            adapter_id : v1,
            escrow_id  : arg0,
        };
        0x2::event::emit<ConcordAdapterInitializedEvent>(v2);
        ConcordAdapterAdminCap{
            id         : 0x2::object::new(arg2),
            adapter_id : v1,
        }
    }

    public fun current_module_version() : u64 {
        5
    }

    public fun custodied_shares<T0, T1, T2: key>(arg0: &ConcordAdapter<T0, T1>, arg1: address) : u64 {
        if (!0x2::table::contains<address, 0x2::bag::Bag>(&arg0.share_bags, arg1)) {
            return 0
        };
        let v0 = 0x2::table::borrow<address, 0x2::bag::Bag>(&arg0.share_bags, arg1);
        let v1 = ShareCustodyKey<T2>{dummy_field: false};
        if (0x2::bag::contains<ShareCustodyKey<T2>>(v0, v1)) {
            0x2::balance::value<T2>(0x2::bag::borrow<ShareCustodyKey<T2>, 0x2::balance::Balance<T2>>(v0, v1))
        } else {
            0
        }
    }

    fun custody_share<T0, T1, T2: key>(arg0: &mut ConcordAdapter<T0, T1>, arg1: address, arg2: 0x2::coin::Coin<T2>, arg3: &mut 0x2::tx_context::TxContext) {
        if (!0x2::table::contains<address, 0x2::bag::Bag>(&arg0.share_bags, arg1)) {
            0x2::table::add<address, 0x2::bag::Bag>(&mut arg0.share_bags, arg1, 0x2::bag::new(arg3));
        };
        let v0 = 0x2::table::borrow_mut<address, 0x2::bag::Bag>(&mut arg0.share_bags, arg1);
        let v1 = ShareCustodyKey<T2>{dummy_field: false};
        if (0x2::bag::contains<ShareCustodyKey<T2>>(v0, v1)) {
            0x2::balance::join<T2>(0x2::bag::borrow_mut<ShareCustodyKey<T2>, 0x2::balance::Balance<T2>>(v0, v1), 0x2::coin::into_balance<T2>(arg2));
        } else {
            0x2::bag::add<ShareCustodyKey<T2>, 0x2::balance::Balance<T2>>(v0, v1, 0x2::coin::into_balance<T2>(arg2));
        };
    }

    public fun deposit<T0, T1, T2: key>(arg0: &mut ConcordAdapter<T0, T1>, arg1: &0x22913eada7f742ef5714054f57b3f5cbe822e9ba3e809ba67a2ec3e900d23a32::stoken_cross_chain_asset_manager::CrossChainAssetManager<T0>, arg2: &mut 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_lending_vault::LendingVault<T0, T1, T2>, arg3: &0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_offer_book::OfferBook, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert_escrow_processor<T0, T1>(arg0, arg1, arg7);
        assert!(!arg0.paused, 0x22913eada7f742ef5714054f57b3f5cbe822e9ba3e809ba67a2ec3e900d23a32::stoken_errors::adapter_paused());
        let v0 = vault_addr<T0, T1, T2>(arg2);
        assert!(is_vault_allowed_internal<T0, T1>(arg0, v0), 0x22913eada7f742ef5714054f57b3f5cbe822e9ba3e809ba67a2ec3e900d23a32::stoken_errors::adapter_vault_not_allowed());
        let v1 = 0x2::coin::value<T0>(&arg4);
        assert!(v1 > 0, 0x22913eada7f742ef5714054f57b3f5cbe822e9ba3e809ba67a2ec3e900d23a32::stoken_errors::invalid_amount());
        assert!(0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_lending_vault::preview_deposit<T0, T1, T2>(arg2, v1) >= arg5, 0x22913eada7f742ef5714054f57b3f5cbe822e9ba3e809ba67a2ec3e900d23a32::stoken_errors::adapter_slippage_too_high());
        let v2 = 0x2::object::id<ConcordAdapter<T0, T1>>(arg0);
        let v3 = 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_lending_vault::deposit_principal_for_and_keep<T0, T1, T2>(arg2, arg3, arg4, 0x2::object::id_to_address(&v2), arg6, arg7);
        let v4 = 0x2::coin::value<T2>(&v3);
        assert!(v4 >= arg5, 0x22913eada7f742ef5714054f57b3f5cbe822e9ba3e809ba67a2ec3e900d23a32::stoken_errors::adapter_slippage_too_high());
        custody_share<T0, T1, T2>(arg0, v0, v3, arg7);
        if (0x2::table::contains<address, Position>(&arg0.positions, v0)) {
            let v5 = 0x2::table::borrow_mut<address, Position>(&mut arg0.positions, v0);
            v5.deposited_amount = v5.deposited_amount + v1;
            v5.shares_received = v5.shares_received + v4;
        } else {
            let v6 = Position{
                deposited_amount : v1,
                shares_received  : v4,
                created_at       : 0x2::clock::timestamp_ms(arg6) / 1000,
            };
            0x2::table::add<address, Position>(&mut arg0.positions, v0, v6);
        };
        let v7 = ConcordDepositEvent{
            adapter_id      : 0x2::object::id<ConcordAdapter<T0, T1>>(arg0),
            vault           : v0,
            amount          : v1,
            shares_received : v4,
        };
        0x2::event::emit<ConcordDepositEvent>(v7);
    }

    public fun execute<T0, T1, T2: key>(arg0: &mut ConcordAdapter<T0, T1>, arg1: &0x22913eada7f742ef5714054f57b3f5cbe822e9ba3e809ba67a2ec3e900d23a32::stoken_cross_chain_asset_manager::CrossChainAssetManager<T0>, arg2: &mut 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_lending_vault::LendingVault<T0, T1, T2>, arg3: u32, arg4: RedeemParams, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg3 == 2, 0x22913eada7f742ef5714054f57b3f5cbe822e9ba3e809ba67a2ec3e900d23a32::stoken_errors::invalid_argument());
        assert!(vault_addr<T0, T1, T2>(arg2) == arg4.vault, 0x22913eada7f742ef5714054f57b3f5cbe822e9ba3e809ba67a2ec3e900d23a32::stoken_errors::invalid_argument());
        execute_redeem<T0, T1, T2>(arg0, arg1, arg2, arg4.shares, arg4.min_assets_out, arg5, arg6)
    }

    public fun execute_deposit<T0, T1, T2: key>(arg0: &mut ConcordAdapter<T0, T1>, arg1: &0x22913eada7f742ef5714054f57b3f5cbe822e9ba3e809ba67a2ec3e900d23a32::stoken_cross_chain_asset_manager::CrossChainAssetManager<T0>, arg2: &mut 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_lending_vault::LendingVault<T0, T1, T2>, arg3: &0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_offer_book::OfferBook, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        deposit<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public fun execute_deposit_action<T0, T1, T2: key>(arg0: &mut ConcordAdapter<T0, T1>, arg1: &0x22913eada7f742ef5714054f57b3f5cbe822e9ba3e809ba67a2ec3e900d23a32::stoken_cross_chain_asset_manager::CrossChainAssetManager<T0>, arg2: &mut 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_lending_vault::LendingVault<T0, T1, T2>, arg3: &0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_offer_book::OfferBook, arg4: DepositParams, arg5: 0x2::coin::Coin<T0>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(vault_addr<T0, T1, T2>(arg2) == arg4.vault, 0x22913eada7f742ef5714054f57b3f5cbe822e9ba3e809ba67a2ec3e900d23a32::stoken_errors::invalid_argument());
        execute_deposit<T0, T1, T2>(arg0, arg1, arg2, arg3, arg5, arg4.min_shares_out, arg6, arg7);
    }

    public fun execute_redeem<T0, T1, T2: key>(arg0: &mut ConcordAdapter<T0, T1>, arg1: &0x22913eada7f742ef5714054f57b3f5cbe822e9ba3e809ba67a2ec3e900d23a32::stoken_cross_chain_asset_manager::CrossChainAssetManager<T0>, arg2: &mut 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_lending_vault::LendingVault<T0, T1, T2>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        redeem<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    public fun execute_redeem_collateral<T0, T1, T2: key>(arg0: &mut ConcordAdapter<T0, T1>, arg1: &0x22913eada7f742ef5714054f57b3f5cbe822e9ba3e809ba67a2ec3e900d23a32::stoken_cross_chain_asset_manager::CrossChainAssetManager<T0>, arg2: &mut 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_lending_vault::LendingVault<T0, T1, T2>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        redeem_collateral<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    public fun execute_redeem_same_asset<T0, T1: key>(arg0: &mut ConcordAdapter<T0, T0>, arg1: &0x22913eada7f742ef5714054f57b3f5cbe822e9ba3e809ba67a2ec3e900d23a32::stoken_cross_chain_asset_manager::CrossChainAssetManager<T0>, arg2: &mut 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_lending_vault::LendingVault<T0, T0, T1>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        redeem_same_asset<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    public fun get_escrow_id<T0, T1>(arg0: &ConcordAdapter<T0, T1>) : 0x2::object::ID {
        arg0.escrow_id
    }

    public fun get_module_version<T0, T1>(arg0: &ConcordAdapter<T0, T1>) : u64 {
        arg0.version
    }

    public fun has_position<T0, T1>(arg0: &ConcordAdapter<T0, T1>, arg1: address) : bool {
        0x2::table::contains<address, Position>(&arg0.positions, arg1)
    }

    public fun is_paused<T0, T1>(arg0: &ConcordAdapter<T0, T1>) : bool {
        arg0.paused
    }

    public fun is_vault_allowed<T0, T1>(arg0: &ConcordAdapter<T0, T1>, arg1: address) : bool {
        is_vault_allowed_internal<T0, T1>(arg0, arg1)
    }

    fun is_vault_allowed_internal<T0, T1>(arg0: &ConcordAdapter<T0, T1>, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.allowed_vaults, arg1) && *0x2::table::borrow<address, bool>(&arg0.allowed_vaults, arg1)
    }

    public fun migrate<T0, T1>(arg0: &mut ConcordAdapter<T0, T1>, arg1: &ConcordAdapterAdminCap) {
        assert!(arg1.adapter_id == 0x2::object::id<ConcordAdapter<T0, T1>>(arg0), 0x22913eada7f742ef5714054f57b3f5cbe822e9ba3e809ba67a2ec3e900d23a32::stoken_errors::unauthorized());
        assert!(arg0.version < 5, 0x22913eada7f742ef5714054f57b3f5cbe822e9ba3e809ba67a2ec3e900d23a32::stoken_errors::not_upgrade());
        arg0.version = 5;
    }

    public fun pause<T0, T1>(arg0: &mut ConcordAdapter<T0, T1>, arg1: &ConcordAdapterAdminCap, arg2: &0x2::tx_context::TxContext) {
        assert_admin<T0, T1>(arg0, arg1, arg2);
        arg0.paused = true;
        let v0 = ConcordAdapterPausedEvent{adapter_id: 0x2::object::id<ConcordAdapter<T0, T1>>(arg0)};
        0x2::event::emit<ConcordAdapterPausedEvent>(v0);
    }

    public fun position_shares<T0, T1>(arg0: &ConcordAdapter<T0, T1>, arg1: address) : u64 {
        if (0x2::table::contains<address, Position>(&arg0.positions, arg1)) {
            0x2::table::borrow<address, Position>(&arg0.positions, arg1).shares_received
        } else {
            0
        }
    }

    public fun push_and_execute<T0, T1, T2: key>(arg0: &mut ConcordAdapter<T0, T1>, arg1: &mut 0x22913eada7f742ef5714054f57b3f5cbe822e9ba3e809ba67a2ec3e900d23a32::stoken_cross_chain_asset_manager::CrossChainAssetManager<T0>, arg2: &0x22913eada7f742ef5714054f57b3f5cbe822e9ba3e809ba67a2ec3e900d23a32::stoken_cross_chain_asset_manager::CcamProcessorCap, arg3: &mut 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_lending_vault::LendingVault<T0, T1, T2>, arg4: &0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_offer_book::OfferBook, arg5: u64, arg6: u32, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg6 == 1, 0x22913eada7f742ef5714054f57b3f5cbe822e9ba3e809ba67a2ec3e900d23a32::stoken_errors::invalid_argument());
        allocate_to_lending_vault<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg7, arg8, arg9);
    }

    public fun redeem<T0, T1, T2: key>(arg0: &mut ConcordAdapter<T0, T1>, arg1: &0x22913eada7f742ef5714054f57b3f5cbe822e9ba3e809ba67a2ec3e900d23a32::stoken_cross_chain_asset_manager::CrossChainAssetManager<T0>, arg2: &mut 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_lending_vault::LendingVault<T0, T1, T2>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_escrow_processor<T0, T1>(arg0, arg1, arg6);
        assert!(!arg0.paused, 0x22913eada7f742ef5714054f57b3f5cbe822e9ba3e809ba67a2ec3e900d23a32::stoken_errors::adapter_paused());
        assert!(arg3 > 0, 0x22913eada7f742ef5714054f57b3f5cbe822e9ba3e809ba67a2ec3e900d23a32::stoken_errors::adapter_zero_shares());
        let v0 = vault_addr<T0, T1, T2>(arg2);
        assert!(is_vault_allowed_internal<T0, T1>(arg0, v0), 0x22913eada7f742ef5714054f57b3f5cbe822e9ba3e809ba67a2ec3e900d23a32::stoken_errors::adapter_vault_not_allowed());
        assert!(0x2::table::contains<address, 0x2::bag::Bag>(&arg0.share_bags, v0), 0x22913eada7f742ef5714054f57b3f5cbe822e9ba3e809ba67a2ec3e900d23a32::stoken_errors::adapter_no_position());
        let v1 = if (0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_lending_vault::is_collateral_mode<T0, T1, T2>(arg2)) {
            0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_lending_vault::preview_claim_collateral<T0, T1, T2>(arg2, arg3)
        } else {
            0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_lending_vault::preview_redeem<T0, T1, T2>(arg2, arg3)
        };
        assert!(v1 >= arg4, 0x22913eada7f742ef5714054f57b3f5cbe822e9ba3e809ba67a2ec3e900d23a32::stoken_errors::adapter_slippage_too_high());
        let v2 = take_custodied_shares<T0, T1, T2>(arg0, v0, arg3, arg6);
        let v3 = 0x2::object::id<ConcordAdapter<T0, T1>>(arg0);
        if (0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_lending_vault::is_collateral_mode<T0, T1, T2>(arg2)) {
            abort 0x22913eada7f742ef5714054f57b3f5cbe822e9ba3e809ba67a2ec3e900d23a32::stoken_errors::invalid_argument()
        };
        let v4 = 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_lending_vault::redeem_principal_for<T0, T1, T2>(arg2, v2, 0x2::object::id_to_address(&v3), arg5, arg6);
        assert!(0x2::coin::value<T0>(&v4) >= arg4, 0x22913eada7f742ef5714054f57b3f5cbe822e9ba3e809ba67a2ec3e900d23a32::stoken_errors::adapter_slippage_too_high());
        if (0x2::table::contains<address, Position>(&arg0.positions, v0)) {
            let v5 = 0x2::table::borrow_mut<address, Position>(&mut arg0.positions, v0);
            let v6 = if (v5.shares_received > arg3) {
                v5.shares_received - arg3
            } else {
                0
            };
            v5.shares_received = v6;
        };
        let v7 = ConcordRedeemEvent{
            adapter_id    : 0x2::object::id<ConcordAdapter<T0, T1>>(arg0),
            vault         : v0,
            shares_burned : arg3,
            assets_quoted : v1,
        };
        0x2::event::emit<ConcordRedeemEvent>(v7);
        v4
    }

    public fun redeem_collateral<T0, T1, T2: key>(arg0: &mut ConcordAdapter<T0, T1>, arg1: &0x22913eada7f742ef5714054f57b3f5cbe822e9ba3e809ba67a2ec3e900d23a32::stoken_cross_chain_asset_manager::CrossChainAssetManager<T0>, arg2: &mut 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_lending_vault::LendingVault<T0, T1, T2>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert_escrow_processor<T0, T1>(arg0, arg1, arg6);
        assert!(!arg0.paused, 0x22913eada7f742ef5714054f57b3f5cbe822e9ba3e809ba67a2ec3e900d23a32::stoken_errors::adapter_paused());
        assert!(arg3 > 0, 0x22913eada7f742ef5714054f57b3f5cbe822e9ba3e809ba67a2ec3e900d23a32::stoken_errors::adapter_zero_shares());
        let v0 = vault_addr<T0, T1, T2>(arg2);
        assert!(is_vault_allowed_internal<T0, T1>(arg0, v0), 0x22913eada7f742ef5714054f57b3f5cbe822e9ba3e809ba67a2ec3e900d23a32::stoken_errors::adapter_vault_not_allowed());
        assert!(0x2::table::contains<address, 0x2::bag::Bag>(&arg0.share_bags, v0), 0x22913eada7f742ef5714054f57b3f5cbe822e9ba3e809ba67a2ec3e900d23a32::stoken_errors::adapter_no_position());
        assert!(0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_lending_vault::is_collateral_mode<T0, T1, T2>(arg2), 0x22913eada7f742ef5714054f57b3f5cbe822e9ba3e809ba67a2ec3e900d23a32::stoken_errors::invalid_argument());
        let v1 = 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_lending_vault::preview_claim_collateral<T0, T1, T2>(arg2, arg3);
        assert!(v1 >= arg4, 0x22913eada7f742ef5714054f57b3f5cbe822e9ba3e809ba67a2ec3e900d23a32::stoken_errors::adapter_slippage_too_high());
        let v2 = take_custodied_shares<T0, T1, T2>(arg0, v0, arg3, arg6);
        let v3 = 0x2::object::id<ConcordAdapter<T0, T1>>(arg0);
        let v4 = 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_lending_vault::redeem_collateral_for<T0, T1, T2>(arg2, v2, 0x2::object::id_to_address(&v3), arg5, arg6);
        assert!(0x2::coin::value<T1>(&v4) >= arg4, 0x22913eada7f742ef5714054f57b3f5cbe822e9ba3e809ba67a2ec3e900d23a32::stoken_errors::adapter_slippage_too_high());
        if (0x2::table::contains<address, Position>(&arg0.positions, v0)) {
            let v5 = 0x2::table::borrow_mut<address, Position>(&mut arg0.positions, v0);
            let v6 = if (v5.shares_received > arg3) {
                v5.shares_received - arg3
            } else {
                0
            };
            v5.shares_received = v6;
        };
        let v7 = ConcordRedeemEvent{
            adapter_id    : 0x2::object::id<ConcordAdapter<T0, T1>>(arg0),
            vault         : v0,
            shares_burned : arg3,
            assets_quoted : v1,
        };
        0x2::event::emit<ConcordRedeemEvent>(v7);
        v4
    }

    public fun redeem_same_asset<T0, T1: key>(arg0: &mut ConcordAdapter<T0, T0>, arg1: &0x22913eada7f742ef5714054f57b3f5cbe822e9ba3e809ba67a2ec3e900d23a32::stoken_cross_chain_asset_manager::CrossChainAssetManager<T0>, arg2: &mut 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_lending_vault::LendingVault<T0, T0, T1>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_escrow_processor<T0, T0>(arg0, arg1, arg6);
        assert!(!arg0.paused, 0x22913eada7f742ef5714054f57b3f5cbe822e9ba3e809ba67a2ec3e900d23a32::stoken_errors::adapter_paused());
        assert!(arg3 > 0, 0x22913eada7f742ef5714054f57b3f5cbe822e9ba3e809ba67a2ec3e900d23a32::stoken_errors::adapter_zero_shares());
        let v0 = vault_addr<T0, T0, T1>(arg2);
        assert!(is_vault_allowed_internal<T0, T0>(arg0, v0), 0x22913eada7f742ef5714054f57b3f5cbe822e9ba3e809ba67a2ec3e900d23a32::stoken_errors::adapter_vault_not_allowed());
        assert!(0x2::table::contains<address, 0x2::bag::Bag>(&arg0.share_bags, v0), 0x22913eada7f742ef5714054f57b3f5cbe822e9ba3e809ba67a2ec3e900d23a32::stoken_errors::adapter_no_position());
        let v1 = if (0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_lending_vault::is_collateral_mode<T0, T0, T1>(arg2)) {
            0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_lending_vault::preview_claim_collateral<T0, T0, T1>(arg2, arg3)
        } else {
            0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_lending_vault::preview_redeem<T0, T0, T1>(arg2, arg3)
        };
        assert!(v1 >= arg4, 0x22913eada7f742ef5714054f57b3f5cbe822e9ba3e809ba67a2ec3e900d23a32::stoken_errors::adapter_slippage_too_high());
        let v2 = take_custodied_shares<T0, T0, T1>(arg0, v0, arg3, arg6);
        let v3 = 0x2::object::id<ConcordAdapter<T0, T0>>(arg0);
        let v4 = if (0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_lending_vault::is_collateral_mode<T0, T0, T1>(arg2)) {
            0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_lending_vault::redeem_collateral_for<T0, T0, T1>(arg2, v2, 0x2::object::id_to_address(&v3), arg5, arg6)
        } else {
            0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_lending_vault::redeem_principal_for<T0, T0, T1>(arg2, v2, 0x2::object::id_to_address(&v3), arg5, arg6)
        };
        let v5 = v4;
        assert!(0x2::coin::value<T0>(&v5) >= arg4, 0x22913eada7f742ef5714054f57b3f5cbe822e9ba3e809ba67a2ec3e900d23a32::stoken_errors::adapter_slippage_too_high());
        if (0x2::table::contains<address, Position>(&arg0.positions, v0)) {
            let v6 = 0x2::table::borrow_mut<address, Position>(&mut arg0.positions, v0);
            let v7 = if (v6.shares_received > arg3) {
                v6.shares_received - arg3
            } else {
                0
            };
            v6.shares_received = v7;
        };
        let v8 = ConcordRedeemEvent{
            adapter_id    : 0x2::object::id<ConcordAdapter<T0, T0>>(arg0),
            vault         : v0,
            shares_burned : arg3,
            assets_quoted : v1,
        };
        0x2::event::emit<ConcordRedeemEvent>(v8);
        v5
    }

    public fun set_allowed_vault<T0, T1>(arg0: &mut ConcordAdapter<T0, T1>, arg1: &ConcordAdapterAdminCap, arg2: address, arg3: bool, arg4: &0x2::tx_context::TxContext) {
        assert_admin<T0, T1>(arg0, arg1, arg4);
        if (0x2::table::contains<address, bool>(&arg0.allowed_vaults, arg2)) {
            *0x2::table::borrow_mut<address, bool>(&mut arg0.allowed_vaults, arg2) = arg3;
        } else {
            0x2::table::add<address, bool>(&mut arg0.allowed_vaults, arg2, arg3);
        };
        let v0 = ConcordAdapterAllowedVaultEvent{
            adapter_id : 0x2::object::id<ConcordAdapter<T0, T1>>(arg0),
            vault      : arg2,
            allowed    : arg3,
        };
        0x2::event::emit<ConcordAdapterAllowedVaultEvent>(v0);
    }

    fun take_custodied_shares<T0, T1, T2: key>(arg0: &mut ConcordAdapter<T0, T1>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        let v0 = 0x2::table::borrow_mut<address, 0x2::bag::Bag>(&mut arg0.share_bags, arg1);
        let v1 = ShareCustodyKey<T2>{dummy_field: false};
        assert!(0x2::bag::contains<ShareCustodyKey<T2>>(v0, v1), 0x22913eada7f742ef5714054f57b3f5cbe822e9ba3e809ba67a2ec3e900d23a32::stoken_errors::adapter_no_position());
        0x2::coin::from_balance<T2>(0x2::balance::split<T2>(0x2::bag::borrow_mut<ShareCustodyKey<T2>, 0x2::balance::Balance<T2>>(v0, v1), arg2), arg3)
    }

    public fun unpause<T0, T1>(arg0: &mut ConcordAdapter<T0, T1>, arg1: &ConcordAdapterAdminCap, arg2: &0x2::tx_context::TxContext) {
        assert_admin<T0, T1>(arg0, arg1, arg2);
        arg0.paused = false;
        let v0 = ConcordAdapterUnpausedEvent{adapter_id: 0x2::object::id<ConcordAdapter<T0, T1>>(arg0)};
        0x2::event::emit<ConcordAdapterUnpausedEvent>(v0);
    }

    fun vault_addr<T0, T1, T2: key>(arg0: &0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_lending_vault::LendingVault<T0, T1, T2>) : address {
        let v0 = 0x2::object::id<0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_lending_vault::LendingVault<T0, T1, T2>>(arg0);
        0x2::object::id_to_address(&v0)
    }

    // decompiled from Move bytecode v7
}

