module 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::tds_authorized_entry {
    struct SetCurrentLendingProtocolFlag has copy, drop {
        signer: address,
        index: u64,
        lending_protocol: u64,
    }

    struct SetLendingProtocolFlag has copy, drop {
        signer: address,
        index: u64,
        lending_protocol: u64,
    }

    struct AddPortfolioVaultAuthorizedUserEvent has copy, drop {
        signer: address,
        index: u64,
        users: vector<address>,
    }

    struct RemovePortfolioVaultAuthorizedUserEvent has copy, drop {
        signer: address,
        index: u64,
        users: vector<address>,
    }

    struct UpdateConfigEvent has copy, drop {
        signer: address,
        index: u64,
        previous: 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Config,
        current: 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Config,
    }

    struct UpdateActiveVaultConfigEvent has copy, drop {
        signer: address,
        index: u64,
        previous: 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::VaultConfig,
        current: 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::VaultConfig,
    }

    struct UpdateWarmupVaultConfigEvent has copy, drop {
        signer: address,
        index: u64,
        previous: 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::VaultConfig,
        current: 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::VaultConfig,
    }

    struct UpdateStrikeEvent has copy, drop {
        signer: address,
        index: u64,
        oracle_price: u64,
        oracle_price_decimal: u64,
        vault_config: 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::VaultConfig,
    }

    struct UpdateAuctionConfigEvent has copy, drop {
        signer: address,
        index: u64,
        start_ts_ms: u64,
        end_ts_ms: u64,
        decay_speed: u64,
        initial_price: u64,
        final_price: u64,
        fee_bp: u64,
        incentive_bp: u64,
        token_decimal: u64,
        size_decimal: u64,
        able_to_remove_bid: bool,
    }

    struct CreateScallopSpoolAccount has copy, drop {
        signer: address,
        index: u64,
        spool_id: address,
        spool_account_id: address,
    }

    struct EnableScallop has copy, drop {
        signer: address,
        index: u64,
    }

    struct DisableScallop has copy, drop {
        signer: address,
        index: u64,
    }

    struct DepositScallop has copy, drop {
        signer: address,
        index: u64,
        u64_padding: vector<u64>,
    }

    struct WithdrawScallop has copy, drop {
        signer: address,
        index: u64,
        u64_padding: vector<u64>,
    }

    struct FixedIncentiviseEvent has copy, drop {
        signer: address,
        token: 0x1::type_name::TypeName,
        amount: u64,
        fixed_incentive_amount: u64,
    }

    struct WithdrawFixedIncentiveEvent has copy, drop {
        signer: address,
        token: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct EnableScallopBasicLending has copy, drop {
        signer: address,
        index: u64,
    }

    struct DisableScallopBasicLending has copy, drop {
        signer: address,
        index: u64,
    }

    struct DepositScallopBasicLending has copy, drop {
        signer: address,
        index: u64,
        u64_padding: vector<u64>,
    }

    struct WithdrawScallopBasicLending has copy, drop {
        signer: address,
        index: u64,
        u64_padding: vector<u64>,
    }

    struct EnableAdditionalLending has copy, drop {
        signer: address,
        index: u64,
    }

    struct DisableAdditionalLending has copy, drop {
        signer: address,
        index: u64,
    }

    struct DepositAdditionalLending has copy, drop {
        signer: address,
        index: u64,
        u64_padding: vector<u64>,
    }

    struct WithdrawAdditionalLending has copy, drop {
        signer: address,
        index: u64,
        u64_padding: vector<u64>,
    }

    struct EnableSuilend has copy, drop {
        signer: address,
        index: u64,
    }

    struct DisableSuilend has copy, drop {
        signer: address,
        index: u64,
    }

    struct CreateSuilendObligationOwnerCap has copy, drop {
        signer: address,
        index: u64,
        lending_market_id: address,
        obligation_owner_cap_id: address,
    }

    struct DepositSuilend has copy, drop {
        signer: address,
        index: u64,
        u64_padding: vector<u64>,
    }

    struct WithdrawSuilend has copy, drop {
        signer: address,
        index: u64,
        u64_padding: vector<u64>,
    }

    struct RewardSuilend has copy, drop {
        signer: address,
        index: u64,
        u64_padding: vector<u64>,
    }

    struct CreateNaviAccountCap has copy, drop {
        signer: address,
        index: u64,
        account_cap_id: address,
    }

    struct DepositNavi has copy, drop {
        signer: address,
        index: u64,
        u64_padding: vector<u64>,
    }

    struct WithdrawNavi has copy, drop {
        signer: address,
        index: u64,
        u64_padding: vector<u64>,
    }

    struct RewardNavi has copy, drop {
        signer: address,
        index: u64,
        u64_padding: vector<u64>,
    }

    public(friend) entry fun activate<T0, T1, T2>(arg0: &mut 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg1: u64, arg2: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg3: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        safety_check<T0, T1>(arg0, arg1, arg5);
        0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::oracle_check(arg0, arg1, arg2);
        let (v0, v1, v2, v3, v4) = 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::activate_<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5);
        0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::emit_activate_event(arg0, arg1, v0, v4, v1, v2, v3, arg5);
    }

    entry fun add_portfolio_vault_authorized_user(arg0: &mut 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg1: u64, arg2: vector<address>, arg3: &0x2::tx_context::TxContext) {
        safety_check_without_token(arg0, arg1, arg3);
        let (_, _, _, _, v4, _, _, _, _, _, _, _) = 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::get_mut_registry_inner(arg0);
        let v12 = 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::get_mut_portfolio_vault(v4, arg1);
        while (!0x1::vector::is_empty<address>(&arg2)) {
            0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::authority::add_authorized_user(0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::get_mut_portfolio_vault_authority(v12), 0x1::vector::pop_back<address>(&mut arg2));
        };
        let v13 = AddPortfolioVaultAuthorizedUserEvent{
            signer : 0x2::tx_context::sender(arg3),
            index  : arg1,
            users  : 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::authority::whitelist(0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::get_portfolio_vault_authority(v12)),
        };
        0x2::event::emit<AddPortfolioVaultAuthorizedUserEvent>(v13);
    }

    public fun airdrop_otc<T0, T1>(arg0: &mut 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg1: u64, arg2: u64, arg3: 0x2::balance::Balance<T1>, arg4: 0x2::balance::Balance<T1>, arg5: vector<address>, arg6: vector<u64>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : vector<u64> {
        safety_check<T0, T1>(arg0, arg1, arg8);
        let v0 = 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::airdrop_otc_<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::emit_otc_event(arg0, arg1, *0x1::vector::borrow<u64>(&v0, 0), *0x1::vector::borrow<u64>(&v0, 1), *0x1::vector::borrow<u64>(&v0, 2), *0x1::vector::borrow<u64>(&v0, 3), 0, 0, 0, arg8);
        v0
    }

    public(friend) entry fun close<T0, T1>(arg0: &mut 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        safety_check<T0, T1>(arg0, arg1, arg2);
        0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::emit_close_event(arg0, arg1, arg2);
        0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::close_(arg0, arg1);
    }

    public(friend) entry fun create_navi_account_cap(arg0: &mut 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        safety_check_without_token(arg0, arg1, arg2);
        let v0 = CreateNaviAccountCap{
            signer         : 0x2::tx_context::sender(arg2),
            index          : arg1,
            account_cap_id : 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::create_navi_account_cap_(arg0, arg1, arg2),
        };
        0x2::event::emit<CreateNaviAccountCap>(v0);
    }

    public(friend) entry fun create_scallop_spool_account<T0, T1>(arg0: &mut 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg1: u64, arg2: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::Spool, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        safety_check<T0, T1>(arg0, arg1, arg4);
        let (v0, v1) = 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::create_scallop_spool_account_<T0>(arg0, arg1, arg2, arg3, arg4);
        let v2 = CreateScallopSpoolAccount{
            signer           : 0x2::tx_context::sender(arg4),
            index            : arg1,
            spool_id         : v0,
            spool_account_id : v1,
        };
        0x2::event::emit<CreateScallopSpoolAccount>(v2);
    }

    public(friend) entry fun create_suilend_obligation_owner_cap<T0, T1>(arg0: &mut 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg1: u64, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg3: &mut 0x2::tx_context::TxContext) {
        safety_check<T0, T1>(arg0, arg1, arg3);
        let (v0, v1) = 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::create_suilend_obligation_owner_cap_(arg0, arg1, arg2, arg3);
        let v2 = CreateSuilendObligationOwnerCap{
            signer                  : 0x2::tx_context::sender(arg3),
            index                   : arg1,
            lending_market_id       : v0,
            obligation_owner_cap_id : v1,
        };
        0x2::event::emit<CreateSuilendObligationOwnerCap>(v2);
    }

    public(friend) entry fun delivery<T0, T1, T2>(arg0: &mut 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg1: u64, arg2: bool, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        safety_check<T0, T1>(arg0, arg1, arg4);
        0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::emit_delivery_event(arg0, arg1, arg2, 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::delivery_<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4), arg4);
    }

    public(friend) entry fun deposit_navi<T0, T1>(arg0: &mut 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg1: u64, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg4: u8, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        safety_check<T0, T1>(arg0, arg1, arg8);
        let v0 = DepositNavi{
            signer      : 0x2::tx_context::sender(arg8),
            index       : arg1,
            u64_padding : 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::deposit_navi_<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8),
        };
        0x2::event::emit<DepositNavi>(v0);
    }

    public(friend) entry fun deposit_scallop<T0, T1>(arg0: &mut 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg1: u64, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::Spool, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        safety_check<T0, T1>(arg0, arg1, arg6);
        let v0 = DepositScallop{
            signer      : 0x2::tx_context::sender(arg6),
            index       : arg1,
            u64_padding : 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::deposit_scallop_<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6),
        };
        0x2::event::emit<DepositScallop>(v0);
    }

    public(friend) entry fun deposit_scallop_basic_lending<T0, T1>(arg0: &mut 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg1: u64, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        safety_check<T0, T1>(arg0, arg1, arg5);
        let v0 = DepositScallopBasicLending{
            signer      : 0x2::tx_context::sender(arg5),
            index       : arg1,
            u64_padding : 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::deposit_scallop_basic_lending_<T0>(arg0, arg1, arg2, arg3, arg4, arg5),
        };
        0x2::event::emit<DepositScallopBasicLending>(v0);
    }

    public(friend) entry fun deposit_suilend<T0, T1>(arg0: &mut 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg1: u64, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        safety_check<T0, T1>(arg0, arg1, arg5);
        let v0 = DepositSuilend{
            signer      : 0x2::tx_context::sender(arg5),
            index       : arg1,
            u64_padding : 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::deposit_suilend_<T0>(arg0, arg1, arg2, arg3, arg4, arg5),
        };
        0x2::event::emit<DepositSuilend>(v0);
    }

    public(friend) entry fun disable_additional_lending<T0, T1>(arg0: &mut 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        safety_check<T0, T1>(arg0, arg1, arg2);
        0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::set_enable_additional_lending_flag_(arg0, arg1, false);
        let v0 = DisableAdditionalLending{
            signer : 0x2::tx_context::sender(arg2),
            index  : arg1,
        };
        0x2::event::emit<DisableAdditionalLending>(v0);
    }

    public(friend) entry fun drop_vault<T0, T1>(arg0: &mut 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        safety_check<T0, T1>(arg0, arg1, arg2);
        0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::emit_drop_vault_event(arg0, arg1, arg2);
        0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::drop_<T0, T1>(arg0, arg1, arg2);
    }

    public(friend) entry fun enable_additional_lending<T0, T1>(arg0: &mut 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        safety_check<T0, T1>(arg0, arg1, arg2);
        0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::set_enable_additional_lending_flag_(arg0, arg1, true);
        let v0 = EnableAdditionalLending{
            signer : 0x2::tx_context::sender(arg2),
            index  : arg1,
        };
        0x2::event::emit<EnableAdditionalLending>(v0);
    }

    public(friend) entry fun fixed_incentivise<T0, T1, T2>(arg0: &mut 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg1: u64, arg2: 0x2::coin::Coin<T2>, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        safety_check<T0, T1>(arg0, arg1, arg4);
        let v0 = FixedIncentiviseEvent{
            signer                 : 0x2::tx_context::sender(arg4),
            token                  : 0x1::type_name::get<T2>(),
            amount                 : 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::fixed_incentivise_<T2>(arg0, arg1, arg2, arg3),
            fixed_incentive_amount : arg3,
        };
        0x2::event::emit<FixedIncentiviseEvent>(v0);
    }

    public(friend) entry fun new_auction<T0, T1>(arg0: &mut 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg1: u64, arg2: 0x1::option::Option<u64>, arg3: 0x1::option::Option<u64>, arg4: &mut 0x2::tx_context::TxContext) {
        safety_check<T0, T1>(arg0, arg1, arg4);
        let (v0, v1, v2) = 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::new_auction_<T1>(arg0, arg1, arg2, arg3, arg4);
        0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::emit_new_auction_event(arg0, arg1, v0, v1, v2, arg4);
    }

    public(friend) entry fun otc<T0, T1>(arg0: &mut 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg1: u64, arg2: vector<0x2::coin::Coin<T1>>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        safety_check<T0, T1>(arg0, arg1, arg11);
        let (v0, _, _, _, v4, _, _, _, _, _, _, _) = 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::get_mut_registry_inner(arg0);
        let v12 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::utils::extract_balance<T1>(arg2, arg5 + arg6, arg11);
        let (v13, v14, v15) = 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::get_otc_incentive_balance<T1>(v0, 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::get_mut_portfolio_vault(v4, arg1), arg7, arg8, arg9);
        0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::otc_<T0, T1>(arg0, arg1, arg3, arg4, v12, 0x2::balance::split<T1>(&mut v12, arg6), v13, v14, v15, arg10, arg11);
        0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::emit_otc_event(arg0, arg1, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg11);
    }

    public fun post_reward_navi<T0, T1, T2>(arg0: &mut 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg1: u64, arg2: vector<0x2::balance::Balance<T2>>, arg3: &0x2::tx_context::TxContext) {
        safety_check<T0, T1>(arg0, arg1, arg3);
        let v0 = RewardNavi{
            signer      : 0x2::tx_context::sender(arg3),
            index       : arg1,
            u64_padding : 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::reward_from_lending_<T2>(arg0, arg1, arg2),
        };
        0x2::event::emit<RewardNavi>(v0);
    }

    public fun pre_reward_navi<T0, T1, T2>(arg0: &mut 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg1: u64, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::RewardFund<T2>, arg4: vector<0x1::ascii::String>, arg5: vector<address>, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T2> {
        safety_check<T0, T1>(arg0, arg1, arg8);
        0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::reward_navi_<T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    }

    public(friend) entry fun recoup<T0, T1>(arg0: &mut 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        safety_check<T0, T1>(arg0, arg1, arg3);
        let (v0, v1) = 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::recoup_<T0>(arg0, arg1, arg2, arg3);
        0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::emit_recoup_event(arg0, arg1, v0, v1, arg3);
    }

    public(friend) entry fun refresh_suilend_reserve_price(arg0: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject) {
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg0, arg1, arg2, arg3);
    }

    entry fun remove_portfolio_vault_authorized_user(arg0: &mut 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg1: u64, arg2: vector<address>, arg3: &0x2::tx_context::TxContext) {
        safety_check_without_token(arg0, arg1, arg3);
        let (_, _, _, _, v4, _, _, _, _, _, _, _) = 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::get_mut_registry_inner(arg0);
        let v12 = 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::get_mut_portfolio_vault(v4, arg1);
        while (!0x1::vector::is_empty<address>(&arg2)) {
            0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::authority::remove_authorized_user(0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::get_mut_portfolio_vault_authority(v12), 0x1::vector::pop_back<address>(&mut arg2));
        };
        let v13 = RemovePortfolioVaultAuthorizedUserEvent{
            signer : 0x2::tx_context::sender(arg3),
            index  : arg1,
            users  : 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::authority::whitelist(0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::get_portfolio_vault_authority(v12)),
        };
        0x2::event::emit<RemovePortfolioVaultAuthorizedUserEvent>(v13);
    }

    public(friend) entry fun resume<T0, T1>(arg0: &mut 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        safety_check<T0, T1>(arg0, arg1, arg2);
        0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::emit_resume_event(arg0, arg1, arg2);
        0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::resume_(arg0, arg1);
    }

    public(friend) entry fun reward_suilend<T0, T1, T2>(arg0: &mut 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg1: u64, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        safety_check<T0, T1>(arg0, arg1, arg6);
        let v0 = RewardSuilend{
            signer      : 0x2::tx_context::sender(arg6),
            index       : arg1,
            u64_padding : 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::reward_suilend_<T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6),
        };
        0x2::event::emit<RewardSuilend>(v0);
    }

    fun safety_check<T0, T1>(arg0: &0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::version_check(arg0);
        0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::validate_portfolio_authority(arg0, arg1, arg2);
        0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::portfolio_vault_token_check<T0, T1>(arg0, arg1);
    }

    fun safety_check_without_token(arg0: &0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::version_check(arg0);
        0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::validate_portfolio_authority(arg0, arg1, arg2);
    }

    public fun safu_otc<T0, T1>(arg0: &mut 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg1: u64, arg2: u64, arg3: 0x2::balance::Balance<T1>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x1::option::Option<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusBidReceipt>, 0x2::balance::Balance<T1>, vector<u64>) {
        abort 0
    }

    public fun safu_otc_v2<T0, T1>(arg0: &mut 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg1: u64, arg2: u64, arg3: 0x2::balance::Balance<T1>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x1::option::Option<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusBidReceipt>, vector<u64>) {
        safety_check<T0, T1>(arg0, arg1, arg5);
        let (v0, v1) = 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::public_safu_otc_v2_<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
        let v2 = v1;
        0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::emit_otc_event(arg0, arg1, *0x1::vector::borrow<u64>(&v2, 0), *0x1::vector::borrow<u64>(&v2, 1), *0x1::vector::borrow<u64>(&v2, 2), *0x1::vector::borrow<u64>(&v2, 3), 0, 0, 0, arg5);
        (v0, v2)
    }

    entry fun set_current_lending_protocol_flag(arg0: &mut 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg1: u64, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        safety_check_without_token(arg0, arg1, arg3);
        0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::set_current_lending_protocol_flag_(arg0, arg1, arg2);
        let v0 = SetCurrentLendingProtocolFlag{
            signer           : 0x2::tx_context::sender(arg3),
            index            : arg1,
            lending_protocol : arg2,
        };
        0x2::event::emit<SetCurrentLendingProtocolFlag>(v0);
    }

    entry fun set_lending_protocol_flag(arg0: &mut 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg1: u64, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        safety_check_without_token(arg0, arg1, arg3);
        0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::set_lending_protocol_flag_(arg0, arg1, arg2);
        let v0 = SetLendingProtocolFlag{
            signer           : 0x2::tx_context::sender(arg3),
            index            : arg1,
            lending_protocol : arg2,
        };
        0x2::event::emit<SetLendingProtocolFlag>(v0);
    }

    public(friend) entry fun settle<T0, T1>(arg0: &mut 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg1: u64, arg2: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg3: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        safety_check<T0, T1>(arg0, arg1, arg5);
        0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::oracle_check(arg0, arg1, arg2);
        let (v0, v1, v2, v3, v4, v5) = 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::settle_<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
        let v6 = v5;
        0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::emit_settle_event(arg0, arg1, v0, v1, v2, v3, v4, arg5);
        if (!0x1::vector::is_empty<u64>(&v6)) {
            0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::emit_skip_event(arg1, v6, arg5);
        };
    }

    public(friend) entry fun terminate_auction<T0, T1>(arg0: &mut 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        safety_check<T0, T1>(arg0, arg1, arg2);
        0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::emit_terminate_auction_event(arg0, arg1, arg2);
        let (v0, _, _, _, _, _, v6, _, v8, _, _, _) = 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::get_mut_registry_inner(arg0);
        let v12 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::dutch::terminate<T1>(0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::take_auction(v6, arg1), 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::get_mut_refund_vault<T1>(v8), arg2);
        if (0x2::balance::value<T1>(&v12) > 0) {
            0x2::balance::join<T1>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(v0, 0x1::type_name::get<T1>()), v12);
        } else {
            0x2::balance::destroy_zero<T1>(v12);
        };
    }

    public(friend) entry fun terminate_vault<T0, T1>(arg0: &mut 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        safety_check<T0, T1>(arg0, arg1, arg2);
        0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::emit_termiante_vault_event(arg0, arg1, arg2);
        0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::terminate_<T0>(arg0, arg1, arg2);
    }

    public(friend) entry fun update_auction_config(arg0: &mut 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: bool, arg12: &0x2::clock::Clock, arg13: &0x2::tx_context::TxContext) {
        safety_check_without_token(arg0, arg1, arg13);
        0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::update_auction_config_(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        let v0 = UpdateAuctionConfigEvent{
            signer             : 0x2::tx_context::sender(arg13),
            index              : arg1,
            start_ts_ms        : arg2,
            end_ts_ms          : arg3,
            decay_speed        : arg4,
            initial_price      : arg5,
            final_price        : arg6,
            fee_bp             : arg7,
            incentive_bp       : arg8,
            token_decimal      : arg9,
            size_decimal       : arg10,
            able_to_remove_bid : arg11,
        };
        0x2::event::emit<UpdateAuctionConfigEvent>(v0);
    }

    entry fun update_config(arg0: &mut 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg1: u64, arg2: 0x1::option::Option<address>, arg3: 0x1::option::Option<u64>, arg4: 0x1::option::Option<u64>, arg5: 0x1::option::Option<u64>, arg6: 0x1::option::Option<u64>, arg7: 0x1::option::Option<u64>, arg8: 0x1::option::Option<u64>, arg9: 0x1::option::Option<u64>, arg10: 0x1::option::Option<u64>, arg11: 0x1::option::Option<0x1::option::Option<vector<u8>>>, arg12: 0x1::option::Option<u64>, arg13: 0x1::option::Option<u64>, arg14: 0x1::option::Option<u64>, arg15: 0x1::option::Option<u64>, arg16: 0x1::option::Option<u64>, arg17: 0x1::option::Option<u64>, arg18: 0x1::option::Option<u64>, arg19: 0x1::option::Option<u64>, arg20: 0x1::option::Option<u64>, arg21: 0x1::option::Option<u64>, arg22: &0x2::tx_context::TxContext) {
        safety_check_without_token(arg0, arg1, arg22);
        let (v0, v1) = 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::update_config_(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20, arg21, arg22);
        let v2 = UpdateConfigEvent{
            signer   : 0x2::tx_context::sender(arg22),
            index    : arg1,
            previous : v0,
            current  : v1,
        };
        0x2::event::emit<UpdateConfigEvent>(v2);
    }

    entry fun update_oracle(arg0: &mut 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg1: u64, arg2: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg3: &0x2::tx_context::TxContext) {
        safety_check_without_token(arg0, arg1, arg3);
        0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::update_oracle_(arg0, arg1, arg2);
    }

    public(friend) entry fun update_strike(arg0: &mut 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg1: u64, arg2: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        safety_check_without_token(arg0, arg1, arg4);
        0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::oracle_check(arg0, arg1, arg2);
        let (v0, v1, v2) = 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::update_strike_(arg0, arg1, arg2, arg3);
        let v3 = UpdateStrikeEvent{
            signer               : 0x2::tx_context::sender(arg4),
            index                : arg1,
            oracle_price         : v0,
            oracle_price_decimal : v1,
            vault_config         : v2,
        };
        0x2::event::emit<UpdateStrikeEvent>(v3);
    }

    public(friend) entry fun update_warmup_vault_config(arg0: &mut 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg1: u64, arg2: vector<u64>, arg3: vector<u64>, arg4: vector<bool>, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: &0x2::tx_context::TxContext) {
        safety_check_without_token(arg0, arg1, arg9);
        let (v0, v1) = 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::update_warmup_vault_config_(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        let v2 = UpdateWarmupVaultConfigEvent{
            signer   : 0x2::tx_context::sender(arg9),
            index    : arg1,
            previous : v0,
            current  : v1,
        };
        0x2::event::emit<UpdateWarmupVaultConfigEvent>(v2);
    }

    public(friend) entry fun withdraw_fixed_incentive<T0>(arg0: &mut 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg1: u64, arg2: 0x1::option::Option<u64>, arg3: &mut 0x2::tx_context::TxContext) {
        safety_check_without_token(arg0, arg1, arg3);
        let v0 = 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::withdraw_fixed_incentive_<T0>(arg0, arg1, arg2, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg3));
        let v1 = WithdrawFixedIncentiveEvent{
            signer : 0x2::tx_context::sender(arg3),
            token  : 0x1::type_name::get<T0>(),
            amount : 0x2::coin::value<T0>(&v0),
        };
        0x2::event::emit<WithdrawFixedIncentiveEvent>(v1);
    }

    public entry fun withdraw_navi<T0, T1>(arg0: &mut 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg1: u64, arg2: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg3: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg4: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: address, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg9: u8, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg11: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg12: &0x2::clock::Clock, arg13: &0x2::tx_context::TxContext) {
        safety_check<T0, T1>(arg0, arg1, arg13);
        let v0 = WithdrawNavi{
            signer      : 0x2::tx_context::sender(arg13),
            index       : arg1,
            u64_padding : 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::withdraw_navi_<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12),
        };
        0x2::event::emit<WithdrawNavi>(v0);
    }

    public(friend) entry fun withdraw_scallop<T0, T1, T2>(arg0: &mut 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg1: u64, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::Spool, arg5: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::rewards_pool::RewardsPool<T2>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        safety_check<T0, T1>(arg0, arg1, arg7);
        let v0 = WithdrawScallop{
            signer      : 0x2::tx_context::sender(arg7),
            index       : arg1,
            u64_padding : 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::withdraw_scallop_<T0, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7),
        };
        0x2::event::emit<WithdrawScallop>(v0);
    }

    public(friend) entry fun withdraw_scallop_basic_lending<T0, T1>(arg0: &mut 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg1: u64, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        safety_check<T0, T1>(arg0, arg1, arg5);
        let v0 = WithdrawScallopBasicLending{
            signer      : 0x2::tx_context::sender(arg5),
            index       : arg1,
            u64_padding : 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::withdraw_scallop_basic_lending_<T0>(arg0, arg1, arg2, arg3, arg4, arg5),
        };
        0x2::event::emit<WithdrawScallopBasicLending>(v0);
    }

    public(friend) entry fun withdraw_suilend<T0, T1, T2>(arg0: &mut 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg1: u64, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg3: u64, arg4: 0x1::option::Option<u64>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        safety_check<T0, T1>(arg0, arg1, arg6);
        let v0 = WithdrawSuilend{
            signer      : 0x2::tx_context::sender(arg6),
            index       : arg1,
            u64_padding : 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::withdraw_suilend_<T0, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6),
        };
        0x2::event::emit<WithdrawSuilend>(v0);
    }

    // decompiled from Move bytecode v6
}

