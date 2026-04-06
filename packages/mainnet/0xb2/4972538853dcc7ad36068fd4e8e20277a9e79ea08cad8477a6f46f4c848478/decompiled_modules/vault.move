module 0xb24972538853dcc7ad36068fd4e8e20277a9e79ea08cad8477a6f46f4c848478::vault {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct BorrowReceipt<phantom T0> {
        vault_id: 0x2::object::ID,
        borrowed_amount: u64,
    }

    struct YieldPromise<phantom T0> {
        vault_id: 0x2::object::ID,
        expected_amount: u64,
        yield_type: 0x1::type_name::TypeName,
    }

    struct ProtocolAccessCap has store, key {
        id: 0x2::object::UID,
    }

    struct Vault<phantom T0> has key {
        id: 0x2::object::UID,
        idle_balance: 0x2::balance::Balance<T0>,
        invested_assets: 0x2::bag::Bag,
        total_receipts: u64,
        current_strategy: u8,
        last_heartbeat_tvl: u64,
        last_deployed_amount: u64,
        last_heartbeat_ms: u64,
        max_tvl_cap: u64,
        performance_fee_bps: u64,
        fee_recipient: address,
        treasury_cap: 0xd32c31d0e1e5d5ab839f68a192a8bcf196cf200536fe0ecede3be100cab721f8::receipt::ReceiptTreasuryCap,
    }

    struct DepositEvent has copy, drop {
        user: address,
        usdc_amount: u64,
        receipts_minted: u64,
    }

    struct WithdrawEvent has copy, drop {
        user: address,
        receipts_burned: u64,
        usdc_returned: u64,
    }

    struct RerouteEvent has copy, drop {
        from_strategy: u8,
        to_strategy: u8,
    }

    struct HeartbeatStaleEvent has copy, drop {
        last_heartbeat_ms: u64,
        age_ms: u64,
    }

    struct HeartbeatTvlEvent has copy, drop {
        tvl: u64,
    }

    struct DepegStatusEvent has copy, drop {
        active: bool,
    }

    struct TvlCapUpdatedEvent has copy, drop {
        old_cap: u64,
        new_cap: u64,
    }

    struct FeeRecipientUpdatedEvent has copy, drop {
        old_recipient: address,
        new_recipient: address,
    }

    struct USDC has drop {
        dummy_field: bool,
    }

    public fun borrow_all_for_strategy<T0>(arg0: &mut Vault<T0>, arg1: &ProtocolAccessCap) : (0x2::balance::Balance<T0>, BorrowReceipt<T0>) {
        let v0 = BorrowReceipt<T0>{
            vault_id        : 0x2::object::id<Vault<T0>>(arg0),
            borrowed_amount : 0x2::balance::value<T0>(&arg0.idle_balance),
        };
        (0x2::balance::withdraw_all<T0>(&mut arg0.idle_balance), v0)
    }

    public(friend) fun borrow_idle_balance_mut<T0>(arg0: &mut Vault<T0>) : &mut 0x2::balance::Balance<T0> {
        &mut arg0.idle_balance
    }

    public fun borrow_protocol_cap<T0, T1: store + key>(arg0: &Vault<T0>, arg1: &ProtocolAccessCap, arg2: vector<u8>) : &T1 {
        0x2::dynamic_field::borrow<0x1::string::String, T1>(&arg0.id, 0x1::string::utf8(arg2))
    }

    public fun borrow_protocol_cap_mut<T0, T1: store + key>(arg0: &mut Vault<T0>, arg1: &ProtocolAccessCap, arg2: vector<u8>) : &mut T1 {
        0x2::dynamic_field::borrow_mut<0x1::string::String, T1>(&mut arg0.id, 0x1::string::utf8(arg2))
    }

    public fun borrow_treasury_ref<T0>(arg0: &Vault<T0>) : &0xd32c31d0e1e5d5ab839f68a192a8bcf196cf200536fe0ecede3be100cab721f8::receipt::ReceiptTreasuryCap {
        &arg0.treasury_cap
    }

    public fun burn_admin_cap(arg0: AdminCap) {
        let AdminCap { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    fun calculate_shares_and_validate<T0>(arg0: &Vault<T0>, arg1: u64, arg2: &0x2::clock::Clock) : (u64, u64) {
        if (arg0.current_strategy != 0 && arg0.last_heartbeat_ms > 0) {
            0xb24972538853dcc7ad36068fd4e8e20277a9e79ea08cad8477a6f46f4c848478::floors::assert_heartbeat_age(0x2::clock::timestamp_ms(arg2) - arg0.last_heartbeat_ms);
        };
        assert!(arg1 > 0, 200);
        let v0 = 0x2::balance::value<T0>(&arg0.idle_balance) + arg0.last_deployed_amount;
        assert!(v0 + arg1 <= arg0.max_tvl_cap, 205);
        let v1 = if (arg0.total_receipts == 0) {
            arg1
        } else {
            assert!(v0 > 0, 212);
            (((arg1 as u128) * ((arg0.total_receipts as u128) + 1000000) / ((v0 as u128) + 1000000)) as u64)
        };
        assert!(v1 > 0, 200);
        (arg1, v1)
    }

    public fun commit_strategy<T0, T1>(arg0: &mut Vault<T0>, arg1: &ProtocolAccessCap, arg2: BorrowReceipt<T0>, arg3: 0x2::balance::Balance<T1>, arg4: u8, arg5: u64) {
        assert!(0x2::object::id<Vault<T0>>(arg0) == arg2.vault_id, 201);
        assert!(arg4 != 0, 202);
        let v0 = arg2.borrowed_amount;
        if (v0 > 0) {
            assert!(arg5 >= v0 - v0 * 0xb24972538853dcc7ad36068fd4e8e20277a9e79ea08cad8477a6f46f4c848478::floors::max_slippage_ceil() / 10000, 207);
        };
        let v1 = 0x1::type_name::with_defining_ids<T1>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.invested_assets, v1)) {
            0x2::balance::join<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.invested_assets, v1), arg3);
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.invested_assets, v1, arg3);
        };
        arg0.current_strategy = arg4;
        arg0.last_deployed_amount = arg2.borrowed_amount;
        let v2 = RerouteEvent{
            from_strategy : 0,
            to_strategy   : arg4,
        };
        0x2::event::emit<RerouteEvent>(v2);
        let BorrowReceipt {
            vault_id        : _,
            borrowed_amount : _,
        } = arg2;
    }

    public fun commit_unwind<T0>(arg0: &mut Vault<T0>, arg1: &ProtocolAccessCap, arg2: YieldPromise<T0>, arg3: 0x2::coin::Coin<T0>, arg4: u64) {
        let YieldPromise {
            vault_id        : v0,
            expected_amount : v1,
            yield_type      : _,
        } = arg2;
        assert!(0x2::object::id<Vault<T0>>(arg0) == v0, 215);
        let v3 = if (is_depeg_active<T0>(arg0)) {
            0xb24972538853dcc7ad36068fd4e8e20277a9e79ea08cad8477a6f46f4c848478::floors::max_emergency_slippage_ceil()
        } else {
            0xb24972538853dcc7ad36068fd4e8e20277a9e79ea08cad8477a6f46f4c848478::floors::max_slippage_ceil()
        };
        if (arg4 > 0) {
            let v4 = arg4 * v3 / 10000;
            let v5 = if (arg4 > v4) {
                arg4 - v4
            } else {
                0
            };
            assert!(0x2::coin::value<T0>(&arg3) >= v5, 207);
        };
        0x2::balance::join<T0>(&mut arg0.idle_balance, 0x2::coin::into_balance<T0>(arg3));
        let v6 = if (arg0.last_deployed_amount > v1) {
            arg0.last_deployed_amount - v1
        } else {
            0
        };
        arg0.last_deployed_amount = v6;
        if (arg0.last_deployed_amount == 0) {
            arg0.current_strategy = 0;
        };
    }

    public fun create_protocol_access_cap<T0>(arg0: &Vault<T0>, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) : ProtocolAccessCap {
        ProtocolAccessCap{id: 0x2::object::new(arg2)}
    }

    public fun create_vault<T0>(arg0: 0xd32c31d0e1e5d5ab839f68a192a8bcf196cf200536fe0ecede3be100cab721f8::receipt::ReceiptTreasuryCap, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Vault<T0>{
            id                   : 0x2::object::new(arg3),
            idle_balance         : 0x2::balance::zero<T0>(),
            invested_assets      : 0x2::bag::new(arg3),
            total_receipts       : 0,
            current_strategy     : 0,
            last_heartbeat_tvl   : 0,
            last_deployed_amount : 0,
            last_heartbeat_ms    : 0,
            max_tvl_cap          : arg2,
            performance_fee_bps  : 0,
            fee_recipient        : arg1,
            treasury_cap         : arg0,
        };
        0x2::transfer::share_object<Vault<T0>>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg3)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg3));
    }

    public fun current_strategy<T0>(arg0: &Vault<T0>) : u8 {
        arg0.current_strategy
    }

    public fun deposit_balance_to_idle<T0>(arg0: &mut Vault<T0>, arg1: &ProtocolAccessCap, arg2: 0x2::balance::Balance<T0>) {
        0x2::balance::join<T0>(&mut arg0.idle_balance, arg2);
    }

    public fun deposit_existing<T0>(arg0: &mut Vault<T0>, arg1: &mut 0xd32c31d0e1e5d5ab839f68a192a8bcf196cf200536fe0ecede3be100cab721f8::receipt::AqReceipt, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xd32c31d0e1e5d5ab839f68a192a8bcf196cf200536fe0ecede3be100cab721f8::receipt::locked_until_epoch(arg1);
        assert!(v0 == 0 || 0x2::tx_context::epoch(arg4) > v0, 214);
        let (v1, v2) = calculate_shares_and_validate<T0>(arg0, 0x2::coin::value<T0>(&arg2), arg3);
        0x2::coin::put<T0>(&mut arg0.idle_balance, arg2);
        arg0.total_receipts = arg0.total_receipts + v2;
        let v3 = DepositEvent{
            user            : 0x2::tx_context::sender(arg4),
            usdc_amount     : v1,
            receipts_minted : v2,
        };
        0x2::event::emit<DepositEvent>(v3);
        0xd32c31d0e1e5d5ab839f68a192a8bcf196cf200536fe0ecede3be100cab721f8::receipt::augment_receipt(&arg0.treasury_cap, arg1, v2, arg4);
    }

    public fun deposit_new<T0>(arg0: &mut Vault<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0xd32c31d0e1e5d5ab839f68a192a8bcf196cf200536fe0ecede3be100cab721f8::receipt::AqReceipt {
        let (v0, v1) = calculate_shares_and_validate<T0>(arg0, 0x2::coin::value<T0>(&arg1), arg2);
        0x2::coin::put<T0>(&mut arg0.idle_balance, arg1);
        arg0.total_receipts = arg0.total_receipts + v1;
        let v2 = DepositEvent{
            user            : 0x2::tx_context::sender(arg3),
            usdc_amount     : v0,
            receipts_minted : v1,
        };
        0x2::event::emit<DepositEvent>(v2);
        0xd32c31d0e1e5d5ab839f68a192a8bcf196cf200536fe0ecede3be100cab721f8::receipt::mint_receipt(&arg0.treasury_cap, v1, arg3)
    }

    public fun emergency_write_down_deployed_amount<T0>(arg0: &mut Vault<T0>, arg1: &ProtocolAccessCap, arg2: u64) {
        arg0.last_deployed_amount = arg2;
    }

    public fun extract_yield_balance<T0, T1>(arg0: &mut Vault<T0>, arg1: &ProtocolAccessCap) : 0x2::balance::Balance<T1> {
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.invested_assets, v0)) {
            0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.invested_assets, v0)
        } else {
            0x2::balance::zero<T1>()
        }
    }

    public fun fee_recipient<T0>(arg0: &Vault<T0>) : address {
        arg0.fee_recipient
    }

    public fun idle_balance<T0>(arg0: &Vault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.idle_balance)
    }

    public fun is_auto_paused<T0>(arg0: &Vault<T0>, arg1: &0x2::clock::Clock) : bool {
        is_heartbeat_stale<T0>(arg0, arg1)
    }

    public fun is_depeg_active<T0>(arg0: &Vault<T0>) : bool {
        let v0 = 0x1::string::utf8(b"depeg_active");
        if (!0x2::dynamic_field::exists_<0x1::string::String>(&arg0.id, v0)) {
            return false
        };
        *0x2::dynamic_field::borrow<0x1::string::String, bool>(&arg0.id, v0)
    }

    public fun is_heartbeat_stale<T0>(arg0: &Vault<T0>, arg1: &0x2::clock::Clock) : bool {
        if (arg0.current_strategy == 0 || arg0.last_heartbeat_ms == 0) {
            return false
        };
        0x2::clock::timestamp_ms(arg1) - arg0.last_heartbeat_ms > 0xb24972538853dcc7ad36068fd4e8e20277a9e79ea08cad8477a6f46f4c848478::floors::max_heartbeat_age_ms()
    }

    public fun issue_yield_promise<T0, T1>(arg0: &Vault<T0>, arg1: &ProtocolAccessCap, arg2: u64) : YieldPromise<T0> {
        YieldPromise<T0>{
            vault_id        : 0x2::object::id<Vault<T0>>(arg0),
            expected_amount : arg2,
            yield_type      : 0x1::type_name::get<T1>(),
        }
    }

    public fun last_deployed_amount<T0>(arg0: &Vault<T0>) : u64 {
        arg0.last_deployed_amount
    }

    public fun last_heartbeat_tvl<T0>(arg0: &Vault<T0>) : u64 {
        arg0.last_heartbeat_tvl
    }

    public fun max_tvl_cap<T0>(arg0: &Vault<T0>) : u64 {
        arg0.max_tvl_cap
    }

    public fun performance_fee_bps<T0>(arg0: &Vault<T0>) : u64 {
        arg0.performance_fee_bps
    }

    public fun promise_expected<T0>(arg0: &YieldPromise<T0>) : u64 {
        arg0.expected_amount
    }

    public fun promise_type<T0>(arg0: &YieldPromise<T0>) : 0x1::type_name::TypeName {
        arg0.yield_type
    }

    public fun repay_withdraw<T0>(arg0: &mut Vault<T0>, arg1: &ProtocolAccessCap, arg2: BorrowReceipt<T0>, arg3: 0x2::coin::Coin<T0>) {
        let BorrowReceipt {
            vault_id        : v0,
            borrowed_amount : v1,
        } = arg2;
        assert!(0x2::object::id<Vault<T0>>(arg0) == v0, 215);
        assert!(0x2::coin::value<T0>(&arg3) == v1, 216);
        0x2::balance::join<T0>(&mut arg0.idle_balance, 0x2::coin::into_balance<T0>(arg3));
    }

    public fun set_depeg_status<T0>(arg0: &mut Vault<T0>, arg1: &ProtocolAccessCap, arg2: bool) {
        let v0 = 0x1::string::utf8(b"depeg_active");
        if (0x2::dynamic_field::exists_<0x1::string::String>(&arg0.id, v0)) {
            *0x2::dynamic_field::borrow_mut<0x1::string::String, bool>(&mut arg0.id, v0) = arg2;
        } else {
            0x2::dynamic_field::add<0x1::string::String, bool>(&mut arg0.id, v0, arg2);
        };
        let v1 = DepegStatusEvent{active: arg2};
        0x2::event::emit<DepegStatusEvent>(v1);
    }

    public fun store_protocol_cap<T0, T1: store + key>(arg0: &mut Vault<T0>, arg1: &AdminCap, arg2: vector<u8>, arg3: T1) {
        0x2::dynamic_field::add<0x1::string::String, T1>(&mut arg0.id, 0x1::string::utf8(arg2), arg3);
    }

    public fun sweep_dust<T0>(arg0: &mut Vault<T0>, arg1: &ProtocolAccessCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.total_receipts == 0, 217);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.idle_balance), arg2), 0x2::tx_context::sender(arg2));
    }

    public fun take_yield_balance<T0, T1>(arg0: &mut Vault<T0>, arg1: &ProtocolAccessCap) : 0x2::balance::Balance<T1> {
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.invested_assets, v0)) {
            0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.invested_assets, v0)
        } else {
            0x2::balance::zero<T1>()
        }
    }

    public fun total_receipts<T0>(arg0: &Vault<T0>) : u64 {
        arg0.total_receipts
    }

    public fun update_fee_recipient<T0>(arg0: &mut Vault<T0>, arg1: &ProtocolAccessCap, arg2: address) {
        arg0.fee_recipient = arg2;
        let v0 = FeeRecipientUpdatedEvent{
            old_recipient : arg0.fee_recipient,
            new_recipient : arg2,
        };
        0x2::event::emit<FeeRecipientUpdatedEvent>(v0);
    }

    public fun update_heartbeat_tvl<T0>(arg0: &mut Vault<T0>, arg1: &0x2::clock::Clock, arg2: &ProtocolAccessCap) {
        arg0.last_heartbeat_tvl = 0x2::balance::value<T0>(&arg0.idle_balance) + arg0.last_deployed_amount;
        arg0.last_heartbeat_ms = 0x2::clock::timestamp_ms(arg1);
        let v0 = HeartbeatTvlEvent{tvl: arg0.last_heartbeat_tvl};
        0x2::event::emit<HeartbeatTvlEvent>(v0);
    }

    public fun update_performance_fee<T0>(arg0: &mut Vault<T0>, arg1: &ProtocolAccessCap, arg2: u64) {
        0xb24972538853dcc7ad36068fd4e8e20277a9e79ea08cad8477a6f46f4c848478::floors::assert_rewards_fee(arg2);
        arg0.performance_fee_bps = arg2;
    }

    public fun update_tvl_cap<T0>(arg0: &mut Vault<T0>, arg1: &ProtocolAccessCap, arg2: u64) {
        assert!(arg2 >= arg0.max_tvl_cap, 213);
        arg0.max_tvl_cap = arg2;
        let v0 = TvlCapUpdatedEvent{
            old_cap : arg0.max_tvl_cap,
            new_cap : arg2,
        };
        0x2::event::emit<TvlCapUpdatedEvent>(v0);
    }

    public fun withdraw<T0>(arg0: &mut Vault<T0>, arg1: 0xd32c31d0e1e5d5ab839f68a192a8bcf196cf200536fe0ecede3be100cab721f8::receipt::AqReceipt, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::tx_context::epoch(arg4) > 0xd32c31d0e1e5d5ab839f68a192a8bcf196cf200536fe0ecede3be100cab721f8::receipt::deposit_epoch(&arg1), 17);
        assert!(0x2::tx_context::epoch(arg4) > 0xd32c31d0e1e5d5ab839f68a192a8bcf196cf200536fe0ecede3be100cab721f8::receipt::locked_until_epoch(&arg1), 214);
        let v0 = 0xd32c31d0e1e5d5ab839f68a192a8bcf196cf200536fe0ecede3be100cab721f8::receipt::receipt_amount(&arg1);
        assert!(v0 > 0, 200);
        let v1 = if (arg0.total_receipts == 0) {
            0
        } else {
            (((v0 as u128) * (((0x2::balance::value<T0>(&arg0.idle_balance) + arg0.last_deployed_amount) as u128) + 1000000) / ((arg0.total_receipts as u128) + 1000000)) as u64)
        };
        assert!(v1 > 0, 200);
        assert!(v1 >= arg2, 203);
        0xd32c31d0e1e5d5ab839f68a192a8bcf196cf200536fe0ecede3be100cab721f8::receipt::deplete_receipt(&arg0.treasury_cap, &mut arg1, v0);
        0xd32c31d0e1e5d5ab839f68a192a8bcf196cf200536fe0ecede3be100cab721f8::receipt::destroy_empty_receipt(arg1);
        arg0.total_receipts = arg0.total_receipts - v0;
        let v2 = WithdrawEvent{
            user            : 0x2::tx_context::sender(arg4),
            receipts_burned : v0,
            usdc_returned   : v1,
        };
        0x2::event::emit<WithdrawEvent>(v2);
        0x2::coin::take<T0>(&mut arg0.idle_balance, v1, arg4)
    }

    // decompiled from Move bytecode v6
}

