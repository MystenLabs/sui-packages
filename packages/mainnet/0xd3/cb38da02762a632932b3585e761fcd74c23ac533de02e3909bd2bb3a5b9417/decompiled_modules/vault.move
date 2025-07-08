module 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct OperatorCap has store, key {
        id: 0x2::object::UID,
    }

    struct AccessCap has store, key {
        id: 0x2::object::UID,
    }

    struct VaultConfig has store, key {
        id: 0x2::object::UID,
        version: u64,
        allowed_access: vector<0x2::object::ID>,
        operators: 0x2::table::Table<address, 0x2::object::ID>,
    }

    struct CoinStore<phantom T0> has store {
        coin: 0x1::option::Option<0x2::coin::Coin<T0>>,
    }

    struct PendingRedeem has copy, drop, store {
        withdraw_time: u64,
        amount: u64,
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

    struct PerformanceFee has store, key {
        id: 0x2::object::UID,
        fee_bps: u64,
        total_fee: u64,
        total_claimed_fee: u64,
        total_available_fee: u64,
        total_pending_redeem_fee: u64,
    }

    struct ManagementFee has store, key {
        id: 0x2::object::UID,
        fee_bps: u64,
        total_fee: u64,
        total_claimed_fee: u64,
        total_pending_redeem_fee: u64,
        period_duration: u64,
        latest_withdraw_time: u64,
    }

    struct Vault<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<T1>,
        deny_cap: 0x2::coin::DenyCapV2<T1>,
        coin_store: CoinStore<T0>,
        enable: bool,
        owner: address,
        harvest_asset_keys: vector<0x1::ascii::String>,
        harvest_assets: 0x2::bag::Bag,
        coin_base: 0x1::type_name::TypeName,
        token_type: 0x1::type_name::TypeName,
        total_liquidity: u128,
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
    }

    struct TableWrapper has store {
        inner: 0x2::table::Table<vector<u8>, bool>,
    }

    struct CreatedVaultEvent has copy, drop, store {
        id: 0x2::object::ID,
    }

    struct DepositEvent has copy, drop, store {
        sender: address,
        amount: u64,
        lp: u64,
        vault_id: 0x2::object::ID,
        fee: u64,
    }

    struct WithdrawEvent has copy, drop, store {
        user: address,
        lp: u64,
        amount: u64,
        vault_id: 0x2::object::ID,
        time: u64,
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

    struct AddProfitEvent has copy, drop, store {
        profit: u128,
        before_liquidity: u128,
        liquidity: u128,
        rate: u64,
        last_update: u64,
        vault_id: 0x2::object::ID,
        fee: u64,
    }

    struct WithdrawPerformanceFeeEvent has copy, drop, store {
        amount: u64,
        vault_id: 0x2::object::ID,
        time: u64,
    }

    struct RedeemPerformanceFeeEvent has copy, drop, store {
        receiver: address,
        amount: u64,
        vault_id: 0x2::object::ID,
    }

    struct WithdrawManagementFeeEvent has copy, drop, store {
        amount: u64,
        vault_id: 0x2::object::ID,
        time: u64,
        rate: u64,
    }

    struct RedeemManagementFeeEvent has copy, drop, store {
        receiver: address,
        amount: u64,
        vault_id: 0x2::object::ID,
        time: u64,
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

    struct CreditLossEvent has copy, drop, store {
        loss: u128,
        before_liquidity: u128,
        liquidity: u128,
        rate: u64,
        last_update: u64,
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

    struct DeductManagementFeeEvent has copy, drop, store {
        amount: u64,
        before_liquidity: u128,
        liquidity: u128,
        vault_id: 0x2::object::ID,
        time: u64,
        rate: u64,
    }

    struct AddProfitWithHwmEvent has copy, drop, store {
        profit: u128,
        before_liquidity: u128,
        liquidity: u128,
        rate: u64,
        last_update: u64,
        vault_id: 0x2::object::ID,
        fee: u64,
        current_hwm: u64,
        new_hwm: u64,
    }

    struct DepositWithHwmEvent has copy, drop, store {
        sender: address,
        amount: u64,
        lp: u64,
        vault_id: 0x2::object::ID,
        fee: u64,
        hwm: u64,
        profit: u64,
        rate: u64,
        time: u64,
    }

    struct DepositWithSigEvent has copy, drop, store {
        sender: address,
        amount: u64,
        lp: u64,
        vault_id: 0x2::object::ID,
        fee: u64,
        hwm: u64,
        profit: u64,
        rate: u64,
        time: u64,
        negative: bool,
    }

    struct WithdrawWithHwmEvent has copy, drop, store {
        user: address,
        lp: u64,
        amount: u64,
        vault_id: 0x2::object::ID,
        hwm: u64,
        profit: u64,
        rate: u64,
        fee: u64,
        paid: bool,
        time: u64,
    }

    struct WithdrawWithSigEvent has copy, drop, store {
        user: address,
        lp: u64,
        amount: u64,
        vault_id: 0x2::object::ID,
        hwm: u64,
        profit: u64,
        rate: u64,
        fee: u64,
        paid: bool,
        time: u64,
        negative: bool,
    }

    struct AddSignerEvent has copy, drop {
        signer: vector<u8>,
    }

    struct RemoveSignerEvent has copy, drop {
        signer: vector<u8>,
    }

    struct Pause<phantom T0> has copy, drop {
        dummy_field: bool,
    }

    struct Resume<phantom T0> has copy, drop {
        dummy_field: bool,
    }

    public entry fun update_icon_url<T0, T1>(arg0: &AdminCap, arg1: &Vault<T0, T1>, arg2: &mut 0x2::coin::CoinMetadata<T1>, arg3: vector<u8>) {
        0x2::coin::update_icon_url<T1>(&arg1.treasury_cap, arg2, 0x1::ascii::string(arg3));
    }

    public entry fun add_fund<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x1::option::is_some<0x2::coin::Coin<T0>>(&arg0.coin_store.coin)) {
            0x2::coin::join<T0>(0x1::option::borrow_mut<0x2::coin::Coin<T0>>(&mut arg0.coin_store.coin), arg1);
        } else {
            0x1::option::fill<0x2::coin::Coin<T0>>(&mut arg0.coin_store.coin, arg1);
        };
        arg0.available_liquidity = (0x2::coin::value<T0>(0x1::option::borrow_mut<0x2::coin::Coin<T0>>(&mut arg0.coin_store.coin)) as u128);
        let v0 = AddFundEvent{
            amount   : 0x2::coin::value<T0>(&arg1),
            vault_id : 0x2::object::id<Vault<T0, T1>>(arg0),
        };
        0x2::event::emit<AddFundEvent>(v0);
    }

    public fun add_harvest_assets<T0, T1, T2>(arg0: &mut VaultConfig, arg1: &mut Vault<T0, T1>, arg2: 0x2::coin::Coin<T2>, arg3: &AccessCap) {
        assert!(check_access_cap(arg0, 0x2::object::id<AccessCap>(arg3)), 1);
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T2>());
        if (0x2::bag::contains<0x1::ascii::String>(&arg1.harvest_assets, v0)) {
            0x2::coin::join<T2>(0x2::bag::borrow_mut<0x1::ascii::String, 0x2::coin::Coin<T2>>(&mut arg1.harvest_assets, v0), arg2);
        } else {
            0x2::bag::add<0x1::ascii::String, 0x2::coin::Coin<T2>>(&mut arg1.harvest_assets, v0, arg2);
            0x1::vector::push_back<0x1::ascii::String>(&mut arg1.harvest_asset_keys, v0);
        };
    }

    public fun add_lp<T0, T1>(arg0: &mut VaultConfig, arg1: &mut Vault<T0, T1>, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: &AccessCap) {
        assert!(check_access_cap(arg0, 0x2::object::id<AccessCap>(arg4)), 1);
        if (0x2::vec_map::contains<0x2::object::ID, vector<0x2::object::ID>>(&arg1.lp_storage, &arg2)) {
            0x1::vector::push_back<0x2::object::ID>(0x2::vec_map::get_mut<0x2::object::ID, vector<0x2::object::ID>>(&mut arg1.lp_storage, &arg2), arg3);
        } else {
            let v0 = 0x1::vector::empty<0x2::object::ID>();
            0x1::vector::push_back<0x2::object::ID>(&mut v0, arg3);
            0x2::vec_map::insert<0x2::object::ID, vector<0x2::object::ID>>(&mut arg1.lp_storage, arg2, v0);
        };
    }

    public entry fun add_operator(arg0: &AdminCap, arg1: &mut VaultConfig, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 1, 5);
        assert!(!0x2::table::contains<address, 0x2::object::ID>(&arg1.operators, arg2), 10);
        let v0 = OperatorCap{id: 0x2::object::new(arg3)};
        0x2::table::add<address, 0x2::object::ID>(&mut arg1.operators, arg2, 0x2::object::id<OperatorCap>(&v0));
        0x2::transfer::transfer<OperatorCap>(v0, arg2);
        let v1 = AddOperatorEvent{operator: arg2};
        0x2::event::emit<AddOperatorEvent>(v1);
    }

    public entry fun add_profit<T0, T1>(arg0: &OperatorCap, arg1: &mut VaultConfig, arg2: &mut Vault<T0, T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 1, 5);
        assert!(check_operator(arg1, 0x2::tx_context::sender(arg5), 0x2::object::id<OperatorCap>(arg0)), 1);
        let v0 = calculate_fee(arg3, arg2.performance_fee.fee_bps);
        let v1 = arg3 - v0;
        let v2 = arg2.liquidity;
        let v3 = 0x2::coin::total_supply<T1>(&arg2.treasury_cap);
        arg2.liquidity = arg2.liquidity + (v1 as u128);
        if (v3 > 1000000) {
            arg2.rate = ((arg2.liquidity * (1000000 as u128) / (v3 as u128)) as u64);
        } else if (v3 == 0) {
            arg2.rate = 1 * 1000000;
        };
        arg2.profit = arg2.profit + (v1 as u128);
        arg2.last_update = 0x2::clock::timestamp_ms(arg4);
        arg2.performance_fee.total_fee = arg2.performance_fee.total_fee + v0;
        let v4 = get_dynamic_field_or_default<T0, T1, u64>(arg2, b"total_fee", 0);
        let v5 = get_dynamic_field_or_default<T0, T1, u64>(arg2, b"pending_fee", 0) + v0;
        set_dynamic_field<T0, T1, u64>(arg2, b"pending_fee", v5);
        set_dynamic_field<T0, T1, u64>(arg2, b"total_fee", v4 + v0);
        let v6 = AddProfitEvent{
            profit           : (v1 as u128),
            before_liquidity : v2,
            liquidity        : arg2.liquidity,
            rate             : arg2.rate,
            last_update      : arg2.last_update,
            vault_id         : 0x2::object::id<Vault<T0, T1>>(arg2),
            fee              : v0,
        };
        0x2::event::emit<AddProfitEvent>(v6);
    }

    public entry fun add_profit_with_hwm<T0, T1>(arg0: &OperatorCap, arg1: &mut VaultConfig, arg2: &mut Vault<T0, T1>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 1, 5);
        assert!(check_operator(arg1, 0x2::tx_context::sender(arg6), 0x2::object::id<OperatorCap>(arg0)), 1);
        add_profit_with_hwm_internal<T0, T1>(arg2, arg3, arg4, arg5);
    }

    fun add_profit_with_hwm_internal<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock) {
        let v0 = get_dynamic_field_or_default<T0, T1, u64>(arg0, b"hwm", (arg0.liquidity as u64));
        let v1 = 0;
        if (arg2 > v0) {
            set_dynamic_field<T0, T1, u64>(arg0, b"hwm", arg2);
            let v2 = calculate_fee(arg2 - v0, arg0.performance_fee.fee_bps);
            v1 = v2;
            arg0.performance_fee.total_fee = arg0.performance_fee.total_fee + v2;
        };
        let v3 = arg1 - v1;
        let v4 = arg0.liquidity;
        let v5 = 0x2::coin::total_supply<T1>(&arg0.treasury_cap);
        arg0.liquidity = arg0.liquidity + (v3 as u128);
        if (v5 > 1000000) {
            arg0.rate = ((arg0.liquidity * (1000000 as u128) / (v5 as u128)) as u64);
        } else if (v5 == 0) {
            arg0.rate = 1 * 1000000;
        };
        arg0.profit = arg0.profit + (v3 as u128);
        arg0.last_update = 0x2::clock::timestamp_ms(arg3);
        let v6 = get_dynamic_field_or_default<T0, T1, u64>(arg0, b"total_fee", 0);
        let v7 = get_dynamic_field_or_default<T0, T1, u64>(arg0, b"pending_fee", 0) + v1;
        set_dynamic_field<T0, T1, u64>(arg0, b"pending_fee", v7);
        set_dynamic_field<T0, T1, u64>(arg0, b"total_fee", v6 + v1);
        let v8 = AddProfitWithHwmEvent{
            profit           : (arg1 as u128),
            before_liquidity : v4,
            liquidity        : arg0.liquidity,
            rate             : arg0.rate,
            last_update      : arg0.last_update,
            vault_id         : 0x2::object::id<Vault<T0, T1>>(arg0),
            fee              : v1,
            current_hwm      : v0,
            new_hwm          : arg2,
        };
        0x2::event::emit<AddProfitWithHwmEvent>(v8);
        if (v1 > 0) {
            withdraw_fee_internal<T0, T1>(arg0, v1, arg3);
        };
    }

    public entry fun add_signer(arg0: &AdminCap, arg1: &mut VaultConfig, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 1, 5);
        if (!0x2::dynamic_field::exists_<vector<u8>>(&arg1.id, b"signers")) {
            let v0 = TableWrapper{inner: 0x2::table::new<vector<u8>, bool>(arg3)};
            0x2::dynamic_field::add<vector<u8>, TableWrapper>(&mut arg1.id, b"signers", v0);
        };
        let v1 = &mut 0x2::dynamic_field::borrow_mut<vector<u8>, TableWrapper>(&mut arg1.id, b"signers").inner;
        assert!(!0x2::table::contains<vector<u8>, bool>(v1, arg2), 18);
        0x2::table::add<vector<u8>, bool>(v1, arg2, true);
        let v2 = AddSignerEvent{signer: arg2};
        0x2::event::emit<AddSignerEvent>(v2);
    }

    public entry fun allow_access(arg0: &AdminCap, arg1: &mut VaultConfig, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 1, 5);
        let v0 = AccessCap{id: 0x2::object::new(arg3)};
        let v1 = 0x2::object::id<AccessCap>(&v0);
        0x2::transfer::public_transfer<AccessCap>(v0, arg2);
        0x1::vector::push_back<0x2::object::ID>(&mut arg1.allowed_access, v1);
        let v2 = AllowAccessCapEvent{access_cap_id: v1};
        0x2::event::emit<AllowAccessCapEvent>(v2);
    }

    fun calculate_fee(arg0: u64, arg1: u64) : u64 {
        arg0 * arg1 / 10000
    }

    public fun check_access_cap(arg0: &VaultConfig, arg1: 0x2::object::ID) : bool {
        assert!(arg0.version == 1, 5);
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

    public fun check_operator(arg0: &VaultConfig, arg1: address, arg2: 0x2::object::ID) : bool {
        if (!0x2::table::contains<address, 0x2::object::ID>(&arg0.operators, arg1)) {
            return false
        };
        0x2::table::borrow<address, 0x2::object::ID>(&arg0.operators, arg1) == &arg2
    }

    public fun check_signer(arg0: &VaultConfig, arg1: vector<u8>) : bool {
        !0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"signers") && false || 0x2::table::contains<vector<u8>, bool>(&0x2::dynamic_field::borrow<vector<u8>, TableWrapper>(&arg0.id, b"signers").inner, arg1)
    }

    public entry fun credit_loss<T0, T1>(arg0: &OperatorCap, arg1: &mut VaultConfig, arg2: &mut Vault<T0, T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 1, 5);
        assert!(check_operator(arg1, 0x2::tx_context::sender(arg5), 0x2::object::id<OperatorCap>(arg0)), 1);
        credit_loss_internal<T0, T1>(arg2, arg3, arg4);
    }

    fun credit_loss_internal<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock) {
        let v0 = 0x2::coin::total_supply<T1>(&arg0.treasury_cap);
        arg0.last_update = 0x2::clock::timestamp_ms(arg2);
        assert!(arg0.liquidity >= (arg1 as u128), 17);
        arg0.liquidity = arg0.liquidity - (arg1 as u128);
        if (v0 > 1000000) {
            arg0.rate = ((arg0.liquidity * (1000000 as u128) / (v0 as u128)) as u64);
        } else if (v0 == 0) {
            arg0.rate = 1 * 1000000;
        };
        let v1 = CreditLossEvent{
            loss             : (arg1 as u128),
            before_liquidity : arg0.liquidity,
            liquidity        : arg0.liquidity,
            rate             : arg0.rate,
            last_update      : arg0.last_update,
            vault_id         : 0x2::object::id<Vault<T0, T1>>(arg0),
        };
        0x2::event::emit<CreditLossEvent>(v1);
    }

    public entry fun deduct_management_fee<T0, T1>(arg0: &OperatorCap, arg1: &mut VaultConfig, arg2: &mut Vault<T0, T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 1, 5);
        assert!(check_operator(arg1, 0x2::tx_context::sender(arg4), 0x2::object::id<OperatorCap>(arg0)), 1);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(arg2.management_fee.latest_withdraw_time + arg2.management_fee.period_duration <= v0, 16);
        let v1 = calculate_fee((arg2.liquidity as u64), arg2.management_fee.fee_bps) / 365;
        assert!(v1 > 0, 15);
        let v2 = arg2.liquidity;
        arg2.management_fee.total_fee = arg2.management_fee.total_fee + v1;
        let v3 = get_dynamic_field_or_default<T0, T1, u64>(arg2, b"total_fee", 0);
        let v4 = get_dynamic_field_or_default<T0, T1, u64>(arg2, b"pending_fee", 0) + v1;
        set_dynamic_field<T0, T1, u64>(arg2, b"pending_fee", v4);
        set_dynamic_field<T0, T1, u64>(arg2, b"total_fee", v3 + v1);
        arg2.management_fee.latest_withdraw_time = v0;
        arg2.liquidity = arg2.liquidity - (v1 as u128);
        arg2.last_update = v0;
        let v5 = 0x2::coin::total_supply<T1>(&arg2.treasury_cap);
        if (v5 > 1000000) {
            arg2.rate = ((arg2.liquidity * (1000000 as u128) / (v5 as u128)) as u64);
        } else if (v5 == 0) {
            arg2.rate = 1 * 1000000;
        };
        let v6 = DeductManagementFeeEvent{
            amount           : v1,
            before_liquidity : v2,
            liquidity        : arg2.liquidity,
            vault_id         : 0x2::object::id<Vault<T0, T1>>(arg2),
            time             : v0,
            rate             : arg2.rate,
        };
        0x2::event::emit<DeductManagementFeeEvent>(v6);
        withdraw_fee_internal<T0, T1>(arg2, v1, arg3);
    }

    public entry fun deny_access(arg0: &AdminCap, arg1: &mut VaultConfig, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 1, 5);
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

    public entry fun deposit<T0, T1>(arg0: &mut VaultConfig, arg1: &mut Vault<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 5);
        assert!(arg1.enable, 4);
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 >= arg1.deposit.min, 9);
        let v1 = calculate_fee(v0, arg1.deposit.fee_bps);
        let v2 = v0 - v1;
        if (0x1::option::is_some<0x2::coin::Coin<T0>>(&arg1.coin_store.coin)) {
            0x2::coin::join<T0>(0x1::option::borrow_mut<0x2::coin::Coin<T0>>(&mut arg1.coin_store.coin), arg2);
        } else {
            0x1::option::fill<0x2::coin::Coin<T0>>(&mut arg1.coin_store.coin, arg2);
        };
        let v3 = v2 * 1000000 / arg1.rate;
        arg1.total_liquidity = arg1.total_liquidity + (v2 as u128);
        arg1.available_liquidity = (0x2::coin::value<T0>(0x1::option::borrow_mut<0x2::coin::Coin<T0>>(&mut arg1.coin_store.coin)) as u128);
        arg1.liquidity = arg1.liquidity + (v2 as u128);
        arg1.deposit.total_fee = arg1.deposit.total_fee + v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg2, v1, arg3), arg1.fee_receiver);
        0x2::coin::mint_and_transfer<T1>(&mut arg1.treasury_cap, v3, 0x2::tx_context::sender(arg3), arg3);
        let v4 = DepositEvent{
            sender   : 0x2::tx_context::sender(arg3),
            amount   : v0,
            lp       : v3,
            vault_id : 0x2::object::id<Vault<T0, T1>>(arg1),
            fee      : v1,
        };
        0x2::event::emit<DepositEvent>(v4);
    }

    public entry fun deposit_with_sigs<T0, T1>(arg0: &mut VaultConfig, arg1: &mut Vault<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: bool, arg6: u64, arg7: vector<vector<u8>>, arg8: vector<vector<u8>>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 5);
        assert!(arg1.enable, 4);
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 >= arg1.deposit.min, 9);
        let v1 = 0x2::clock::timestamp_ms(arg9);
        assert!(arg6 >= v1, 20);
        let v2 = 0x1::vector::empty<u8>();
        0x2::object::id<Vault<T0, T1>>(arg1);
        0x2::object::id<0x2::coin::Coin<T0>>(&arg2);
        0x1::vector::append<u8>(&mut v2, 0x2::bcs::to_bytes<u64>(&arg3));
        0x1::vector::append<u8>(&mut v2, 0x2::bcs::to_bytes<u64>(&arg4));
        0x1::vector::append<u8>(&mut v2, 0x2::bcs::to_bytes<bool>(&arg5));
        0x1::vector::append<u8>(&mut v2, 0x2::bcs::to_bytes<u64>(&arg6));
        0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::utils::verify_signature(get_signers(arg0), 1, v2, arg7, arg8);
        if (!arg5) {
            add_profit_with_hwm_internal<T0, T1>(arg1, arg4, arg3, arg9);
        } else {
            credit_loss_internal<T0, T1>(arg1, arg4, arg9);
        };
        let v3 = calculate_fee(v0, arg1.deposit.fee_bps);
        let v4 = v0 - v3;
        if (0x1::option::is_some<0x2::coin::Coin<T0>>(&arg1.coin_store.coin)) {
            0x2::coin::join<T0>(0x1::option::borrow_mut<0x2::coin::Coin<T0>>(&mut arg1.coin_store.coin), arg2);
        } else {
            0x1::option::fill<0x2::coin::Coin<T0>>(&mut arg1.coin_store.coin, arg2);
        };
        let v5 = v4 * 1000000 / arg1.rate;
        arg1.total_liquidity = arg1.total_liquidity + (v4 as u128);
        arg1.available_liquidity = (0x2::coin::value<T0>(0x1::option::borrow_mut<0x2::coin::Coin<T0>>(&mut arg1.coin_store.coin)) as u128);
        arg1.liquidity = arg1.liquidity + (v4 as u128);
        arg1.deposit.total_fee = arg1.deposit.total_fee + v3;
        let v6 = get_dynamic_field_or_default<T0, T1, u64>(arg1, b"hwm", (arg1.liquidity as u64)) + v4;
        set_dynamic_field<T0, T1, u64>(arg1, b"hwm", v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg2, v3, arg10), arg1.fee_receiver);
        0x2::coin::mint_and_transfer<T1>(&mut arg1.treasury_cap, v5, 0x2::tx_context::sender(arg10), arg10);
        let v7 = DepositWithSigEvent{
            sender   : 0x2::tx_context::sender(arg10),
            amount   : v0,
            lp       : v5,
            vault_id : 0x2::object::id<Vault<T0, T1>>(arg1),
            fee      : v3,
            hwm      : arg3,
            profit   : arg4,
            rate     : arg1.rate,
            time     : v1,
            negative : arg5,
        };
        0x2::event::emit<DepositWithSigEvent>(v7);
    }

    fun get_dynamic_field_or_default<T0, T1, T2: copy + drop + store>(arg0: &Vault<T0, T1>, arg1: vector<u8>, arg2: T2) : T2 {
        if (0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, arg1)) {
            *0x2::dynamic_field::borrow<vector<u8>, T2>(&arg0.id, arg1)
        } else {
            arg2
        }
    }

    public fun get_est_deposit_amount<T0, T1>(arg0: &Vault<T0, T1>, arg1: u64) : (u64, u64) {
        abort 0
    }

    public fun get_est_deposit_amount_with_hwm<T0, T1>(arg0: &Vault<T0, T1>, arg1: u64, arg2: u64, arg3: u64, arg4: bool) : (u64, u64) {
        let v0 = arg1 - calculate_fee(arg1, arg0.deposit.fee_bps);
        let v1 = arg0.rate;
        let v2 = if (!arg4) {
            let v3 = get_dynamic_field_or_default<T0, T1, u64>(arg0, b"hwm", (arg0.liquidity as u64));
            let v4 = 0;
            if (arg2 > v3) {
                v4 = calculate_fee(arg2 - v3, arg0.performance_fee.fee_bps);
            };
            arg0.liquidity + ((arg3 - v4) as u128)
        } else {
            arg0.liquidity - (arg3 as u128)
        };
        let v5 = 0x2::coin::total_supply<T1>(&arg0.treasury_cap);
        if (v5 > 1000000) {
            v1 = ((v2 * (1000000 as u128) / (v5 as u128)) as u64);
        } else if (v5 == 0) {
            v1 = 1 * 1000000;
        };
        (v0, v0 * 1000000 / v1)
    }

    public fun get_est_withdraw_amount<T0, T1>(arg0: &Vault<T0, T1>, arg1: u64) : (u64, u64) {
        abort 0
    }

    public fun get_est_withdraw_amount_with_hmw<T0, T1>(arg0: &Vault<T0, T1>, arg1: u64, arg2: u64, arg3: u64, arg4: bool) : (u64, u64) {
        let v0 = arg0.rate;
        let v1 = if (!arg4) {
            let v2 = get_dynamic_field_or_default<T0, T1, u64>(arg0, b"hwm", (arg0.liquidity as u64));
            let v3 = 0;
            if (arg2 > v2) {
                v3 = calculate_fee(arg2 - v2, arg0.performance_fee.fee_bps);
            };
            arg0.liquidity + ((arg3 - v3) as u128)
        } else {
            arg0.liquidity - (arg3 as u128)
        };
        let v4 = 0x2::coin::total_supply<T1>(&arg0.treasury_cap);
        if (v4 > 1000000) {
            v0 = ((v1 * (1000000 as u128) / (v4 as u128)) as u64);
        } else if (v4 == 0) {
            v0 = 1 * 1000000;
        };
        let v5 = arg1 * v0 / 1000000;
        (v5, v5 - calculate_fee(v5, arg0.withdraw.fee_bps))
    }

    public fun get_harvest_asset_balance<T0, T1, T2>(arg0: &mut Vault<T0, T1>) : u64 {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T2>());
        if (0x2::bag::contains<0x1::ascii::String>(&arg0.harvest_assets, v0)) {
            0x2::coin::value<T2>(0x2::bag::borrow<0x1::ascii::String, 0x2::coin::Coin<T2>>(&arg0.harvest_assets, v0))
        } else {
            0
        }
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
        if (0x2::table::contains<address, vector<PendingRedeem>>(&arg0.pending_redeems, arg1)) {
            let v2 = 0x2::table::borrow<address, vector<PendingRedeem>>(&arg0.pending_redeems, arg1);
            let v3 = 0;
            let v4 = 0;
            let v5 = 0;
            while (v5 < 0x1::vector::length<PendingRedeem>(v2)) {
                let v6 = 0x1::vector::borrow<PendingRedeem>(v2, v5);
                if (v6.withdraw_time <= 0x2::clock::timestamp_ms(arg2) - arg0.lock_duration_ms) {
                    v4 = v4 + v6.amount;
                };
                v3 = v3 + v6.amount;
                v5 = v5 + 1;
            };
            (v3, v4)
        } else {
            (0, 0)
        }
    }

    public fun get_signers(arg0: &VaultConfig) : &0x2::table::Table<vector<u8>, bool> {
        assert!(0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"signers"), 19);
        &0x2::dynamic_field::borrow<vector<u8>, TableWrapper>(&arg0.id, b"signers").inner
    }

    fun has_dynamic_field<T0, T1>(arg0: &Vault<T0, T1>, arg1: vector<u8>) : bool {
        0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = VaultConfig{
            id             : 0x2::object::new(arg0),
            version        : 1,
            allowed_access : 0x1::vector::empty<0x2::object::ID>(),
            operators      : 0x2::table::new<address, 0x2::object::ID>(arg0),
        };
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<VaultConfig>(v1);
    }

    public entry fun init_vault<T0, T1>(arg0: &AdminCap, arg1: 0x2::coin::TreasuryCap<T1>, arg2: 0x2::coin::DenyCapV2<T1>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = PerformanceFee{
            id                       : 0x2::object::new(arg3),
            fee_bps                  : 0,
            total_fee                : 0,
            total_claimed_fee        : 0,
            total_available_fee      : 0,
            total_pending_redeem_fee : 0,
        };
        let v1 = ManagementFee{
            id                       : 0x2::object::new(arg3),
            fee_bps                  : 50,
            total_fee                : 0,
            total_claimed_fee        : 0,
            total_pending_redeem_fee : 0,
            period_duration          : 86400000,
            latest_withdraw_time     : 0,
        };
        let v2 = CoinStore<T0>{coin: 0x1::option::none<0x2::coin::Coin<T0>>()};
        let v3 = Deposit{
            fee_bps   : 0,
            min       : 0,
            total_fee : 0,
        };
        let v4 = Withdraw{
            fee_bps   : 0,
            min       : 0,
            total_fee : 0,
        };
        let v5 = Vault<T0, T1>{
            id                  : 0x2::object::new(arg3),
            treasury_cap        : arg1,
            deny_cap            : arg2,
            coin_store          : v2,
            enable              : true,
            owner               : 0x2::tx_context::sender(arg3),
            harvest_asset_keys  : 0x1::vector::empty<0x1::ascii::String>(),
            harvest_assets      : 0x2::bag::new(arg3),
            coin_base           : 0x1::type_name::get<T0>(),
            token_type          : 0x1::type_name::get<T1>(),
            total_liquidity     : 0,
            liquidity           : 0,
            available_liquidity : 0,
            profit              : 0,
            last_update         : 0,
            lp_storage          : 0x2::vec_map::empty<0x2::object::ID, vector<0x2::object::ID>>(),
            rate                : 1 * 1000000,
            pending_redemptions : 0,
            pending_redeems     : 0x2::table::new<address, vector<PendingRedeem>>(arg3),
            lock_duration_ms    : 86400000,
            fee_receiver        : 0x2::tx_context::sender(arg3),
            deposit             : v3,
            withdraw            : v4,
            performance_fee     : v0,
            management_fee      : v1,
        };
        let v6 = CreatedVaultEvent{id: 0x2::object::id<Vault<T0, T1>>(&v5)};
        0x2::event::emit<CreatedVaultEvent>(v6);
        0x2::transfer::share_object<Vault<T0, T1>>(v5);
    }

    public fun is_enable<T0, T1>(arg0: &Vault<T0, T1>) : bool {
        arg0.enable
    }

    entry fun migrate(arg0: &AdminCap, arg1: &mut VaultConfig, arg2: &0x2::tx_context::TxContext) {
        assert!(arg1.version < 1, 0);
        arg1.version = 1;
    }

    public entry fun pause<T0, T1>(arg0: &AdminCap, arg1: &VaultConfig, arg2: &mut Vault<T0, T1>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 1, 5);
        arg2.enable = false;
        let v0 = Pause<T0>{dummy_field: false};
        0x2::event::emit<Pause<T0>>(v0);
    }

    public entry fun redeem<T0, T1>(arg0: &mut VaultConfig, arg1: &mut Vault<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 5);
        assert!(arg1.enable, 4);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::table::contains<address, vector<PendingRedeem>>(&arg1.pending_redeems, v0), 7);
        let v1 = 0x2::table::remove<address, vector<PendingRedeem>>(&mut arg1.pending_redeems, v0);
        let v2 = 0x1::vector::empty<PendingRedeem>();
        let v3 = 0x1::vector::empty<PendingRedeem>();
        let v4 = 0;
        while (v4 < 0x1::vector::length<PendingRedeem>(&v1)) {
            let v5 = 0x1::vector::borrow<PendingRedeem>(&v1, v4);
            if (v5.withdraw_time <= 0x2::clock::timestamp_ms(arg2) - arg1.lock_duration_ms) {
                0x1::vector::push_back<PendingRedeem>(&mut v2, *v5);
            } else {
                0x1::vector::push_back<PendingRedeem>(&mut v3, *v5);
            };
            v4 = v4 + 1;
        };
        if (0x1::vector::length<PendingRedeem>(&v3) > 0) {
            0x2::table::add<address, vector<PendingRedeem>>(&mut arg1.pending_redeems, v0, v3);
        };
        let v6 = 0x1::vector::length<PendingRedeem>(&v2);
        assert!(v6 > 0, 7);
        let v7 = 0;
        let v8 = 0;
        while (v8 < v6) {
            v7 = v7 + 0x1::vector::borrow<PendingRedeem>(&v2, v8).amount;
            v8 = v8 + 1;
        };
        assert!(arg1.available_liquidity >= (v7 as u128), 2);
        arg1.available_liquidity = arg1.available_liquidity - (v7 as u128);
        arg1.pending_redemptions = arg1.pending_redemptions - (v7 as u128);
        let v9 = 0x1::option::borrow_mut<0x2::coin::Coin<T0>>(&mut arg1.coin_store.coin);
        assert!(0x2::coin::value<T0>(v9) >= v7, 2);
        let v10 = 0x2::coin::split<T0>(v9, v7, arg3);
        let v11 = calculate_fee(v7, arg1.withdraw.fee_bps);
        arg1.withdraw.total_fee = arg1.withdraw.total_fee + v11;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v10, v11, arg3), arg1.fee_receiver);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v10, v0);
        let v12 = RedeemEvent{
            receiver : v0,
            amount   : v7,
            vault_id : 0x2::object::id<Vault<T0, T1>>(arg1),
            fee      : v11,
        };
        0x2::event::emit<RedeemEvent>(v12);
    }

    public entry fun redeem_fee<T0, T1>(arg0: &OperatorCap, arg1: &mut VaultConfig, arg2: &mut Vault<T0, T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 1, 5);
        assert!(check_operator(arg1, 0x2::tx_context::sender(arg4), 0x2::object::id<OperatorCap>(arg0)), 1);
        let v0 = 0x2::object::id_address<Vault<T0, T1>>(arg2);
        assert!(0x2::table::contains<address, vector<PendingRedeem>>(&arg2.pending_redeems, v0), 7);
        let v1 = 0x2::table::remove<address, vector<PendingRedeem>>(&mut arg2.pending_redeems, v0);
        let v2 = 0x1::vector::empty<PendingRedeem>();
        let v3 = 0x1::vector::empty<PendingRedeem>();
        let v4 = 0;
        while (v4 < 0x1::vector::length<PendingRedeem>(&v1)) {
            let v5 = 0x1::vector::borrow<PendingRedeem>(&v1, v4);
            if (v5.withdraw_time <= 0x2::clock::timestamp_ms(arg3) - arg2.lock_duration_ms) {
                0x1::vector::push_back<PendingRedeem>(&mut v2, *v5);
            } else {
                0x1::vector::push_back<PendingRedeem>(&mut v3, *v5);
            };
            v4 = v4 + 1;
        };
        if (0x1::vector::length<PendingRedeem>(&v3) > 0) {
            0x2::table::add<address, vector<PendingRedeem>>(&mut arg2.pending_redeems, v0, v3);
        };
        let v6 = 0x1::vector::length<PendingRedeem>(&v2);
        assert!(v6 > 0, 7);
        let v7 = 0;
        let v8 = 0;
        while (v8 < v6) {
            v7 = v7 + 0x1::vector::borrow<PendingRedeem>(&v2, v8).amount;
            v8 = v8 + 1;
        };
        assert!(arg2.available_liquidity >= (v7 as u128), 2);
        arg2.available_liquidity = arg2.available_liquidity - (v7 as u128);
        arg2.pending_redemptions = arg2.pending_redemptions - (v7 as u128);
        assert!(0x2::coin::value<T0>(0x1::option::borrow_mut<0x2::coin::Coin<T0>>(&mut arg2.coin_store.coin)) >= v7, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(0x1::option::borrow_mut<0x2::coin::Coin<T0>>(&mut arg2.coin_store.coin), v7, arg4), arg2.fee_receiver);
        let v9 = RedeemFeeEvent{
            receiver : arg2.fee_receiver,
            amount   : v7,
            vault_id : 0x2::object::id<Vault<T0, T1>>(arg2),
        };
        0x2::event::emit<RedeemFeeEvent>(v9);
    }

    public entry fun redeem_management_fee<T0, T1>(arg0: &OperatorCap, arg1: &mut VaultConfig, arg2: &mut Vault<T0, T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun redeem_performance_fee<T0, T1>(arg0: &OperatorCap, arg1: &mut VaultConfig, arg2: &mut Vault<T0, T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun remove_operator(arg0: &AdminCap, arg1: &mut VaultConfig, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 1, 5);
        assert!(0x2::table::contains<address, 0x2::object::ID>(&arg1.operators, arg2), 11);
        0x2::table::remove<address, 0x2::object::ID>(&mut arg1.operators, arg2);
        let v0 = RemoveOperatorEvent{operator: arg2};
        0x2::event::emit<RemoveOperatorEvent>(v0);
    }

    public entry fun remove_signer(arg0: &AdminCap, arg1: &mut VaultConfig, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 1, 5);
        assert!(0x2::dynamic_field::exists_<vector<u8>>(&arg1.id, b"signers"), 19);
        let v0 = &mut 0x2::dynamic_field::borrow_mut<vector<u8>, TableWrapper>(&mut arg1.id, b"signers").inner;
        assert!(0x2::table::contains<vector<u8>, bool>(v0, arg2), 19);
        0x2::table::remove<vector<u8>, bool>(v0, arg2);
        let v1 = RemoveSignerEvent{signer: arg2};
        0x2::event::emit<RemoveSignerEvent>(v1);
    }

    public entry fun resume<T0, T1>(arg0: &AdminCap, arg1: &VaultConfig, arg2: &mut Vault<T0, T1>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 1, 5);
        arg2.enable = true;
        let v0 = Resume<T0>{dummy_field: false};
        0x2::event::emit<Resume<T0>>(v0);
    }

    fun set_dynamic_field<T0, T1, T2: copy + drop + store>(arg0: &mut Vault<T0, T1>, arg1: vector<u8>, arg2: T2) {
        if (0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, arg1)) {
            *0x2::dynamic_field::borrow_mut<vector<u8>, T2>(&mut arg0.id, arg1) = arg2;
        } else {
            0x2::dynamic_field::add<vector<u8>, T2>(&mut arg0.id, arg1, arg2);
        };
    }

    public fun spend_harvest_asset<T0, T1, T2>(arg0: &mut VaultConfig, arg1: &mut Vault<T0, T1>, arg2: u64, arg3: &AccessCap, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        assert!(check_access_cap(arg0, 0x2::object::id<AccessCap>(arg3)), 1);
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T2>());
        assert!(0x2::bag::contains<0x1::ascii::String>(&arg1.harvest_assets, v0), 2);
        let v1 = 0x2::bag::borrow_mut<0x1::ascii::String, 0x2::coin::Coin<T2>>(&mut arg1.harvest_assets, v0);
        assert!(0x2::coin::value<T2>(v1) >= arg2, 2);
        0x2::coin::split<T2>(v1, arg2, arg4)
    }

    public fun spend_vault_funds<T0, T1>(arg0: &mut VaultConfig, arg1: &mut Vault<T0, T1>, arg2: u64, arg3: &AccessCap, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(check_access_cap(arg0, 0x2::object::id<AccessCap>(arg3)), 1);
        assert!(0x1::option::is_some<0x2::coin::Coin<T0>>(&arg1.coin_store.coin), 2);
        let v0 = 0x1::option::borrow_mut<0x2::coin::Coin<T0>>(&mut arg1.coin_store.coin);
        assert!(0x2::coin::value<T0>(v0) >= arg2, 2);
        arg1.available_liquidity = arg1.available_liquidity - (arg2 as u128);
        0x2::coin::split<T0>(v0, arg2, arg4)
    }

    public entry fun update_deposit_fee<T0, T1>(arg0: &AdminCap, arg1: &mut VaultConfig, arg2: &mut Vault<T0, T1>, arg3: u64) {
        assert!(arg1.version == 1, 5);
        arg2.deposit.fee_bps = arg3;
        let v0 = UpdateDepositFeeEvent{
            vault_id : 0x2::object::id<Vault<T0, T1>>(arg2),
            fee_bps  : arg3,
        };
        0x2::event::emit<UpdateDepositFeeEvent>(v0);
    }

    public entry fun update_fee_receiver<T0, T1>(arg0: &AdminCap, arg1: &mut VaultConfig, arg2: &mut Vault<T0, T1>, arg3: address) {
        assert!(arg1.version == 1, 5);
        arg2.fee_receiver = arg3;
        let v0 = UpdateFeeReceiverEvent{
            vault_id : 0x2::object::id<Vault<T0, T1>>(arg2),
            address  : arg3,
        };
        0x2::event::emit<UpdateFeeReceiverEvent>(v0);
    }

    public entry fun update_lock_duration<T0, T1>(arg0: &AdminCap, arg1: &mut VaultConfig, arg2: &mut Vault<T0, T1>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 1, 5);
        arg2.lock_duration_ms = arg3;
        let v0 = UpdateLockDurationEvent{
            vault_id         : 0x2::object::id<Vault<T0, T1>>(arg2),
            lock_duration_ms : arg3,
        };
        0x2::event::emit<UpdateLockDurationEvent>(v0);
    }

    public entry fun update_management_fee<T0, T1>(arg0: &AdminCap, arg1: &mut VaultConfig, arg2: &mut Vault<T0, T1>, arg3: u64) {
        assert!(arg1.version == 1, 5);
        arg2.management_fee.fee_bps = arg3;
        let v0 = UpdateManagementFeeEvent{
            vault_id : 0x2::object::id<Vault<T0, T1>>(arg2),
            fee_bps  : arg3,
        };
        0x2::event::emit<UpdateManagementFeeEvent>(v0);
    }

    public entry fun update_management_fee_period_duration<T0, T1>(arg0: &AdminCap, arg1: &mut VaultConfig, arg2: &mut Vault<T0, T1>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 1, 5);
        arg2.management_fee.period_duration = arg3;
        let v0 = UpdateManagementPeriodDurationEvent{
            vault_id        : 0x2::object::id<Vault<T0, T1>>(arg2),
            period_duration : arg3,
        };
        0x2::event::emit<UpdateManagementPeriodDurationEvent>(v0);
    }

    public entry fun update_min_deposit<T0, T1>(arg0: &AdminCap, arg1: &mut VaultConfig, arg2: &mut Vault<T0, T1>, arg3: u64) {
        assert!(arg1.version == 1, 5);
        arg2.deposit.min = arg3;
        let v0 = UpdateMinDepositEvent{
            vault_id : 0x2::object::id<Vault<T0, T1>>(arg2),
            min      : arg3,
        };
        0x2::event::emit<UpdateMinDepositEvent>(v0);
    }

    public entry fun update_min_withdraw<T0, T1>(arg0: &AdminCap, arg1: &mut VaultConfig, arg2: &mut Vault<T0, T1>, arg3: u64) {
        assert!(arg1.version == 1, 5);
        arg2.withdraw.min = arg3;
        let v0 = UpdateMinWithdrawEvent{
            vault_id : 0x2::object::id<Vault<T0, T1>>(arg2),
            min      : arg3,
        };
        0x2::event::emit<UpdateMinWithdrawEvent>(v0);
    }

    public entry fun update_performance_fee<T0, T1>(arg0: &AdminCap, arg1: &mut VaultConfig, arg2: &mut Vault<T0, T1>, arg3: u64) {
        assert!(arg1.version == 1, 5);
        arg2.performance_fee.fee_bps = arg3;
        let v0 = UpdatePerformanceFeeEvent{
            vault_id : 0x2::object::id<Vault<T0, T1>>(arg2),
            fee_bps  : arg3,
        };
        0x2::event::emit<UpdatePerformanceFeeEvent>(v0);
    }

    public entry fun update_withdraw_fee<T0, T1>(arg0: &AdminCap, arg1: &mut VaultConfig, arg2: &mut Vault<T0, T1>, arg3: u64) {
        assert!(arg1.version == 1, 5);
        arg2.withdraw.fee_bps = arg3;
        let v0 = UpdateWithdrawFeeEvent{
            vault_id : 0x2::object::id<Vault<T0, T1>>(arg2),
            fee_bps  : arg3,
        };
        0x2::event::emit<UpdateWithdrawFeeEvent>(v0);
    }

    public entry fun withdraw<T0, T1>(arg0: &mut VaultConfig, arg1: &mut Vault<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 5);
        assert!(arg1.enable, 4);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = 0x2::tx_context::sender(arg4);
        let v2 = 0x2::coin::value<T1>(&arg2);
        assert!(v2 > 0, 6);
        assert!(v2 >= arg1.withdraw.min, 9);
        let v3 = v2 * arg1.rate / 1000000;
        let v4 = PendingRedeem{
            withdraw_time : v0,
            amount        : v3,
        };
        if (0x2::table::contains<address, vector<PendingRedeem>>(&arg1.pending_redeems, v1)) {
            0x1::vector::push_back<PendingRedeem>(0x2::table::borrow_mut<address, vector<PendingRedeem>>(&mut arg1.pending_redeems, v1), v4);
        } else {
            let v5 = 0x1::vector::empty<PendingRedeem>();
            0x1::vector::push_back<PendingRedeem>(&mut v5, v4);
            0x2::table::add<address, vector<PendingRedeem>>(&mut arg1.pending_redeems, v1, v5);
        };
        arg1.liquidity = arg1.liquidity - (v3 as u128);
        arg1.pending_redemptions = arg1.pending_redemptions + (v3 as u128);
        0x2::coin::burn<T1>(&mut arg1.treasury_cap, arg2);
        let v6 = WithdrawEvent{
            user     : v1,
            lp       : v2,
            amount   : v3,
            vault_id : 0x2::object::id<Vault<T0, T1>>(arg1),
            time     : v0,
        };
        0x2::event::emit<WithdrawEvent>(v6);
    }

    public entry fun withdraw_fee<T0, T1>(arg0: &OperatorCap, arg1: &mut VaultConfig, arg2: &mut Vault<T0, T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 1, 5);
        assert!(check_operator(arg1, 0x2::tx_context::sender(arg5), 0x2::object::id<OperatorCap>(arg0)), 1);
        withdraw_fee_internal<T0, T1>(arg2, arg3, arg4);
    }

    fun withdraw_fee_internal<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(arg1 > 0, 15);
        let v1 = arg1;
        let v2 = get_dynamic_field_or_default<T0, T1, u64>(arg0, b"pending_fee", 0);
        if (arg1 > v2) {
            v1 = v2;
        };
        let v3 = 0x2::object::id_address<Vault<T0, T1>>(arg0);
        let v4 = PendingRedeem{
            withdraw_time : v0,
            amount        : v1,
        };
        if (0x2::table::contains<address, vector<PendingRedeem>>(&arg0.pending_redeems, v3)) {
            0x1::vector::push_back<PendingRedeem>(0x2::table::borrow_mut<address, vector<PendingRedeem>>(&mut arg0.pending_redeems, v3), v4);
        } else {
            let v5 = 0x1::vector::empty<PendingRedeem>();
            0x1::vector::push_back<PendingRedeem>(&mut v5, v4);
            0x2::table::add<address, vector<PendingRedeem>>(&mut arg0.pending_redeems, v3, v5);
        };
        arg0.pending_redemptions = arg0.pending_redemptions + (v1 as u128);
        set_dynamic_field<T0, T1, u64>(arg0, b"pending_fee", v2 - v1);
        let v6 = WithdrawFeeEvent{
            amount   : arg1,
            vault_id : 0x2::object::id<Vault<T0, T1>>(arg0),
            time     : v0,
        };
        0x2::event::emit<WithdrawFeeEvent>(v6);
    }

    public fun withdraw_lp<T0, T1>(arg0: &VaultConfig, arg1: &mut Vault<T0, T1>, arg2: 0x2::object::ID, arg3: &AccessCap) : 0x2::object::ID {
        assert!(check_access_cap(arg0, 0x2::object::id<AccessCap>(arg3)), 1);
        let v0 = 0x2::vec_map::get_mut<0x2::object::ID, vector<0x2::object::ID>>(&mut arg1.lp_storage, &arg2);
        assert!(0x1::vector::length<0x2::object::ID>(v0) > 0, 3);
        0x1::vector::pop_back<0x2::object::ID>(v0)
    }

    public fun withdraw_lp_by_id<T0, T1>(arg0: &VaultConfig, arg1: &mut Vault<T0, T1>, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: &AccessCap) : 0x2::object::ID {
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
        assert!(v2, 3);
        0x1::vector::swap_remove<0x2::object::ID>(v0, v1);
        arg3
    }

    public entry fun withdraw_management_fee<T0, T1>(arg0: &OperatorCap, arg1: &mut VaultConfig, arg2: &mut Vault<T0, T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun withdraw_performance_fee<T0, T1>(arg0: &OperatorCap, arg1: &mut VaultConfig, arg2: &mut Vault<T0, T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun withdraw_with_sigs<T0, T1>(arg0: &mut VaultConfig, arg1: &mut Vault<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: u64, arg5: bool, arg6: u64, arg7: vector<vector<u8>>, arg8: vector<vector<u8>>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 5);
        assert!(arg1.enable, 4);
        let v0 = 0x2::clock::timestamp_ms(arg9);
        let v1 = 0x2::tx_context::sender(arg10);
        let v2 = 0x2::coin::value<T1>(&arg2);
        assert!(v2 > 0, 6);
        assert!(v2 >= arg1.withdraw.min, 9);
        let v3 = 0x1::vector::empty<u8>();
        let v4 = 0x2::object::id<Vault<T0, T1>>(arg1);
        let v5 = 0x2::object::id<0x2::coin::Coin<T1>>(&arg2);
        0x1::vector::append<u8>(&mut v3, 0x2::bcs::to_bytes<0x2::object::ID>(&v4));
        0x1::vector::append<u8>(&mut v3, 0x2::bcs::to_bytes<0x2::object::ID>(&v5));
        0x1::vector::append<u8>(&mut v3, 0x2::bcs::to_bytes<u64>(&arg3));
        0x1::vector::append<u8>(&mut v3, 0x2::bcs::to_bytes<u64>(&arg4));
        0x1::vector::append<u8>(&mut v3, 0x2::bcs::to_bytes<bool>(&arg5));
        0x1::vector::append<u8>(&mut v3, 0x2::bcs::to_bytes<u64>(&arg6));
        0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::utils::verify_signature(get_signers(arg0), 1, v3, arg7, arg8);
        if (!arg5) {
            add_profit_with_hwm_internal<T0, T1>(arg1, arg4, arg3, arg9);
        } else {
            credit_loss_internal<T0, T1>(arg1, arg4, arg9);
        };
        let v6 = v2 * arg1.rate / 1000000;
        let v7 = 0;
        let v8 = false;
        if (arg1.lock_duration_ms == 0 && (v6 as u128) <= arg1.available_liquidity) {
            let v9 = 0x1::option::borrow_mut<0x2::coin::Coin<T0>>(&mut arg1.coin_store.coin);
            assert!(0x2::coin::value<T0>(v9) >= v6, 2);
            let v10 = 0x2::coin::split<T0>(v9, v6, arg10);
            let v11 = calculate_fee(v6, arg1.withdraw.fee_bps);
            v7 = v11;
            arg1.withdraw.total_fee = arg1.withdraw.total_fee + v11;
            arg1.available_liquidity = arg1.available_liquidity - (v6 as u128);
            v8 = true;
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v10, v11, arg10), arg1.fee_receiver);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v10, v1);
        } else {
            let v12 = PendingRedeem{
                withdraw_time : v0,
                amount        : v6,
            };
            if (0x2::table::contains<address, vector<PendingRedeem>>(&arg1.pending_redeems, v1)) {
                0x1::vector::push_back<PendingRedeem>(0x2::table::borrow_mut<address, vector<PendingRedeem>>(&mut arg1.pending_redeems, v1), v12);
            } else {
                let v13 = 0x1::vector::empty<PendingRedeem>();
                0x1::vector::push_back<PendingRedeem>(&mut v13, v12);
                0x2::table::add<address, vector<PendingRedeem>>(&mut arg1.pending_redeems, v1, v13);
            };
        };
        arg1.liquidity = arg1.liquidity - (v6 as u128);
        arg1.pending_redemptions = arg1.pending_redemptions + (v6 as u128);
        let v14 = get_dynamic_field_or_default<T0, T1, u64>(arg1, b"hwm", (arg1.liquidity as u64));
        let v15 = if (v14 >= v6) {
            v14 - v6
        } else {
            0
        };
        set_dynamic_field<T0, T1, u64>(arg1, b"hwm", v15);
        0x2::coin::burn<T1>(&mut arg1.treasury_cap, arg2);
        let v16 = WithdrawWithSigEvent{
            user     : v1,
            lp       : v2,
            amount   : v6,
            vault_id : 0x2::object::id<Vault<T0, T1>>(arg1),
            hwm      : arg3,
            profit   : arg4,
            rate     : arg1.rate,
            fee      : v7,
            paid     : v8,
            time     : v0,
            negative : arg5,
        };
        0x2::event::emit<WithdrawWithSigEvent>(v16);
    }

    // decompiled from Move bytecode v6
}

