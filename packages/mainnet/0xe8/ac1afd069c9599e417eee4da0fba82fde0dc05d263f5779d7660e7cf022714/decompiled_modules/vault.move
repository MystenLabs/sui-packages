module 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct OperatorCap has store, key {
        id: 0x2::object::UID,
    }

    struct Request<phantom T0> has store {
        deposit_id_count: u64,
        deposit_requests: 0x2::table::Table<u64, 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::deposit_request::DepositRequest>,
        deposit_receipt_buffer: 0x2::table::Table<u64, 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::receipt::Receipt>,
        deposit_coin_buffer: 0x2::table::Table<u64, 0x2::coin::Coin<T0>>,
        withdraw_id_count: u64,
        withdraw_requests: 0x2::table::Table<u64, 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::withdraw_request::WithdrawRequest>,
        withdraw_receipt_buffer: 0x2::table::Table<u64, 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::receipt::Receipt>,
        withdraw_coin_buffer: 0x2::table::Table<u64, 0x2::coin::Coin<T0>>,
    }

    struct Vault<phantom T0> has store, key {
        id: 0x2::object::UID,
        version: u64,
        enabled: bool,
        total_shares: u256,
        locking_time: u64,
        request_cancel_time: u64,
        last_total_usd_value: u256,
        total_usd_value_updated: u64,
        performance_fee_cumulated: u256,
        performance_fee_collected: 0x2::balance::Balance<T0>,
        deposit_withdraw_fee_collected: 0x2::balance::Balance<T0>,
        navi_asset_id: u8,
        principal_decimal: u8,
        free_principal: 0x2::balance::Balance<T0>,
        performance_fee_rate: u64,
        deposit_fee_rate: u64,
        withdraw_fee_rate: u64,
        asset_types: vector<0x1::ascii::String>,
        assets: 0x2::bag::Bag,
        assets_value: 0x2::table::Table<0x1::ascii::String, u256>,
        assets_value_updated: 0x2::table::Table<0x1::ascii::String, u64>,
        cur_epoch: u64,
        cur_epoch_loss: u256,
        loss_tolerance: u256,
        rewards: 0x2::bag::Bag,
        reward_indices: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u256>,
        reward_buffer: address,
        request: Request<T0>,
    }

    struct BufferDistribution has store {
        rate: u64,
        last_updated: u64,
    }

    struct RewardBuffer has store, key {
        id: 0x2::object::UID,
        vault_id: address,
        rewards: 0x2::bag::Bag,
        distribution: 0x2::table::Table<0x1::type_name::TypeName, BufferDistribution>,
    }

    struct VaultCreated has copy, drop {
        vault_id: address,
        principal: 0x1::type_name::TypeName,
        navi_asset_id: u8,
        principal_decimal: u8,
    }

    struct VaultEnabled has copy, drop {
        vault_id: address,
        enabled: bool,
    }

    struct DepositRequested has copy, drop {
        request_id: u64,
        receipt_id: address,
        recipient: address,
        vault_id: address,
        amount: u64,
        expected_shares: u256,
    }

    struct DepositCancelled has copy, drop {
        request_id: u64,
        receipt_id: address,
        recipient: address,
        vault_id: address,
        amount: u64,
    }

    struct DepositExecuted has copy, drop {
        request_id: u64,
        receipt_id: address,
        vault_id: address,
        coin_type: 0x1::ascii::String,
        deposit_amount: u64,
        new_share: u256,
    }

    struct WithdrawRequested has copy, drop {
        request_id: u64,
        receipt_id: address,
        recipient: address,
        vault_id: address,
        shares: u256,
        expected_amount: u64,
    }

    struct WithdrawCancelled has copy, drop {
        request_id: u64,
        receipt_id: address,
        recipient: address,
        vault_id: address,
        shares: u256,
    }

    struct RewardAdded has copy, drop {
        vault_id: address,
        coin_type: 0x1::type_name::TypeName,
        reward_amount: u64,
        inc_reward_index: u256,
        new_reward_index: u256,
    }

    struct RewardClaimed has copy, drop {
        vault_id: address,
        receipt_id: address,
        coin_type: 0x1::type_name::TypeName,
        reward_amount: u64,
    }

    struct ToleranceChanged has copy, drop {
        vault_id: address,
        tolerance: u256,
    }

    struct WithdrawFeeChanged has copy, drop {
        vault_id: address,
        fee: u64,
    }

    struct DepositFeeChanged has copy, drop {
        vault_id: address,
        fee: u64,
    }

    struct PerformanceFeeRateChanged has copy, drop {
        vault_id: address,
        fee: u64,
    }

    struct RewardBufferCreated has copy, drop {
        vault_id: address,
        buffer_id: address,
    }

    struct RewardBufferUpdated has copy, drop {
        vault_id: address,
        coin_type: 0x1::type_name::TypeName,
        reward_amount: u64,
    }

    struct RewardBufferRateUpdated has copy, drop {
        vault_id: address,
        coin_type: 0x1::type_name::TypeName,
        rate: u64,
    }

    struct RewardBufferAdded has copy, drop {
        vault_id: address,
        coin_type: 0x1::type_name::TypeName,
        reward_amount: u64,
    }

    struct RewardBufferSet has copy, drop {
        vault_id: address,
        buffer_id: address,
    }

    struct VaultUpgraded has copy, drop {
        vault_id: address,
        version: u64,
    }

    struct FreePrincipalReturned has copy, drop {
        vault_id: address,
        amount: u64,
    }

    struct FreePrincipalBorrowed has copy, drop {
        vault_id: address,
        amount: u64,
    }

    struct LossToleranceReset has copy, drop {
        vault_id: address,
        epoch: u64,
    }

    struct LossToleranceUpdated has copy, drop {
        vault_id: address,
        current_loss: u256,
        loss_limit: u256,
    }

    struct DepositByOperator has copy, drop {
        vault_id: address,
        amount: u64,
    }

    struct PerformanceFeeCharged has copy, drop {
        vault_id: address,
        amount: u256,
    }

    struct NewAssetTypeAdded has copy, drop {
        vault_id: address,
        asset_type: 0x1::ascii::String,
    }

    public fun deposit_request<T0>(arg0: &Vault<T0>, arg1: u64) : &0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::deposit_request::DepositRequest {
        0x2::table::borrow<u64, 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::deposit_request::DepositRequest>(&arg0.request.deposit_requests, arg1)
    }

    public fun vault_id<T0>(arg0: &Vault<T0>) : address {
        0x2::object::uid_to_address(&arg0.id)
    }

    public(friend) fun add_new_bluefin_position<T0>(arg0: &mut Vault<T0>, arg1: u8, arg2: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position) {
        let v0 = 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault_utils::parse_key<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(arg1);
        set_new_asset_type<T0>(arg0, v0);
        0x2::bag::add<0x1::ascii::String, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg0.assets, v0, arg2);
    }

    public(friend) fun add_new_cetus_position<T0>(arg0: &mut Vault<T0>, arg1: u8, arg2: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position) {
        let v0 = 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault_utils::parse_key<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg1);
        set_new_asset_type<T0>(arg0, v0);
        0x2::bag::add<0x1::ascii::String, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.assets, v0, arg2);
    }

    public(friend) fun add_new_coin_type_asset<T0, T1>(arg0: &mut Vault<T0>) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        set_new_asset_type<T0>(arg0, v0);
        0x2::bag::add<0x1::ascii::String, 0x2::balance::Balance<T1>>(&mut arg0.assets, v0, 0x2::balance::zero<T1>());
    }

    public(friend) fun add_new_momentum_position<T0>(arg0: &mut Vault<T0>, arg1: u8, arg2: 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position) {
        let v0 = 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault_utils::parse_key<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(arg1);
        set_new_asset_type<T0>(arg0, v0);
        0x2::bag::add<0x1::ascii::String, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&mut arg0.assets, v0, arg2);
    }

    public(friend) fun add_new_navi_account_cap<T0>(arg0: &mut Vault<T0>, arg1: u8, arg2: 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap) {
        let v0 = 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault_utils::parse_key<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(arg1);
        set_new_asset_type<T0>(arg0, v0);
        0x2::bag::add<0x1::ascii::String, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(&mut arg0.assets, v0, arg2);
    }

    public(friend) fun add_new_suilend_obligation<T0, T1>(arg0: &mut Vault<T0>, arg1: u8, arg2: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::Obligation<T1>) {
        let v0 = 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault_utils::parse_key<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::Obligation<T1>>(arg1);
        set_new_asset_type<T0>(arg0, v0);
        0x2::bag::add<0x1::ascii::String, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::Obligation<T1>>(&mut arg0.assets, v0, arg2);
    }

    public(friend) fun add_reward_balance<T0, T1>(arg0: &mut Vault<T0>, arg1: 0x2::balance::Balance<T1>) {
        let v0 = 0x1::type_name::get<T1>();
        let v1 = 0x2::balance::value<T1>(&arg1);
        if (!0x2::bag::contains_with_type<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&arg0.rewards, v0)) {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.rewards, v0, 0x2::balance::zero<T1>());
        };
        if (!0x2::vec_map::contains<0x1::type_name::TypeName, u256>(&arg0.reward_indices, &v0)) {
            0x2::vec_map::insert<0x1::type_name::TypeName, u256>(&mut arg0.reward_indices, v0, 0);
        };
        0x2::balance::join<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.rewards, v0), arg1);
        let v2 = 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault_utils::div_d(0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault_utils::to_decimals((v1 as u256)), total_shares<T0>(arg0));
        let v3 = 0x2::vec_map::try_get<0x1::type_name::TypeName, u256>(&arg0.reward_indices, &v0);
        let v4 = v2 + 0x1::option::get_with_default<u256>(&v3, 0);
        *0x2::vec_map::get_mut<0x1::type_name::TypeName, u256>(&mut arg0.reward_indices, &v0) = v4;
        let v5 = RewardAdded{
            vault_id         : vault_id<T0>(arg0),
            coin_type        : v0,
            reward_amount    : v1,
            inc_reward_index : v2,
            new_reward_index : v4,
        };
        0x2::event::emit<RewardAdded>(v5);
    }

    public(friend) fun add_reward_with_buffer<T0, T1>(arg0: &mut Vault<T0>, arg1: &0x2::clock::Clock, arg2: &mut RewardBuffer, arg3: 0x2::balance::Balance<T1>) {
        let v0 = 0x1::type_name::get<T1>();
        update_reward_buffer<T0, T1>(arg0, arg1, arg2);
        0x2::balance::join<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg2.rewards, v0), arg3);
        let v1 = RewardBufferAdded{
            vault_id      : vault_id<T0>(arg0),
            coin_type     : v0,
            reward_amount : 0x2::balance::value<T1>(&arg3),
        };
        0x2::event::emit<RewardBufferAdded>(v1);
    }

    public(friend) fun assert_enabled<T0>(arg0: &Vault<T0>) {
        assert!(arg0.enabled, 1013);
    }

    public(friend) fun assert_vault_receipt_matched<T0>(arg0: &Vault<T0>, arg1: &0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::receipt::Receipt) {
        assert!(0x2::object::uid_to_address(&arg0.id) == 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::receipt::vault_id(arg1), 1014);
    }

    public(friend) fun borrow_bluefin_position<T0>(arg0: &mut Vault<T0>, arg1: u8) : 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position {
        0x2::bag::remove<0x1::ascii::String, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg0.assets, 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault_utils::parse_key<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(arg1))
    }

    public(friend) fun borrow_cetus_position<T0>(arg0: &mut Vault<T0>, arg1: u8) : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position {
        0x2::bag::remove<0x1::ascii::String, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.assets, 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault_utils::parse_key<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg1))
    }

    public(friend) fun borrow_coin_type_asset<T0, T1>(arg0: &mut Vault<T0>, arg1: u64) : 0x2::balance::Balance<T1> {
        0x2::balance::split<T1>(0x2::bag::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T1>>(&mut arg0.assets, 0x1::type_name::into_string(0x1::type_name::get<T1>())), arg1)
    }

    public(friend) fun borrow_defi_asset<T0, T1: store + key>(arg0: &mut Vault<T0>, arg1: 0x1::ascii::String) : T1 {
        assert!(contains_asset_type<T0>(arg0, arg1), 1022);
        0x2::bag::remove<0x1::ascii::String, T1>(&mut arg0.assets, arg1)
    }

    public(friend) fun borrow_free_principal<T0>(arg0: &mut Vault<T0>, arg1: u64) : 0x2::balance::Balance<T0> {
        let v0 = FreePrincipalBorrowed{
            vault_id : vault_id<T0>(arg0),
            amount   : arg1,
        };
        0x2::event::emit<FreePrincipalBorrowed>(v0);
        0x2::balance::split<T0>(&mut arg0.free_principal, arg1)
    }

    public(friend) fun borrow_momentum_position<T0>(arg0: &mut Vault<T0>, arg1: u8) : 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position {
        0x2::bag::remove<0x1::ascii::String, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&mut arg0.assets, 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault_utils::parse_key<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(arg1))
    }

    public(friend) fun borrow_navi_account_cap<T0>(arg0: &mut Vault<T0>, arg1: u8) : 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap {
        0x2::bag::remove<0x1::ascii::String, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(&mut arg0.assets, 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault_utils::parse_key<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(arg1))
    }

    public(friend) fun borrow_suilend_obligation<T0, T1>(arg0: &mut Vault<T0>, arg1: u8) : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::Obligation<T1> {
        0x2::bag::remove<0x1::ascii::String, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::Obligation<T1>>(&mut arg0.assets, 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault_utils::parse_key<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::Obligation<T1>>(arg1))
    }

    public(friend) fun cancel_deposit<T0>(arg0: &mut Vault<T0>, arg1: u64, arg2: address) {
        assert!(0x2::table::contains<u64, 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::deposit_request::DepositRequest>(&arg0.request.deposit_requests, arg1), 1018);
        let v0 = 0x2::table::borrow_mut<u64, 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::deposit_request::DepositRequest>(&mut arg0.request.deposit_requests, arg1);
        assert!(0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::deposit_request::vault_id(v0) == 0x2::object::uid_to_address(&arg0.id), 1003);
        assert!(!0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::deposit_request::is_executed(v0), 1004);
        assert!(!0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::deposit_request::is_cancelled(v0), 1005);
        assert!(0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::deposit_request::recipient(v0) == arg2, 1006);
        0x2::transfer::public_transfer<0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::receipt::Receipt>(0x2::table::remove<u64, 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::receipt::Receipt>(&mut arg0.request.deposit_receipt_buffer, arg1), arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::table::remove<u64, 0x2::coin::Coin<T0>>(&mut arg0.request.deposit_coin_buffer, arg1), arg2);
        let v1 = DepositCancelled{
            request_id : arg1,
            receipt_id : 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::deposit_request::receipt_id(v0),
            recipient  : arg2,
            vault_id   : 0x2::object::uid_to_address(&arg0.id),
            amount     : 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::deposit_request::amount(v0),
        };
        0x2::event::emit<DepositCancelled>(v1);
        0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::deposit_request::cancel(v0);
    }

    public(friend) fun cancel_withdraw<T0>(arg0: &mut Vault<T0>, arg1: u64, arg2: address) {
        let v0 = 0x2::table::borrow_mut<u64, 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::withdraw_request::WithdrawRequest>(&mut arg0.request.withdraw_requests, arg1);
        assert!(0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::withdraw_request::vault_id(v0) == 0x2::object::uid_to_address(&arg0.id), 1003);
        assert!(!0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::withdraw_request::is_executed(v0), 1004);
        assert!(!0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::withdraw_request::is_cancelled(v0), 1005);
        assert!(0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::withdraw_request::recipient(v0) == arg2, 1006);
        0x2::transfer::public_transfer<0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::receipt::Receipt>(0x2::table::remove<u64, 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::receipt::Receipt>(&mut arg0.request.withdraw_receipt_buffer, arg1), arg2);
        let v1 = WithdrawCancelled{
            request_id : arg1,
            receipt_id : 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::withdraw_request::receipt_id(v0),
            recipient  : arg2,
            vault_id   : 0x2::object::uid_to_address(&arg0.id),
            shares     : 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::withdraw_request::shares(v0),
        };
        0x2::event::emit<WithdrawCancelled>(v1);
        0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::withdraw_request::cancel(v0);
    }

    public(friend) fun charge_performance_fee<T0>(arg0: &mut Vault<T0>, arg1: &0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault_oracle::OracleConfig, arg2: &0x2::clock::Clock, arg3: u256) : u256 {
        let v0 = arg3 * (performance_fee_rate<T0>(arg0) as u256) / (10000 as u256);
        if (v0 > 0) {
            arg0.performance_fee_cumulated = arg0.performance_fee_cumulated + v0;
            let v1 = (0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault_utils::div_with_oracle_price(v0, 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault_oracle::get_asset_price(arg1, arg2, 0x1::type_name::into_string(0x1::type_name::get<T0>()))) as u64);
            assert!(0x2::balance::value<T0>(&arg0.free_principal) >= v1, 1021);
            0x2::balance::join<T0>(&mut arg0.performance_fee_collected, 0x2::balance::split<T0>(&mut arg0.free_principal, v1));
        };
        let v2 = PerformanceFeeCharged{
            vault_id : vault_id<T0>(arg0),
            amount   : v0,
        };
        0x2::event::emit<PerformanceFeeCharged>(v2);
        v0
    }

    public(friend) fun claim_reward<T0, T1>(arg0: &mut Vault<T0>, arg1: &0x2::clock::Clock, arg2: &mut RewardBuffer, arg3: &mut 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::receipt::Receipt) : 0x2::balance::Balance<T1> {
        assert_enabled<T0>(arg0);
        assert_vault_receipt_matched<T0>(arg0, arg3);
        update_reward_buffer<T0, T1>(arg0, arg1, arg2);
        update_receipt_reward<T0>(arg0, arg3);
        let v0 = 0x1::type_name::get<T1>();
        let v1 = 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::receipt::reset_unclaimed_rewards<T1>(arg3);
        let v2 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.rewards, v0);
        assert!(v1 <= 0x2::balance::value<T1>(v2), 1002);
        let v3 = RewardClaimed{
            vault_id      : 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::receipt::vault_id(arg3),
            receipt_id    : 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::receipt::receipt_id(arg3),
            coin_type     : v0,
            reward_amount : v1,
        };
        0x2::event::emit<RewardClaimed>(v3);
        0x2::balance::split<T1>(v2, v1)
    }

    public(friend) fun contains_asset_type<T0>(arg0: &Vault<T0>, arg1: 0x1::ascii::String) : bool {
        0x2::bag::contains<0x1::ascii::String>(&arg0.assets, arg1)
    }

    public(friend) fun create_operator_cap(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) : OperatorCap {
        OperatorCap{id: 0x2::object::new(arg1)}
    }

    public(friend) fun create_reward_buffer<T0>(arg0: &mut Vault<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = RewardBuffer{
            id           : 0x2::object::new(arg1),
            vault_id     : vault_id<T0>(arg0),
            rewards      : 0x2::bag::new(arg1),
            distribution : 0x2::table::new<0x1::type_name::TypeName, BufferDistribution>(arg1),
        };
        let v1 = RewardBufferCreated{
            vault_id  : vault_id<T0>(arg0),
            buffer_id : 0x2::object::id_address<RewardBuffer>(&v0),
        };
        0x2::event::emit<RewardBufferCreated>(v1);
        set_reward_buffer<T0>(arg0, 0x2::object::id_address<RewardBuffer>(&v0));
        0x2::transfer::share_object<RewardBuffer>(v0);
    }

    public(friend) fun create_vault<T0>(arg0: &AdminCap, arg1: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg4);
        assert!(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_coin_type(arg1, arg3) == 0x1::type_name::into_string(0x1::type_name::get<T0>()), 1001);
        let v1 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::get_coin_decimal<T0>(arg2);
        let v2 = Request<T0>{
            deposit_id_count        : 0,
            deposit_requests        : 0x2::table::new<u64, 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::deposit_request::DepositRequest>(arg4),
            deposit_receipt_buffer  : 0x2::table::new<u64, 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::receipt::Receipt>(arg4),
            deposit_coin_buffer     : 0x2::table::new<u64, 0x2::coin::Coin<T0>>(arg4),
            withdraw_id_count       : 0,
            withdraw_requests       : 0x2::table::new<u64, 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::withdraw_request::WithdrawRequest>(arg4),
            withdraw_receipt_buffer : 0x2::table::new<u64, 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::receipt::Receipt>(arg4),
            withdraw_coin_buffer    : 0x2::table::new<u64, 0x2::coin::Coin<T0>>(arg4),
        };
        let v3 = Vault<T0>{
            id                             : v0,
            version                        : 1,
            enabled                        : true,
            total_shares                   : 0,
            locking_time                   : 43200000,
            request_cancel_time            : 300000,
            last_total_usd_value           : 0,
            total_usd_value_updated        : 0,
            performance_fee_cumulated      : 0,
            performance_fee_collected      : 0x2::balance::zero<T0>(),
            deposit_withdraw_fee_collected : 0x2::balance::zero<T0>(),
            navi_asset_id                  : arg3,
            principal_decimal              : v1,
            free_principal                 : 0x2::balance::zero<T0>(),
            performance_fee_rate           : 0,
            deposit_fee_rate               : 10,
            withdraw_fee_rate              : 10,
            asset_types                    : 0x1::vector::empty<0x1::ascii::String>(),
            assets                         : 0x2::bag::new(arg4),
            assets_value                   : 0x2::table::new<0x1::ascii::String, u256>(arg4),
            assets_value_updated           : 0x2::table::new<0x1::ascii::String, u64>(arg4),
            cur_epoch                      : 0x2::tx_context::epoch(arg4),
            cur_epoch_loss                 : 0,
            loss_tolerance                 : 200000,
            rewards                        : 0x2::bag::new(arg4),
            reward_indices                 : 0x2::vec_map::empty<0x1::type_name::TypeName, u256>(),
            reward_buffer                  : 0x2::address::from_u256(0),
            request                        : v2,
        };
        let v4 = &mut v3;
        add_new_navi_account_cap<T0>(v4, 0, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::create_account(arg4));
        let v5 = &mut v3;
        add_new_coin_type_asset<T0, T0>(v5);
        0x2::transfer::share_object<Vault<T0>>(v3);
        let v6 = VaultCreated{
            vault_id          : 0x2::object::uid_to_address(&v0),
            principal         : 0x1::type_name::get<T0>(),
            navi_asset_id     : arg3,
            principal_decimal : v1,
        };
        0x2::event::emit<VaultCreated>(v6);
    }

    public fun cur_epoch<T0>(arg0: &Vault<T0>) : u64 {
        arg0.cur_epoch
    }

    public fun cur_epoch_loss<T0>(arg0: &Vault<T0>) : u256 {
        arg0.cur_epoch_loss
    }

    public(friend) fun deposit_by_operator<T0>(arg0: &mut Vault<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg4: &0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault_oracle::OracleConfig, arg5: 0x2::coin::Coin<T0>, arg6: bool, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive) {
        assert_enabled<T0>(arg0);
        let v0 = get_navi_account_cap<T0>(arg0, 0);
        if (arg6) {
            0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::deposit_with_account_cap<T0>(arg1, arg2, arg3, arg0.navi_asset_id, arg5, arg7, arg8, v0);
            update_navi_position_value<T0>(arg0, arg4, arg1, 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault_utils::parse_key<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(0), arg2);
        } else {
            0x2::balance::join<T0>(&mut arg0.free_principal, 0x2::coin::into_balance<T0>(arg5));
            update_free_principal_value<T0>(arg0, arg4, arg1);
        };
        let v1 = DepositByOperator{
            vault_id : vault_id<T0>(arg0),
            amount   : 0x2::coin::value<T0>(&arg5),
        };
        0x2::event::emit<DepositByOperator>(v1);
    }

    public fun deposit_coin_buffer<T0>(arg0: &Vault<T0>, arg1: u64) : &0x2::coin::Coin<T0> {
        0x2::table::borrow<u64, 0x2::coin::Coin<T0>>(&arg0.request.deposit_coin_buffer, arg1)
    }

    public fun deposit_fee_rate<T0>(arg0: &Vault<T0>) : u64 {
        arg0.deposit_fee_rate
    }

    public fun deposit_id_count<T0>(arg0: &Vault<T0>) : u64 {
        arg0.request.deposit_id_count
    }

    public fun deposit_receipt_buffer<T0>(arg0: &Vault<T0>, arg1: u64) : &0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::receipt::Receipt {
        assert!(0x2::table::contains<u64, 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::receipt::Receipt>(&arg0.request.deposit_receipt_buffer, arg1), 1019);
        0x2::table::borrow<u64, 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::receipt::Receipt>(&arg0.request.deposit_receipt_buffer, arg1)
    }

    public fun deposit_withdraw_fee_collected<T0>(arg0: &Vault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.deposit_withdraw_fee_collected)
    }

    public(friend) fun execute_deposit<T0>(arg0: &mut Vault<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg4: &0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault_oracle::OracleConfig, arg5: u64, arg6: address, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg9: bool, arg10: &mut 0x2::tx_context::TxContext) {
        assert_enabled<T0>(arg0);
        let v0 = get_total_usd_value<T0>(arg0, arg4, arg1, true);
        let v1 = get_share_ratio<T0>(arg0, arg4, arg1, false);
        let v2 = 0x2::table::remove<u64, 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::receipt::Receipt>(&mut arg0.request.deposit_receipt_buffer, arg5);
        assert_vault_receipt_matched<T0>(arg0, &v2);
        let v3 = &mut v2;
        update_receipt_reward<T0>(arg0, v3);
        let v4 = *0x2::table::borrow<u64, 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::deposit_request::DepositRequest>(&arg0.request.deposit_requests, arg5);
        assert!(0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::deposit_request::vault_id(&v4) == vault_id<T0>(arg0), 1003);
        assert!(0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::deposit_request::receipt_id(&v4) == arg6, 1007);
        assert!(!0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::deposit_request::is_executed(&v4), 1004);
        assert!(!0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::deposit_request::is_cancelled(&v4), 1005);
        let v5 = 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::deposit_request::amount(&v4);
        assert!(v5 == 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::deposit_request::amount(&v4), 1008);
        let v6 = 0x2::coin::into_balance<T0>(0x2::table::remove<u64, 0x2::coin::Coin<T0>>(&mut arg0.request.deposit_coin_buffer, arg5));
        0x2::balance::join<T0>(&mut arg0.deposit_withdraw_fee_collected, 0x2::balance::split<T0>(&mut v6, ((v5 * arg0.deposit_fee_rate / 10000) as u64)));
        let v7 = get_navi_account_cap<T0>(arg0, 0);
        if (arg9) {
            0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::deposit_with_account_cap<T0>(arg1, arg2, arg3, arg0.navi_asset_id, 0x2::coin::from_balance<T0>(v6, arg10), arg7, arg8, v7);
            update_navi_position_value<T0>(arg0, arg4, arg1, 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault_utils::parse_key<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(0), arg2);
        } else {
            0x2::balance::join<T0>(&mut arg0.free_principal, v6);
            update_free_principal_value<T0>(arg0, arg4, arg1);
        };
        let v8 = get_total_usd_value<T0>(arg0, arg4, arg1, false);
        let v9 = 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault_utils::div_d(v8 - v0, v1);
        let v10 = 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::deposit_request::expected_shares(&v4);
        assert!(v9 > 0, 1009);
        if (v10 > 0) {
            assert!(0x1::u256::diff(v9, v10) * (10000 as u256) / v10 < (500 as u256), 1017);
        };
        arg0.total_shares = arg0.total_shares + v9;
        0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::receipt::add_share(&mut v2, v9);
        0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::receipt::set_last_deposit_ms(&mut v2, 0x2::clock::timestamp_ms(arg1));
        let v11 = get_share_ratio<T0>(arg0, arg4, arg1, false);
        assert!(0x1::u256::diff(v11, v1) < 10, 1012);
        let v12 = DepositExecuted{
            request_id     : arg5,
            receipt_id     : arg6,
            vault_id       : 0x2::object::uid_to_address(&arg0.id),
            coin_type      : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            deposit_amount : v5,
            new_share      : v9,
        };
        0x2::event::emit<DepositExecuted>(v12);
        0x2::transfer::public_transfer<0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::receipt::Receipt>(v2, 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::deposit_request::recipient(&v4));
    }

    public(friend) fun execute_withdraw<T0>(arg0: &mut Vault<T0>, arg1: &0x2::clock::Clock, arg2: &0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault_oracle::OracleConfig, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert_enabled<T0>(arg0);
        let v0 = 0x2::table::remove<u64, 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::receipt::Receipt>(&mut arg0.request.withdraw_receipt_buffer, arg3);
        assert_vault_receipt_matched<T0>(arg0, &v0);
        let v1 = &mut v0;
        update_receipt_reward<T0>(arg0, v1);
        let v2 = get_share_ratio<T0>(arg0, arg2, arg1, true);
        let v3 = 0x2::table::borrow_mut<u64, 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::withdraw_request::WithdrawRequest>(&mut arg0.request.withdraw_requests, arg3);
        assert!(0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::withdraw_request::vault_id(v3) == 0x2::object::uid_to_address(&arg0.id), 1003);
        assert!(!0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::withdraw_request::is_executed(v3), 1004);
        assert!(!0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::withdraw_request::is_cancelled(v3), 1005);
        assert!(0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::withdraw_request::receipt_id(v3) == arg4, 1007);
        let v4 = 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::withdraw_request::shares(v3);
        let v5 = (0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault_utils::div_with_oracle_price(0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault_utils::mul_d(v4, v2), 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault_oracle::get_asset_price(arg2, arg1, 0x1::type_name::into_string(0x1::type_name::get<T0>()))) as u64);
        let v6 = 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::withdraw_request::expected_amount(v3);
        if (v6 > 0) {
            assert!(0x1::u64::diff(v5, v6) * 10000 / v6 < 500, 1017);
        };
        arg0.total_shares = arg0.total_shares - v4;
        0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::receipt::decrease_share(&mut v0, v4);
        let v7 = 0x2::balance::split<T0>(&mut arg0.free_principal, v5);
        0x2::balance::join<T0>(&mut arg0.deposit_withdraw_fee_collected, 0x2::balance::split<T0>(&mut v7, ((v5 * arg0.withdraw_fee_rate / 10000) as u64)));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v7, arg5), 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::withdraw_request::recipient(v3));
        0x2::transfer::public_transfer<0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::receipt::Receipt>(v0, 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::withdraw_request::recipient(v3));
        0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::withdraw_request::execute(v3);
        update_free_principal_value<T0>(arg0, arg2, arg1);
    }

    public(friend) fun finish_update_asset_value<T0>(arg0: &mut Vault<T0>, arg1: 0x1::ascii::String, arg2: u256, arg3: u64) {
        *0x2::table::borrow_mut<0x1::ascii::String, u64>(&mut arg0.assets_value_updated, arg1) = arg3;
        *0x2::table::borrow_mut<0x1::ascii::String, u256>(&mut arg0.assets_value, arg1) = arg2;
    }

    public fun free_principal<T0>(arg0: &Vault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.free_principal)
    }

    public(friend) fun get_asset_value<T0>(arg0: &Vault<T0>, arg1: 0x1::ascii::String) : (u256, u64) {
        (*0x2::table::borrow<0x1::ascii::String, u256>(&arg0.assets_value, arg1), *0x2::table::borrow<0x1::ascii::String, u64>(&arg0.assets_value_updated, arg1))
    }

    public(friend) fun get_bluefin_position<T0>(arg0: &Vault<T0>, arg1: u8) : &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position {
        0x2::bag::borrow<0x1::ascii::String, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&arg0.assets, 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault_utils::parse_key<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(arg1))
    }

    public(friend) fun get_cetus_position<T0>(arg0: &Vault<T0>, arg1: u8) : &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position {
        0x2::bag::borrow<0x1::ascii::String, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.assets, 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault_utils::parse_key<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg1))
    }

    public(friend) fun get_momentum_position<T0>(arg0: &Vault<T0>, arg1: u8) : &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position {
        0x2::bag::borrow<0x1::ascii::String, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&arg0.assets, 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault_utils::parse_key<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(arg1))
    }

    public(friend) fun get_navi_account_cap<T0>(arg0: &Vault<T0>, arg1: u8) : &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap {
        0x2::bag::borrow<0x1::ascii::String, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(&arg0.assets, 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault_utils::parse_key<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(arg1))
    }

    public(friend) fun get_share_ratio<T0>(arg0: &mut Vault<T0>, arg1: &0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault_oracle::OracleConfig, arg2: &0x2::clock::Clock, arg3: bool) : u256 {
        if (arg0.total_shares == 0) {
            return 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault_utils::to_decimals(1)
        };
        let v0 = get_total_usd_value<T0>(arg0, arg1, arg2, arg3);
        0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault_utils::div_d(v0, arg0.total_shares)
    }

    public fun get_share_ratio_without_update<T0>(arg0: &mut Vault<T0>) : u256 {
        if (arg0.total_shares == 0) {
            return 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault_utils::to_decimals(1)
        };
        let v0 = get_total_usd_value_without_update<T0>(arg0);
        0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault_utils::div_d(v0, arg0.total_shares)
    }

    public(friend) fun get_suilend_obligation<T0>(arg0: &Vault<T0>, arg1: u8) : &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::Obligation<T0> {
        0x2::bag::borrow<0x1::ascii::String, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::Obligation<T0>>(&arg0.assets, 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault_utils::parse_key<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::Obligation<T0>>(arg1))
    }

    public fun get_total_usd_value<T0>(arg0: &mut Vault<T0>, arg1: &0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault_oracle::OracleConfig, arg2: &0x2::clock::Clock, arg3: bool) : u256 {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = arg0.last_total_usd_value;
        let v2 = 0x1::vector::length<0x1::ascii::String>(&arg0.asset_types);
        let v3 = 0;
        while (v2 > 0) {
            let v4 = *0x1::vector::borrow<0x1::ascii::String>(&arg0.asset_types, v2 - 1);
            assert!(v0 - *0x2::table::borrow<0x1::ascii::String, u64>(&arg0.assets_value_updated, v4) <= 60000, 1015);
            v3 = v3 + *0x2::table::borrow<0x1::ascii::String, u256>(&arg0.assets_value, v4);
            v2 = v2 - 1;
        };
        let v5 = if (arg3 && v3 > v1) {
            charge_performance_fee<T0>(arg0, arg1, arg2, v3 - v1)
        } else {
            0
        };
        let v6 = v3 - v5;
        arg0.last_total_usd_value = v6;
        arg0.total_usd_value_updated = v0;
        v6
    }

    public fun get_total_usd_value_without_update<T0>(arg0: &mut Vault<T0>) : u256 {
        let v0 = 0x1::vector::length<0x1::ascii::String>(&arg0.asset_types);
        let v1 = 0;
        while (v0 > 0) {
            v1 = v1 + *0x2::table::borrow<0x1::ascii::String, u256>(&arg0.assets_value, *0x1::vector::borrow<0x1::ascii::String>(&arg0.asset_types, v0 - 1));
            v0 = v0 - 1;
        };
        v1
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun loss_tolerance<T0>(arg0: &Vault<T0>) : u256 {
        arg0.loss_tolerance
    }

    public fun operator_id(arg0: &OperatorCap) : address {
        0x2::object::uid_to_address(&arg0.id)
    }

    public fun performance_fee_collected<T0>(arg0: &Vault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.performance_fee_collected)
    }

    public fun performance_fee_cumulated<T0>(arg0: &Vault<T0>) : u256 {
        arg0.performance_fee_cumulated
    }

    public fun performance_fee_rate<T0>(arg0: &Vault<T0>) : u64 {
        arg0.performance_fee_rate
    }

    public(friend) fun request_deposit<T0>(arg0: &mut Vault<T0>, arg1: 0x1::option::Option<0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::receipt::Receipt>, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<T0>, arg4: u256, arg5: &mut 0x2::tx_context::TxContext) : u64 {
        assert_enabled<T0>(arg0);
        let v0 = arg0.request.deposit_id_count;
        arg0.request.deposit_id_count = v0 + 1;
        let v1 = 0x2::balance::value<T0>(0x2::coin::balance<T0>(&arg3));
        let v2 = if (!0x1::option::is_some<0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::receipt::Receipt>(&arg1)) {
            0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::receipt::create_receipt(vault_id<T0>(arg0), 0, 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault_utils::clone_vecmap_table<0x1::type_name::TypeName, u256>(&arg0.reward_indices, arg5), 0x2::table::new<0x1::type_name::TypeName, u64>(arg5), 0x2::clock::timestamp_ms(arg2), arg5)
        } else {
            0x1::option::extract<0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::receipt::Receipt>(&mut arg1)
        };
        let v3 = v2;
        0x1::option::destroy_none<0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::receipt::Receipt>(arg1);
        assert!(0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::receipt::vault_id(&v3) == vault_id<T0>(arg0), 1003);
        let v4 = 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::receipt::receipt_id(&v3);
        0x2::table::add<u64, 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::receipt::Receipt>(&mut arg0.request.deposit_receipt_buffer, v0, v3);
        0x2::table::add<u64, 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::deposit_request::DepositRequest>(&mut arg0.request.deposit_requests, v0, 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::deposit_request::new(v0, v4, 0x2::tx_context::sender(arg5), vault_id<T0>(arg0), v1, arg4));
        let v5 = DepositRequested{
            request_id      : v0,
            receipt_id      : v4,
            recipient       : 0x2::tx_context::sender(arg5),
            vault_id        : 0x2::object::uid_to_address(&arg0.id),
            amount          : v1,
            expected_shares : arg4,
        };
        0x2::event::emit<DepositRequested>(v5);
        0x2::table::add<u64, 0x2::coin::Coin<T0>>(&mut arg0.request.deposit_coin_buffer, v0, arg3);
        v0
    }

    public(friend) fun request_withdraw<T0>(arg0: &mut Vault<T0>, arg1: 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::receipt::Receipt, arg2: &0x2::clock::Clock, arg3: u256, arg4: u64, arg5: address) : u64 {
        assert!(withdraw_is_unlocked<T0>(arg0, &arg1, arg2), 1010);
        assert!(0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::receipt::shares(&arg1) >= arg3, 1011);
        let v0 = arg0.request.withdraw_id_count;
        arg0.request.withdraw_id_count = v0 + 1;
        0x2::table::add<u64, 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::withdraw_request::WithdrawRequest>(&mut arg0.request.withdraw_requests, v0, 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::withdraw_request::new(v0, 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::receipt::receipt_id(&arg1), arg5, 0x2::object::uid_to_address(&arg0.id), arg3, arg4));
        0x2::table::add<u64, 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::receipt::Receipt>(&mut arg0.request.withdraw_receipt_buffer, v0, arg1);
        let v1 = WithdrawRequested{
            request_id      : v0,
            receipt_id      : 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::receipt::receipt_id(&arg1),
            recipient       : arg5,
            vault_id        : 0x2::object::uid_to_address(&arg0.id),
            shares          : arg3,
            expected_amount : arg4,
        };
        0x2::event::emit<WithdrawRequested>(v1);
        v0
    }

    public(friend) fun retrieve_deposit_withdraw_fee<T0>(arg0: &mut Vault<T0>, arg1: u64) : 0x2::balance::Balance<T0> {
        0x2::balance::split<T0>(&mut arg0.deposit_withdraw_fee_collected, arg1)
    }

    public(friend) fun retrieve_performance_fee<T0>(arg0: &mut Vault<T0>, arg1: u64) : 0x2::balance::Balance<T0> {
        0x2::balance::split<T0>(&mut arg0.performance_fee_collected, arg1)
    }

    public(friend) fun return_bluefin_position<T0>(arg0: &mut Vault<T0>, arg1: u8, arg2: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position) {
        0x2::bag::add<0x1::ascii::String, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg0.assets, 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault_utils::parse_key<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(arg1), arg2);
    }

    public(friend) fun return_cetus_position<T0>(arg0: &mut Vault<T0>, arg1: u8, arg2: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position) {
        0x2::bag::add<0x1::ascii::String, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.assets, 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault_utils::parse_key<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg1), arg2);
    }

    public(friend) fun return_coin_type_asset<T0, T1>(arg0: &mut Vault<T0>, arg1: 0x2::balance::Balance<T1>) {
        0x2::balance::join<T1>(0x2::bag::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T1>>(&mut arg0.assets, 0x1::type_name::into_string(0x1::type_name::get<T1>())), arg1);
    }

    public(friend) fun return_defi_asset<T0, T1: store + key>(arg0: &mut Vault<T0>, arg1: 0x1::ascii::String, arg2: T1) {
        assert!(contains_asset_type<T0>(arg0, arg1), 1022);
        0x2::bag::add<0x1::ascii::String, T1>(&mut arg0.assets, arg1, arg2);
    }

    public(friend) fun return_free_principal<T0>(arg0: &mut Vault<T0>, arg1: 0x2::balance::Balance<T0>) {
        let v0 = FreePrincipalReturned{
            vault_id : vault_id<T0>(arg0),
            amount   : 0x2::balance::value<T0>(&arg1),
        };
        0x2::event::emit<FreePrincipalReturned>(v0);
        0x2::balance::join<T0>(&mut arg0.free_principal, arg1);
    }

    public(friend) fun return_momentum_position<T0>(arg0: &mut Vault<T0>, arg1: u8, arg2: 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position) {
        0x2::bag::add<0x1::ascii::String, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&mut arg0.assets, 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault_utils::parse_key<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(arg1), arg2);
    }

    public(friend) fun return_navi_account_cap<T0>(arg0: &mut Vault<T0>, arg1: u8, arg2: 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap) {
        0x2::bag::add<0x1::ascii::String, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(&mut arg0.assets, 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault_utils::parse_key<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(arg1), arg2);
    }

    public(friend) fun return_suilend_obligation<T0, T1>(arg0: &mut Vault<T0>, arg1: u8, arg2: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::Obligation<T1>) {
        0x2::bag::add<0x1::ascii::String, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::Obligation<T1>>(&mut arg0.assets, 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault_utils::parse_key<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::Obligation<T1>>(arg1), arg2);
    }

    public fun reward_indices<T0>(arg0: &Vault<T0>) : &0x2::vec_map::VecMap<0x1::type_name::TypeName, u256> {
        &arg0.reward_indices
    }

    public(friend) fun set_deposit_fee<T0>(arg0: &mut Vault<T0>, arg1: u64) {
        assert!(arg1 <= 500, 1002);
        arg0.deposit_fee_rate = arg1;
        let v0 = DepositFeeChanged{
            vault_id : vault_id<T0>(arg0),
            fee      : arg1,
        };
        0x2::event::emit<DepositFeeChanged>(v0);
    }

    public(friend) fun set_enabled<T0>(arg0: &mut Vault<T0>, arg1: bool) {
        arg0.enabled = arg1;
        let v0 = VaultEnabled{
            vault_id : vault_id<T0>(arg0),
            enabled  : arg1,
        };
        0x2::event::emit<VaultEnabled>(v0);
    }

    public(friend) fun set_loss_tolerance<T0>(arg0: &mut Vault<T0>, arg1: u256) {
        assert!(arg1 <= 1000000, 1002);
        arg0.loss_tolerance = arg1;
        let v0 = ToleranceChanged{
            vault_id  : vault_id<T0>(arg0),
            tolerance : arg1,
        };
        0x2::event::emit<ToleranceChanged>(v0);
    }

    public(friend) fun set_new_asset_type<T0>(arg0: &mut Vault<T0>, arg1: 0x1::ascii::String) {
        assert!(!0x2::bag::contains<0x1::ascii::String>(&arg0.assets, arg1), 1020);
        0x1::vector::push_back<0x1::ascii::String>(&mut arg0.asset_types, arg1);
        0x2::table::add<0x1::ascii::String, u256>(&mut arg0.assets_value, arg1, 0);
        0x2::table::add<0x1::ascii::String, u64>(&mut arg0.assets_value_updated, arg1, 0);
        let v0 = NewAssetTypeAdded{
            vault_id   : vault_id<T0>(arg0),
            asset_type : arg1,
        };
        0x2::event::emit<NewAssetTypeAdded>(v0);
    }

    public(friend) fun set_performance_fee_rate<T0>(arg0: &mut Vault<T0>, arg1: u64) {
        assert!(arg1 <= 10000, 1002);
        arg0.performance_fee_rate = arg1;
        let v0 = PerformanceFeeRateChanged{
            vault_id : vault_id<T0>(arg0),
            fee      : arg1,
        };
        0x2::event::emit<PerformanceFeeRateChanged>(v0);
    }

    public(friend) fun set_reward_buffer<T0>(arg0: &mut Vault<T0>, arg1: address) {
        assert!(arg0.reward_buffer == 0x2::address::from_u256(0), 1024);
        arg0.reward_buffer = arg1;
        let v0 = RewardBufferSet{
            vault_id  : vault_id<T0>(arg0),
            buffer_id : arg1,
        };
        0x2::event::emit<RewardBufferSet>(v0);
    }

    public(friend) fun set_reward_rate<T0, T1>(arg0: &mut Vault<T0>, arg1: &0x2::clock::Clock, arg2: &mut RewardBuffer, arg3: u64) {
        let v0 = 0x1::type_name::get<T1>();
        update_reward_buffer<T0, T1>(arg0, arg1, arg2);
        0x2::table::borrow_mut<0x1::type_name::TypeName, BufferDistribution>(&mut arg2.distribution, v0).rate = arg3;
        let v1 = RewardBufferRateUpdated{
            vault_id  : vault_id<T0>(arg0),
            coin_type : v0,
            rate      : arg3,
        };
        0x2::event::emit<RewardBufferRateUpdated>(v1);
    }

    public(friend) fun set_withdraw_fee<T0>(arg0: &mut Vault<T0>, arg1: u64) {
        assert!(arg1 <= 500, 1002);
        arg0.withdraw_fee_rate = arg1;
        let v0 = WithdrawFeeChanged{
            vault_id : vault_id<T0>(arg0),
            fee      : arg1,
        };
        0x2::event::emit<WithdrawFeeChanged>(v0);
    }

    public fun total_shares<T0>(arg0: &Vault<T0>) : u256 {
        arg0.total_shares
    }

    public(friend) fun try_reset_tolerance<T0>(arg0: &mut Vault<T0>, arg1: &0x2::tx_context::TxContext) {
        if (arg0.cur_epoch < 0x2::tx_context::epoch(arg1)) {
            arg0.cur_epoch_loss = 0;
            arg0.cur_epoch = 0x2::tx_context::epoch(arg1);
            let v0 = LossToleranceReset{
                vault_id : vault_id<T0>(arg0),
                epoch    : arg0.cur_epoch,
            };
            0x2::event::emit<LossToleranceReset>(v0);
        };
    }

    public fun update_bluefin_position_value<T0, T1, T2>(arg0: &mut Vault<T0>, arg1: &0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault_oracle::OracleConfig, arg2: &0x2::clock::Clock, arg3: 0x1::ascii::String, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>) {
        *0x2::table::borrow_mut<0x1::ascii::String, u64>(&mut arg0.assets_value_updated, arg3) = 0x2::clock::timestamp_ms(arg2);
        *0x2::table::borrow_mut<0x1::ascii::String, u256>(&mut arg0.assets_value, arg3) = 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::bluefin_adaptor::get_position_value<T1, T2>(arg4, 0x2::bag::borrow<0x1::ascii::String, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&arg0.assets, arg3), arg1, arg2);
    }

    public fun update_cetus_position_value<T0, T1, T2>(arg0: &mut Vault<T0>, arg1: &0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault_oracle::OracleConfig, arg2: &0x2::clock::Clock, arg3: 0x1::ascii::String, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>) {
        let v0 = 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::cetus_adaptor::calculate_cetus_position_value<T1, T2>(arg4, 0x2::bag::borrow<0x1::ascii::String, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.assets, arg3), arg1, arg2);
        finish_update_asset_value<T0>(arg0, arg3, v0, 0x2::clock::timestamp_ms(arg2));
    }

    public fun update_coin_type_asset_value<T0, T1>(arg0: &mut Vault<T0>, arg1: &0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault_oracle::OracleConfig, arg2: &0x2::clock::Clock) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        let v1 = 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault_utils::mul_with_oracle_price((0x2::balance::value<T1>(0x2::bag::borrow<0x1::ascii::String, 0x2::balance::Balance<T1>>(&arg0.assets, v0)) as u256), 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault_oracle::get_asset_price(arg1, arg2, v0));
        finish_update_asset_value<T0>(arg0, v0, v1, 0x2::clock::timestamp_ms(arg2));
    }

    public fun update_free_principal_value<T0>(arg0: &mut Vault<T0>, arg1: &0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault_oracle::OracleConfig, arg2: &0x2::clock::Clock) {
        let v0 = 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault_utils::mul_with_oracle_price((0x2::balance::value<T0>(&arg0.free_principal) as u256), 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault_oracle::get_asset_price(arg1, arg2, 0x1::type_name::into_string(0x1::type_name::get<T0>())));
        finish_update_asset_value<T0>(arg0, 0x1::type_name::into_string(0x1::type_name::get<T0>()), v0, 0x2::clock::timestamp_ms(arg2));
    }

    public fun update_momentum_position_value<T0, T1, T2>(arg0: &mut Vault<T0>, arg1: &0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault_oracle::OracleConfig, arg2: &0x2::clock::Clock, arg3: 0x1::ascii::String, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T2>) {
        let v0 = 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::momentum_adaptor::get_position_value<T1, T2>(arg4, 0x2::bag::borrow<0x1::ascii::String, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&arg0.assets, arg3), arg1, arg2);
        finish_update_asset_value<T0>(arg0, arg3, v0, 0x2::clock::timestamp_ms(arg2));
    }

    public fun update_navi_position_value<T0>(arg0: &mut Vault<T0>, arg1: &0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault_oracle::OracleConfig, arg2: &0x2::clock::Clock, arg3: 0x1::ascii::String, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage) {
        let v0 = 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::navi_adaptor::calculate_navi_position_value(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(0x2::bag::borrow<0x1::ascii::String, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(&arg0.assets, arg3)), arg4, arg1, arg2);
        finish_update_asset_value<T0>(arg0, arg3, v0, 0x2::clock::timestamp_ms(arg2));
    }

    fun update_receipt_reward<T0>(arg0: &Vault<T0>, arg1: &mut 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::receipt::Receipt) {
        assert_vault_receipt_matched<T0>(arg0, arg1);
        let v0 = 0x2::vec_map::keys<0x1::type_name::TypeName, u256>(&arg0.reward_indices);
        let v1 = 0x1::vector::length<0x1::type_name::TypeName>(&v0);
        while (v1 > 0) {
            let v2 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v0, v1 - 1);
            0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::receipt::update_reward(arg1, v2, *0x2::vec_map::get<0x1::type_name::TypeName, u256>(&arg0.reward_indices, &v2));
            v1 = v1 - 1;
        };
    }

    public fun update_reward_buffer<T0, T1>(arg0: &mut Vault<T0>, arg1: &0x2::clock::Clock, arg2: &mut RewardBuffer) {
        let v0 = 0x1::type_name::get<T1>();
        let v1 = 0x2::clock::timestamp_ms(arg1);
        if (!0x2::table::contains<0x1::type_name::TypeName, BufferDistribution>(&arg2.distribution, v0)) {
            let v2 = BufferDistribution{
                rate         : 0,
                last_updated : v1,
            };
            0x2::table::add<0x1::type_name::TypeName, BufferDistribution>(&mut arg2.distribution, v0, v2);
        };
        let v3 = 0x2::table::borrow_mut<0x1::type_name::TypeName, BufferDistribution>(&mut arg2.distribution, v0);
        let v4 = v3.rate * (v1 - v3.last_updated);
        if (!0x2::bag::contains_with_type<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&arg2.rewards, v0)) {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg2.rewards, v0, 0x2::balance::zero<T1>());
        };
        let v5 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg2.rewards, v0);
        let v6 = 0x2::balance::value<T1>(v5);
        if (v6 > v4) {
            add_reward_balance<T0, T1>(arg0, 0x2::balance::split<T1>(v5, v4));
        } else {
            add_reward_balance<T0, T1>(arg0, 0x2::balance::split<T1>(v5, v6));
        };
        v3.last_updated = v1;
        let v7 = RewardBufferUpdated{
            vault_id      : vault_id<T0>(arg0),
            coin_type     : v0,
            reward_amount : v4,
        };
        0x2::event::emit<RewardBufferUpdated>(v7);
    }

    public fun update_suilend_position_value<T0, T1>(arg0: &mut Vault<T0>, arg1: &0x2::clock::Clock, arg2: 0x1::ascii::String) {
        *0x2::table::borrow_mut<0x1::ascii::String, u64>(&mut arg0.assets_value_updated, arg2) = 0x2::clock::timestamp_ms(arg1);
        *0x2::table::borrow_mut<0x1::ascii::String, u256>(&mut arg0.assets_value, arg2) = 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::suilend_adaptor::parse_suilend_obligation<T1>(0x2::bag::borrow<0x1::ascii::String, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::Obligation<T1>>(&arg0.assets, arg2));
    }

    public(friend) fun update_tolerance<T0>(arg0: &mut Vault<T0>, arg1: u256, arg2: u256) {
        arg0.cur_epoch_loss = arg0.cur_epoch_loss + arg2;
        let v0 = 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault_utils::mul_d(arg1, (arg0.loss_tolerance as u256));
        assert!(v0 >= arg0.cur_epoch_loss, 1016);
        let v1 = LossToleranceUpdated{
            vault_id     : vault_id<T0>(arg0),
            current_loss : arg0.cur_epoch_loss,
            loss_limit   : v0,
        };
        0x2::event::emit<LossToleranceUpdated>(v1);
    }

    public(friend) fun upgrade_vault<T0>(arg0: &mut Vault<T0>) {
        assert!(arg0.version < 1, 1023);
        arg0.version = 1;
        let v0 = VaultUpgraded{
            vault_id : 0x2::object::uid_to_address(&arg0.id),
            version  : 1,
        };
        0x2::event::emit<VaultUpgraded>(v0);
    }

    public fun validate_total_usd_value_updated<T0>(arg0: &Vault<T0>, arg1: &0x2::clock::Clock) {
        let v0 = 0x1::vector::length<0x1::ascii::String>(&arg0.asset_types);
        while (v0 > 0) {
            assert!(0x2::clock::timestamp_ms(arg1) - *0x2::table::borrow<0x1::ascii::String, u64>(&arg0.assets_value_updated, *0x1::vector::borrow<0x1::ascii::String>(&arg0.asset_types, v0 - 1)) <= 60000, 1015);
            v0 = v0 - 1;
        };
    }

    public fun withdraw_coin_buffer<T0>(arg0: &Vault<T0>, arg1: u64) : &0x2::coin::Coin<T0> {
        0x2::table::borrow<u64, 0x2::coin::Coin<T0>>(&arg0.request.withdraw_coin_buffer, arg1)
    }

    public fun withdraw_fee_rate<T0>(arg0: &Vault<T0>) : u64 {
        arg0.withdraw_fee_rate
    }

    public(friend) fun withdraw_is_unlocked<T0>(arg0: &Vault<T0>, arg1: &0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::receipt::Receipt, arg2: &0x2::clock::Clock) : bool {
        arg0.locking_time + 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::receipt::last_deposit_ms(arg1) <= 0x2::clock::timestamp_ms(arg2)
    }

    public fun withdraw_receipt_buffer<T0>(arg0: &Vault<T0>, arg1: u64) : &0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::receipt::Receipt {
        assert!(0x2::table::contains<u64, 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::receipt::Receipt>(&arg0.request.withdraw_receipt_buffer, arg1), 1019);
        0x2::table::borrow<u64, 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::receipt::Receipt>(&arg0.request.withdraw_receipt_buffer, arg1)
    }

    public fun withdraw_request<T0>(arg0: &Vault<T0>, arg1: u64) : &0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::withdraw_request::WithdrawRequest {
        0x2::table::borrow<u64, 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::withdraw_request::WithdrawRequest>(&arg0.request.withdraw_requests, arg1)
    }

    // decompiled from Move bytecode v6
}

