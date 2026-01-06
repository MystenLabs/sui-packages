module 0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::vault {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct OperatorCap has store, key {
        id: 0x2::object::UID,
    }

    struct Operation has store, key {
        id: 0x2::object::UID,
        freezed_operators: 0x2::table::Table<address, bool>,
    }

    struct SingleVaultOperatorConfig has store {
        vault_to_operators: 0x2::table::Table<address, vector<address>>,
    }

    struct Vault<phantom T0> has store, key {
        id: 0x2::object::UID,
        version: u64,
        status: u8,
        total_shares: u256,
        locking_time_for_withdraw: u64,
        locking_time_for_cancel_request: u64,
        deposit_withdraw_fee_collected: 0x2::balance::Balance<T0>,
        free_principal: 0x2::balance::Balance<T0>,
        claimable_principal: 0x2::balance::Balance<T0>,
        deposit_fee_rate: u64,
        withdraw_fee_rate: u64,
        asset_types: vector<0x1::ascii::String>,
        assets: 0x2::bag::Bag,
        assets_value: 0x2::table::Table<0x1::ascii::String, u256>,
        assets_value_updated: 0x2::table::Table<0x1::ascii::String, u64>,
        cur_epoch: u64,
        cur_epoch_loss_base_usd_value: u256,
        cur_epoch_loss: u256,
        loss_tolerance: u256,
        request_buffer: RequestBuffer<T0>,
        reward_manager: address,
        receipts: 0x2::table::Table<address, 0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::vault_receipt_info::VaultReceiptInfo>,
        op_value_update_record: OperationValueUpdateRecord,
    }

    struct RequestBuffer<phantom T0> has store {
        deposit_id_count: u64,
        deposit_requests: 0x2::table::Table<u64, 0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::deposit_request::DepositRequest>,
        deposit_coin_buffer: 0x2::table::Table<u64, 0x2::coin::Coin<T0>>,
        withdraw_id_count: u64,
        withdraw_requests: 0x2::table::Table<u64, 0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::withdraw_request::WithdrawRequest>,
    }

    struct OperationValueUpdateRecord has store {
        asset_types_borrowed: vector<0x1::ascii::String>,
        value_update_enabled: bool,
        asset_types_updated: 0x2::table::Table<0x1::ascii::String, bool>,
    }

    struct VaultCreated has copy, drop {
        vault_id: address,
        principal: 0x1::type_name::TypeName,
    }

    struct OperatorCapCreated has copy, drop {
        cap_id: address,
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
        recipient: address,
        vault_id: address,
        amount: u64,
        shares: u256,
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

    struct WithdrawExecuted has copy, drop {
        request_id: u64,
        receipt_id: address,
        recipient: address,
        vault_id: address,
        shares: u256,
        amount: u64,
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

    struct RewardManagerSet has copy, drop {
        vault_id: address,
        reward_manager_id: address,
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

    struct OperatorDeposited has copy, drop {
        vault_id: address,
        amount: u64,
    }

    struct NewAssetTypeAdded has copy, drop {
        vault_id: address,
        asset_type: 0x1::ascii::String,
    }

    struct DefiAssetRemoved has copy, drop {
        vault_id: address,
        asset_type: 0x1::ascii::String,
    }

    struct CoinTypeAssetRemoved has copy, drop {
        vault_id: address,
        asset_type: 0x1::ascii::String,
    }

    struct AssetValueUpdated has copy, drop {
        vault_id: address,
        asset_type: 0x1::ascii::String,
        usd_value: u256,
        timestamp: u64,
    }

    struct TotalUSDValueUpdated has copy, drop {
        vault_id: address,
        total_usd_value: u256,
        timestamp: u64,
    }

    struct ShareRatioUpdated has copy, drop {
        vault_id: address,
        share_ratio: u256,
        timestamp: u64,
    }

    struct DepositWithdrawFeeRetrieved has copy, drop {
        vault_id: address,
        amount: u64,
    }

    struct DefiAssetBorrowed has copy, drop {
        vault_id: address,
        asset_type: 0x1::ascii::String,
    }

    struct DefiAssetReturned has copy, drop {
        vault_id: address,
        asset_type: 0x1::ascii::String,
    }

    struct ClaimablePrincipalAdded has copy, drop {
        vault_id: address,
        amount: u64,
    }

    struct ClaimablePrincipalClaimed has copy, drop {
        vault_id: address,
        receipt_id: address,
        amount: u64,
    }

    struct OperatorFreezed has copy, drop {
        operator_id: address,
        freezed: bool,
    }

    struct VaultStatusChanged has copy, drop {
        vault_id: address,
        status: u8,
    }

    struct LockingTimeForWithdrawChanged has copy, drop {
        vault_id: address,
        locking_time: u64,
    }

    struct LockingTimeForCancelRequestChanged has copy, drop {
        vault_id: address,
        locking_time: u64,
    }

    struct SingleVaultOperatorAdded has copy, drop {
        vault_id: address,
        operator_id: address,
    }

    struct SingleVaultOperatorRemoved has copy, drop {
        vault_id: address,
        operator_id: address,
    }

    struct SingleVaultOperatorConfigFieldKey has copy, drop, store {
        dummy_field: bool,
    }

    public fun deposit_request<T0>(arg0: &Vault<T0>, arg1: u64) : &0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::deposit_request::DepositRequest {
        let v0 = &arg0.request_buffer;
        assert!(0x2::table::contains<u64, 0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::deposit_request::DepositRequest>(&v0.deposit_requests, arg1), 5010);
        0x2::table::borrow<u64, 0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::deposit_request::DepositRequest>(&v0.deposit_requests, arg1)
    }

    public fun vault_id<T0>(arg0: &Vault<T0>) : address {
        0x2::object::uid_to_address(&arg0.id)
    }

    public fun add_claimable_principal<T0>(arg0: &mut Vault<T0>, arg1: 0x2::balance::Balance<T0>) {
        check_version<T0>(arg0);
        assert_normal<T0>(arg0);
        let v0 = ClaimablePrincipalAdded{
            vault_id : vault_id<T0>(arg0),
            amount   : 0x2::balance::value<T0>(&arg1),
        };
        0x2::event::emit<ClaimablePrincipalAdded>(v0);
        0x2::balance::join<T0>(&mut arg0.claimable_principal, arg1);
    }

    public(friend) fun add_dynamic_field_to_operation(arg0: &mut Operation, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = SingleVaultOperatorConfig{vault_to_operators: 0x2::table::new<address, vector<address>>(arg1)};
        let v1 = SingleVaultOperatorConfigFieldKey{dummy_field: false};
        0x2::dynamic_field::add<SingleVaultOperatorConfigFieldKey, SingleVaultOperatorConfig>(operation_id_mut(arg0), v1, v0);
    }

    public(friend) fun add_new_coin_type_asset<T0, T1>(arg0: &mut Vault<T0>) {
        check_version<T0>(arg0);
        assert_normal<T0>(arg0);
        assert!(0x1::type_name::get<T1>() != 0x1::type_name::get<T0>(), 5026);
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        set_new_asset_type<T0>(arg0, v0);
        0x2::bag::add<0x1::ascii::String, 0x2::balance::Balance<T1>>(&mut arg0.assets, v0, 0x2::balance::zero<T1>());
    }

    public(friend) fun add_new_defi_asset<T0, T1: store + key>(arg0: &mut Vault<T0>, arg1: u8, arg2: T1) {
        check_version<T0>(arg0);
        assert_enabled<T0>(arg0);
        let v0 = 0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::vault_utils::parse_key<T1>(arg1);
        set_new_asset_type<T0>(arg0, v0);
        0x2::bag::add<0x1::ascii::String, T1>(&mut arg0.assets, v0, arg2);
    }

    public(friend) fun add_vault_receipt_info<T0>(arg0: &mut Vault<T0>, arg1: address, arg2: 0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::vault_receipt_info::VaultReceiptInfo) {
        check_version<T0>(arg0);
        assert_normal<T0>(arg0);
        0x2::table::add<address, 0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::vault_receipt_info::VaultReceiptInfo>(&mut arg0.receipts, arg1, arg2);
    }

    public fun vault_receipt_info<T0>(arg0: &Vault<T0>, arg1: address) : &0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::vault_receipt_info::VaultReceiptInfo {
        0x2::table::borrow<address, 0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::vault_receipt_info::VaultReceiptInfo>(&arg0.receipts, arg1)
    }

    public(friend) fun assert_during_operation<T0>(arg0: &Vault<T0>) {
        assert!(status<T0>(arg0) == 1, 5024);
    }

    public(friend) fun assert_enabled<T0>(arg0: &Vault<T0>) {
        assert!(status<T0>(arg0) != 2, 5005);
    }

    public(friend) fun assert_normal<T0>(arg0: &Vault<T0>) {
        assert!(status<T0>(arg0) == 0, 5022);
    }

    public(friend) fun assert_not_during_operation<T0>(arg0: &Vault<T0>) {
        assert!(status<T0>(arg0) != 1, 5025);
    }

    public(friend) fun assert_operator_not_freezed(arg0: &Operation, arg1: &OperatorCap) {
        assert!(!operator_freezed(arg0, operator_id(arg1)), 5015);
    }

    public(friend) fun assert_operator_not_freezed_by_id(arg0: &Operation, arg1: address) {
        assert!(!operator_freezed(arg0, arg1), 5015);
    }

    public fun assert_single_vault_operator_paired(arg0: &Operation, arg1: address, arg2: &OperatorCap) {
        let v0 = operator_id(arg2);
        let (v1, _) = 0x1::vector::index_of<address>(0x2::table::borrow<address, vector<address>>(get_single_vault_operator_config_by_dynamic_field(arg0), arg1), &v0);
        assert!(v1, 5030);
    }

    public(friend) fun assert_vault_receipt_matched<T0>(arg0: &Vault<T0>, arg1: &0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::receipt::Receipt) {
        assert!(vault_id<T0>(arg0) == 0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::receipt::vault_id(arg1), 5006);
    }

    public(friend) fun borrow_coin_type_asset<T0, T1>(arg0: &mut Vault<T0>, arg1: u64) : 0x2::balance::Balance<T1> {
        check_version<T0>(arg0);
        assert_enabled<T0>(arg0);
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        if (status<T0>(arg0) == 1) {
            0x1::vector::push_back<0x1::ascii::String>(&mut arg0.op_value_update_record.asset_types_borrowed, v0);
        };
        0x2::balance::split<T1>(0x2::bag::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T1>>(&mut arg0.assets, v0), arg1)
    }

    public(friend) fun borrow_defi_asset<T0, T1: store + key>(arg0: &mut Vault<T0>, arg1: 0x1::ascii::String) : T1 {
        check_version<T0>(arg0);
        assert_enabled<T0>(arg0);
        assert!(contains_asset_type<T0>(arg0, arg1), 5012);
        if (status<T0>(arg0) == 1) {
            0x1::vector::push_back<0x1::ascii::String>(&mut arg0.op_value_update_record.asset_types_borrowed, arg1);
        };
        let v0 = DefiAssetBorrowed{
            vault_id   : vault_id<T0>(arg0),
            asset_type : arg1,
        };
        0x2::event::emit<DefiAssetBorrowed>(v0);
        0x2::bag::remove<0x1::ascii::String, T1>(&mut arg0.assets, arg1)
    }

    public(friend) fun borrow_free_principal<T0>(arg0: &mut Vault<T0>, arg1: u64) : 0x2::balance::Balance<T0> {
        check_version<T0>(arg0);
        assert_enabled<T0>(arg0);
        if (status<T0>(arg0) == 1) {
            0x1::vector::push_back<0x1::ascii::String>(&mut arg0.op_value_update_record.asset_types_borrowed, 0x1::type_name::into_string(0x1::type_name::get<T0>()));
        };
        let v0 = FreePrincipalBorrowed{
            vault_id : vault_id<T0>(arg0),
            amount   : arg1,
        };
        0x2::event::emit<FreePrincipalBorrowed>(v0);
        0x2::balance::split<T0>(&mut arg0.free_principal, arg1)
    }

    public(friend) fun cancel_deposit<T0>(arg0: &mut Vault<T0>, arg1: &0x2::clock::Clock, arg2: u64, arg3: address, arg4: address) : 0x2::coin::Coin<T0> {
        check_version<T0>(arg0);
        assert_not_during_operation<T0>(arg0);
        assert!(contains_vault_receipt_info<T0>(arg0, arg3), 5020);
        assert!(0x2::table::contains<u64, 0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::deposit_request::DepositRequest>(&arg0.request_buffer.deposit_requests, arg2), 5010);
        let v0 = 0x2::table::borrow_mut<address, 0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::vault_receipt_info::VaultReceiptInfo>(&mut arg0.receipts, arg3);
        assert!(0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::vault_receipt_info::status(v0) == 1, 5017);
        let v1 = 0x2::table::borrow_mut<u64, 0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::deposit_request::DepositRequest>(&mut arg0.request_buffer.deposit_requests, arg2);
        assert!(arg3 == 0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::deposit_request::receipt_id(v1), 5003);
        assert!(0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::deposit_request::request_time(v1) + arg0.locking_time_for_cancel_request <= 0x2::clock::timestamp_ms(arg1), 5018);
        assert!(0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::deposit_request::recipient(v1) == arg4, 5023);
        0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::vault_receipt_info::update_after_cancel_deposit(v0, 0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::deposit_request::amount(v1));
        let v2 = 0x2::table::remove<u64, 0x2::coin::Coin<T0>>(&mut arg0.request_buffer.deposit_coin_buffer, arg2);
        let v3 = DepositCancelled{
            request_id : arg2,
            receipt_id : 0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::deposit_request::receipt_id(v1),
            recipient  : arg4,
            vault_id   : 0x2::object::uid_to_address(&arg0.id),
            amount     : 0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::deposit_request::amount(v1),
        };
        0x2::event::emit<DepositCancelled>(v3);
        delete_deposit_request<T0>(arg0, arg2);
        v2
    }

    public(friend) fun cancel_withdraw<T0>(arg0: &mut Vault<T0>, arg1: &0x2::clock::Clock, arg2: u64, arg3: address, arg4: address) : u256 {
        check_version<T0>(arg0);
        assert_normal<T0>(arg0);
        assert!(contains_vault_receipt_info<T0>(arg0, arg3), 5020);
        assert!(0x2::table::contains<u64, 0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::withdraw_request::WithdrawRequest>(&arg0.request_buffer.withdraw_requests, arg2), 5010);
        let v0 = 0x2::table::borrow_mut<address, 0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::vault_receipt_info::VaultReceiptInfo>(&mut arg0.receipts, arg3);
        let v1 = 0x2::table::borrow_mut<u64, 0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::withdraw_request::WithdrawRequest>(&mut arg0.request_buffer.withdraw_requests, arg2);
        assert!(arg3 == 0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::withdraw_request::receipt_id(v1), 5003);
        assert!(0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::withdraw_request::request_time(v1) + arg0.locking_time_for_cancel_request <= 0x2::clock::timestamp_ms(arg1), 5018);
        assert!(0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::withdraw_request::recipient(v1) == arg4 || 0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::withdraw_request::recipient(v1) == 0x2::address::from_u256(0), 5023);
        0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::vault_receipt_info::update_after_cancel_withdraw(v0, 0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::withdraw_request::shares(v1));
        let v2 = WithdrawCancelled{
            request_id : arg2,
            receipt_id : 0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::withdraw_request::receipt_id(v1),
            recipient  : arg4,
            vault_id   : 0x2::object::uid_to_address(&arg0.id),
            shares     : 0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::withdraw_request::shares(v1),
        };
        0x2::event::emit<WithdrawCancelled>(v2);
        delete_withdraw_request<T0>(arg0, arg2);
        0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::withdraw_request::shares(v1)
    }

    public fun check_locking_time_for_cancel_request<T0>(arg0: &Vault<T0>, arg1: bool, arg2: u64, arg3: &0x2::clock::Clock) : bool {
        check_version<T0>(arg0);
        arg1 && 0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::deposit_request::request_time(0x2::table::borrow<u64, 0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::deposit_request::DepositRequest>(&arg0.request_buffer.deposit_requests, arg2)) + arg0.locking_time_for_cancel_request <= 0x2::clock::timestamp_ms(arg3) || 0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::withdraw_request::request_time(0x2::table::borrow<u64, 0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::withdraw_request::WithdrawRequest>(&arg0.request_buffer.withdraw_requests, arg2)) + arg0.locking_time_for_cancel_request <= 0x2::clock::timestamp_ms(arg3)
    }

    public fun check_locking_time_for_withdraw<T0>(arg0: &Vault<T0>, arg1: address, arg2: &0x2::clock::Clock) : bool {
        check_version<T0>(arg0);
        arg0.locking_time_for_withdraw + 0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::vault_receipt_info::last_deposit_time(0x2::table::borrow<address, 0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::vault_receipt_info::VaultReceiptInfo>(&arg0.receipts, arg1)) <= 0x2::clock::timestamp_ms(arg2)
    }

    public(friend) fun check_op_value_update_record<T0>(arg0: &Vault<T0>) {
        check_version<T0>(arg0);
        assert_enabled<T0>(arg0);
        assert!(arg0.op_value_update_record.value_update_enabled, 5027);
        let v0 = &arg0.op_value_update_record;
        let v1 = &v0.asset_types_borrowed;
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::ascii::String>(v1)) {
            let v3 = 0x1::vector::borrow<0x1::ascii::String>(v1, v2);
            assert!(0x2::table::contains<0x1::ascii::String, bool>(&v0.asset_types_updated, *v3), 5007);
            assert!(*0x2::table::borrow<0x1::ascii::String, bool>(&v0.asset_types_updated, *v3), 5007);
            v2 = v2 + 1;
        };
    }

    public(friend) fun check_version<T0>(arg0: &Vault<T0>) {
        assert!(arg0.version == 1, 5013);
    }

    public(friend) fun claim_claimable_principal<T0>(arg0: &mut Vault<T0>, arg1: address, arg2: u64) : 0x2::balance::Balance<T0> {
        check_version<T0>(arg0);
        assert_normal<T0>(arg0);
        let v0 = 0x2::table::borrow_mut<address, 0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::vault_receipt_info::VaultReceiptInfo>(&mut arg0.receipts, arg1);
        assert!(0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::vault_receipt_info::claimable_principal(v0) >= arg2, 5021);
        assert!(0x2::balance::value<T0>(&arg0.claimable_principal) >= arg2, 5021);
        0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::vault_receipt_info::update_after_claim_principal(v0, arg2);
        let v1 = ClaimablePrincipalClaimed{
            vault_id   : vault_id<T0>(arg0),
            receipt_id : arg1,
            amount     : arg2,
        };
        0x2::event::emit<ClaimablePrincipalClaimed>(v1);
        0x2::balance::split<T0>(&mut arg0.claimable_principal, arg2)
    }

    public fun claimable_principal<T0>(arg0: &Vault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.claimable_principal)
    }

    public(friend) fun clear_op_value_update_record<T0>(arg0: &mut Vault<T0>) {
        check_version<T0>(arg0);
        assert_enabled<T0>(arg0);
        let v0 = &mut arg0.op_value_update_record;
        let v1 = &v0.asset_types_borrowed;
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::ascii::String>(v1)) {
            0x2::table::remove<0x1::ascii::String, bool>(&mut v0.asset_types_updated, *0x1::vector::borrow<0x1::ascii::String>(v1, v2));
            v2 = v2 + 1;
        };
        while (0x1::vector::length<0x1::ascii::String>(&v0.asset_types_borrowed) > 0) {
            0x1::vector::pop_back<0x1::ascii::String>(&mut v0.asset_types_borrowed);
        };
        v0.value_update_enabled = false;
    }

    public(friend) fun contains_asset_type<T0>(arg0: &Vault<T0>, arg1: 0x1::ascii::String) : bool {
        0x2::bag::contains<0x1::ascii::String>(&arg0.assets, arg1)
    }

    public(friend) fun contains_vault_receipt_info<T0>(arg0: &Vault<T0>, arg1: address) : bool {
        0x2::table::contains<address, 0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::vault_receipt_info::VaultReceiptInfo>(&arg0.receipts, arg1)
    }

    public(friend) fun create_operator_cap(arg0: &mut 0x2::tx_context::TxContext) : OperatorCap {
        let v0 = OperatorCap{id: 0x2::object::new(arg0)};
        let v1 = OperatorCapCreated{cap_id: 0x2::object::id_address<OperatorCap>(&v0)};
        0x2::event::emit<OperatorCapCreated>(v1);
        v0
    }

    public fun create_vault<T0>(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg1);
        let v1 = RequestBuffer<T0>{
            deposit_id_count    : 0,
            deposit_requests    : 0x2::table::new<u64, 0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::deposit_request::DepositRequest>(arg1),
            deposit_coin_buffer : 0x2::table::new<u64, 0x2::coin::Coin<T0>>(arg1),
            withdraw_id_count   : 0,
            withdraw_requests   : 0x2::table::new<u64, 0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::withdraw_request::WithdrawRequest>(arg1),
        };
        let v2 = OperationValueUpdateRecord{
            asset_types_borrowed : 0x1::vector::empty<0x1::ascii::String>(),
            value_update_enabled : false,
            asset_types_updated  : 0x2::table::new<0x1::ascii::String, bool>(arg1),
        };
        let v3 = Vault<T0>{
            id                              : v0,
            version                         : 1,
            status                          : 0,
            total_shares                    : 0,
            locking_time_for_withdraw       : 43200000,
            locking_time_for_cancel_request : 300000,
            deposit_withdraw_fee_collected  : 0x2::balance::zero<T0>(),
            free_principal                  : 0x2::balance::zero<T0>(),
            claimable_principal             : 0x2::balance::zero<T0>(),
            deposit_fee_rate                : 10,
            withdraw_fee_rate               : 10,
            asset_types                     : 0x1::vector::empty<0x1::ascii::String>(),
            assets                          : 0x2::bag::new(arg1),
            assets_value                    : 0x2::table::new<0x1::ascii::String, u256>(arg1),
            assets_value_updated            : 0x2::table::new<0x1::ascii::String, u64>(arg1),
            cur_epoch                       : 0x2::tx_context::epoch(arg1),
            cur_epoch_loss_base_usd_value   : 0,
            cur_epoch_loss                  : 0,
            loss_tolerance                  : 10,
            request_buffer                  : v1,
            reward_manager                  : 0x2::address::from_u256(0),
            receipts                        : 0x2::table::new<address, 0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::vault_receipt_info::VaultReceiptInfo>(arg1),
            op_value_update_record          : v2,
        };
        let v4 = &mut v3;
        set_new_asset_type<T0>(v4, 0x1::type_name::into_string(0x1::type_name::get<T0>()));
        0x2::transfer::share_object<Vault<T0>>(v3);
        let v5 = VaultCreated{
            vault_id  : 0x2::object::uid_to_address(&v0),
            principal : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<VaultCreated>(v5);
    }

    public fun cur_epoch<T0>(arg0: &Vault<T0>) : u64 {
        arg0.cur_epoch
    }

    public fun cur_epoch_loss<T0>(arg0: &Vault<T0>) : u256 {
        arg0.cur_epoch_loss
    }

    public(friend) fun delete_deposit_request<T0>(arg0: &mut Vault<T0>, arg1: u64) {
        check_version<T0>(arg0);
        0x2::table::remove<u64, 0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::deposit_request::DepositRequest>(&mut arg0.request_buffer.deposit_requests, arg1);
    }

    public(friend) fun delete_withdraw_request<T0>(arg0: &mut Vault<T0>, arg1: u64) {
        check_version<T0>(arg0);
        0x2::table::remove<u64, 0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::withdraw_request::WithdrawRequest>(&mut arg0.request_buffer.withdraw_requests, arg1);
    }

    public(friend) fun deposit_by_operator<T0>(arg0: &mut Vault<T0>, arg1: &0x2::clock::Clock, arg2: &0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::vault_oracle::OracleConfig, arg3: 0x2::coin::Coin<T0>) {
        check_version<T0>(arg0);
        assert_normal<T0>(arg0);
        0x2::balance::join<T0>(&mut arg0.free_principal, 0x2::coin::into_balance<T0>(arg3));
        update_free_principal_value<T0>(arg0, arg2, arg1);
        let v0 = OperatorDeposited{
            vault_id : vault_id<T0>(arg0),
            amount   : 0x2::coin::value<T0>(&arg3),
        };
        0x2::event::emit<OperatorDeposited>(v0);
    }

    public fun deposit_coin_buffer<T0>(arg0: &Vault<T0>, arg1: u64) : &0x2::coin::Coin<T0> {
        let v0 = &arg0.request_buffer;
        assert!(0x2::table::contains<u64, 0x2::coin::Coin<T0>>(&v0.deposit_coin_buffer, arg1), 5016);
        0x2::table::borrow<u64, 0x2::coin::Coin<T0>>(&v0.deposit_coin_buffer, arg1)
    }

    public fun deposit_fee_rate<T0>(arg0: &Vault<T0>) : u64 {
        arg0.deposit_fee_rate
    }

    public fun deposit_id_count<T0>(arg0: &Vault<T0>) : u64 {
        arg0.request_buffer.deposit_id_count
    }

    public fun deposit_withdraw_fee_collected<T0>(arg0: &Vault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.deposit_withdraw_fee_collected)
    }

    public(friend) fun enable_op_value_update<T0>(arg0: &mut Vault<T0>) {
        check_version<T0>(arg0);
        assert_enabled<T0>(arg0);
        arg0.op_value_update_record.value_update_enabled = true;
    }

    public(friend) fun execute_deposit<T0>(arg0: &mut Vault<T0>, arg1: &0x2::clock::Clock, arg2: &0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::vault_oracle::OracleConfig, arg3: u64, arg4: u256) {
        check_version<T0>(arg0);
        assert_normal<T0>(arg0);
        assert!(0x2::table::contains<u64, 0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::deposit_request::DepositRequest>(&arg0.request_buffer.deposit_requests, arg3), 5010);
        let v0 = get_total_usd_value<T0>(arg0, arg1);
        let v1 = get_share_ratio<T0>(arg0, arg1);
        let v2 = *0x2::table::borrow<u64, 0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::deposit_request::DepositRequest>(&arg0.request_buffer.deposit_requests, arg3);
        assert!(0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::deposit_request::vault_id(&v2) == 0x2::object::uid_to_address(&arg0.id), 5002);
        let v3 = 0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::deposit_request::amount(&v2);
        let v4 = 0x2::coin::into_balance<T0>(0x2::table::remove<u64, 0x2::coin::Coin<T0>>(&mut arg0.request_buffer.deposit_coin_buffer, arg3));
        0x2::balance::join<T0>(&mut arg0.deposit_withdraw_fee_collected, 0x2::balance::split<T0>(&mut v4, ((v3 * arg0.deposit_fee_rate / 10000) as u64)));
        0x2::balance::join<T0>(&mut arg0.free_principal, v4);
        update_free_principal_value<T0>(arg0, arg2, arg1);
        let v5 = 0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::vault_utils::div_d(get_total_usd_value<T0>(arg0, arg1) - v0, v1);
        assert!(v5 > 0, 5004);
        assert!(v5 >= 0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::deposit_request::expected_shares(&v2), 5009);
        assert!(v5 <= arg4, 5009);
        arg0.total_shares = arg0.total_shares + v5;
        let v6 = DepositExecuted{
            request_id : arg3,
            receipt_id : 0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::deposit_request::receipt_id(&v2),
            recipient  : 0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::deposit_request::recipient(&v2),
            vault_id   : 0x2::object::uid_to_address(&arg0.id),
            amount     : v3,
            shares     : v5,
        };
        0x2::event::emit<DepositExecuted>(v6);
        0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::vault_receipt_info::update_after_execute_deposit(0x2::table::borrow_mut<address, 0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::vault_receipt_info::VaultReceiptInfo>(&mut arg0.receipts, 0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::deposit_request::receipt_id(&v2)), 0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::deposit_request::amount(&v2), v5, 0x2::clock::timestamp_ms(arg1));
        delete_deposit_request<T0>(arg0, arg3);
    }

    public(friend) fun execute_withdraw<T0>(arg0: &mut Vault<T0>, arg1: &0x2::clock::Clock, arg2: &0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::vault_oracle::OracleConfig, arg3: u64, arg4: u64) : (0x2::balance::Balance<T0>, address) {
        check_version<T0>(arg0);
        assert_normal<T0>(arg0);
        assert!(0x2::table::contains<u64, 0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::withdraw_request::WithdrawRequest>(&arg0.request_buffer.withdraw_requests, arg3), 5010);
        let v0 = *0x2::table::borrow<u64, 0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::withdraw_request::WithdrawRequest>(&arg0.request_buffer.withdraw_requests, arg3);
        let v1 = 0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::withdraw_request::shares(&v0);
        let v2 = (0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::vault_utils::div_with_oracle_price(0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::vault_utils::mul_d(v1, get_share_ratio<T0>(arg0, arg1)), 0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::vault_oracle::get_normalized_asset_price(arg2, arg1, 0x1::type_name::into_string(0x1::type_name::get<T0>()))) as u64);
        assert!(v2 >= 0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::withdraw_request::expected_amount(&v0), 5009);
        assert!(v2 <= arg4, 5009);
        arg0.total_shares = arg0.total_shares - v1;
        assert!(v2 <= 0x2::balance::value<T0>(&arg0.free_principal), 5028);
        let v3 = 0x2::balance::split<T0>(&mut arg0.free_principal, v2);
        let v4 = v2 * arg0.withdraw_fee_rate / 10000;
        0x2::balance::join<T0>(&mut arg0.deposit_withdraw_fee_collected, 0x2::balance::split<T0>(&mut v3, (v4 as u64)));
        let v5 = WithdrawExecuted{
            request_id : arg3,
            receipt_id : 0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::withdraw_request::receipt_id(&v0),
            recipient  : 0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::withdraw_request::recipient(&v0),
            vault_id   : 0x2::object::uid_to_address(&arg0.id),
            shares     : v1,
            amount     : v2 - v4,
        };
        0x2::event::emit<WithdrawExecuted>(v5);
        update_free_principal_value<T0>(arg0, arg2, arg1);
        let v6 = 0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::withdraw_request::recipient(&v0);
        if (v6 != 0x2::address::from_u256(0)) {
            0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::vault_receipt_info::update_after_execute_withdraw(0x2::table::borrow_mut<address, 0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::vault_receipt_info::VaultReceiptInfo>(&mut arg0.receipts, 0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::withdraw_request::receipt_id(&v0)), v1, 0);
        } else {
            0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::vault_receipt_info::update_after_execute_withdraw(0x2::table::borrow_mut<address, 0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::vault_receipt_info::VaultReceiptInfo>(&mut arg0.receipts, 0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::withdraw_request::receipt_id(&v0)), v1, 0x2::balance::value<T0>(&v3));
        };
        delete_withdraw_request<T0>(arg0, arg3);
        (v3, v6)
    }

    public(friend) fun finish_update_asset_value<T0>(arg0: &mut Vault<T0>, arg1: 0x1::ascii::String, arg2: u256, arg3: u64) {
        check_version<T0>(arg0);
        assert_enabled<T0>(arg0);
        *0x2::table::borrow_mut<0x1::ascii::String, u64>(&mut arg0.assets_value_updated, arg1) = arg3;
        *0x2::table::borrow_mut<0x1::ascii::String, u256>(&mut arg0.assets_value, arg1) = arg2;
        let v0 = if (status<T0>(arg0) == 1) {
            if (arg0.op_value_update_record.value_update_enabled) {
                0x1::vector::contains<0x1::ascii::String>(&arg0.op_value_update_record.asset_types_borrowed, &arg1)
            } else {
                false
            }
        } else {
            false
        };
        if (v0) {
            0x2::table::add<0x1::ascii::String, bool>(&mut arg0.op_value_update_record.asset_types_updated, arg1, true);
        };
        let v1 = AssetValueUpdated{
            vault_id   : vault_id<T0>(arg0),
            asset_type : arg1,
            usd_value  : arg2,
            timestamp  : arg3,
        };
        0x2::event::emit<AssetValueUpdated>(v1);
    }

    public fun free_principal<T0>(arg0: &Vault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.free_principal)
    }

    public fun get_asset_value<T0>(arg0: &Vault<T0>, arg1: 0x1::ascii::String) : (u256, u64) {
        check_version<T0>(arg0);
        (*0x2::table::borrow<0x1::ascii::String, u256>(&arg0.assets_value, arg1), *0x2::table::borrow<0x1::ascii::String, u64>(&arg0.assets_value_updated, arg1))
    }

    public fun get_defi_asset<T0, T1: store + key>(arg0: &Vault<T0>, arg1: 0x1::ascii::String) : &T1 {
        0x2::bag::borrow<0x1::ascii::String, T1>(&arg0.assets, arg1)
    }

    public(friend) fun get_share_ratio<T0>(arg0: &Vault<T0>, arg1: &0x2::clock::Clock) : u256 {
        check_version<T0>(arg0);
        assert_enabled<T0>(arg0);
        if (arg0.total_shares == 0) {
            return 0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::vault_utils::to_decimals(1)
        };
        let v0 = 0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::vault_utils::div_d(get_total_usd_value<T0>(arg0, arg1), arg0.total_shares);
        let v1 = ShareRatioUpdated{
            vault_id    : vault_id<T0>(arg0),
            share_ratio : v0,
            timestamp   : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<ShareRatioUpdated>(v1);
        v0
    }

    public fun get_share_ratio_without_update<T0>(arg0: &Vault<T0>) : u256 {
        check_version<T0>(arg0);
        if (arg0.total_shares == 0) {
            return 0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::vault_utils::to_decimals(1)
        };
        0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::vault_utils::div_d(get_total_usd_value_without_update<T0>(arg0), arg0.total_shares)
    }

    public fun get_single_vault_operator_by_dynamic_field(arg0: &Operation, arg1: address) : &vector<address> {
        let v0 = SingleVaultOperatorConfigFieldKey{dummy_field: false};
        0x2::table::borrow<address, vector<address>>(&0x2::dynamic_field::borrow<SingleVaultOperatorConfigFieldKey, SingleVaultOperatorConfig>(&arg0.id, v0).vault_to_operators, arg1)
    }

    public fun get_single_vault_operator_config_by_dynamic_field(arg0: &Operation) : &0x2::table::Table<address, vector<address>> {
        let v0 = SingleVaultOperatorConfigFieldKey{dummy_field: false};
        &0x2::dynamic_field::borrow<SingleVaultOperatorConfigFieldKey, SingleVaultOperatorConfig>(&arg0.id, v0).vault_to_operators
    }

    public(friend) fun get_total_usd_value<T0>(arg0: &Vault<T0>, arg1: &0x2::clock::Clock) : u256 {
        check_version<T0>(arg0);
        assert_enabled<T0>(arg0);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = 0;
        let v2 = &arg0.asset_types;
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x1::ascii::String>(v2)) {
            let v4 = 0x1::vector::borrow<0x1::ascii::String>(v2, v3);
            assert!(v0 - *0x2::table::borrow<0x1::ascii::String, u64>(&arg0.assets_value_updated, *v4) <= 0, 5007);
            v1 = v1 + *0x2::table::borrow<0x1::ascii::String, u256>(&arg0.assets_value, *v4);
            v3 = v3 + 1;
        };
        let v5 = TotalUSDValueUpdated{
            vault_id        : vault_id<T0>(arg0),
            total_usd_value : v1,
            timestamp       : v0,
        };
        0x2::event::emit<TotalUSDValueUpdated>(v5);
        v1
    }

    public fun get_total_usd_value_without_update<T0>(arg0: &Vault<T0>) : u256 {
        check_version<T0>(arg0);
        let v0 = 0;
        let v1 = &arg0.asset_types;
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::ascii::String>(v1)) {
            v0 = v0 + *0x2::table::borrow<0x1::ascii::String, u256>(&arg0.assets_value, *0x1::vector::borrow<0x1::ascii::String>(v1, v2));
            v2 = v2 + 1;
        };
        v0
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = Operation{
            id                : 0x2::object::new(arg0),
            freezed_operators : 0x2::table::new<address, bool>(arg0),
        };
        0x2::transfer::share_object<Operation>(v1);
    }

    public fun locking_time_for_cancel_request<T0>(arg0: &Vault<T0>) : u64 {
        arg0.locking_time_for_cancel_request
    }

    public fun locking_time_for_withdraw<T0>(arg0: &Vault<T0>) : u64 {
        arg0.locking_time_for_withdraw
    }

    public fun loss_tolerance<T0>(arg0: &Vault<T0>) : u256 {
        arg0.loss_tolerance
    }

    public fun op_value_update_record<T0>(arg0: &Vault<T0>) : &OperationValueUpdateRecord {
        &arg0.op_value_update_record
    }

    public fun op_value_update_record_assets_borrowed(arg0: &OperationValueUpdateRecord) : &vector<0x1::ascii::String> {
        &arg0.asset_types_borrowed
    }

    public fun op_value_update_record_assets_updated(arg0: &OperationValueUpdateRecord) : &0x2::table::Table<0x1::ascii::String, bool> {
        &arg0.asset_types_updated
    }

    public fun op_value_update_record_value_update_enabled(arg0: &OperationValueUpdateRecord) : bool {
        arg0.value_update_enabled
    }

    public(friend) fun operation_id_mut(arg0: &mut Operation) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public fun operator_freezed(arg0: &Operation, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.freezed_operators, arg1) && *0x2::table::borrow<address, bool>(&arg0.freezed_operators, arg1)
    }

    public fun operator_id(arg0: &OperatorCap) : address {
        0x2::object::uid_to_address(&arg0.id)
    }

    public(friend) fun remove_coin_type_asset<T0, T1>(arg0: &mut Vault<T0>) {
        check_version<T0>(arg0);
        assert_normal<T0>(arg0);
        assert!(0x1::type_name::get<T1>() != 0x1::type_name::get<T0>(), 5026);
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        let (v1, v2) = 0x1::vector::index_of<0x1::ascii::String>(&arg0.asset_types, &v0);
        assert!(v1, 5012);
        0x1::vector::remove<0x1::ascii::String>(&mut arg0.asset_types, v2);
        0x2::balance::destroy_zero<T1>(0x2::bag::remove<0x1::ascii::String, 0x2::balance::Balance<T1>>(&mut arg0.assets, v0));
        0x2::table::remove<0x1::ascii::String, u256>(&mut arg0.assets_value, v0);
        0x2::table::remove<0x1::ascii::String, u64>(&mut arg0.assets_value_updated, v0);
        let v3 = CoinTypeAssetRemoved{
            vault_id   : vault_id<T0>(arg0),
            asset_type : v0,
        };
        0x2::event::emit<CoinTypeAssetRemoved>(v3);
    }

    public(friend) fun remove_defi_asset_support<T0, T1: store + key>(arg0: &mut Vault<T0>, arg1: u8) : T1 {
        check_version<T0>(arg0);
        assert_normal<T0>(arg0);
        let v0 = 0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::vault_utils::parse_key<T1>(arg1);
        let (v1, v2) = 0x1::vector::index_of<0x1::ascii::String>(&arg0.asset_types, &v0);
        assert!(v1, 5012);
        0x1::vector::remove<0x1::ascii::String>(&mut arg0.asset_types, v2);
        assert!(*0x2::table::borrow<0x1::ascii::String, u256>(&arg0.assets_value, v0) == 0 || *0x2::table::borrow<0x1::ascii::String, u64>(&arg0.assets_value_updated, v0) == 0, 5012);
        let v3 = DefiAssetRemoved{
            vault_id   : vault_id<T0>(arg0),
            asset_type : v0,
        };
        0x2::event::emit<DefiAssetRemoved>(v3);
        0x2::bag::remove<0x1::ascii::String, T1>(&mut arg0.assets, v0)
    }

    public(friend) fun remove_single_vault_operator(arg0: &mut Operation, arg1: address, arg2: address) {
        let v0 = SingleVaultOperatorConfigFieldKey{dummy_field: false};
        let v1 = 0x2::table::borrow_mut<address, vector<address>>(&mut 0x2::dynamic_field::borrow_mut<SingleVaultOperatorConfigFieldKey, SingleVaultOperatorConfig>(operation_id_mut(arg0), v0).vault_to_operators, arg1);
        let (v2, v3) = 0x1::vector::index_of<address>(v1, &arg2);
        assert!(v2, 5029);
        0x1::vector::swap_remove<address>(v1, v3);
        let v4 = SingleVaultOperatorRemoved{
            vault_id    : arg1,
            operator_id : arg2,
        };
        0x2::event::emit<SingleVaultOperatorRemoved>(v4);
    }

    public(friend) fun request_deposit<T0>(arg0: &mut Vault<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: u256, arg4: address, arg5: address) : u64 {
        check_version<T0>(arg0);
        assert_normal<T0>(arg0);
        assert!(contains_vault_receipt_info<T0>(arg0, arg4), 5020);
        let v0 = 0x2::table::borrow_mut<address, 0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::vault_receipt_info::VaultReceiptInfo>(&mut arg0.receipts, arg4);
        assert!(0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::vault_receipt_info::status(v0) == 0, 5017);
        let v1 = arg0.request_buffer.deposit_id_count;
        arg0.request_buffer.deposit_id_count = v1 + 1;
        let v2 = 0x2::coin::value<T0>(&arg1);
        0x2::table::add<u64, 0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::deposit_request::DepositRequest>(&mut arg0.request_buffer.deposit_requests, v1, 0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::deposit_request::new(v1, arg4, arg5, 0x2::object::uid_to_address(&arg0.id), v2, arg3, 0x2::clock::timestamp_ms(arg2)));
        let v3 = DepositRequested{
            request_id      : v1,
            receipt_id      : arg4,
            recipient       : arg5,
            vault_id        : 0x2::object::uid_to_address(&arg0.id),
            amount          : v2,
            expected_shares : arg3,
        };
        0x2::event::emit<DepositRequested>(v3);
        0x2::table::add<u64, 0x2::coin::Coin<T0>>(&mut arg0.request_buffer.deposit_coin_buffer, v1, arg1);
        0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::vault_receipt_info::update_after_request_deposit(v0, v2);
        v1
    }

    public(friend) fun request_withdraw<T0>(arg0: &mut Vault<T0>, arg1: &0x2::clock::Clock, arg2: address, arg3: u256, arg4: u64, arg5: address) : u64 {
        check_version<T0>(arg0);
        assert_normal<T0>(arg0);
        assert!(contains_vault_receipt_info<T0>(arg0, arg2), 5020);
        let v0 = 0x2::table::borrow_mut<address, 0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::vault_receipt_info::VaultReceiptInfo>(&mut arg0.receipts, arg2);
        assert!(0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::vault_receipt_info::status(v0) == 0, 5017);
        assert!(0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::vault_receipt_info::shares(v0) >= arg3, 5019);
        let v1 = arg0.request_buffer.withdraw_id_count;
        arg0.request_buffer.withdraw_id_count = v1 + 1;
        0x2::table::add<u64, 0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::withdraw_request::WithdrawRequest>(&mut arg0.request_buffer.withdraw_requests, v1, 0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::withdraw_request::new(v1, arg2, arg5, 0x2::object::uid_to_address(&arg0.id), arg3, arg4, 0x2::clock::timestamp_ms(arg1)));
        let v2 = WithdrawRequested{
            request_id      : v1,
            receipt_id      : arg2,
            recipient       : arg5,
            vault_id        : 0x2::object::uid_to_address(&arg0.id),
            shares          : arg3,
            expected_amount : arg4,
        };
        0x2::event::emit<WithdrawRequested>(v2);
        0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::vault_receipt_info::update_after_request_withdraw(v0, arg3, arg5);
        v1
    }

    public(friend) fun retrieve_deposit_withdraw_fee<T0>(arg0: &mut Vault<T0>, arg1: u64) : 0x2::balance::Balance<T0> {
        check_version<T0>(arg0);
        assert_normal<T0>(arg0);
        let v0 = DepositWithdrawFeeRetrieved{
            vault_id : vault_id<T0>(arg0),
            amount   : arg1,
        };
        0x2::event::emit<DepositWithdrawFeeRetrieved>(v0);
        0x2::balance::split<T0>(&mut arg0.deposit_withdraw_fee_collected, arg1)
    }

    public(friend) fun return_coin_type_asset<T0, T1>(arg0: &mut Vault<T0>, arg1: 0x2::balance::Balance<T1>) {
        check_version<T0>(arg0);
        assert_enabled<T0>(arg0);
        0x2::balance::join<T1>(0x2::bag::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T1>>(&mut arg0.assets, 0x1::type_name::into_string(0x1::type_name::get<T1>())), arg1);
    }

    public(friend) fun return_defi_asset<T0, T1: store + key>(arg0: &mut Vault<T0>, arg1: 0x1::ascii::String, arg2: T1) {
        check_version<T0>(arg0);
        let v0 = DefiAssetReturned{
            vault_id   : vault_id<T0>(arg0),
            asset_type : arg1,
        };
        0x2::event::emit<DefiAssetReturned>(v0);
        0x2::bag::add<0x1::ascii::String, T1>(&mut arg0.assets, arg1, arg2);
    }

    public(friend) fun return_free_principal<T0>(arg0: &mut Vault<T0>, arg1: 0x2::balance::Balance<T0>) {
        check_version<T0>(arg0);
        assert_enabled<T0>(arg0);
        let v0 = FreePrincipalReturned{
            vault_id : vault_id<T0>(arg0),
            amount   : 0x2::balance::value<T0>(&arg1),
        };
        0x2::event::emit<FreePrincipalReturned>(v0);
        0x2::balance::join<T0>(&mut arg0.free_principal, arg1);
    }

    public fun reward_manager_id<T0>(arg0: &Vault<T0>) : address {
        arg0.reward_manager
    }

    public(friend) fun set_deposit_fee<T0>(arg0: &mut Vault<T0>, arg1: u64) {
        check_version<T0>(arg0);
        assert!(arg1 <= 500, 5001);
        arg0.deposit_fee_rate = arg1;
        let v0 = DepositFeeChanged{
            vault_id : vault_id<T0>(arg0),
            fee      : arg1,
        };
        0x2::event::emit<DepositFeeChanged>(v0);
    }

    public(friend) fun set_enabled<T0>(arg0: &mut Vault<T0>, arg1: bool) {
        check_version<T0>(arg0);
        assert!(status<T0>(arg0) != 1, 5025);
        if (arg1) {
            set_status<T0>(arg0, 0);
        } else {
            set_status<T0>(arg0, 2);
        };
        let v0 = VaultEnabled{
            vault_id : vault_id<T0>(arg0),
            enabled  : arg1,
        };
        0x2::event::emit<VaultEnabled>(v0);
    }

    public(friend) fun set_locking_time_for_cancel_request<T0>(arg0: &mut Vault<T0>, arg1: u64) {
        check_version<T0>(arg0);
        arg0.locking_time_for_cancel_request = arg1;
        let v0 = LockingTimeForCancelRequestChanged{
            vault_id     : vault_id<T0>(arg0),
            locking_time : arg1,
        };
        0x2::event::emit<LockingTimeForCancelRequestChanged>(v0);
    }

    public(friend) fun set_locking_time_for_withdraw<T0>(arg0: &mut Vault<T0>, arg1: u64) {
        check_version<T0>(arg0);
        arg0.locking_time_for_withdraw = arg1;
        let v0 = LockingTimeForWithdrawChanged{
            vault_id     : vault_id<T0>(arg0),
            locking_time : arg1,
        };
        0x2::event::emit<LockingTimeForWithdrawChanged>(v0);
    }

    public(friend) fun set_loss_tolerance<T0>(arg0: &mut Vault<T0>, arg1: u256) {
        check_version<T0>(arg0);
        assert!(arg1 <= (10000 as u256), 5001);
        arg0.loss_tolerance = arg1;
        let v0 = ToleranceChanged{
            vault_id  : vault_id<T0>(arg0),
            tolerance : arg1,
        };
        0x2::event::emit<ToleranceChanged>(v0);
    }

    public(friend) fun set_new_asset_type<T0>(arg0: &mut Vault<T0>, arg1: 0x1::ascii::String) {
        check_version<T0>(arg0);
        assert_enabled<T0>(arg0);
        assert!(!0x1::vector::contains<0x1::ascii::String>(&arg0.asset_types, &arg1), 5011);
        0x1::vector::push_back<0x1::ascii::String>(&mut arg0.asset_types, arg1);
        0x2::table::add<0x1::ascii::String, u256>(&mut arg0.assets_value, arg1, 0);
        0x2::table::add<0x1::ascii::String, u64>(&mut arg0.assets_value_updated, arg1, 0);
        let v0 = NewAssetTypeAdded{
            vault_id   : vault_id<T0>(arg0),
            asset_type : arg1,
        };
        0x2::event::emit<NewAssetTypeAdded>(v0);
    }

    public(friend) fun set_operator_freezed(arg0: &mut Operation, arg1: address, arg2: bool) {
        if (0x2::table::contains<address, bool>(&arg0.freezed_operators, arg1)) {
            *0x2::table::borrow_mut<address, bool>(&mut arg0.freezed_operators, arg1) = arg2;
        } else {
            0x2::table::add<address, bool>(&mut arg0.freezed_operators, arg1, arg2);
        };
        let v0 = OperatorFreezed{
            operator_id : arg1,
            freezed     : arg2,
        };
        0x2::event::emit<OperatorFreezed>(v0);
    }

    public(friend) fun set_reward_manager<T0>(arg0: &mut Vault<T0>, arg1: address) {
        check_version<T0>(arg0);
        assert!(arg0.reward_manager == 0x2::address::from_u256(0), 5014);
        arg0.reward_manager = arg1;
        let v0 = RewardManagerSet{
            vault_id          : vault_id<T0>(arg0),
            reward_manager_id : arg1,
        };
        0x2::event::emit<RewardManagerSet>(v0);
    }

    public(friend) fun set_single_vault_operator(arg0: &mut Operation, arg1: address, arg2: address) {
        let v0 = SingleVaultOperatorConfigFieldKey{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow_mut<SingleVaultOperatorConfigFieldKey, SingleVaultOperatorConfig>(operation_id_mut(arg0), v0);
        if (!0x2::table::contains<address, vector<address>>(&v1.vault_to_operators, arg1)) {
            0x2::table::add<address, vector<address>>(&mut v1.vault_to_operators, arg1, 0x1::vector::empty<address>());
        };
        0x1::vector::push_back<address>(0x2::table::borrow_mut<address, vector<address>>(&mut v1.vault_to_operators, arg1), arg2);
        let v2 = SingleVaultOperatorAdded{
            vault_id    : arg1,
            operator_id : arg2,
        };
        0x2::event::emit<SingleVaultOperatorAdded>(v2);
    }

    public(friend) fun set_status<T0>(arg0: &mut Vault<T0>, arg1: u8) {
        check_version<T0>(arg0);
        arg0.status = arg1;
        let v0 = VaultStatusChanged{
            vault_id : vault_id<T0>(arg0),
            status   : arg1,
        };
        0x2::event::emit<VaultStatusChanged>(v0);
    }

    public(friend) fun set_withdraw_fee<T0>(arg0: &mut Vault<T0>, arg1: u64) {
        check_version<T0>(arg0);
        assert!(arg1 <= 500, 5001);
        arg0.withdraw_fee_rate = arg1;
        let v0 = WithdrawFeeChanged{
            vault_id : vault_id<T0>(arg0),
            fee      : arg1,
        };
        0x2::event::emit<WithdrawFeeChanged>(v0);
    }

    public fun status<T0>(arg0: &Vault<T0>) : u8 {
        arg0.status
    }

    public fun total_shares<T0>(arg0: &Vault<T0>) : u256 {
        arg0.total_shares
    }

    public(friend) fun try_reset_tolerance<T0>(arg0: &mut Vault<T0>, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        check_version<T0>(arg0);
        if (arg1 || arg0.cur_epoch < 0x2::tx_context::epoch(arg2)) {
            arg0.cur_epoch_loss = 0;
            arg0.cur_epoch = 0x2::tx_context::epoch(arg2);
            arg0.cur_epoch_loss_base_usd_value = get_total_usd_value_without_update<T0>(arg0);
            let v0 = LossToleranceReset{
                vault_id : vault_id<T0>(arg0),
                epoch    : arg0.cur_epoch,
            };
            0x2::event::emit<LossToleranceReset>(v0);
        };
    }

    public fun update_coin_type_asset_value<T0, T1>(arg0: &mut Vault<T0>, arg1: &0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::vault_oracle::OracleConfig, arg2: &0x2::clock::Clock) {
        check_version<T0>(arg0);
        assert_enabled<T0>(arg0);
        assert!(0x1::type_name::get<T1>() != 0x1::type_name::get<T0>(), 5026);
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        let v1 = 0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::vault_utils::mul_with_oracle_price((0x2::balance::value<T1>(0x2::bag::borrow<0x1::ascii::String, 0x2::balance::Balance<T1>>(&arg0.assets, v0)) as u256), 0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::vault_oracle::get_normalized_asset_price(arg1, arg2, v0));
        finish_update_asset_value<T0>(arg0, v0, v1, 0x2::clock::timestamp_ms(arg2));
    }

    public fun update_free_principal_value<T0>(arg0: &mut Vault<T0>, arg1: &0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::vault_oracle::OracleConfig, arg2: &0x2::clock::Clock) {
        check_version<T0>(arg0);
        assert_enabled<T0>(arg0);
        let v0 = 0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::vault_utils::mul_with_oracle_price((0x2::balance::value<T0>(&arg0.free_principal) as u256), 0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::vault_oracle::get_normalized_asset_price(arg1, arg2, 0x1::type_name::into_string(0x1::type_name::get<T0>())));
        finish_update_asset_value<T0>(arg0, 0x1::type_name::into_string(0x1::type_name::get<T0>()), v0, 0x2::clock::timestamp_ms(arg2));
    }

    public(friend) fun update_tolerance<T0>(arg0: &mut Vault<T0>, arg1: u256) {
        check_version<T0>(arg0);
        arg0.cur_epoch_loss = arg0.cur_epoch_loss + arg1;
        let v0 = arg0.cur_epoch_loss_base_usd_value * (arg0.loss_tolerance as u256) / (10000 as u256);
        assert!(v0 >= arg0.cur_epoch_loss, 5008);
        let v1 = LossToleranceUpdated{
            vault_id     : vault_id<T0>(arg0),
            current_loss : arg0.cur_epoch_loss,
            loss_limit   : v0,
        };
        0x2::event::emit<LossToleranceUpdated>(v1);
    }

    public(friend) fun upgrade_vault<T0>(arg0: &mut Vault<T0>) {
        assert!(arg0.version < 1, 5013);
        arg0.version = 1;
        let v0 = VaultUpgraded{
            vault_id : 0x2::object::uid_to_address(&arg0.id),
            version  : 1,
        };
        0x2::event::emit<VaultUpgraded>(v0);
    }

    public fun validate_total_usd_value_updated<T0>(arg0: &Vault<T0>, arg1: &0x2::clock::Clock) {
        check_version<T0>(arg0);
        let v0 = &arg0.asset_types;
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::ascii::String>(v0)) {
            assert!(0x2::clock::timestamp_ms(arg1) - *0x2::table::borrow<0x1::ascii::String, u64>(&arg0.assets_value_updated, *0x1::vector::borrow<0x1::ascii::String>(v0, v1)) <= 0, 5007);
            v1 = v1 + 1;
        };
    }

    public(friend) fun vault_receipt_info_mut<T0>(arg0: &mut Vault<T0>, arg1: address) : &mut 0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::vault_receipt_info::VaultReceiptInfo {
        0x2::table::borrow_mut<address, 0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::vault_receipt_info::VaultReceiptInfo>(&mut arg0.receipts, arg1)
    }

    public fun withdraw_fee_rate<T0>(arg0: &Vault<T0>) : u64 {
        arg0.withdraw_fee_rate
    }

    public fun withdraw_request<T0>(arg0: &Vault<T0>, arg1: u64) : &0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::withdraw_request::WithdrawRequest {
        let v0 = &arg0.request_buffer;
        assert!(0x2::table::contains<u64, 0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::withdraw_request::WithdrawRequest>(&v0.withdraw_requests, arg1), 5010);
        0x2::table::borrow<u64, 0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::withdraw_request::WithdrawRequest>(&v0.withdraw_requests, arg1)
    }

    // decompiled from Move bytecode v6
}

