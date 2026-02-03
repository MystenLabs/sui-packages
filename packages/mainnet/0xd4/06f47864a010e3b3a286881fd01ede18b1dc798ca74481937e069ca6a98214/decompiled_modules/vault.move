module 0x45355b07146d699e6a8c405bcc2f60ef5d062a15183c6012ac55d5734d8add21::vault {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct OperatorCap has store, key {
        id: 0x2::object::UID,
    }

    struct AccessCap has store, key {
        id: 0x2::object::UID,
    }

    struct PauserCap has store, key {
        id: 0x2::object::UID,
    }

    struct VaultConfig has store, key {
        id: 0x2::object::UID,
        version: u64,
        allowed_access: vector<0x2::object::ID>,
        operators: 0x2::table::Table<address, 0x2::object::ID>,
        signers: 0x2::table::Table<vector<u8>, bool>,
        threshold: u64,
    }

    struct CoinStore<phantom T0> has store {
        coin: 0x1::option::Option<0x2::coin::Coin<T0>>,
    }

    struct PendingRedeem has copy, drop, store {
        withdraw_time: u64,
        amount: u64,
        lp: u64,
        rate: u64,
    }

    struct PendingRedeemV2 has copy, drop, store {
        withdraw_time: u64,
        amount: u64,
        lp: u64,
        rate: u64,
        token_a: 0x1::option::Option<0x1::ascii::String>,
        token_a_amount: u64,
        token_b: 0x1::option::Option<0x1::ascii::String>,
        token_b_amount: u64,
    }

    struct Deposit has copy, drop, store {
        fee_bps: u64,
        min: u64,
        total_fee: u64,
    }

    struct Withdraw has copy, drop, store {
        fee_bps: u64,
        min: u64,
        total_fee: u64,
    }

    struct PerformanceFee has store {
        fee_bps: u64,
        total_fee: u64,
    }

    struct ManagementFee has store {
        fee_bps: u64,
        total_fee: u64,
        period_duration: u64,
        latest_deduce_time: u64,
    }

    struct Vault<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<T1>,
        coin_store: CoinStore<T0>,
        enable: bool,
        harvest_asset_keys: vector<0x1::ascii::String>,
        harvest_assets: 0x2::bag::Bag,
        total_deposit: u128,
        liquidity: u128,
        available_liquidity: u128,
        profit: u128,
        last_update: u64,
        lp_storage: 0x2::vec_map::VecMap<0x2::object::ID, vector<0x2::object::ID>>,
        rate: u64,
        pending_redemptions: u128,
        pending_redeems: 0x2::table::Table<address, vector<PendingRedeem>>,
        lock_duration_ms: u64,
        fee_receiver: address,
        deposit: Deposit,
        withdraw: Withdraw,
        performance_fee: PerformanceFee,
        management_fee: ManagementFee,
        total_fee: u64,
        pending_fee: u64,
        hwm: u128,
        latest_credit_time: u64,
        total_withdraw: u128,
        withdraw_asset_keys: vector<0x1::ascii::String>,
        withdraw_assets: 0x2::bag::Bag,
        reserves: 0x2::bag::Bag,
    }

    struct TableVaultAssets has store {
        tb: 0x2::table::Table<0x1::ascii::String, u128>,
    }

    struct TableWithdrawAssets has store {
        tb: 0x2::table::Table<0x1::ascii::String, u128>,
    }

    struct CreatedVaultEvent has copy, drop, store {
        id: 0x2::object::ID,
    }

    struct RedeemEvent has copy, drop, store {
        receiver: address,
        amount: u64,
        vault_id: 0x2::object::ID,
        fee: u64,
    }

    struct AddFundEvent has copy, drop, store {
        amount: u64,
        vault_id: 0x2::object::ID,
    }

    struct WithdrawFeeEvent has copy, drop, store {
        amount: u64,
        vault_id: 0x2::object::ID,
        time: u64,
    }

    struct RedeemFeeEvent has copy, drop, store {
        receiver: address,
        amount: u64,
        vault_id: 0x2::object::ID,
    }

    struct RedeemFeeEventV2 has copy, drop, store {
        receiver: address,
        amount: u64,
        vault_id: 0x2::object::ID,
        withdraw_requests: vector<u64>,
    }

    struct DeductManagementFeeEvent has copy, drop, store {
        amount: u64,
        before_liquidity: u128,
        liquidity: u128,
        vault_id: 0x2::object::ID,
        time: u64,
        rate: u64,
    }

    struct AllowAccessCapEvent has copy, drop {
        access_cap_id: 0x2::object::ID,
    }

    struct DenyAccessCapEvent has copy, drop {
        access_cap_id: 0x2::object::ID,
    }

    struct AddOperatorEvent has copy, drop {
        operator: address,
    }

    struct RemoveOperatorEvent has copy, drop {
        operator: address,
    }

    struct UpdateLockDurationEvent has copy, drop {
        vault_id: 0x2::object::ID,
        lock_duration_ms: u64,
    }

    struct UpdateDepositFeeEvent has copy, drop {
        vault_id: 0x2::object::ID,
        fee_bps: u64,
    }

    struct UpdateWithdrawFeeEvent has copy, drop {
        vault_id: 0x2::object::ID,
        fee_bps: u64,
    }

    struct UpdatePerformanceFeeEvent has copy, drop {
        vault_id: 0x2::object::ID,
        fee_bps: u64,
    }

    struct UpdateManagementFeeEvent has copy, drop {
        vault_id: 0x2::object::ID,
        fee_bps: u64,
    }

    struct UpdateManagementPeriodDurationEvent has copy, drop {
        vault_id: 0x2::object::ID,
        period_duration: u64,
    }

    struct UpdateFeeReceiverEvent has copy, drop {
        vault_id: 0x2::object::ID,
        address: address,
    }

    struct UpdateMinDepositEvent has copy, drop {
        vault_id: 0x2::object::ID,
        min: u64,
    }

    struct UpdateMinWithdrawEvent has copy, drop {
        vault_id: 0x2::object::ID,
        min: u64,
    }

    struct Pause<phantom T0> has copy, drop {
        dummy_field: bool,
    }

    struct Resume<phantom T0> has copy, drop {
        dummy_field: bool,
    }

    struct RedeemWithSigEvent has copy, drop, store {
        receiver: address,
        item_amount: u64,
        amount: u64,
        vault_id: 0x2::object::ID,
        fee: u64,
        withdraw_time_requests: vector<u64>,
        withdraw_amount_requests: vector<u64>,
        time: u64,
    }

    struct RedeemWithSigTokenEvent has copy, drop, store {
        receiver: address,
        item_amount: u64,
        amount: u64,
        collateral_amount: u64,
        vault_id: 0x2::object::ID,
        fee: u64,
        withdraw_time_requests: vector<u64>,
        withdraw_amount_requests: vector<u64>,
        withdraw_amount_collateral_requests: vector<u64>,
        time: u64,
        token: 0x1::ascii::String,
    }

    struct DepositWithSigTimeEvent has copy, drop, store {
        sender: address,
        amount: u64,
        lp: u64,
        vault_id: 0x2::object::ID,
        fee: u64,
        hwm: u128,
        profit: u64,
        rate: u64,
        time: u64,
        negative: bool,
        credit_time: u64,
    }

    struct WithdrawWithSigTimeEvent has copy, drop, store {
        user: address,
        lp: u64,
        amount: u64,
        vault_id: 0x2::object::ID,
        hwm: u128,
        profit: u64,
        rate: u64,
        fee: u64,
        paid: bool,
        time: u64,
        negative: bool,
        credit_time: u64,
        token: 0x1::ascii::String,
    }

    struct AddProfitTimeEvent has copy, drop, store {
        profit: u128,
        before_liquidity: u128,
        liquidity: u128,
        rate: u64,
        last_update: u64,
        vault_id: 0x2::object::ID,
        fee: u64,
        current_hwm: u128,
        new_hwm: u128,
        credit_time: u64,
    }

    struct CreditLossTimeEvent has copy, drop, store {
        loss: u128,
        before_liquidity: u128,
        liquidity: u128,
        rate: u64,
        last_update: u64,
        vault_id: 0x2::object::ID,
        credit_time: u64,
    }

    struct AddSignerEvent has copy, drop {
        signer: vector<u8>,
    }

    struct RemoveSignerEvent has copy, drop {
        signer: vector<u8>,
    }

    struct MoveTokenToWithdrawAssetEvent has copy, drop {
        amount: u64,
        vault_id: 0x2::object::ID,
        token: 0x1::ascii::String,
    }

    struct DualTokenDepositEvent has copy, drop, store {
        sender: address,
        amount: u64,
        lp: u64,
        vault_id: 0x2::object::ID,
        fee: u64,
        current_vault_value: u128,
        profit: u64,
        rate: u64,
        time: u64,
        negative: bool,
        credit_time: u64,
        token_a: 0x1::ascii::String,
        token_b: 0x1::ascii::String,
        token_a_amount: u64,
        token_b_amount: u64,
    }

    struct ZapModeDepositEvent has copy, drop, store {
        sender: address,
        amount: u64,
        lp: u64,
        vault_id: 0x2::object::ID,
        fee: u64,
        current_vault_value: u128,
        profit: u64,
        rate: u64,
        time: u64,
        negative: bool,
        credit_time: u64,
        token_a: 0x1::ascii::String,
        token_b: 0x1::ascii::String,
        token_a_amount: u64,
        token_b_amount: u64,
        token_deposit: 0x1::ascii::String,
        token_deposit_amount: u64,
    }

    struct DualTokenWithdrawEvent has copy, drop, store {
        user: address,
        lp: u64,
        amount: u64,
        vault_id: 0x2::object::ID,
        current_vault_value: u128,
        profit: u64,
        rate: u64,
        fee: u64,
        time: u64,
        negative: bool,
        credit_time: u64,
        token_a: 0x1::ascii::String,
        token_b: 0x1::ascii::String,
        amount_a_by_collateral: u64,
        amount_b_by_collateral: u64,
    }

    struct DualTokensRedeemEvent has copy, drop, store {
        receiver: address,
        item_amount: u64,
        collateral_amount: u64,
        vault_id: 0x2::object::ID,
        fee_a: u64,
        fee_b: u64,
        tokens: vector<vector<0x1::ascii::String>>,
        withdraw_time_requests: vector<u64>,
        withdraw_amount_requests: vector<vector<u64>>,
        withdraw_amount_collateral_requests: vector<u64>,
        time: u64,
        token_a: 0x1::ascii::String,
        token_b: 0x1::ascii::String,
        token_a_amount: u64,
        token_b_amount: u64,
    }

    struct CollectFeeEvent has copy, drop, store {
        fee_receiver: address,
        vault_id: 0x2::object::ID,
        token_amount: u64,
        token: 0x1::ascii::String,
        time: u64,
        fee_type: u8,
    }

    struct UpdateWithdrawFeeReceiverEvent has copy, drop {
        vault_id: 0x2::object::ID,
        address: address,
    }

    struct AllowPauserCapEvent has copy, drop {
        pauser_cap_id: 0x2::object::ID,
    }

    struct DenyPauserCapEvent has copy, drop {
        pauser_cap_id: 0x2::object::ID,
    }

    struct GlobalPause has copy, drop {
        address: address,
        global_pause: bool,
    }

    struct DepositEventV2 has copy, drop, store {
        sender: address,
        amount: u64,
        net_amount: u64,
        lp: u64,
        vault_id: 0x2::object::ID,
        fee: u64,
        liquidity: u128,
        total_supply: u64,
        rate: u64,
        time: u64,
    }

    struct DualTokenDepositEventV2 has copy, drop, store {
        sender: address,
        amount: u64,
        net_amount: u64,
        lp: u64,
        vault_id: 0x2::object::ID,
        fee: u64,
        liquidity: u128,
        total_supply: u64,
        rate: u64,
        time: u64,
        token_a: 0x1::ascii::String,
        token_b: 0x1::ascii::String,
        token_a_amount: u64,
        token_b_amount: u64,
    }

    struct ZapModeDepositEventV2 has copy, drop, store {
        sender: address,
        amount: u64,
        net_amount: u64,
        lp: u64,
        vault_id: 0x2::object::ID,
        fee: u64,
        liquidity: u128,
        total_supply: u64,
        rate: u64,
        time: u64,
        token_a: 0x1::ascii::String,
        token_b: 0x1::ascii::String,
        token_a_amount: u64,
        token_b_amount: u64,
        token_deposit: 0x1::ascii::String,
        token_deposit_amount: u64,
    }

    struct WithdrawEventV2 has copy, drop, store {
        user: address,
        lp: u64,
        amount: u64,
        net_amount: u64,
        vault_id: 0x2::object::ID,
        liquidity: u128,
        total_supply: u64,
        rate: u64,
        fee: u64,
        paid: bool,
        time: u64,
        token: 0x1::ascii::String,
        token_amount: u64,
    }

    struct DualWithdrawEventV2 has copy, drop, store {
        user: address,
        lp: u64,
        amount: u64,
        net_amount: u64,
        vault_id: 0x2::object::ID,
        liquidity: u128,
        total_supply: u64,
        rate: u64,
        fee: u64,
        time: u64,
        token_a: 0x1::ascii::String,
        token_b: 0x1::ascii::String,
        token_a_amount: u64,
        token_b_amount: u64,
        amount_a_by_collateral: u64,
        amount_b_by_collateral: u64,
    }

    struct UpdateRateEvent has copy, drop, store {
        vault_id: 0x2::object::ID,
        current_liquidity: u128,
        new_liquidity: u128,
        total_supply: u64,
        current_rate: u64,
        new_rate: u64,
        time: u64,
    }

    public fun verify_signature(arg0: &VaultConfig, arg1: vector<u8>, arg2: vector<vector<u8>>, arg3: vector<vector<u8>>) : bool {
        assert!(arg0.version == 9, 5);
        0x45355b07146d699e6a8c405bcc2f60ef5d062a15183c6012ac55d5734d8add21::utils::verify_signature(&arg0.signers, arg0.threshold, arg1, arg2, arg3)
    }

    public fun add_dynamic_field<T0, T1, T2: copy + drop + store>(arg0: &VaultConfig, arg1: &AccessCap, arg2: &mut Vault<T0, T1>, arg3: vector<u8>, arg4: T2) {
        assert!(check_access_cap(arg0, 0x2::object::id<AccessCap>(arg1)), 1);
        if (0x2::dynamic_field::exists_<vector<u8>>(&arg2.id, arg3)) {
            *0x2::dynamic_field::borrow_mut<vector<u8>, T2>(&mut arg2.id, arg3) = arg4;
        } else {
            0x2::dynamic_field::add<vector<u8>, T2>(&mut arg2.id, arg3, arg4);
        };
    }

    entry fun add_field_vault_asset<T0, T1>(arg0: &AdminCap, arg1: &mut Vault<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) {
        if (!0x2::dynamic_field::exists_<vector<u8>>(&arg1.id, b"table_vault_assets")) {
            let v0 = TableVaultAssets{tb: 0x2::table::new<0x1::ascii::String, u128>(arg2)};
            0x2::dynamic_field::add<vector<u8>, TableVaultAssets>(&mut arg1.id, b"table_vault_assets", v0);
        };
    }

    entry fun add_field_withdraw_asset<T0, T1>(arg0: &AdminCap, arg1: &mut Vault<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) {
        if (!0x2::dynamic_field::exists_<vector<u8>>(&arg1.id, b"table_withdraw_assets")) {
            let v0 = TableWithdrawAssets{tb: 0x2::table::new<0x1::ascii::String, u128>(arg2)};
            0x2::dynamic_field::add<vector<u8>, TableWithdrawAssets>(&mut arg1.id, b"table_withdraw_assets", v0);
        };
    }

    public entry fun add_fund<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x1::option::is_some<0x2::coin::Coin<T0>>(&arg0.coin_store.coin)) {
            0x2::coin::join<T0>(0x1::option::borrow_mut<0x2::coin::Coin<T0>>(&mut arg0.coin_store.coin), arg1);
        } else {
            0x1::option::fill<0x2::coin::Coin<T0>>(&mut arg0.coin_store.coin, arg1);
        };
        arg0.available_liquidity = (0x2::coin::value<T0>(0x1::option::borrow_mut<0x2::coin::Coin<T0>>(&mut arg0.coin_store.coin)) as u128);
        let v0 = arg0.available_liquidity;
        add_table_vault_asset<T0, T1>(arg0, 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()), v0, arg2);
        let v1 = AddFundEvent{
            amount   : 0x2::coin::value<T0>(&arg1),
            vault_id : 0x2::object::id<Vault<T0, T1>>(arg0),
        };
        0x2::event::emit<AddFundEvent>(v1);
    }

    public fun add_harvest_assets<T0, T1, T2>(arg0: &mut VaultConfig, arg1: &mut Vault<T0, T1>, arg2: 0x2::coin::Coin<T2>, arg3: &AccessCap) {
        assert!(arg0.version == 9, 5);
        assert!(!check_global_pause(arg0), 35);
        assert!(!check_trade_pause<T0, T1>(arg0, arg1), 44);
        assert!(check_access_cap(arg0, 0x2::object::id<AccessCap>(arg3)), 1);
        let v0 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T2>());
        let v1 = if (0x2::bag::contains<0x1::ascii::String>(&arg1.harvest_assets, v0)) {
            let v2 = 0x2::bag::borrow_mut<0x1::ascii::String, 0x2::coin::Coin<T2>>(&mut arg1.harvest_assets, v0);
            0x2::coin::join<T2>(v2, arg2);
            0x2::coin::value<T2>(v2)
        } else {
            0x2::bag::add<0x1::ascii::String, 0x2::coin::Coin<T2>>(&mut arg1.harvest_assets, v0, arg2);
            0x1::vector::push_back<0x1::ascii::String>(&mut arg1.harvest_asset_keys, v0);
            0x2::coin::value<T2>(&arg2)
        };
        add_table_vault_asset_no_ctx<T0, T1>(arg1, v0, (v1 as u128));
    }

    public fun add_lp<T0, T1>(arg0: &mut VaultConfig, arg1: &mut Vault<T0, T1>, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: &AccessCap) {
        assert!(arg0.version == 9, 5);
        assert!(!check_global_pause(arg0), 35);
        assert!(!check_trade_pause<T0, T1>(arg0, arg1), 44);
        assert!(check_access_cap(arg0, 0x2::object::id<AccessCap>(arg4)), 1);
        if (0x2::vec_map::contains<0x2::object::ID, vector<0x2::object::ID>>(&arg1.lp_storage, &arg2)) {
            let v0 = 0x2::vec_map::get_mut<0x2::object::ID, vector<0x2::object::ID>>(&mut arg1.lp_storage, &arg2);
            if (!0x1::vector::contains<0x2::object::ID>(v0, &arg3)) {
                0x1::vector::push_back<0x2::object::ID>(v0, arg3);
            };
        } else {
            let v1 = 0x1::vector::empty<0x2::object::ID>();
            0x1::vector::push_back<0x2::object::ID>(&mut v1, arg3);
            0x2::vec_map::insert<0x2::object::ID, vector<0x2::object::ID>>(&mut arg1.lp_storage, arg2, v1);
        };
    }

    public entry fun add_operator(arg0: &AdminCap, arg1: &mut VaultConfig, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 9, 5);
        assert!(!0x2::table::contains<address, 0x2::object::ID>(&arg1.operators, arg2), 10);
        let v0 = OperatorCap{id: 0x2::object::new(arg3)};
        0x2::table::add<address, 0x2::object::ID>(&mut arg1.operators, arg2, 0x2::object::id<OperatorCap>(&v0));
        0x2::transfer::transfer<OperatorCap>(v0, arg2);
        let v1 = AddOperatorEvent{operator: arg2};
        0x2::event::emit<AddOperatorEvent>(v1);
    }

    fun add_pending_redeem_v2<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: address, arg2: u64, arg3: u64, arg4: 0x1::option::Option<0x1::ascii::String>, arg5: u64, arg6: 0x1::option::Option<0x1::ascii::String>, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 6);
        let v0 = PendingRedeemV2{
            withdraw_time  : 0x2::clock::timestamp_ms(arg8),
            amount         : arg2,
            lp             : arg3,
            rate           : arg0.rate,
            token_a        : arg4,
            token_a_amount : arg5,
            token_b        : arg6,
            token_b_amount : arg7,
        };
        if (!0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"pending_redeems_v2")) {
            0x2::dynamic_field::add<vector<u8>, 0x2::table::Table<address, vector<PendingRedeemV2>>>(&mut arg0.id, b"pending_redeems_v2", 0x2::table::new<address, vector<PendingRedeemV2>>(arg9));
        };
        let v1 = 0x2::dynamic_field::borrow_mut<vector<u8>, 0x2::table::Table<address, vector<PendingRedeemV2>>>(&mut arg0.id, b"pending_redeems_v2");
        if (0x2::table::contains<address, vector<PendingRedeemV2>>(v1, arg1)) {
            let v2 = 0x2::table::borrow_mut<address, vector<PendingRedeemV2>>(v1, arg1);
            let v3 = 0;
            while (v3 < 0x1::vector::length<PendingRedeemV2>(v2)) {
                assert!(0x1::vector::borrow<PendingRedeemV2>(v2, v3).withdraw_time != v0.withdraw_time, 26);
                v3 = v3 + 1;
            };
            0x1::vector::push_back<PendingRedeemV2>(v2, v0);
        } else {
            let v4 = 0x1::vector::empty<PendingRedeemV2>();
            0x1::vector::push_back<PendingRedeemV2>(&mut v4, v0);
            0x2::table::add<address, vector<PendingRedeemV2>>(v1, arg1, v4);
        };
        arg0.pending_redemptions = arg0.pending_redemptions + (arg2 as u128);
    }

    public entry fun add_profit_with_credit_time<T0, T1>(arg0: &OperatorCap, arg1: &mut VaultConfig, arg2: &mut Vault<T0, T1>, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 9, 5);
        assert!(!check_global_pause(arg1), 35);
        abort 0
    }

    public fun add_profit_with_credit_time_sigs<T0, T1>(arg0: &OperatorCap, arg1: &mut VaultConfig, arg2: &mut Vault<T0, T1>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: vector<vector<u8>>, arg8: vector<vector<u8>>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 9, 5);
        assert!(!check_global_pause(arg1), 35);
        abort 0
    }

    public entry fun add_signer(arg0: &AdminCap, arg1: &mut VaultConfig, arg2: vector<u8>) {
        assert!(arg1.version == 9, 5);
        assert!(!0x2::table::contains<vector<u8>, bool>(&arg1.signers, arg2), 15);
        0x2::table::add<vector<u8>, bool>(&mut arg1.signers, arg2, true);
        let v0 = AddSignerEvent{signer: arg2};
        0x2::event::emit<AddSignerEvent>(v0);
    }

    fun add_table_vault_asset<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x1::ascii::String, arg2: u128, arg3: &mut 0x2::tx_context::TxContext) {
        if (!0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"table_vault_assets")) {
            let v0 = TableVaultAssets{tb: 0x2::table::new<0x1::ascii::String, u128>(arg3)};
            0x2::dynamic_field::add<vector<u8>, TableVaultAssets>(&mut arg0.id, b"table_vault_assets", v0);
        };
        let v1 = &mut 0x2::dynamic_field::borrow_mut<vector<u8>, TableVaultAssets>(&mut arg0.id, b"table_vault_assets").tb;
        if (0x2::table::contains<0x1::ascii::String, u128>(v1, arg1)) {
            *0x2::table::borrow_mut<0x1::ascii::String, u128>(v1, arg1) = arg2;
        } else {
            0x2::table::add<0x1::ascii::String, u128>(v1, arg1, arg2);
        };
    }

    fun add_table_vault_asset_no_ctx<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x1::ascii::String, arg2: u128) {
        let v0 = &mut 0x2::dynamic_field::borrow_mut<vector<u8>, TableVaultAssets>(&mut arg0.id, b"table_vault_assets").tb;
        if (0x2::table::contains<0x1::ascii::String, u128>(v0, arg1)) {
            *0x2::table::borrow_mut<0x1::ascii::String, u128>(v0, arg1) = arg2;
        } else {
            0x2::table::add<0x1::ascii::String, u128>(v0, arg1, arg2);
        };
    }

    fun add_table_withdraw_asset<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x1::ascii::String, arg2: u128, arg3: &mut 0x2::tx_context::TxContext) {
        if (!0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"table_withdraw_assets")) {
            let v0 = TableWithdrawAssets{tb: 0x2::table::new<0x1::ascii::String, u128>(arg3)};
            0x2::dynamic_field::add<vector<u8>, TableWithdrawAssets>(&mut arg0.id, b"table_withdraw_assets", v0);
        };
        let v1 = &mut 0x2::dynamic_field::borrow_mut<vector<u8>, TableWithdrawAssets>(&mut arg0.id, b"table_withdraw_assets").tb;
        if (0x2::table::contains<0x1::ascii::String, u128>(v1, arg1)) {
            *0x2::table::borrow_mut<0x1::ascii::String, u128>(v1, arg1) = arg2;
        } else {
            0x2::table::add<0x1::ascii::String, u128>(v1, arg1, arg2);
        };
    }

    public fun add_tbl_vault_asset<T0, T1, T2>(arg0: &mut Vault<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T2>());
        if (v0 == 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>())) {
            let v1 = (0x2::coin::value<T0>(0x1::option::borrow<0x2::coin::Coin<T0>>(&arg0.coin_store.coin)) as u128);
            add_table_vault_asset<T0, T1>(arg0, v0, v1, arg1);
        } else if (0x2::bag::contains<0x1::ascii::String>(&arg0.harvest_assets, v0)) {
            let v2 = (0x2::coin::value<T2>(0x2::bag::borrow<0x1::ascii::String, 0x2::coin::Coin<T2>>(&arg0.harvest_assets, v0)) as u128);
            add_table_vault_asset<T0, T1>(arg0, v0, v2, arg1);
        };
    }

    public fun add_tbl_withdraw_asset<T0, T1, T2>(arg0: &mut Vault<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T2>());
        let v1 = (0x2::coin::value<T2>(0x2::bag::borrow<0x1::ascii::String, 0x2::coin::Coin<T2>>(&arg0.withdraw_assets, v0)) as u128);
        add_table_withdraw_asset<T0, T1>(arg0, v0, v1, arg1);
    }

    entry fun add_vault_dynamic_field<T0, T1, T2: copy + drop + store>(arg0: &AdminCap, arg1: &mut Vault<T0, T1>, arg2: vector<u8>, arg3: T2) {
        if (0x2::dynamic_field::exists_<vector<u8>>(&arg1.id, arg2)) {
            *0x2::dynamic_field::borrow_mut<vector<u8>, T2>(&mut arg1.id, arg2) = arg3;
        } else {
            0x2::dynamic_field::add<vector<u8>, T2>(&mut arg1.id, arg2, arg3);
        };
    }

    public entry fun add_withdraw_assets<T0, T1, T2>(arg0: &OperatorCap, arg1: &mut VaultConfig, arg2: &mut Vault<T0, T1>, arg3: 0x2::coin::Coin<T2>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 9, 5);
        assert!(!check_global_pause(arg1), 35);
        assert!(check_operator(arg1, 0x2::tx_context::sender(arg4), 0x2::object::id<OperatorCap>(arg0)), 1);
        let v0 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T2>());
        if (0x2::bag::contains<0x1::ascii::String>(&arg2.withdraw_assets, v0)) {
            let v1 = 0x2::bag::borrow_mut<0x1::ascii::String, 0x2::coin::Coin<T2>>(&mut arg2.withdraw_assets, v0);
            0x2::coin::join<T2>(v1, arg3);
            add_table_withdraw_asset<T0, T1>(arg2, v0, (0x2::coin::value<T2>(v1) as u128), arg4);
        } else {
            add_table_withdraw_asset<T0, T1>(arg2, v0, (0x2::coin::value<T2>(&arg3) as u128), arg4);
            0x2::bag::add<0x1::ascii::String, 0x2::coin::Coin<T2>>(&mut arg2.withdraw_assets, v0, arg3);
            0x1::vector::push_back<0x1::ascii::String>(&mut arg2.withdraw_asset_keys, v0);
        };
    }

    public entry fun allow_access(arg0: &AdminCap, arg1: &mut VaultConfig, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 9, 5);
        let v0 = AccessCap{id: 0x2::object::new(arg3)};
        let v1 = 0x2::object::id<AccessCap>(&v0);
        0x2::transfer::public_transfer<AccessCap>(v0, arg2);
        0x1::vector::push_back<0x2::object::ID>(&mut arg1.allowed_access, v1);
        let v2 = AllowAccessCapEvent{access_cap_id: v1};
        0x2::event::emit<AllowAccessCapEvent>(v2);
    }

    entry fun allow_pauser_cap(arg0: &AdminCap, arg1: &mut VaultConfig, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 9, 5);
        let v0 = PauserCap{id: 0x2::object::new(arg3)};
        let v1 = 0x2::object::id<PauserCap>(&v0);
        0x2::transfer::public_transfer<PauserCap>(v0, arg2);
        if (!0x2::dynamic_field::exists_<vector<u8>>(&arg1.id, b"pausers")) {
            0x2::dynamic_field::add<vector<u8>, vector<0x2::object::ID>>(&mut arg1.id, b"pausers", 0x1::vector::empty<0x2::object::ID>());
        };
        0x1::vector::push_back<0x2::object::ID>(0x2::dynamic_field::borrow_mut<vector<u8>, vector<0x2::object::ID>>(&mut arg1.id, b"pausers"), v1);
        let v2 = AllowPauserCapEvent{pauser_cap_id: v1};
        0x2::event::emit<AllowPauserCapEvent>(v2);
    }

    fun calculate_fee(arg0: u64, arg1: u64) : u64 {
        arg0 * arg1 / 10000
    }

    fun calculate_profit_and_rate_internal<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: u128, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.hwm;
        let v1 = 0;
        let v2 = 0;
        if (arg0.liquidity > v0) {
            let v3 = ((arg0.liquidity - v0) as u64);
            v2 = v3;
            let v4 = calculate_fee(v3, arg0.performance_fee.fee_bps);
            v1 = v4;
            arg0.performance_fee.total_fee = arg0.performance_fee.total_fee + v4;
            arg0.hwm = arg0.liquidity;
        };
        let v5 = 0x2::coin::total_supply<T1>(&arg0.treasury_cap);
        arg0.liquidity = arg0.liquidity - (v1 as u128);
        if (v5 > 1) {
            arg0.rate = ((arg0.liquidity * (1000000 as u128) / (v5 as u128)) as u64);
        } else if (v5 == 0) {
            arg0.rate = 1 * 1000000;
        };
        assert!(arg0.rate > 0, 41);
        arg0.profit = arg0.profit + (v2 as u128);
        arg0.last_update = 0x2::clock::timestamp_ms(arg2);
        arg0.pending_fee = arg0.pending_fee + v1;
        arg0.total_fee = arg0.total_fee + v1;
        if (v2 > 0) {
            let v6 = AddProfitTimeEvent{
                profit           : (v2 as u128),
                before_liquidity : arg1,
                liquidity        : arg0.liquidity,
                rate             : arg0.rate,
                last_update      : arg0.last_update,
                vault_id         : 0x2::object::id<Vault<T0, T1>>(arg0),
                fee              : v1,
                current_hwm      : v0,
                new_hwm          : arg0.hwm,
                credit_time      : 0x2::clock::timestamp_ms(arg2),
            };
            0x2::event::emit<AddProfitTimeEvent>(v6);
        };
        let v7 = UpdateRateEvent{
            vault_id          : 0x2::object::id<Vault<T0, T1>>(arg0),
            current_liquidity : arg1,
            new_liquidity     : arg0.liquidity,
            total_supply      : v5,
            current_rate      : arg0.rate,
            new_rate          : arg0.rate,
            time              : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<UpdateRateEvent>(v7);
        if (v1 > 0) {
            withdraw_fee_internal<T0, T1>(arg0, v1, arg2, arg3);
        };
        arg0.latest_credit_time = 0x2::clock::timestamp_ms(arg2);
        set_dynamic_field<T0, T1, u64>(arg0, b"last_credit_profit_time", 0x2::clock::timestamp_ms(arg2));
        set_dynamic_field<T0, T1, u64>(arg0, b"last_credit_profit_amount", v2);
        set_dynamic_field<T0, T1, bool>(arg0, b"last_is_loss", false);
    }

    public fun check_access_cap(arg0: &VaultConfig, arg1: 0x2::object::ID) : bool {
        assert!(arg0.version == 9, 5);
        let v0 = arg0.allowed_access;
        let v1 = 0;
        let v2 = false;
        while (v1 < 0x1::vector::length<0x2::object::ID>(&v0)) {
            if (*0x1::vector::borrow<0x2::object::ID>(&v0, v1) == arg1) {
                v2 = true;
                break
            };
            v1 = v1 + 1;
        };
        v2
    }

    fun check_deposit_pause<T0, T1>(arg0: &VaultConfig, arg1: &Vault<T0, T1>) : bool {
        assert!(arg0.version == 9, 5);
        get_dynamic_field_or_default<T0, T1, bool>(arg1, b"deposit_pause", false)
    }

    public fun check_dynamic_field<T0, T1>(arg0: &Vault<T0, T1>, arg1: vector<u8>) : bool {
        0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, arg1)
    }

    fun check_global_pause(arg0: &VaultConfig) : bool {
        assert!(arg0.version == 9, 5);
        get_config_dynamic_field_or_default<bool>(arg0, b"global_pause", false)
    }

    public fun check_operator(arg0: &VaultConfig, arg1: address, arg2: 0x2::object::ID) : bool {
        if (!0x2::table::contains<address, 0x2::object::ID>(&arg0.operators, arg1)) {
            return false
        };
        0x2::table::borrow<address, 0x2::object::ID>(&arg0.operators, arg1) == &arg2
    }

    public fun check_pauser_cap(arg0: &mut VaultConfig, arg1: 0x2::object::ID) : bool {
        assert!(arg0.version == 9, 5);
        if (!0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"pausers")) {
            0x2::dynamic_field::add<vector<u8>, vector<0x2::object::ID>>(&mut arg0.id, b"pausers", 0x1::vector::empty<0x2::object::ID>());
        };
        let v0 = 0x2::dynamic_field::borrow<vector<u8>, vector<0x2::object::ID>>(&arg0.id, b"pausers");
        let v1 = 0;
        let v2 = false;
        while (v1 < 0x1::vector::length<0x2::object::ID>(v0)) {
            if (*0x1::vector::borrow<0x2::object::ID>(v0, v1) == arg1) {
                v2 = true;
                break
            };
            v1 = v1 + 1;
        };
        v2
    }

    public fun check_signer(arg0: &VaultConfig, arg1: vector<u8>) : bool {
        0x2::table::contains<vector<u8>, bool>(&arg0.signers, arg1)
    }

    fun check_trade_pause<T0, T1>(arg0: &VaultConfig, arg1: &Vault<T0, T1>) : bool {
        assert!(arg0.version == 9, 5);
        get_dynamic_field_or_default<T0, T1, bool>(arg1, b"trade_pause", false)
    }

    fun check_withdraw_pause<T0, T1>(arg0: &VaultConfig, arg1: &Vault<T0, T1>) : bool {
        assert!(arg0.version == 9, 5);
        get_dynamic_field_or_default<T0, T1, bool>(arg1, b"withdraw_pause", false)
    }

    public fun collect_fee_from_user<T0, T1, T2>(arg0: &VaultConfig, arg1: &Vault<T0, T1>, arg2: 0x2::coin::Coin<T2>, arg3: u8, arg4: &AccessCap, arg5: &0x2::clock::Clock) {
        assert!(check_access_cap(arg0, 0x2::object::id<AccessCap>(arg4)), 1);
        collect_fee_internal<T0, T1, T2>(arg0, arg1, arg2, arg3, arg5);
    }

    public(friend) fun collect_fee_internal<T0, T1, T2>(arg0: &VaultConfig, arg1: &Vault<T0, T1>, arg2: 0x2::coin::Coin<T2>, arg3: u8, arg4: &0x2::clock::Clock) {
        assert!(arg0.version == 9, 5);
        assert!(!check_global_pause(arg0), 35);
        assert!(arg1.enable, 4);
        let v0 = 0x2::coin::value<T2>(&arg2);
        if (arg1.deposit.fee_bps > 0) {
            assert!(v0 > 0, 12);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(arg2, arg1.fee_receiver);
        let v1 = CollectFeeEvent{
            fee_receiver : arg1.fee_receiver,
            vault_id     : 0x2::object::id<Vault<T0, T1>>(arg1),
            token_amount : v0,
            token        : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T2>()),
            time         : 0x2::clock::timestamp_ms(arg4),
            fee_type     : arg3,
        };
        0x2::event::emit<CollectFeeEvent>(v1);
    }

    public entry fun credit_loss_with_credit_time<T0, T1>(arg0: &OperatorCap, arg1: &mut VaultConfig, arg2: &mut Vault<T0, T1>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 9, 5);
        assert!(!check_global_pause(arg1), 35);
        abort 0
    }

    public fun credit_loss_with_credit_time_sigs<T0, T1>(arg0: &OperatorCap, arg1: &mut VaultConfig, arg2: &mut Vault<T0, T1>, arg3: u64, arg4: u64, arg5: u64, arg6: vector<vector<u8>>, arg7: vector<vector<u8>>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 9, 5);
        assert!(!check_global_pause(arg1), 35);
        abort 0
    }

    public entry fun deduct_management_fee<T0, T1>(arg0: &OperatorCap, arg1: &mut VaultConfig, arg2: &mut Vault<T0, T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 9, 5);
        assert!(!check_global_pause(arg1), 35);
        assert!(check_operator(arg1, 0x2::tx_context::sender(arg4), 0x2::object::id<OperatorCap>(arg0)), 1);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(arg2.management_fee.latest_deduce_time + arg2.management_fee.period_duration <= v0, 13);
        let v1 = calculate_fee((arg2.liquidity as u64), arg2.management_fee.fee_bps) / 365;
        assert!(v1 > 0, 12);
        arg2.management_fee.total_fee = arg2.management_fee.total_fee + v1;
        arg2.total_fee = arg2.total_fee + v1;
        arg2.pending_fee = arg2.pending_fee + v1;
        arg2.management_fee.latest_deduce_time = v0;
        arg2.liquidity = arg2.liquidity - (v1 as u128);
        arg2.last_update = v0;
        let v2 = 0x2::coin::total_supply<T1>(&arg2.treasury_cap);
        if (v2 > 1) {
            arg2.rate = ((arg2.liquidity * (1000000 as u128) / (v2 as u128)) as u64);
        } else if (v2 == 0) {
            arg2.rate = 1 * 1000000;
            arg2.liquidity = 0;
        };
        let v3 = DeductManagementFeeEvent{
            amount           : v1,
            before_liquidity : arg2.liquidity,
            liquidity        : arg2.liquidity,
            vault_id         : 0x2::object::id<Vault<T0, T1>>(arg2),
            time             : v0,
            rate             : arg2.rate,
        };
        0x2::event::emit<DeductManagementFeeEvent>(v3);
        withdraw_fee_internal<T0, T1>(arg2, v1, arg3, arg4);
    }

    public entry fun deny_access(arg0: &AdminCap, arg1: &mut VaultConfig, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 9, 5);
        let v0 = &mut arg1.allowed_access;
        let v1 = 0;
        let v2 = false;
        while (v1 < 0x1::vector::length<0x2::object::ID>(v0)) {
            if (*0x1::vector::borrow<0x2::object::ID>(v0, v1) == arg2) {
                v2 = true;
                break
            };
            v1 = v1 + 1;
        };
        assert!(v2, 8);
        0x1::vector::swap_remove<0x2::object::ID>(v0, v1);
        let v3 = DenyAccessCapEvent{access_cap_id: arg2};
        0x2::event::emit<DenyAccessCapEvent>(v3);
    }

    entry fun deny_pauser_cap(arg0: &AdminCap, arg1: &mut VaultConfig, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 9, 5);
        if (!0x2::dynamic_field::exists_<vector<u8>>(&arg1.id, b"pausers")) {
            0x2::dynamic_field::add<vector<u8>, vector<0x2::object::ID>>(&mut arg1.id, b"pausers", 0x1::vector::empty<0x2::object::ID>());
        };
        let v0 = 0x2::dynamic_field::borrow_mut<vector<u8>, vector<0x2::object::ID>>(&mut arg1.id, b"pausers");
        let v1 = 0;
        let v2 = false;
        while (v1 < 0x1::vector::length<0x2::object::ID>(v0)) {
            if (*0x1::vector::borrow<0x2::object::ID>(v0, v1) == arg2) {
                v2 = true;
                break
            };
            v1 = v1 + 1;
        };
        assert!(v2, 34);
        0x1::vector::swap_remove<0x2::object::ID>(v0, v1);
        let v3 = DenyPauserCapEvent{pauser_cap_id: arg2};
        0x2::event::emit<DenyPauserCapEvent>(v3);
    }

    public fun deposit_dual_token<T0, T1>(arg0: &mut VaultConfig, arg1: &mut Vault<T0, T1>, arg2: u64, arg3: u64, arg4: u64, arg5: bool, arg6: u64, arg7: u64, arg8: vector<vector<u8>>, arg9: vector<vector<u8>>, arg10: address, arg11: 0x1::ascii::String, arg12: 0x1::ascii::String, arg13: u64, arg14: u64, arg15: &0x2::clock::Clock, arg16: &AccessCap, arg17: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 9, 5);
        assert!(!check_global_pause(arg0), 35);
        abort 0
    }

    public fun deposit_dual_token_v2<T0, T1>(arg0: &mut VaultConfig, arg1: &mut Vault<T0, T1>, arg2: u64, arg3: u128, arg4: 0x1::ascii::String, arg5: 0x1::ascii::String, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &AccessCap, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 9, 5);
        assert!(!check_global_pause(arg0), 35);
        assert!(arg1.enable, 4);
        assert!(!check_deposit_pause<T0, T1>(arg0, arg1), 42);
        assert!(check_access_cap(arg0, 0x2::object::id<AccessCap>(arg9)), 1);
        assert!(arg2 >= arg1.deposit.min, 9);
        let v0 = arg1.liquidity;
        arg1.liquidity = arg3;
        let v1 = get_dynamic_field_or_default<T0, T1, u128>(arg1, b"max_vault_cap", 0);
        if (v1 > 0) {
            assert!(arg1.liquidity + (arg2 as u128) <= v1, 20);
        };
        calculate_profit_and_rate_internal<T0, T1>(arg1, v0, arg8, arg10);
        let v2 = 0x2::tx_context::sender(arg10);
        arg1.hwm = arg1.hwm + (arg2 as u128);
        let v3 = 0xffb7c9726224597e54606958ada3fad60bf7dc5cecc238ff97af99304ee75228::fast_price_feed::safe_mul_div_u64(arg2, 1000000, arg1.rate);
        arg1.total_deposit = arg1.total_deposit + (arg2 as u128);
        if (0x1::option::is_some<0x2::coin::Coin<T0>>(&arg1.coin_store.coin)) {
            arg1.available_liquidity = (0x2::coin::value<T0>(0x1::option::borrow_mut<0x2::coin::Coin<T0>>(&mut arg1.coin_store.coin)) as u128);
        };
        arg1.liquidity = arg1.liquidity + (arg2 as u128);
        0x2::coin::mint_and_transfer<T1>(&mut arg1.treasury_cap, v3, v2, arg10);
        let v4 = DualTokenDepositEventV2{
            sender         : v2,
            amount         : arg2,
            net_amount     : arg2,
            lp             : v3,
            vault_id       : 0x2::object::id<Vault<T0, T1>>(arg1),
            fee            : 0,
            liquidity      : arg1.liquidity,
            total_supply   : 0x2::coin::total_supply<T1>(&arg1.treasury_cap),
            rate           : arg1.rate,
            time           : 0x2::clock::timestamp_ms(arg8),
            token_a        : arg4,
            token_b        : arg5,
            token_a_amount : arg6,
            token_b_amount : arg7,
        };
        0x2::event::emit<DualTokenDepositEventV2>(v4);
    }

    public fun deposit_v2<T0, T1>(arg0: &mut VaultConfig, arg1: &mut Vault<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: u128, arg4: &0x2::clock::Clock, arg5: &AccessCap, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 9, 5);
        assert!(!check_global_pause(arg0), 35);
        assert!(arg1.enable, 4);
        assert!(!check_deposit_pause<T0, T1>(arg0, arg1), 42);
        assert!(check_access_cap(arg0, 0x2::object::id<AccessCap>(arg5)), 1);
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 >= arg1.deposit.min, 9);
        let v1 = arg1.liquidity;
        arg1.liquidity = arg3;
        let v2 = get_dynamic_field_or_default<T0, T1, u128>(arg1, b"max_vault_cap", 0);
        if (v2 > 0) {
            assert!(arg1.liquidity + (v0 as u128) <= v2, 20);
        };
        calculate_profit_and_rate_internal<T0, T1>(arg1, v1, arg4, arg6);
        let v3 = calculate_fee(v0, arg1.deposit.fee_bps);
        let v4 = v0 - v3;
        let v5 = 0x2::coin::split<T0>(&mut arg2, v3, arg6);
        if (0x1::option::is_some<0x2::coin::Coin<T0>>(&arg1.coin_store.coin)) {
            0x2::coin::join<T0>(0x1::option::borrow_mut<0x2::coin::Coin<T0>>(&mut arg1.coin_store.coin), arg2);
        } else {
            0x1::option::fill<0x2::coin::Coin<T0>>(&mut arg1.coin_store.coin, arg2);
        };
        arg1.hwm = arg1.hwm + (v4 as u128);
        let v6 = 0xffb7c9726224597e54606958ada3fad60bf7dc5cecc238ff97af99304ee75228::fast_price_feed::safe_mul_div_u64(v4, 1000000, arg1.rate);
        arg1.total_deposit = arg1.total_deposit + (v4 as u128);
        let v7 = 0x1::option::borrow_mut<0x2::coin::Coin<T0>>(&mut arg1.coin_store.coin);
        arg1.available_liquidity = (0x2::coin::value<T0>(v7) as u128);
        add_table_vault_asset<T0, T1>(arg1, 0x1::type_name::into_string(0x1::type_name::get<T0>()), (0x2::coin::value<T0>(v7) as u128), arg6);
        arg1.liquidity = arg1.liquidity + (v4 as u128);
        arg1.deposit.total_fee = arg1.deposit.total_fee + v3;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v5, arg1.fee_receiver);
        0x2::coin::mint_and_transfer<T1>(&mut arg1.treasury_cap, v6, 0x2::tx_context::sender(arg6), arg6);
        let v8 = DepositEventV2{
            sender       : 0x2::tx_context::sender(arg6),
            amount       : v0,
            net_amount   : v4,
            lp           : v6,
            vault_id     : 0x2::object::id<Vault<T0, T1>>(arg1),
            fee          : v3,
            liquidity    : arg1.liquidity,
            total_supply : 0x2::coin::total_supply<T1>(&arg1.treasury_cap),
            rate         : arg1.rate,
            time         : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<DepositEventV2>(v8);
    }

    public(friend) fun deposit_with_no_fee<T0, T1>(arg0: &VaultConfig, arg1: &mut Vault<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: bool, arg6: u64, arg7: u64, arg8: vector<vector<u8>>, arg9: vector<vector<u8>>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 9, 5);
        assert!(!check_global_pause(arg0), 35);
        assert!(arg1.enable, 4);
        abort 0
    }

    public fun deposit_with_no_fee_v2<T0, T1>(arg0: &VaultConfig, arg1: &mut Vault<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: u128, arg4: &0x2::clock::Clock, arg5: &AccessCap, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 9, 5);
        assert!(!check_global_pause(arg0), 35);
        assert!(arg1.enable, 4);
        assert!(!check_deposit_pause<T0, T1>(arg0, arg1), 42);
        assert!(check_access_cap(arg0, 0x2::object::id<AccessCap>(arg5)), 1);
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 >= arg1.deposit.min, 9);
        let v1 = arg1.liquidity;
        arg1.liquidity = arg3;
        let v2 = get_dynamic_field_or_default<T0, T1, u128>(arg1, b"max_vault_cap", 0);
        if (v2 > 0) {
            assert!(arg1.liquidity + (v0 as u128) <= v2, 20);
        };
        calculate_profit_and_rate_internal<T0, T1>(arg1, v1, arg4, arg6);
        if (0x1::option::is_some<0x2::coin::Coin<T0>>(&arg1.coin_store.coin)) {
            0x2::coin::join<T0>(0x1::option::borrow_mut<0x2::coin::Coin<T0>>(&mut arg1.coin_store.coin), arg2);
        } else {
            0x1::option::fill<0x2::coin::Coin<T0>>(&mut arg1.coin_store.coin, arg2);
        };
        arg1.hwm = arg1.hwm + (v0 as u128);
        let v3 = 0xffb7c9726224597e54606958ada3fad60bf7dc5cecc238ff97af99304ee75228::fast_price_feed::safe_mul_div_u64(v0, 1000000, arg1.rate);
        arg1.total_deposit = arg1.total_deposit + (v0 as u128);
        let v4 = 0x1::option::borrow_mut<0x2::coin::Coin<T0>>(&mut arg1.coin_store.coin);
        arg1.available_liquidity = (0x2::coin::value<T0>(v4) as u128);
        add_table_vault_asset<T0, T1>(arg1, 0x1::type_name::into_string(0x1::type_name::get<T0>()), (0x2::coin::value<T0>(v4) as u128), arg6);
        arg1.liquidity = arg1.liquidity + (v0 as u128);
        0x2::coin::mint_and_transfer<T1>(&mut arg1.treasury_cap, v3, 0x2::tx_context::sender(arg6), arg6);
        let v5 = DepositEventV2{
            sender       : 0x2::tx_context::sender(arg6),
            amount       : v0,
            net_amount   : v0,
            lp           : v3,
            vault_id     : 0x2::object::id<Vault<T0, T1>>(arg1),
            fee          : 0,
            liquidity    : arg1.liquidity,
            total_supply : 0x2::coin::total_supply<T1>(&arg1.treasury_cap),
            rate         : arg1.rate,
            time         : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<DepositEventV2>(v5);
    }

    public entry fun deposit_with_sigs_credit_time<T0, T1>(arg0: &mut VaultConfig, arg1: &mut Vault<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: bool, arg6: u64, arg7: u64, arg8: vector<vector<u8>>, arg9: vector<vector<u8>>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 9, 5);
        assert!(!check_global_pause(arg0), 35);
        abort 0
    }

    public fun deposit_zap_mode_token<T0, T1>(arg0: &mut VaultConfig, arg1: &mut Vault<T0, T1>, arg2: u64, arg3: u64, arg4: u64, arg5: bool, arg6: u64, arg7: u64, arg8: vector<vector<u8>>, arg9: vector<vector<u8>>, arg10: address, arg11: 0x1::ascii::String, arg12: 0x1::ascii::String, arg13: u64, arg14: u64, arg15: 0x1::ascii::String, arg16: u64, arg17: &0x2::clock::Clock, arg18: &AccessCap, arg19: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 9, 5);
        assert!(!check_global_pause(arg0), 35);
        assert!(arg1.enable, 4);
        abort 0
    }

    public fun deposit_zap_mode_token_v2<T0, T1>(arg0: &mut VaultConfig, arg1: &mut Vault<T0, T1>, arg2: u128, arg3: u64, arg4: 0x1::ascii::String, arg5: 0x1::ascii::String, arg6: u64, arg7: u64, arg8: 0x1::ascii::String, arg9: u64, arg10: &0x2::clock::Clock, arg11: &AccessCap, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 9, 5);
        assert!(!check_global_pause(arg0), 35);
        assert!(arg1.enable, 4);
        abort 0
    }

    entry fun disable_deposit<T0, T1>(arg0: &AdminCap, arg1: &VaultConfig, arg2: &mut Vault<T0, T1>) {
        assert!(arg1.version == 9, 5);
        set_dynamic_field<T0, T1, bool>(arg2, b"deposit_pause", true);
    }

    entry fun disable_global_pause(arg0: &AdminCap, arg1: &mut VaultConfig, arg2: &0x2::tx_context::TxContext) {
        assert!(arg1.version == 9, 5);
        assert!(get_config_dynamic_field_or_default<bool>(arg1, b"global_pause", false), 33);
        set_config_dynamic_field<bool>(arg1, b"global_pause", false);
        let v0 = GlobalPause{
            address      : 0x2::tx_context::sender(arg2),
            global_pause : false,
        };
        0x2::event::emit<GlobalPause>(v0);
    }

    entry fun disable_trade<T0, T1>(arg0: &AdminCap, arg1: &VaultConfig, arg2: &mut Vault<T0, T1>) {
        assert!(arg1.version == 9, 5);
        set_dynamic_field<T0, T1, bool>(arg2, b"trade_pause", true);
    }

    entry fun disable_withdraw<T0, T1>(arg0: &AdminCap, arg1: &VaultConfig, arg2: &mut Vault<T0, T1>) {
        assert!(arg1.version == 9, 5);
        set_dynamic_field<T0, T1, bool>(arg2, b"withdraw_pause", true);
    }

    entry fun enable_deposit<T0, T1>(arg0: &AdminCap, arg1: &VaultConfig, arg2: &mut Vault<T0, T1>) {
        assert!(arg1.version == 9, 5);
        set_dynamic_field<T0, T1, bool>(arg2, b"deposit_pause", false);
    }

    entry fun enable_global_pause(arg0: &mut VaultConfig, arg1: &PauserCap, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.version == 9, 5);
        assert!(!check_global_pause(arg0), 35);
        assert!(check_pauser_cap(arg0, 0x2::object::id<PauserCap>(arg1)), 1);
        assert!(!get_config_dynamic_field_or_default<bool>(arg0, b"global_pause", false), 32);
        set_config_dynamic_field<bool>(arg0, b"global_pause", true);
        let v0 = GlobalPause{
            address      : 0x2::tx_context::sender(arg2),
            global_pause : true,
        };
        0x2::event::emit<GlobalPause>(v0);
    }

    entry fun enable_trade<T0, T1>(arg0: &AdminCap, arg1: &VaultConfig, arg2: &mut Vault<T0, T1>) {
        assert!(arg1.version == 9, 5);
        set_dynamic_field<T0, T1, bool>(arg2, b"trade_pause", false);
    }

    entry fun enable_withdraw<T0, T1>(arg0: &AdminCap, arg1: &VaultConfig, arg2: &mut Vault<T0, T1>) {
        assert!(arg1.version == 9, 5);
        set_dynamic_field<T0, T1, bool>(arg2, b"withdraw_pause", false);
    }

    fun get_config_dynamic_field_or_default<T0: copy + drop + store>(arg0: &VaultConfig, arg1: vector<u8>, arg2: T0) : T0 {
        if (0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, arg1)) {
            *0x2::dynamic_field::borrow<vector<u8>, T0>(&arg0.id, arg1)
        } else {
            arg2
        }
    }

    public fun get_deposit_fee_bps<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        arg0.deposit.fee_bps
    }

    public fun get_dynamic_field<T0, T1, T2: copy + drop + store>(arg0: &Vault<T0, T1>, arg1: vector<u8>) : T2 {
        assert!(0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, arg1), 0);
        *0x2::dynamic_field::borrow<vector<u8>, T2>(&arg0.id, arg1)
    }

    fun get_dynamic_field_or_default<T0, T1, T2: copy + drop + store>(arg0: &Vault<T0, T1>, arg1: vector<u8>, arg2: T2) : T2 {
        if (0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, arg1)) {
            *0x2::dynamic_field::borrow<vector<u8>, T2>(&arg0.id, arg1)
        } else {
            arg2
        }
    }

    public fun get_est_deposit_amount_credit_time<T0, T1>(arg0: &Vault<T0, T1>, arg1: u64, arg2: u64, arg3: u64, arg4: bool, arg5: u64) : (u64, u64) {
        abort 0
    }

    public fun get_est_withdraw_amount_credit_time<T0, T1>(arg0: &Vault<T0, T1>, arg1: u64, arg2: u64, arg3: u64, arg4: bool, arg5: u64) : (u64, u64) {
        abort 0
    }

    public fun get_harvest_asset_balance<T0, T1, T2>(arg0: &mut Vault<T0, T1>) : u64 {
        let v0 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T2>());
        if (0x2::bag::contains<0x1::ascii::String>(&arg0.harvest_assets, v0)) {
            0x2::coin::value<T2>(0x2::bag::borrow<0x1::ascii::String, 0x2::coin::Coin<T2>>(&arg0.harvest_assets, v0))
        } else {
            0
        }
    }

    public fun get_last_credit_profit<T0, T1>(arg0: &Vault<T0, T1>) : (u64, u64, bool, u64) {
        let v0 = arg0.latest_credit_time;
        (get_dynamic_field_or_default<T0, T1, u64>(arg0, b"last_credit_profit_time", v0), get_dynamic_field_or_default<T0, T1, u64>(arg0, b"last_credit_profit_amount", 0), get_dynamic_field_or_default<T0, T1, bool>(arg0, b"last_is_loss", false), v0)
    }

    public fun get_lock_duration<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        arg0.lock_duration_ms
    }

    public fun get_lp_ids_by_amm<T0, T1>(arg0: &Vault<T0, T1>, arg1: 0x2::object::ID) : vector<0x2::object::ID> {
        if (0x2::vec_map::contains<0x2::object::ID, vector<0x2::object::ID>>(&arg0.lp_storage, &arg1)) {
            *0x2::vec_map::get<0x2::object::ID, vector<0x2::object::ID>>(&arg0.lp_storage, &arg1)
        } else {
            0x1::vector::empty<0x2::object::ID>()
        }
    }

    public fun get_pending_redeem<T0, T1>(arg0: &Vault<T0, T1>, arg1: address, arg2: &0x2::clock::Clock) : (u64, u64) {
        abort 0
    }

    public fun get_pending_redemptions<T0, T1>(arg0: &Vault<T0, T1>) : u128 {
        arg0.pending_redemptions
    }

    public fun get_threshold(arg0: &VaultConfig) : u64 {
        assert!(arg0.version == 9, 5);
        arg0.threshold
    }

    public fun get_vault_asset_balances<T0, T1>(arg0: &Vault<T0, T1>) : (vector<0x1::ascii::String>, vector<u128>) {
        let v0 = arg0.harvest_asset_keys;
        0x1::vector::push_back<0x1::ascii::String>(&mut v0, 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()));
        let v1 = 0x1::vector::empty<u128>();
        let v2 = 0;
        if (!0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"table_vault_assets")) {
            abort 0
        };
        let v3 = &0x2::dynamic_field::borrow<vector<u8>, TableVaultAssets>(&arg0.id, b"table_vault_assets").tb;
        while (v2 < 0x1::vector::length<0x1::ascii::String>(&v0)) {
            let v4 = 0x1::vector::borrow<0x1::ascii::String>(&v0, v2);
            if (0x2::table::contains<0x1::ascii::String, u128>(v3, *v4)) {
                0x1::vector::push_back<u128>(&mut v1, *0x2::table::borrow<0x1::ascii::String, u128>(v3, *v4));
            } else {
                0x1::vector::push_back<u128>(&mut v1, 0);
            };
            v2 = v2 + 1;
        };
        (v0, v1)
    }

    public fun get_withdraw_asset_balance<T0, T1, T2>(arg0: &mut Vault<T0, T1>) : u64 {
        let v0 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T2>());
        if (0x2::bag::contains<0x1::ascii::String>(&arg0.withdraw_assets, v0)) {
            0x2::coin::value<T2>(0x2::bag::borrow<0x1::ascii::String, 0x2::coin::Coin<T2>>(&arg0.withdraw_assets, v0))
        } else {
            0
        }
    }

    public fun get_withdraw_asset_balances<T0, T1>(arg0: &Vault<T0, T1>) : (vector<0x1::ascii::String>, vector<u128>) {
        let v0 = arg0.withdraw_asset_keys;
        let v1 = 0x1::vector::empty<u128>();
        let v2 = 0;
        if (!0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"table_withdraw_assets")) {
            abort 0
        };
        let v3 = &0x2::dynamic_field::borrow<vector<u8>, TableWithdrawAssets>(&arg0.id, b"table_withdraw_assets").tb;
        while (v2 < 0x1::vector::length<0x1::ascii::String>(&v0)) {
            let v4 = 0x1::vector::borrow<0x1::ascii::String>(&v0, v2);
            if (0x2::table::contains<0x1::ascii::String, u128>(v3, *v4)) {
                0x1::vector::push_back<u128>(&mut v1, *0x2::table::borrow<0x1::ascii::String, u128>(v3, *v4));
            } else {
                0x1::vector::push_back<u128>(&mut v1, 0);
            };
            v2 = v2 + 1;
        };
        (v0, v1)
    }

    fun has_dynamic_field<T0, T1>(arg0: &Vault<T0, T1>, arg1: vector<u8>) : bool {
        0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, arg1)
    }

    public fun increase_balance_dynamic_field<T0, T1>(arg0: &VaultConfig, arg1: &AccessCap, arg2: &mut Vault<T0, T1>, arg3: vector<u8>, arg4: u64) {
        assert!(check_access_cap(arg0, 0x2::object::id<AccessCap>(arg1)), 1);
        if (0x2::dynamic_field::exists_<vector<u8>>(&arg2.id, arg3)) {
            let v0 = 0x2::dynamic_field::borrow_mut<vector<u8>, u64>(&mut arg2.id, arg3);
            *v0 = *v0 + arg4;
        } else {
            0x2::dynamic_field::add<vector<u8>, u64>(&mut arg2.id, arg3, arg4);
        };
    }

    fun increase_table_withdraw_asset<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x1::ascii::String, arg2: u128, arg3: &mut 0x2::tx_context::TxContext) {
        if (!0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"table_withdraw_assets")) {
            let v0 = TableWithdrawAssets{tb: 0x2::table::new<0x1::ascii::String, u128>(arg3)};
            0x2::dynamic_field::add<vector<u8>, TableWithdrawAssets>(&mut arg0.id, b"table_withdraw_assets", v0);
        };
        let v1 = &mut 0x2::dynamic_field::borrow_mut<vector<u8>, TableWithdrawAssets>(&mut arg0.id, b"table_withdraw_assets").tb;
        if (0x2::table::contains<0x1::ascii::String, u128>(v1, arg1)) {
            let v2 = 0x2::table::borrow_mut<0x1::ascii::String, u128>(v1, arg1);
            *v2 = *v2 + arg2;
        } else {
            0x2::table::add<0x1::ascii::String, u128>(v1, arg1, arg2);
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = VaultConfig{
            id             : 0x2::object::new(arg0),
            version        : 9,
            allowed_access : 0x1::vector::empty<0x2::object::ID>(),
            operators      : 0x2::table::new<address, 0x2::object::ID>(arg0),
            signers        : 0x2::table::new<vector<u8>, bool>(arg0),
            threshold      : 1,
        };
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<VaultConfig>(v1);
    }

    public entry fun init_vault<T0, T1>(arg0: &AdminCap, arg1: 0x2::coin::TreasuryCap<T1>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = CoinStore<T0>{coin: 0x1::option::none<0x2::coin::Coin<T0>>()};
        let v1 = Deposit{
            fee_bps   : 0,
            min       : 0,
            total_fee : 0,
        };
        let v2 = Withdraw{
            fee_bps   : 0,
            min       : 0,
            total_fee : 0,
        };
        let v3 = PerformanceFee{
            fee_bps   : 500,
            total_fee : 0,
        };
        let v4 = ManagementFee{
            fee_bps            : 0,
            total_fee          : 0,
            period_duration    : 86400000,
            latest_deduce_time : 0,
        };
        let v5 = Vault<T0, T1>{
            id                  : 0x2::object::new(arg2),
            treasury_cap        : arg1,
            coin_store          : v0,
            enable              : true,
            harvest_asset_keys  : 0x1::vector::empty<0x1::ascii::String>(),
            harvest_assets      : 0x2::bag::new(arg2),
            total_deposit       : 0,
            liquidity           : 0,
            available_liquidity : 0,
            profit              : 0,
            last_update         : 0,
            lp_storage          : 0x2::vec_map::empty<0x2::object::ID, vector<0x2::object::ID>>(),
            rate                : 1 * 1000000,
            pending_redemptions : 0,
            pending_redeems     : 0x2::table::new<address, vector<PendingRedeem>>(arg2),
            lock_duration_ms    : 300000,
            fee_receiver        : 0x2::tx_context::sender(arg2),
            deposit             : v1,
            withdraw            : v2,
            performance_fee     : v3,
            management_fee      : v4,
            total_fee           : 0,
            pending_fee         : 0,
            hwm                 : 0,
            latest_credit_time  : 0,
            total_withdraw      : 0,
            withdraw_asset_keys : 0x1::vector::empty<0x1::ascii::String>(),
            withdraw_assets     : 0x2::bag::new(arg2),
            reserves            : 0x2::bag::new(arg2),
        };
        let v6 = CreatedVaultEvent{id: 0x2::object::id<Vault<T0, T1>>(&v5)};
        0x2::event::emit<CreatedVaultEvent>(v6);
        0x2::transfer::share_object<Vault<T0, T1>>(v5);
    }

    public fun is_enable<T0, T1>(arg0: &Vault<T0, T1>) : bool {
        arg0.enable
    }

    entry fun migrate(arg0: &AdminCap, arg1: &mut VaultConfig, arg2: &0x2::tx_context::TxContext) {
        assert!(arg1.version < 9, 0);
        arg1.version = 9;
    }

    entry fun move_token<T0, T1, T2>(arg0: &AdminCap, arg1: &VaultConfig, arg2: &mut Vault<T0, T1>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 9, 5);
        let v0 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T2>());
        assert!(0x2::bag::contains<0x1::ascii::String>(&arg2.withdraw_assets, v0), 14);
        let v1 = 0x2::bag::borrow_mut<0x1::ascii::String, 0x2::coin::Coin<T0>>(&mut arg2.withdraw_assets, v0);
        let v2 = 0x2::coin::value<T0>(v1);
        assert!(v2 > 0, 2);
        let v3 = 0x2::coin::split<T0>(v1, v2, arg3);
        if (0x2::coin::value<T0>(v1) == 0) {
            0x2::coin::destroy_zero<T2>(0x2::bag::remove<0x1::ascii::String, 0x2::coin::Coin<T2>>(&mut arg2.withdraw_assets, v0));
            let (v4, v5) = 0x1::vector::index_of<0x1::ascii::String>(&arg2.withdraw_asset_keys, &v0);
            if (v4) {
                0x1::vector::swap_remove<0x1::ascii::String>(&mut arg2.withdraw_asset_keys, v5);
            };
            add_table_withdraw_asset<T0, T1>(arg2, v0, 0, arg3);
        } else {
            add_table_withdraw_asset<T0, T1>(arg2, v0, (0x2::coin::value<T0>(v1) as u128), arg3);
        };
        if (0x1::type_name::into_string(0x1::type_name::with_defining_ids<T2>()) == 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>())) {
            if (0x1::option::is_some<0x2::coin::Coin<T0>>(&arg2.coin_store.coin)) {
                0x2::coin::join<T0>(0x1::option::borrow_mut<0x2::coin::Coin<T0>>(&mut arg2.coin_store.coin), v3);
            } else {
                0x1::option::fill<0x2::coin::Coin<T0>>(&mut arg2.coin_store.coin, v3);
            };
            arg2.available_liquidity = (0x2::coin::value<T0>(0x1::option::borrow_mut<0x2::coin::Coin<T0>>(&mut arg2.coin_store.coin)) as u128);
            let v6 = arg2.available_liquidity;
            add_table_vault_asset<T0, T1>(arg2, 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()), v6, arg3);
        } else if (0x2::bag::contains<0x1::ascii::String>(&arg2.harvest_assets, v0)) {
            0x2::coin::join<T0>(0x2::bag::borrow_mut<0x1::ascii::String, 0x2::coin::Coin<T0>>(&mut arg2.harvest_assets, v0), v3);
        } else {
            0x2::bag::add<0x1::ascii::String, 0x2::coin::Coin<T0>>(&mut arg2.harvest_assets, v0, v3);
            0x1::vector::push_back<0x1::ascii::String>(&mut arg2.harvest_asset_keys, v0);
        };
        let v7 = AddFundEvent{
            amount   : v2,
            vault_id : 0x2::object::id<Vault<T0, T1>>(arg2),
        };
        0x2::event::emit<AddFundEvent>(v7);
    }

    public entry fun move_token_to_withdraw_assets<T0, T1, T2>(arg0: &OperatorCap, arg1: &mut VaultConfig, arg2: &mut Vault<T0, T1>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 9, 5);
        assert!(!check_global_pause(arg1), 35);
        abort 0
    }

    public fun move_token_to_withdraw_assets_sigs<T0, T1, T2>(arg0: &OperatorCap, arg1: &mut VaultConfig, arg2: &mut Vault<T0, T1>, arg3: u64, arg4: u64, arg5: vector<vector<u8>>, arg6: vector<vector<u8>>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 9, 5);
        assert!(!check_global_pause(arg1), 35);
        assert!(!check_withdraw_pause<T0, T1>(arg1, arg2), 43);
        assert!(check_operator(arg1, 0x2::tx_context::sender(arg8), 0x2::object::id<OperatorCap>(arg0)), 1);
        assert!(arg4 >= 0x2::clock::timestamp_ms(arg7), 17);
        let v0 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T2>());
        let v1 = 0x1::vector::empty<u8>();
        let v2 = 0x2::object::id<Vault<T0, T1>>(arg2);
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<0x2::object::ID>(&v2));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<0x1::ascii::String>(&v0));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u64>(&arg3));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u64>(&arg4));
        0x45355b07146d699e6a8c405bcc2f60ef5d062a15183c6012ac55d5734d8add21::utils::verify_signature(&arg1.signers, arg1.threshold, v1, arg5, arg6);
        if (v0 == 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>())) {
            assert!(0x1::option::is_some<0x2::coin::Coin<T0>>(&arg2.coin_store.coin), 2);
            let v3 = 0x1::option::borrow_mut<0x2::coin::Coin<T0>>(&mut arg2.coin_store.coin);
            assert!(0x2::coin::value<T0>(v3) >= arg3, 2);
            arg2.available_liquidity = arg2.available_liquidity - (arg3 as u128);
            let v4 = 0x2::coin::split<T0>(v3, arg3, arg8);
            if (0x2::bag::contains<0x1::ascii::String>(&arg2.withdraw_assets, v0)) {
                increase_table_withdraw_asset<T0, T1>(arg2, v0, (0x2::coin::value<T0>(&v4) as u128), arg8);
                0x2::coin::join<T0>(0x2::bag::borrow_mut<0x1::ascii::String, 0x2::coin::Coin<T0>>(&mut arg2.withdraw_assets, v0), v4);
            } else {
                add_table_withdraw_asset<T0, T1>(arg2, v0, (0x2::coin::value<T0>(&v4) as u128), arg8);
                0x2::bag::add<0x1::ascii::String, 0x2::coin::Coin<T0>>(&mut arg2.withdraw_assets, v0, v4);
                0x1::vector::push_back<0x1::ascii::String>(&mut arg2.withdraw_asset_keys, v0);
            };
            let v5 = arg2.available_liquidity;
            add_table_vault_asset<T0, T1>(arg2, v0, v5, arg8);
        } else {
            assert!(0x2::bag::contains<0x1::ascii::String>(&arg2.harvest_assets, v0), 14);
            let v6 = 0x2::bag::borrow_mut<0x1::ascii::String, 0x2::coin::Coin<T2>>(&mut arg2.harvest_assets, v0);
            assert!(0x2::coin::value<T2>(v6) >= arg3, 2);
            let v7 = 0x2::coin::split<T2>(v6, arg3, arg8);
            if (0x2::coin::value<T2>(v6) == 0) {
                add_table_vault_asset<T0, T1>(arg2, v0, 0, arg8);
                0x2::coin::destroy_zero<T2>(0x2::bag::remove<0x1::ascii::String, 0x2::coin::Coin<T2>>(&mut arg2.harvest_assets, v0));
                let (v8, v9) = 0x1::vector::index_of<0x1::ascii::String>(&arg2.harvest_asset_keys, &v0);
                if (v8) {
                    0x1::vector::swap_remove<0x1::ascii::String>(&mut arg2.harvest_asset_keys, v9);
                };
            } else {
                add_table_vault_asset<T0, T1>(arg2, v0, (0x2::coin::value<T2>(v6) as u128), arg8);
            };
            if (0x2::bag::contains<0x1::ascii::String>(&arg2.withdraw_assets, v0)) {
                increase_table_withdraw_asset<T0, T1>(arg2, v0, (0x2::coin::value<T2>(&v7) as u128), arg8);
                0x2::coin::join<T2>(0x2::bag::borrow_mut<0x1::ascii::String, 0x2::coin::Coin<T2>>(&mut arg2.withdraw_assets, v0), v7);
            } else {
                add_table_withdraw_asset<T0, T1>(arg2, v0, (0x2::coin::value<T2>(&v7) as u128), arg8);
                0x2::bag::add<0x1::ascii::String, 0x2::coin::Coin<T2>>(&mut arg2.withdraw_assets, v0, v7);
                0x1::vector::push_back<0x1::ascii::String>(&mut arg2.withdraw_asset_keys, v0);
            };
        };
        let v10 = MoveTokenToWithdrawAssetEvent{
            amount   : arg3,
            vault_id : 0x2::object::id<Vault<T0, T1>>(arg2),
            token    : v0,
        };
        0x2::event::emit<MoveTokenToWithdrawAssetEvent>(v10);
    }

    public entry fun pause<T0, T1>(arg0: &AdminCap, arg1: &VaultConfig, arg2: &mut Vault<T0, T1>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 9, 5);
        assert!(!check_global_pause(arg1), 35);
        arg2.enable = false;
        let v0 = Pause<T0>{dummy_field: false};
        0x2::event::emit<Pause<T0>>(v0);
    }

    public entry fun redeem<T0, T1>(arg0: &mut VaultConfig, arg1: &mut Vault<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 9, 5);
        assert!(!check_global_pause(arg0), 35);
        assert!(arg1.enable, 4);
        abort 0
    }

    public fun redeem_dual_v2<T0, T1, T2, T3>(arg0: &mut VaultConfig, arg1: &mut Vault<T0, T1>, arg2: address, arg3: vector<vector<0x1::ascii::String>>, arg4: vector<u64>, arg5: vector<vector<u64>>, arg6: vector<u64>, arg7: u64, arg8: vector<vector<u8>>, arg9: vector<vector<u8>>, arg10: &0x2::clock::Clock, arg11: &AccessCap, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 9, 5);
        assert!(!check_global_pause(arg0), 35);
        assert!(arg1.enable, 4);
        assert!(!check_withdraw_pause<T0, T1>(arg0, arg1), 43);
        assert!(check_access_cap(arg0, 0x2::object::id<AccessCap>(arg11)), 1);
        let (v0, v1) = redeem_dual_v2_internal<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg12);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v0, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(v1, arg2);
    }

    fun redeem_dual_v2_internal<T0, T1, T2, T3>(arg0: &VaultConfig, arg1: &mut Vault<T0, T1>, arg2: address, arg3: vector<vector<0x1::ascii::String>>, arg4: vector<u64>, arg5: vector<vector<u64>>, arg6: vector<u64>, arg7: u64, arg8: vector<vector<u8>>, arg9: vector<vector<u8>>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T2>, 0x2::coin::Coin<T3>) {
        assert!(arg0.version == 9, 5);
        assert!(!check_global_pause(arg0), 35);
        assert!(arg1.enable, 4);
        let v0 = 0x2::clock::timestamp_ms(arg10);
        assert!(arg7 >= v0, 17);
        let v1 = 0x1::vector::empty<u8>();
        let v2 = 0x2::object::id<Vault<T0, T1>>(arg1);
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<0x2::object::ID>(&v2));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<address>(&arg2));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<vector<vector<0x1::ascii::String>>>(&arg3));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<vector<u64>>(&arg4));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<vector<vector<u64>>>(&arg5));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<vector<u64>>(&arg6));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u64>(&arg7));
        0x45355b07146d699e6a8c405bcc2f60ef5d062a15183c6012ac55d5734d8add21::utils::verify_signature(&arg0.signers, arg0.threshold, v1, arg8, arg9);
        let v3 = 0x1::vector::length<u64>(&arg4);
        assert!(v3 == 0x1::vector::length<vector<0x1::ascii::String>>(&arg3), 29);
        assert!(v3 == 0x1::vector::length<vector<u64>>(&arg5), 28);
        assert!(v3 == 0x1::vector::length<u64>(&arg6), 30);
        let v4 = 0x1::vector::empty<PendingRedeemV2>();
        let v5 = 0x1::vector::empty<PendingRedeemV2>();
        if (!0x2::dynamic_field::exists_<vector<u8>>(&arg1.id, b"pending_redeems_v2")) {
            0x2::dynamic_field::add<vector<u8>, 0x2::table::Table<address, vector<PendingRedeemV2>>>(&mut arg1.id, b"pending_redeems_v2", 0x2::table::new<address, vector<PendingRedeemV2>>(arg11));
        };
        let v6 = 0x2::dynamic_field::borrow_mut<vector<u8>, 0x2::table::Table<address, vector<PendingRedeemV2>>>(&mut arg1.id, b"pending_redeems_v2");
        assert!(0x2::table::contains<address, vector<PendingRedeemV2>>(v6, arg2) || 0x2::table::contains<address, vector<PendingRedeem>>(&arg1.pending_redeems, arg2), 7);
        if (0x2::table::contains<address, vector<PendingRedeemV2>>(v6, arg2)) {
            let v7 = 0x2::table::remove<address, vector<PendingRedeemV2>>(v6, arg2);
            let v8 = 0;
            while (v8 < 0x1::vector::length<PendingRedeemV2>(&v7)) {
                let v9 = 0x1::vector::borrow<PendingRedeemV2>(&v7, v8);
                let (v10, _) = 0x1::vector::index_of<u64>(&arg4, &v9.withdraw_time);
                if (v10 && 0x1::option::is_some<0x1::ascii::String>(&v9.token_b)) {
                    0x1::vector::push_back<PendingRedeemV2>(&mut v4, *v9);
                } else {
                    0x1::vector::push_back<PendingRedeemV2>(&mut v5, *v9);
                };
                v8 = v8 + 1;
            };
            if (0x1::vector::length<PendingRedeemV2>(&v5) > 0) {
                0x2::table::add<address, vector<PendingRedeemV2>>(v6, arg2, v5);
            };
        };
        let v12 = 0x1::vector::empty<PendingRedeem>();
        let v13 = 0x1::vector::empty<PendingRedeem>();
        if (0x2::table::contains<address, vector<PendingRedeem>>(&arg1.pending_redeems, arg2)) {
            let v14 = 0x2::table::remove<address, vector<PendingRedeem>>(&mut arg1.pending_redeems, arg2);
            let v15 = 0;
            while (v15 < 0x1::vector::length<PendingRedeem>(&v14)) {
                let v16 = 0x1::vector::borrow<PendingRedeem>(&v14, v15);
                let (v17, _) = 0x1::vector::index_of<u64>(&arg4, &v16.withdraw_time);
                if (v17) {
                    0x1::vector::push_back<PendingRedeem>(&mut v12, *v16);
                } else {
                    0x1::vector::push_back<PendingRedeem>(&mut v13, *v16);
                };
                v15 = v15 + 1;
            };
            if (0x1::vector::length<PendingRedeem>(&v13) > 0) {
                0x2::table::add<address, vector<PendingRedeem>>(&mut arg1.pending_redeems, arg2, v13);
            };
        };
        let v19 = 0x1::vector::length<PendingRedeemV2>(&v4);
        let v20 = 0x1::vector::length<PendingRedeem>(&v12);
        assert!(v19 > 0 || v20 > 0, 19);
        let v21 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T2>());
        let v22 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T3>());
        let v23 = 0;
        let v24 = 0;
        let v25 = 0;
        let v26 = 0;
        if (v19 > 0) {
            let v27 = 0;
            while (v27 < v19) {
                let v28 = 0x1::vector::borrow<PendingRedeemV2>(&v4, v27);
                let (_, v30) = 0x1::vector::index_of<u64>(&arg4, &v28.withdraw_time);
                let v31 = 0x1::vector::borrow<vector<0x1::ascii::String>>(&arg3, v30);
                assert!(0x1::vector::length<0x1::ascii::String>(v31) == 2, 31);
                let v32 = 0x1::vector::borrow<vector<u64>>(&arg5, v30);
                let v33 = 0x1::vector::borrow<u64>(&arg6, v30);
                let v34 = 0x1::option::borrow<0x1::ascii::String>(&v28.token_b);
                assert!(0x1::option::borrow<0x1::ascii::String>(&v28.token_a) == &v21, 37);
                assert!(v34 == &v22, 38);
                let (v35, v36) = 0x1::vector::index_of<0x1::ascii::String>(v31, &v21);
                let (v37, v38) = 0x1::vector::index_of<0x1::ascii::String>(v31, &v22);
                if (v35 && v37) {
                    let v39 = 0x1::vector::borrow<u64>(v32, v36);
                    assert!(v28.token_a_amount >= *v39, 39);
                    v23 = v23 + *v39;
                    let v40 = 0x1::vector::borrow<u64>(v32, v38);
                    assert!(v28.token_b_amount >= *v40, 40);
                    v24 = v24 + *v40;
                } else if (v35) {
                    let v41 = 0x1::vector::borrow<u64>(v32, v36);
                    assert!(v28.token_a_amount >= *v41, 39);
                    v23 = v23 + *v41;
                } else if (v37) {
                    let v42 = 0x1::vector::borrow<u64>(v32, v38);
                    assert!(v28.token_b_amount >= *v42, 40);
                    v24 = v24 + *v42;
                };
                v25 = v25 + v28.amount;
                v26 = v26 + *v33;
                v27 = v27 + 1;
            };
        };
        if (v20 > 0) {
            let v43 = 0;
            while (v43 < v20) {
                let v44 = 0x1::vector::borrow<PendingRedeem>(&v12, v43);
                let (_, v46) = 0x1::vector::index_of<u64>(&arg4, &v44.withdraw_time);
                let v47 = 0x1::vector::borrow<vector<u64>>(&arg5, v46);
                let v48 = 0x1::vector::borrow<u64>(&arg6, v46);
                assert!(v44.amount >= *v48, 18);
                let v49 = 0x1::vector::borrow<vector<0x1::ascii::String>>(&arg3, v46);
                assert!(0x1::vector::length<0x1::ascii::String>(v49) == 2, 31);
                let (v50, v51) = 0x1::vector::index_of<0x1::ascii::String>(v49, &v21);
                let (v52, v53) = 0x1::vector::index_of<0x1::ascii::String>(v49, &v22);
                if (v50 && v52) {
                    v23 = v23 + *0x1::vector::borrow<u64>(v47, v51);
                    v24 = v24 + *0x1::vector::borrow<u64>(v47, v53);
                } else if (v50) {
                    v23 = v23 + *0x1::vector::borrow<u64>(v47, v51);
                } else if (v52) {
                    v24 = v24 + *0x1::vector::borrow<u64>(v47, v53);
                };
                v25 = v25 + v44.amount;
                v26 = v26 + *v48;
                v43 = v43 + 1;
            };
        };
        arg1.pending_redemptions = arg1.pending_redemptions - (v25 as u128);
        assert!(v23 > 0, 21);
        assert!(v24 > 0, 22);
        let v54 = spend_withdraw_asset<T0, T1, T2>(arg1, v23, arg11);
        let v55 = spend_withdraw_asset<T0, T1, T3>(arg1, v24, arg11);
        let v56 = calculate_fee(v23, arg1.withdraw.fee_bps);
        let v57 = calculate_fee(v24, arg1.withdraw.fee_bps);
        arg1.withdraw.total_fee = arg1.withdraw.total_fee + calculate_fee(v26, arg1.withdraw.fee_bps);
        let v58 = get_dynamic_field_or_default<T0, T1, address>(arg1, b"withdraw_fee_receiver", arg1.fee_receiver);
        if (v56 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::split<T2>(&mut v54, v56, arg11), v58);
        };
        if (v57 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(0x2::coin::split<T3>(&mut v55, v57, arg11), v58);
        };
        arg1.total_withdraw = arg1.total_withdraw + (v26 as u128);
        let v59 = DualTokensRedeemEvent{
            receiver                            : arg2,
            item_amount                         : v25,
            collateral_amount                   : v26,
            vault_id                            : 0x2::object::id<Vault<T0, T1>>(arg1),
            fee_a                               : v56,
            fee_b                               : v57,
            tokens                              : arg3,
            withdraw_time_requests              : arg4,
            withdraw_amount_requests            : arg5,
            withdraw_amount_collateral_requests : arg6,
            time                                : v0,
            token_a                             : v21,
            token_b                             : v22,
            token_a_amount                      : v23,
            token_b_amount                      : v24,
        };
        0x2::event::emit<DualTokensRedeemEvent>(v59);
        (v54, v55)
    }

    public entry fun redeem_fee<T0, T1>(arg0: &OperatorCap, arg1: &mut VaultConfig, arg2: &mut Vault<T0, T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 9, 5);
        assert!(!check_global_pause(arg1), 35);
        abort 0
    }

    entry fun redeem_fee_v2<T0, T1>(arg0: &OperatorCap, arg1: &mut VaultConfig, arg2: &mut Vault<T0, T1>, arg3: vector<u64>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 9, 5);
        assert!(!check_global_pause(arg1), 35);
        assert!(check_operator(arg1, 0x2::tx_context::sender(arg5), 0x2::object::id<OperatorCap>(arg0)), 1);
        let v0 = 0x2::object::id_address<Vault<T0, T1>>(arg2);
        let v1 = 0x1::vector::empty<PendingRedeemV2>();
        let v2 = 0x1::vector::empty<PendingRedeemV2>();
        if (!0x2::dynamic_field::exists_<vector<u8>>(&arg2.id, b"pending_redeems_v2")) {
            0x2::dynamic_field::add<vector<u8>, 0x2::table::Table<address, vector<PendingRedeemV2>>>(&mut arg2.id, b"pending_redeems_v2", 0x2::table::new<address, vector<PendingRedeemV2>>(arg5));
        };
        let v3 = 0x2::dynamic_field::borrow_mut<vector<u8>, 0x2::table::Table<address, vector<PendingRedeemV2>>>(&mut arg2.id, b"pending_redeems_v2");
        assert!(0x2::table::contains<address, vector<PendingRedeemV2>>(v3, v0) || 0x2::table::contains<address, vector<PendingRedeem>>(&arg2.pending_redeems, v0), 7);
        if (0x2::table::contains<address, vector<PendingRedeemV2>>(v3, v0)) {
            let v4 = 0x2::table::remove<address, vector<PendingRedeemV2>>(v3, v0);
            let v5 = 0;
            while (v5 < 0x1::vector::length<PendingRedeemV2>(&v4)) {
                let v6 = 0x1::vector::borrow<PendingRedeemV2>(&v4, v5);
                let (v7, _) = 0x1::vector::index_of<u64>(&arg3, &v6.withdraw_time);
                if (v7) {
                    0x1::vector::push_back<PendingRedeemV2>(&mut v1, *v6);
                } else {
                    0x1::vector::push_back<PendingRedeemV2>(&mut v2, *v6);
                };
                v5 = v5 + 1;
            };
            if (0x1::vector::length<PendingRedeemV2>(&v2) > 0) {
                0x2::table::add<address, vector<PendingRedeemV2>>(v3, v0, v2);
            };
        };
        let v9 = 0x1::vector::empty<PendingRedeem>();
        let v10 = 0x1::vector::empty<PendingRedeem>();
        if (0x2::table::contains<address, vector<PendingRedeem>>(&arg2.pending_redeems, v0)) {
            let v11 = 0x2::table::remove<address, vector<PendingRedeem>>(&mut arg2.pending_redeems, v0);
            let v12 = 0;
            while (v12 < 0x1::vector::length<PendingRedeem>(&v11)) {
                let v13 = 0x1::vector::borrow<PendingRedeem>(&v11, v12);
                let (v14, _) = 0x1::vector::index_of<u64>(&arg3, &v13.withdraw_time);
                if (v14) {
                    0x1::vector::push_back<PendingRedeem>(&mut v9, *v13);
                } else {
                    0x1::vector::push_back<PendingRedeem>(&mut v10, *v13);
                };
                v12 = v12 + 1;
            };
            if (0x1::vector::length<PendingRedeem>(&v10) > 0) {
                0x2::table::add<address, vector<PendingRedeem>>(&mut arg2.pending_redeems, v0, v10);
            };
        };
        let v16 = 0x1::vector::length<PendingRedeemV2>(&v1);
        let v17 = 0x1::vector::length<PendingRedeem>(&v9);
        assert!(v16 > 0 || v17 > 0, 19);
        let v18 = 0;
        if (v16 > 0) {
            let v19 = 0;
            while (v19 < v16) {
                v18 = v18 + 0x1::vector::borrow<PendingRedeemV2>(&v1, v19).amount;
                v19 = v19 + 1;
            };
        };
        if (v17 > 0) {
            let v20 = 0;
            while (v20 < v17) {
                v18 = v18 + 0x1::vector::borrow<PendingRedeem>(&v9, v20).amount;
                v20 = v20 + 1;
            };
        };
        arg2.pending_redemptions = arg2.pending_redemptions - (v18 as u128);
        let v21 = spend_withdraw_asset<T0, T1, T0>(arg2, v18, arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v21, arg2.fee_receiver);
        let v22 = RedeemFeeEventV2{
            receiver          : arg2.fee_receiver,
            amount            : v18,
            vault_id          : 0x2::object::id<Vault<T0, T1>>(arg2),
            withdraw_requests : arg3,
        };
        0x2::event::emit<RedeemFeeEventV2>(v22);
    }

    public(friend) fun redeem_internal<T0, T1>(arg0: &VaultConfig, arg1: &mut Vault<T0, T1>, arg2: address, arg3: vector<u64>, arg4: vector<u64>, arg5: u64, arg6: vector<vector<u8>>, arg7: vector<vector<u8>>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.version == 9, 5);
        assert!(!check_global_pause(arg0), 35);
        assert!(arg1.enable, 4);
        abort 0
    }

    public entry fun redeem_token_dual<T0, T1, T2, T3>(arg0: &mut VaultConfig, arg1: &mut Vault<T0, T1>, arg2: address, arg3: vector<vector<0x1::ascii::String>>, arg4: vector<u64>, arg5: vector<vector<u64>>, arg6: vector<u64>, arg7: u64, arg8: vector<vector<u8>>, arg9: vector<vector<u8>>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 9, 5);
        assert!(!check_global_pause(arg0), 35);
        assert!(arg1.enable, 4);
        abort 0
    }

    public(friend) fun redeem_token_internal<T0, T1, T2>(arg0: &VaultConfig, arg1: &mut Vault<T0, T1>, arg2: address, arg3: address, arg4: vector<u64>, arg5: vector<u64>, arg6: vector<u64>, arg7: u64, arg8: vector<vector<u8>>, arg9: vector<vector<u8>>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        assert!(arg0.version == 9, 5);
        assert!(!check_global_pause(arg0), 35);
        assert!(arg1.enable, 4);
        abort 0
    }

    public fun redeem_v2<T0, T1, T2>(arg0: &mut VaultConfig, arg1: &mut Vault<T0, T1>, arg2: address, arg3: vector<u64>, arg4: vector<u64>, arg5: vector<u64>, arg6: u64, arg7: vector<vector<u8>>, arg8: vector<vector<u8>>, arg9: &0x2::clock::Clock, arg10: &AccessCap, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 9, 5);
        assert!(!check_global_pause(arg0), 35);
        assert!(arg1.enable, 4);
        assert!(!check_withdraw_pause<T0, T1>(arg0, arg1), 43);
        assert!(check_access_cap(arg0, 0x2::object::id<AccessCap>(arg10)), 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(redeem_v2_internal<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg11), arg2);
    }

    fun redeem_v2_internal<T0, T1, T2>(arg0: &VaultConfig, arg1: &mut Vault<T0, T1>, arg2: address, arg3: vector<u64>, arg4: vector<u64>, arg5: vector<u64>, arg6: u64, arg7: vector<vector<u8>>, arg8: vector<vector<u8>>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        assert!(arg0.version == 9, 5);
        assert!(!check_global_pause(arg0), 35);
        assert!(arg1.enable, 4);
        let v0 = 0x2::clock::timestamp_ms(arg9);
        assert!(arg6 >= v0, 17);
        let v1 = 0x1::vector::empty<u8>();
        let v2 = 0x2::object::id<Vault<T0, T1>>(arg1);
        let v3 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T2>());
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<0x2::object::ID>(&v2));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<address>(&arg2));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<0x1::ascii::String>(&v3));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<vector<u64>>(&arg3));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<vector<u64>>(&arg4));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<vector<u64>>(&arg5));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u64>(&arg6));
        0x45355b07146d699e6a8c405bcc2f60ef5d062a15183c6012ac55d5734d8add21::utils::verify_signature(&arg0.signers, arg0.threshold, v1, arg7, arg8);
        let v4 = 0x1::vector::empty<PendingRedeemV2>();
        let v5 = 0x1::vector::empty<PendingRedeemV2>();
        if (!0x2::dynamic_field::exists_<vector<u8>>(&arg1.id, b"pending_redeems_v2")) {
            0x2::dynamic_field::add<vector<u8>, 0x2::table::Table<address, vector<PendingRedeemV2>>>(&mut arg1.id, b"pending_redeems_v2", 0x2::table::new<address, vector<PendingRedeemV2>>(arg10));
        };
        let v6 = 0x2::dynamic_field::borrow_mut<vector<u8>, 0x2::table::Table<address, vector<PendingRedeemV2>>>(&mut arg1.id, b"pending_redeems_v2");
        assert!(0x2::table::contains<address, vector<PendingRedeemV2>>(v6, arg2) || 0x2::table::contains<address, vector<PendingRedeem>>(&arg1.pending_redeems, arg2), 7);
        if (0x2::table::contains<address, vector<PendingRedeemV2>>(v6, arg2)) {
            let v7 = 0x2::table::remove<address, vector<PendingRedeemV2>>(v6, arg2);
            let v8 = 0;
            while (v8 < 0x1::vector::length<PendingRedeemV2>(&v7)) {
                let v9 = 0x1::vector::borrow<PendingRedeemV2>(&v7, v8);
                let (v10, _) = 0x1::vector::index_of<u64>(&arg3, &v9.withdraw_time);
                if (v10 && !0x1::option::is_some<0x1::ascii::String>(&v9.token_b)) {
                    0x1::vector::push_back<PendingRedeemV2>(&mut v4, *v9);
                } else {
                    0x1::vector::push_back<PendingRedeemV2>(&mut v5, *v9);
                };
                v8 = v8 + 1;
            };
            if (0x1::vector::length<PendingRedeemV2>(&v5) > 0) {
                0x2::table::add<address, vector<PendingRedeemV2>>(v6, arg2, v5);
            };
        };
        let v12 = 0x1::vector::empty<PendingRedeem>();
        let v13 = 0x1::vector::empty<PendingRedeem>();
        if (0x2::table::contains<address, vector<PendingRedeem>>(&arg1.pending_redeems, arg2)) {
            let v14 = 0x2::table::remove<address, vector<PendingRedeem>>(&mut arg1.pending_redeems, arg2);
            let v15 = 0;
            while (v15 < 0x1::vector::length<PendingRedeem>(&v14)) {
                let v16 = 0x1::vector::borrow<PendingRedeem>(&v14, v15);
                let (v17, _) = 0x1::vector::index_of<u64>(&arg3, &v16.withdraw_time);
                if (v17) {
                    0x1::vector::push_back<PendingRedeem>(&mut v12, *v16);
                } else {
                    0x1::vector::push_back<PendingRedeem>(&mut v13, *v16);
                };
                v15 = v15 + 1;
            };
            if (0x1::vector::length<PendingRedeem>(&v13) > 0) {
                0x2::table::add<address, vector<PendingRedeem>>(&mut arg1.pending_redeems, arg2, v13);
            };
        };
        let v19 = 0x1::vector::length<PendingRedeemV2>(&v4);
        let v20 = 0x1::vector::length<PendingRedeem>(&v12);
        assert!(v19 > 0 || v20 > 0, 19);
        let v21 = 0;
        let v22 = 0;
        let v23 = 0;
        if (v19 > 0) {
            let v24 = 0;
            while (v24 < v19) {
                let v25 = 0x1::vector::borrow<PendingRedeemV2>(&v4, v24);
                let (_, v27) = 0x1::vector::index_of<u64>(&arg3, &v25.withdraw_time);
                let v28 = 0x1::vector::borrow<u64>(&arg4, v27);
                let v29 = 0x1::vector::borrow<u64>(&arg5, v27);
                assert!(0x1::option::borrow<0x1::ascii::String>(&v25.token_a) == &v3, 36);
                assert!(v25.token_a_amount >= *v28, 18);
                v21 = v21 + *v28;
                v22 = v22 + v25.amount;
                v23 = v23 + *v29;
                v24 = v24 + 1;
            };
        };
        if (v20 > 0) {
            let v30 = 0;
            while (v30 < v20) {
                let v31 = 0x1::vector::borrow<PendingRedeem>(&v12, v30);
                let (_, v33) = 0x1::vector::index_of<u64>(&arg3, &v31.withdraw_time);
                let v34 = 0x1::vector::borrow<u64>(&arg4, v33);
                let v35 = 0x1::vector::borrow<u64>(&arg5, v33);
                assert!(v31.amount >= *v35, 18);
                v21 = v21 + *v34;
                v22 = v22 + v31.amount;
                v23 = v23 + *v35;
                v30 = v30 + 1;
            };
        };
        arg1.pending_redemptions = arg1.pending_redemptions - (v22 as u128);
        let v36 = spend_withdraw_asset<T0, T1, T2>(arg1, v21, arg10);
        let v37 = calculate_fee(v21, arg1.withdraw.fee_bps);
        if (v37 > 0) {
            arg1.withdraw.total_fee = arg1.withdraw.total_fee + calculate_fee(v23, arg1.withdraw.fee_bps);
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::split<T2>(&mut v36, v37, arg10), get_dynamic_field_or_default<T0, T1, address>(arg1, b"withdraw_fee_receiver", arg1.fee_receiver));
        };
        arg1.total_withdraw = arg1.total_withdraw + (v23 as u128);
        let v38 = RedeemWithSigTokenEvent{
            receiver                            : arg2,
            item_amount                         : v22,
            amount                              : v21,
            collateral_amount                   : v23,
            vault_id                            : 0x2::object::id<Vault<T0, T1>>(arg1),
            fee                                 : v37,
            withdraw_time_requests              : arg3,
            withdraw_amount_requests            : arg4,
            withdraw_amount_collateral_requests : arg5,
            time                                : v0,
            token                               : v3,
        };
        0x2::event::emit<RedeemWithSigTokenEvent>(v38);
        v36
    }

    public entry fun redeem_with_sigs<T0, T1>(arg0: &mut VaultConfig, arg1: &mut Vault<T0, T1>, arg2: address, arg3: vector<u64>, arg4: vector<u64>, arg5: u64, arg6: vector<vector<u8>>, arg7: vector<vector<u8>>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 9, 5);
        assert!(!check_global_pause(arg0), 35);
        assert!(arg1.enable, 4);
        abort 0
    }

    public entry fun redeem_with_sigs_verify_token<T0, T1, T2>(arg0: &mut VaultConfig, arg1: &mut Vault<T0, T1>, arg2: address, arg3: address, arg4: vector<u64>, arg5: vector<u64>, arg6: vector<u64>, arg7: u64, arg8: vector<vector<u8>>, arg9: vector<vector<u8>>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 9, 5);
        assert!(!check_global_pause(arg0), 35);
        assert!(arg1.enable, 4);
        abort 0
    }

    public fun remove_dynamic_field<T0, T1, T2: copy + drop + store>(arg0: &VaultConfig, arg1: &AccessCap, arg2: &mut Vault<T0, T1>, arg3: vector<u8>) {
        assert!(check_access_cap(arg0, 0x2::object::id<AccessCap>(arg1)), 1);
        if (0x2::dynamic_field::exists_<vector<u8>>(&arg2.id, arg3)) {
            0x2::dynamic_field::remove<vector<u8>, T2>(&mut arg2.id, arg3);
        };
    }

    public entry fun remove_operator(arg0: &AdminCap, arg1: &mut VaultConfig, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 9, 5);
        assert!(0x2::table::contains<address, 0x2::object::ID>(&arg1.operators, arg2), 11);
        0x2::table::remove<address, 0x2::object::ID>(&mut arg1.operators, arg2);
        let v0 = RemoveOperatorEvent{operator: arg2};
        0x2::event::emit<RemoveOperatorEvent>(v0);
    }

    public entry fun remove_signer(arg0: &AdminCap, arg1: &mut VaultConfig, arg2: vector<u8>) {
        assert!(arg1.version == 9, 5);
        assert!(0x2::table::contains<vector<u8>, bool>(&arg1.signers, arg2), 16);
        0x2::table::remove<vector<u8>, bool>(&mut arg1.signers, arg2);
        let v0 = RemoveSignerEvent{signer: arg2};
        0x2::event::emit<RemoveSignerEvent>(v0);
    }

    public entry fun resume<T0, T1>(arg0: &AdminCap, arg1: &VaultConfig, arg2: &mut Vault<T0, T1>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 9, 5);
        assert!(!check_global_pause(arg1), 35);
        arg2.enable = true;
        let v0 = Resume<T0>{dummy_field: false};
        0x2::event::emit<Resume<T0>>(v0);
    }

    fun set_config_dynamic_field<T0: copy + drop + store>(arg0: &mut VaultConfig, arg1: vector<u8>, arg2: T0) {
        if (0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, arg1)) {
            *0x2::dynamic_field::borrow_mut<vector<u8>, T0>(&mut arg0.id, arg1) = arg2;
        } else {
            0x2::dynamic_field::add<vector<u8>, T0>(&mut arg0.id, arg1, arg2);
        };
    }

    fun set_dynamic_field<T0, T1, T2: copy + drop + store>(arg0: &mut Vault<T0, T1>, arg1: vector<u8>, arg2: T2) {
        if (0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, arg1)) {
            *0x2::dynamic_field::borrow_mut<vector<u8>, T2>(&mut arg0.id, arg1) = arg2;
        } else {
            0x2::dynamic_field::add<vector<u8>, T2>(&mut arg0.id, arg1, arg2);
        };
    }

    public entry fun set_threshold(arg0: &AdminCap, arg1: &mut VaultConfig, arg2: u64) {
        assert!(arg1.version == 9, 5);
        assert!(!check_global_pause(arg1), 35);
        assert!(arg2 > 0, 23);
        arg1.threshold = arg2;
    }

    public fun spend_harvest_asset<T0, T1, T2>(arg0: &mut VaultConfig, arg1: &mut Vault<T0, T1>, arg2: u64, arg3: &AccessCap, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        assert!(arg0.version == 9, 5);
        assert!(!check_global_pause(arg0), 35);
        assert!(!check_trade_pause<T0, T1>(arg0, arg1), 44);
        assert!(check_access_cap(arg0, 0x2::object::id<AccessCap>(arg3)), 1);
        let v0 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T2>());
        assert!(0x2::bag::contains<0x1::ascii::String>(&arg1.harvest_assets, v0), 14);
        let v1 = 0x2::bag::borrow_mut<0x1::ascii::String, 0x2::coin::Coin<T2>>(&mut arg1.harvest_assets, v0);
        assert!(0x2::coin::value<T2>(v1) >= arg2, 2);
        let v2 = 0x2::coin::split<T2>(v1, arg2, arg4);
        if (0x2::coin::value<T2>(v1) == 0) {
            0x2::coin::destroy_zero<T2>(0x2::bag::remove<0x1::ascii::String, 0x2::coin::Coin<T2>>(&mut arg1.harvest_assets, v0));
            let (v3, v4) = 0x1::vector::index_of<0x1::ascii::String>(&arg1.harvest_asset_keys, &v0);
            if (v3) {
                0x1::vector::swap_remove<0x1::ascii::String>(&mut arg1.harvest_asset_keys, v4);
            };
            add_table_vault_asset<T0, T1>(arg1, v0, 0, arg4);
        } else {
            add_table_vault_asset<T0, T1>(arg1, v0, (0x2::coin::value<T2>(v1) as u128), arg4);
        };
        v2
    }

    public fun spend_vault_funds<T0, T1>(arg0: &mut VaultConfig, arg1: &mut Vault<T0, T1>, arg2: u64, arg3: &AccessCap, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.version == 9, 5);
        assert!(!check_global_pause(arg0), 35);
        assert!(!check_trade_pause<T0, T1>(arg0, arg1), 44);
        assert!(check_access_cap(arg0, 0x2::object::id<AccessCap>(arg3)), 1);
        assert!(0x1::option::is_some<0x2::coin::Coin<T0>>(&arg1.coin_store.coin), 2);
        let v0 = 0x1::option::borrow_mut<0x2::coin::Coin<T0>>(&mut arg1.coin_store.coin);
        assert!(0x2::coin::value<T0>(v0) >= arg2, 2);
        arg1.available_liquidity = arg1.available_liquidity - (arg2 as u128);
        let v1 = 0x2::coin::split<T0>(v0, arg2, arg4);
        let v2 = arg1.available_liquidity;
        add_table_vault_asset<T0, T1>(arg1, 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()), v2, arg4);
        v1
    }

    fun spend_withdraw_asset<T0, T1, T2>(arg0: &mut Vault<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        let v0 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T2>());
        assert!(0x2::bag::contains<0x1::ascii::String>(&arg0.withdraw_assets, v0), 14);
        let v1 = 0x2::bag::borrow_mut<0x1::ascii::String, 0x2::coin::Coin<T2>>(&mut arg0.withdraw_assets, v0);
        assert!(0x2::coin::value<T2>(v1) >= arg1, 2);
        let v2 = 0x2::coin::split<T2>(v1, arg1, arg2);
        if (0x2::coin::value<T2>(v1) == 0) {
            0x2::coin::destroy_zero<T2>(0x2::bag::remove<0x1::ascii::String, 0x2::coin::Coin<T2>>(&mut arg0.withdraw_assets, v0));
            let (v3, v4) = 0x1::vector::index_of<0x1::ascii::String>(&arg0.withdraw_asset_keys, &v0);
            if (v3) {
                0x1::vector::swap_remove<0x1::ascii::String>(&mut arg0.withdraw_asset_keys, v4);
            };
            add_table_withdraw_asset<T0, T1>(arg0, v0, 0, arg2);
        } else {
            add_table_withdraw_asset<T0, T1>(arg0, v0, (0x2::coin::value<T2>(v1) as u128), arg2);
        };
        v2
    }

    public entry fun update_deposit_fee<T0, T1>(arg0: &AdminCap, arg1: &mut VaultConfig, arg2: &mut Vault<T0, T1>, arg3: u64) {
        assert!(arg1.version == 9, 5);
        assert!(!check_global_pause(arg1), 35);
        assert!(arg3 <= 10000, 24);
        arg2.deposit.fee_bps = arg3;
        let v0 = UpdateDepositFeeEvent{
            vault_id : 0x2::object::id<Vault<T0, T1>>(arg2),
            fee_bps  : arg3,
        };
        0x2::event::emit<UpdateDepositFeeEvent>(v0);
    }

    public entry fun update_fee_receiver<T0, T1>(arg0: &AdminCap, arg1: &mut VaultConfig, arg2: &mut Vault<T0, T1>, arg3: address) {
        assert!(arg1.version == 9, 5);
        assert!(!check_global_pause(arg1), 35);
        arg2.fee_receiver = arg3;
        let v0 = UpdateFeeReceiverEvent{
            vault_id : 0x2::object::id<Vault<T0, T1>>(arg2),
            address  : arg3,
        };
        0x2::event::emit<UpdateFeeReceiverEvent>(v0);
    }

    public entry fun update_lock_duration<T0, T1>(arg0: &AdminCap, arg1: &mut VaultConfig, arg2: &mut Vault<T0, T1>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 9, 5);
        assert!(!check_global_pause(arg1), 35);
        arg2.lock_duration_ms = arg3;
        let v0 = UpdateLockDurationEvent{
            vault_id         : 0x2::object::id<Vault<T0, T1>>(arg2),
            lock_duration_ms : arg3,
        };
        0x2::event::emit<UpdateLockDurationEvent>(v0);
    }

    public entry fun update_management_fee<T0, T1>(arg0: &AdminCap, arg1: &mut VaultConfig, arg2: &mut Vault<T0, T1>, arg3: u64) {
        assert!(arg1.version == 9, 5);
        assert!(!check_global_pause(arg1), 35);
        assert!(arg3 <= 10000, 24);
        arg2.management_fee.fee_bps = arg3;
        let v0 = UpdateManagementFeeEvent{
            vault_id : 0x2::object::id<Vault<T0, T1>>(arg2),
            fee_bps  : arg3,
        };
        0x2::event::emit<UpdateManagementFeeEvent>(v0);
    }

    public entry fun update_management_fee_period_duration<T0, T1>(arg0: &AdminCap, arg1: &mut VaultConfig, arg2: &mut Vault<T0, T1>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 9, 5);
        assert!(!check_global_pause(arg1), 35);
        arg2.management_fee.period_duration = arg3;
        let v0 = UpdateManagementPeriodDurationEvent{
            vault_id        : 0x2::object::id<Vault<T0, T1>>(arg2),
            period_duration : arg3,
        };
        0x2::event::emit<UpdateManagementPeriodDurationEvent>(v0);
    }

    public fun update_max_vault_cap<T0, T1>(arg0: &AdminCap, arg1: &VaultConfig, arg2: &mut Vault<T0, T1>, arg3: u128, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 9, 5);
        assert!(!check_global_pause(arg1), 35);
        assert!(arg3 >= arg2.available_liquidity, 25);
        set_dynamic_field<T0, T1, u128>(arg2, b"max_vault_cap", arg3);
    }

    public entry fun update_min_deposit<T0, T1>(arg0: &AdminCap, arg1: &mut VaultConfig, arg2: &mut Vault<T0, T1>, arg3: u64) {
        assert!(arg1.version == 9, 5);
        assert!(!check_global_pause(arg1), 35);
        arg2.deposit.min = arg3;
        let v0 = UpdateMinDepositEvent{
            vault_id : 0x2::object::id<Vault<T0, T1>>(arg2),
            min      : arg3,
        };
        0x2::event::emit<UpdateMinDepositEvent>(v0);
    }

    public entry fun update_min_withdraw<T0, T1>(arg0: &AdminCap, arg1: &mut VaultConfig, arg2: &mut Vault<T0, T1>, arg3: u64) {
        assert!(arg1.version == 9, 5);
        assert!(!check_global_pause(arg1), 35);
        arg2.withdraw.min = arg3;
        let v0 = UpdateMinWithdrawEvent{
            vault_id : 0x2::object::id<Vault<T0, T1>>(arg2),
            min      : arg3,
        };
        0x2::event::emit<UpdateMinWithdrawEvent>(v0);
    }

    public entry fun update_performance_fee<T0, T1>(arg0: &AdminCap, arg1: &mut VaultConfig, arg2: &mut Vault<T0, T1>, arg3: u64) {
        assert!(arg1.version == 9, 5);
        assert!(!check_global_pause(arg1), 35);
        assert!(arg3 <= 10000, 24);
        arg2.performance_fee.fee_bps = arg3;
        let v0 = UpdatePerformanceFeeEvent{
            vault_id : 0x2::object::id<Vault<T0, T1>>(arg2),
            fee_bps  : arg3,
        };
        0x2::event::emit<UpdatePerformanceFeeEvent>(v0);
    }

    public fun update_rate_v2<T0, T1>(arg0: &mut VaultConfig, arg1: &mut Vault<T0, T1>, arg2: u128, arg3: &0x2::clock::Clock, arg4: &AccessCap, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 9, 5);
        assert!(!check_global_pause(arg0), 35);
        assert!(arg1.enable, 4);
        assert!(check_access_cap(arg0, 0x2::object::id<AccessCap>(arg4)), 1);
        let v0 = arg1.liquidity;
        arg1.liquidity = arg2;
        calculate_profit_and_rate_internal<T0, T1>(arg1, v0, arg3, arg5);
    }

    public entry fun update_withdraw_fee<T0, T1>(arg0: &AdminCap, arg1: &mut VaultConfig, arg2: &mut Vault<T0, T1>, arg3: u64) {
        assert!(arg1.version == 9, 5);
        assert!(!check_global_pause(arg1), 35);
        assert!(arg3 <= 10000, 24);
        arg2.withdraw.fee_bps = arg3;
        let v0 = UpdateWithdrawFeeEvent{
            vault_id : 0x2::object::id<Vault<T0, T1>>(arg2),
            fee_bps  : arg3,
        };
        0x2::event::emit<UpdateWithdrawFeeEvent>(v0);
    }

    entry fun update_withdraw_fee_receiver<T0, T1>(arg0: &AdminCap, arg1: &VaultConfig, arg2: &mut Vault<T0, T1>, arg3: address) {
        assert!(arg1.version == 9, 5);
        assert!(arg2.enable, 4);
        set_dynamic_field<T0, T1, address>(arg2, b"withdraw_fee_receiver", arg3);
        let v0 = UpdateWithdrawFeeReceiverEvent{
            vault_id : 0x2::object::id<Vault<T0, T1>>(arg2),
            address  : arg3,
        };
        0x2::event::emit<UpdateWithdrawFeeReceiverEvent>(v0);
    }

    public entry fun withdraw_dual_token<T0, T1, T2, T3>(arg0: &mut VaultConfig, arg1: &mut Vault<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: u64, arg5: bool, arg6: u64, arg7: u64, arg8: vector<vector<u8>>, arg9: vector<vector<u8>>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 9, 5);
        assert!(!check_global_pause(arg0), 35);
        assert!(arg1.enable, 4);
        abort 0
    }

    public fun withdraw_dual_token_v2<T0, T1, T2, T3>(arg0: &mut VaultConfig, arg1: &mut Vault<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: u128, arg4: vector<0x1::ascii::String>, arg5: vector<u64>, arg6: vector<u64>, arg7: &0x2::clock::Clock, arg8: &AccessCap, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 9, 5);
        assert!(!check_global_pause(arg0), 35);
        assert!(arg1.enable, 4);
        assert!(!check_withdraw_pause<T0, T1>(arg0, arg1), 43);
        assert!(check_access_cap(arg0, 0x2::object::id<AccessCap>(arg8)), 1);
        let v0 = 0x2::tx_context::sender(arg9);
        let v1 = 0x2::coin::value<T1>(&arg2);
        assert!(v1 > 0, 6);
        assert!(v1 >= arg1.withdraw.min, 9);
        let v2 = arg1.liquidity;
        arg1.liquidity = arg3;
        calculate_profit_and_rate_internal<T0, T1>(arg1, v2, arg7, arg9);
        let v3 = 0xffb7c9726224597e54606958ada3fad60bf7dc5cecc238ff97af99304ee75228::fast_price_feed::safe_mul_div_u64(v1, arg1.rate, 1000000);
        let v4 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T2>());
        let v5 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T3>());
        let v6 = 0;
        let v7 = if (v4 == 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>())) {
            v3 / 2
        } else {
            (0x45355b07146d699e6a8c405bcc2f60ef5d062a15183c6012ac55d5734d8add21::utils::get_token_out_amount(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()), v4, arg4, arg5, arg6, v3 / 2) as u64)
        };
        let v8 = if (v5 == 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>())) {
            v3 / 2
        } else {
            (0x45355b07146d699e6a8c405bcc2f60ef5d062a15183c6012ac55d5734d8add21::utils::get_token_out_amount(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()), v5, arg4, arg5, arg6, v3 / 2) as u64)
        };
        add_pending_redeem_v2<T0, T1>(arg1, v0, v3, v1, 0x1::option::some<0x1::ascii::String>(v4), (v7 as u64), 0x1::option::some<0x1::ascii::String>(v5), (v8 as u64), arg7, arg9);
        if (arg1.liquidity > (v3 as u128)) {
            arg1.liquidity = arg1.liquidity - (v3 as u128);
        } else {
            arg1.liquidity = 0;
        };
        let v9 = arg1.hwm;
        let v10 = if (v9 >= (v3 as u128)) {
            v9 - (v3 as u128)
        } else {
            0
        };
        arg1.hwm = v10;
        0x2::coin::burn<T1>(&mut arg1.treasury_cap, arg2);
        let v11 = DualWithdrawEventV2{
            user                   : v0,
            lp                     : v1,
            amount                 : v3,
            net_amount             : v3 - v6,
            vault_id               : 0x2::object::id<Vault<T0, T1>>(arg1),
            liquidity              : arg1.liquidity,
            total_supply           : 0x2::coin::total_supply<T1>(&arg1.treasury_cap),
            rate                   : arg1.rate,
            fee                    : v6,
            time                   : 0x2::clock::timestamp_ms(arg7),
            token_a                : v4,
            token_b                : v5,
            token_a_amount         : v7,
            token_b_amount         : v8,
            amount_a_by_collateral : v3 / 2,
            amount_b_by_collateral : v3 / 2,
        };
        0x2::event::emit<DualWithdrawEventV2>(v11);
    }

    public fun withdraw_dual_v2<T0, T1, T2, T3>(arg0: &mut VaultConfig, arg1: &mut Vault<T0, T1>, arg2: &0x35cf1945256c4ae43e32458151c961b5daf4161772f39b34b65587f92bf6ffbd::price_feed::PriceFeedConfig, arg3: 0x2::coin::Coin<T1>, arg4: u128, arg5: &vector<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>, arg6: &vector<0x12d35682ee1196f12174748738983e364b4b217df41206badbd5adb436264a42::nodo_price_feed::NodoPriceFeedInfo>, arg7: &0x2::clock::Clock, arg8: &AccessCap, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 9, 5);
        assert!(!check_global_pause(arg0), 35);
        assert!(arg1.enable, 4);
        abort 0
    }

    public entry fun withdraw_fee<T0, T1>(arg0: &OperatorCap, arg1: &mut VaultConfig, arg2: &mut Vault<T0, T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 9, 5);
        assert!(!check_global_pause(arg1), 35);
        assert!(arg2.enable, 4);
        assert!(!check_withdraw_pause<T0, T1>(arg1, arg2), 43);
        assert!(check_operator(arg1, 0x2::tx_context::sender(arg5), 0x2::object::id<OperatorCap>(arg0)), 1);
        withdraw_fee_internal<T0, T1>(arg2, arg3, arg4, arg5);
    }

    fun withdraw_fee_internal<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 12);
        let v0 = arg1;
        let v1 = arg0.pending_fee;
        if (arg1 > v1) {
            v0 = v1;
        };
        let v2 = 0x2::object::id_address<Vault<T0, T1>>(arg0);
        add_pending_redeem_v2<T0, T1>(arg0, v2, v0, 0, 0x1::option::some<0x1::ascii::String>(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>())), v0, 0x1::option::none<0x1::ascii::String>(), 0, arg2, arg3);
        arg0.pending_fee = arg0.pending_fee - v0;
        let v3 = WithdrawFeeEvent{
            amount   : arg1,
            vault_id : 0x2::object::id<Vault<T0, T1>>(arg0),
            time     : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<WithdrawFeeEvent>(v3);
    }

    public fun withdraw_lp<T0, T1>(arg0: &VaultConfig, arg1: &mut Vault<T0, T1>, arg2: 0x2::object::ID, arg3: &AccessCap) : 0x2::object::ID {
        assert!(arg0.version == 9, 5);
        assert!(!check_global_pause(arg0), 35);
        assert!(!check_trade_pause<T0, T1>(arg0, arg1), 44);
        assert!(check_access_cap(arg0, 0x2::object::id<AccessCap>(arg3)), 1);
        let v0 = 0x2::vec_map::get_mut<0x2::object::ID, vector<0x2::object::ID>>(&mut arg1.lp_storage, &arg2);
        assert!(0x1::vector::length<0x2::object::ID>(v0) > 0, 3);
        0x1::vector::pop_back<0x2::object::ID>(v0)
    }

    public fun withdraw_lp_by_id<T0, T1>(arg0: &VaultConfig, arg1: &mut Vault<T0, T1>, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: &AccessCap) : 0x2::object::ID {
        assert!(arg0.version == 9, 5);
        assert!(!check_global_pause(arg0), 35);
        assert!(!check_trade_pause<T0, T1>(arg0, arg1), 44);
        assert!(check_access_cap(arg0, 0x2::object::id<AccessCap>(arg4)), 1);
        let v0 = 0x2::vec_map::get_mut<0x2::object::ID, vector<0x2::object::ID>>(&mut arg1.lp_storage, &arg2);
        let v1 = 0;
        let v2 = false;
        while (v1 < 0x1::vector::length<0x2::object::ID>(v0)) {
            if (*0x1::vector::borrow<0x2::object::ID>(v0, v1) == arg3) {
                v2 = true;
                break
            };
            v1 = v1 + 1;
        };
        if (v2) {
            0x1::vector::swap_remove<0x2::object::ID>(v0, v1);
        };
        arg3
    }

    public fun withdraw_token_v2<T0, T1, T2>(arg0: &mut VaultConfig, arg1: &mut Vault<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: u128, arg4: vector<0x1::ascii::String>, arg5: vector<u64>, arg6: vector<u64>, arg7: &0x2::clock::Clock, arg8: &AccessCap, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 9, 5);
        assert!(!check_global_pause(arg0), 35);
        assert!(arg1.enable, 4);
        assert!(!check_withdraw_pause<T0, T1>(arg0, arg1), 43);
        assert!(check_access_cap(arg0, 0x2::object::id<AccessCap>(arg8)), 1);
        let v0 = 0x2::tx_context::sender(arg9);
        let v1 = 0x2::coin::value<T1>(&arg2);
        assert!(v1 > 0, 6);
        assert!(v1 >= arg1.withdraw.min, 9);
        let v2 = arg1.liquidity;
        arg1.liquidity = arg3;
        calculate_profit_and_rate_internal<T0, T1>(arg1, v2, arg7, arg9);
        let v3 = 0xffb7c9726224597e54606958ada3fad60bf7dc5cecc238ff97af99304ee75228::fast_price_feed::safe_mul_div_u64(v1, arg1.rate, 1000000);
        let v4 = 0;
        let v5 = false;
        let v6 = 0;
        let v7 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T2>());
        let v8 = if (arg1.lock_duration_ms == 0) {
            if ((v3 as u128) <= arg1.available_liquidity) {
                0x1::type_name::into_string(0x1::type_name::with_defining_ids<T2>()) == 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>())
            } else {
                false
            }
        } else {
            false
        };
        if (v8) {
            let v9 = 0x1::option::borrow_mut<0x2::coin::Coin<T0>>(&mut arg1.coin_store.coin);
            assert!(0x2::coin::value<T0>(v9) >= v3, 2);
            let v10 = 0x2::coin::split<T0>(v9, v3, arg9);
            let v11 = calculate_fee(v3, arg1.withdraw.fee_bps);
            v4 = v11;
            arg1.available_liquidity = arg1.available_liquidity - (v3 as u128);
            v5 = true;
            if (v11 > 0) {
                arg1.withdraw.total_fee = arg1.withdraw.total_fee + v11;
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v10, v11, arg9), get_dynamic_field_or_default<T0, T1, address>(arg1, b"withdraw_fee_receiver", arg1.fee_receiver));
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v10, v0);
            let v12 = arg1.available_liquidity;
            add_table_vault_asset<T0, T1>(arg1, 0x1::type_name::into_string(0x1::type_name::get<T0>()), v12, arg9);
        } else if (0x1::type_name::into_string(0x1::type_name::with_defining_ids<T2>()) == 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>())) {
            v6 = v3;
            add_pending_redeem_v2<T0, T1>(arg1, v0, v3, v1, 0x1::option::some<0x1::ascii::String>(v7), v3, 0x1::option::none<0x1::ascii::String>(), 0, arg7, arg9);
        } else {
            let v13 = (0x45355b07146d699e6a8c405bcc2f60ef5d062a15183c6012ac55d5734d8add21::utils::get_token_out_amount(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()), v7, arg4, arg5, arg6, v3) as u64);
            v6 = v13;
            add_pending_redeem_v2<T0, T1>(arg1, v0, v3, v1, 0x1::option::some<0x1::ascii::String>(v7), v13, 0x1::option::none<0x1::ascii::String>(), 0, arg7, arg9);
        };
        if (arg1.liquidity > (v3 as u128)) {
            arg1.liquidity = arg1.liquidity - (v3 as u128);
        } else {
            arg1.liquidity = 0;
        };
        let v14 = arg1.hwm;
        let v15 = if (v14 >= (v3 as u128)) {
            v14 - (v3 as u128)
        } else {
            0
        };
        arg1.hwm = v15;
        0x2::coin::burn<T1>(&mut arg1.treasury_cap, arg2);
        let v16 = WithdrawEventV2{
            user         : v0,
            lp           : v1,
            amount       : v3,
            net_amount   : v3 - v4,
            vault_id     : 0x2::object::id<Vault<T0, T1>>(arg1),
            liquidity    : arg1.liquidity,
            total_supply : 0x2::coin::total_supply<T1>(&arg1.treasury_cap),
            rate         : arg1.rate,
            fee          : v4,
            paid         : v5,
            time         : 0x2::clock::timestamp_ms(arg7),
            token        : v7,
            token_amount : v6,
        };
        0x2::event::emit<WithdrawEventV2>(v16);
    }

    public fun withdraw_v2<T0, T1, T2>(arg0: &mut VaultConfig, arg1: &mut Vault<T0, T1>, arg2: &0x35cf1945256c4ae43e32458151c961b5daf4161772f39b34b65587f92bf6ffbd::price_feed::PriceFeedConfig, arg3: 0x2::coin::Coin<T1>, arg4: u128, arg5: &vector<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>, arg6: &vector<0x12d35682ee1196f12174748738983e364b4b217df41206badbd5adb436264a42::nodo_price_feed::NodoPriceFeedInfo>, arg7: &0x2::clock::Clock, arg8: &AccessCap, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 9, 5);
        assert!(!check_global_pause(arg0), 35);
        assert!(arg1.enable, 4);
        abort 0
    }

    public entry fun withdraw_with_sigs_credit_time<T0, T1, T2>(arg0: &mut VaultConfig, arg1: &mut Vault<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: u64, arg5: bool, arg6: u64, arg7: u64, arg8: vector<vector<u8>>, arg9: vector<vector<u8>>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 9, 5);
        assert!(!check_global_pause(arg0), 35);
        abort 0
    }

    // decompiled from Move bytecode v6
}

