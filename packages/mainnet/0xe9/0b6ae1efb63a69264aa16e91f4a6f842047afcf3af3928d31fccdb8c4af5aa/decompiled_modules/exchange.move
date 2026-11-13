module 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange {
    struct Exchange<phantom T0> has key {
        id: 0x2::object::UID,
        version: u64,
        accounts: 0x2::table::Table<address, 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::account::Account>,
        instruments: 0x2::table::Table<u256, 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::instrument::Instrument>,
        removed: 0x2::table::Table<u256, bool>,
        vault: 0x2::bag::Bag,
        coins: 0x2::table::Table<0x1::type_name::TypeName, CoinInfo>,
        coin_list: vector<0x1::type_name::TypeName>,
        fees: u64,
        taker_fee_bps: u64,
        price_key: vector<u8>,
        risk_key: vector<u8>,
        pending_price_key: 0x1::option::Option<Pending<vector<u8>>>,
        pending_risk_key: 0x1::option::Option<Pending<vector<u8>>>,
        house: address,
        pending_house: 0x1::option::Option<address>,
        lent: u64,
        max_debt_default: u64,
        max_lent_bps: u64,
        emergency_address: address,
        pending_emergency_address: 0x1::option::Option<Pending<address>>,
        pending_coins: 0x2::table::Table<0x1::type_name::TypeName, Pending<CoinInfo>>,
        sweeps: 0x2::table::Table<u256, Pending<bool>>,
        paused: bool,
        paused_at_ms: u64,
        claim_delay_ms: u64,
        operator_epoch: u64,
        frozen_from: u64,
        notice_epoch: u64,
    }

    struct Pending<T0: copy + drop + store> has copy, drop, store {
        value: T0,
        requested_ms: u64,
        epoch: u64,
    }

    struct CoinInfo has copy, drop, store {
        decimals: u8,
        underlying: u32,
        dust: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        exchange: 0x2::object::ID,
    }

    struct OperatorCap has store, key {
        id: 0x2::object::UID,
        exchange: 0x2::object::ID,
        epoch: u64,
    }

    struct ExchangeCreated has copy, drop {
        exchange: 0x2::object::ID,
        house: address,
    }

    struct KeyRegistered has copy, drop {
        user: address,
        trading_pubkey: vector<u8>,
        key_epoch: u64,
    }

    struct Deposited has copy, drop {
        user: address,
        coin: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct Withdrawn has copy, drop {
        user: address,
        coin: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct Cancelled has copy, drop {
        user: address,
        nonce: u64,
    }

    struct Listed has copy, drop {
        instrument: u256,
        spec: 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::instrument::InstrumentSpec,
    }

    struct Settled has copy, drop {
        instrument: u256,
        payout_per_lot: u64,
    }

    struct Claimed has copy, drop {
        instrument: u256,
        user: address,
        amount: u64,
        is_short: bool,
        paid: u64,
        refund: bool,
    }

    struct InstrumentRemoved has copy, drop {
        instrument: u256,
        dust: u64,
    }

    struct RefundStarted has copy, drop {
        instrument: u256,
        by_admin: bool,
        pool: u64,
        at_ms: u64,
    }

    struct DebtChanged has copy, drop {
        user: address,
        debt: u64,
        lent: u64,
    }

    struct MarginToggled has copy, drop {
        user: address,
        enabled: bool,
    }

    struct ConfigChanged has copy, drop {
        what: vector<u8>,
        value: u64,
    }

    struct CoinAllowed has copy, drop {
        coin: 0x1::type_name::TypeName,
        decimals: u8,
        underlying: u32,
        dust: u64,
    }

    struct OracleRotationRequested has copy, drop {
        kind: u8,
        key: vector<u8>,
        eligible_ms: u64,
        expires_ms: u64,
    }

    struct OracleRotationCancelled has copy, drop {
        kind: u8,
    }

    struct OracleRotated has copy, drop {
        kind: u8,
        key: vector<u8>,
    }

    struct OracleRevoked has copy, drop {
        kind: u8,
    }

    struct EmergencyAddressRequested has copy, drop {
        to: address,
        eligible_ms: u64,
        expires_ms: u64,
    }

    struct EmergencyAddressChanged has copy, drop {
        to: address,
    }

    struct SweepRequested has copy, drop {
        instrument: u256,
        eligible_ms: u64,
        expires_ms: u64,
    }

    struct SweepCancelled has copy, drop {
        instrument: u256,
    }

    struct Swept has copy, drop {
        instrument: u256,
        coin: 0x1::type_name::TypeName,
        amount: u64,
        to: address,
    }

    struct FeesWithdrawn has copy, drop {
        amount: u64,
    }

    struct HouseChanged has copy, drop {
        house: address,
    }

    struct HouseProposed has copy, drop {
        house: address,
    }

    struct AccountMaxDebtSet has copy, drop {
        user: address,
        max: 0x1::option::Option<u64>,
    }

    struct OperatorCapIssued has copy, drop {
        cap: 0x2::object::ID,
        epoch: u64,
    }

    struct Migrated has copy, drop {
        from: u64,
        to: u64,
    }

    struct NonceReclaimed has copy, drop {
        user: address,
        nonce: u64,
    }

    struct CoinInfoRequested has copy, drop {
        coin: 0x1::type_name::TypeName,
        decimals: u8,
        underlying: u32,
        dust: u64,
        eligible_ms: u64,
        expires_ms: u64,
    }

    struct CoinInfoChanged has copy, drop {
        coin: 0x1::type_name::TypeName,
        decimals: u8,
        underlying: u32,
        dust: u64,
    }

    public fun account<T0>(arg0: &Exchange<T0>, arg1: address) : &0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::account::Account {
        assert!(0x2::table::contains<address, 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::account::Account>(&arg0.accounts, arg1), 5);
        0x2::table::borrow<address, 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::account::Account>(&arg0.accounts, arg1)
    }

    public(friend) fun bump<T0>(arg0: &mut Exchange<T0>, arg1: address) {
        0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::account::bump(account_mut<T0>(arg0, arg1));
    }

    public fun reclaim_nonce<T0>(arg0: &mut Exchange<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        check_version<T0>(arg0);
        let v0 = 0x2::tx_context::sender(arg3);
        0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::account::reclaim_nonce(account_mut<T0>(arg0, v0), arg1, 0x2::clock::timestamp_ms(arg2));
        let v1 = NonceReclaimed{
            user  : v0,
            nonce : arg1,
        };
        0x2::event::emit<NonceReclaimed>(v1);
    }

    public fun accept_house<T0>(arg0: &mut Exchange<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        check_version<T0>(arg0);
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(arg0.pending_house == 0x1::option::some<address>(v0), 45);
        ensure_account<T0>(arg0, v0, arg1);
        assert!(0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::account::debt(account<T0>(arg0, v0)) == 0, 7);
        arg0.pending_house = 0x1::option::none<address>();
        arg0.house = v0;
        let v1 = HouseChanged{house: v0};
        0x2::event::emit<HouseChanged>(v1);
    }

    public(friend) fun account_mut<T0>(arg0: &mut Exchange<T0>, arg1: address) : &mut 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::account::Account {
        assert!(0x2::table::contains<address, 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::account::Account>(&arg0.accounts, arg1), 5);
        0x2::table::borrow_mut<address, 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::account::Account>(&mut arg0.accounts, arg1)
    }

    public(friend) fun add_fee<T0>(arg0: &mut Exchange<T0>, arg1: u64) {
        arg0.fees = arg0.fees + arg1;
    }

    fun add_instrument<T0>(arg0: &mut Exchange<T0>, arg1: u256, arg2: 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::instrument::InstrumentSpec, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::table::contains<u256, 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::instrument::Instrument>(&arg0.instruments, arg1), 9);
        assert!(!0x2::table::contains<u256, bool>(&arg0.removed, arg1), 25);
        assert!(0x2::table::contains<0x1::type_name::TypeName, CoinInfo>(&arg0.coins, 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::instrument::collateral_coin(&arg2)), 23);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::instrument::expiry_ms(&arg2) > v0, 10);
        assert!(0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::instrument::expiry_ms(&arg2) <= v0 + 157680000000, 37);
        let v1 = Listed{
            instrument : arg1,
            spec       : arg2,
        };
        0x2::event::emit<Listed>(v1);
        0x2::table::add<u256, 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::instrument::Instrument>(&mut arg0.instruments, arg1, 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::instrument::new(arg2, arg4));
    }

    public fun instrument<T0>(arg0: &Exchange<T0>, arg1: u256) : &0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::instrument::Instrument {
        assert!(0x2::table::contains<u256, 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::instrument::Instrument>(&arg0.instruments, arg1), 8);
        0x2::table::borrow<u256, 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::instrument::Instrument>(&arg0.instruments, arg1)
    }

    public fun allow_coin<T0, T1>(arg0: &AdminCap, arg1: &mut Exchange<T0>, arg2: u8, arg3: u32, arg4: u64) {
        check_admin<T0>(arg1, arg0);
        let v0 = 0x1::type_name::with_original_ids<T1>();
        assert!(!0x2::table::contains<0x1::type_name::TypeName, CoinInfo>(&arg1.coins, v0), 17);
        assert!(arg2 <= 18 && arg3 != 0, 34);
        let v1 = CoinInfo{
            decimals   : arg2,
            underlying : arg3,
            dust       : arg4,
        };
        0x2::table::add<0x1::type_name::TypeName, CoinInfo>(&mut arg1.coins, v0, v1);
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg1.coin_list, v0);
        let v2 = CoinAllowed{
            coin       : v0,
            decimals   : arg2,
            underlying : arg3,
            dust       : arg4,
        };
        0x2::event::emit<CoinAllowed>(v2);
    }

    public fun cancel<T0>(arg0: &mut Exchange<T0>, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::account::cancel_nonce(account_mut<T0>(arg0, v0), arg1);
        let v1 = Cancelled{
            user  : v0,
            nonce : arg1,
        };
        0x2::event::emit<Cancelled>(v1);
    }

    public fun cancel_emergency_address<T0>(arg0: &AdminCap, arg1: &mut Exchange<T0>) {
        check_admin<T0>(arg1, arg0);
        assert!(0x1::option::is_some<Pending<address>>(&arg1.pending_emergency_address), 14);
        arg1.pending_emergency_address = 0x1::option::none<Pending<address>>();
        let v0 = ConfigChanged{
            what  : b"emergency_address_cancelled",
            value : 0,
        };
        0x2::event::emit<ConfigChanged>(v0);
    }

    public(friend) fun cancel_for<T0>(arg0: &mut Exchange<T0>, arg1: address, arg2: u64) {
        0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::account::cancel_nonce(account_mut<T0>(arg0, arg1), arg2);
        let v0 = Cancelled{
            user  : arg1,
            nonce : arg2,
        };
        0x2::event::emit<Cancelled>(v0);
    }

    public fun cancel_oracle_rotation<T0>(arg0: &AdminCap, arg1: &mut Exchange<T0>, arg2: u8) {
        check_admin<T0>(arg1, arg0);
        let v0 = if (arg2 == 0) {
            &mut arg1.pending_price_key
        } else {
            assert!(arg2 == 1, 31);
            &mut arg1.pending_risk_key
        };
        assert!(0x1::option::is_some<Pending<vector<u8>>>(v0), 14);
        *v0 = 0x1::option::none<Pending<vector<u8>>>();
        let v1 = OracleRotationCancelled{kind: arg2};
        0x2::event::emit<OracleRotationCancelled>(v1);
    }

    public fun cancel_sweep<T0>(arg0: &AdminCap, arg1: &mut Exchange<T0>, arg2: u256) {
        check_admin<T0>(arg1, arg0);
        assert!(0x2::table::contains<u256, Pending<bool>>(&arg1.sweeps, arg2), 14);
        0x2::table::remove<u256, Pending<bool>>(&mut arg1.sweeps, arg2);
        let v0 = SweepCancelled{instrument: arg2};
        0x2::event::emit<SweepCancelled>(v0);
    }

    public fun cash<T0>() : 0x1::type_name::TypeName {
        0x1::type_name::with_original_ids<T0>()
    }

    public(friend) fun check_admin<T0>(arg0: &Exchange<T0>, arg1: &AdminCap) {
        check_version<T0>(arg0);
        assert!(arg1.exchange == 0x2::object::id<Exchange<T0>>(arg0), 2);
    }

    fun check_due<T0, T1: copy + drop + store>(arg0: &Exchange<T0>, arg1: &Pending<T1>, arg2: u64) {
        assert!(arg1.epoch == arg0.notice_epoch, 28);
        assert!(arg2 >= arg1.requested_ms + 172800000, 15);
        assert!(arg2 <= arg1.requested_ms + 172800000 + 604800000, 28);
    }

    public(friend) fun check_house_limit<T0>(arg0: &Exchange<T0>) {
        let v0 = cash<T0>();
        assert!((arg0.lent as u128) * (10000 as u128) <= ((0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::account::balance(account<T0>(arg0, arg0.house), &v0) as u128) + (arg0.lent as u128)) * (arg0.max_lent_bps as u128), 22);
    }

    public(friend) fun check_idle<T0>(arg0: &Exchange<T0>, arg1: address) {
        assert!(!0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::account::is_busy(account<T0>(arg0, arg1)), 36);
    }

    fun check_key(arg0: &vector<u8>) {
        assert!(0x1::vector::length<u8>(arg0) == 32 && !0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::is_small_order(arg0), 6);
    }

    public(friend) fun check_not_paused<T0>(arg0: &Exchange<T0>) {
        assert!(!arg0.paused, 4);
    }

    public(friend) fun check_operator<T0>(arg0: &Exchange<T0>, arg1: &OperatorCap) {
        check_version<T0>(arg0);
        check_operator_cap<T0>(arg0, arg1);
    }

    public(friend) fun check_operator_cap<T0>(arg0: &Exchange<T0>, arg1: &OperatorCap) {
        assert!(arg1.exchange == 0x2::object::id<Exchange<T0>>(arg0), 2);
        assert!(arg1.epoch == arg0.operator_epoch, 3);
    }

    fun check_other_key<T0>(arg0: &Exchange<T0>, arg1: u8, arg2: &vector<u8>) {
        let (v0, v1) = if (arg1 == 0) {
            let v1 = &arg0.pending_risk_key;
            (&arg0.risk_key, v1)
        } else {
            assert!(arg1 == 1, 31);
            let v1 = &arg0.pending_price_key;
            (&arg0.price_key, v1)
        };
        assert!(arg2 != v0, 33);
        let v2 = if (0x1::option::is_none<Pending<vector<u8>>>(v1)) {
            true
        } else if (0x1::option::borrow<Pending<vector<u8>>>(v1).epoch != arg0.notice_epoch) {
            true
        } else {
            &0x1::option::borrow<Pending<vector<u8>>>(v1).value != arg2
        };
        assert!(v2, 33);
    }

    public(friend) fun check_version<T0>(arg0: &Exchange<T0>) {
        assert!(arg0.version == 1, 1);
    }

    public fun claim<T0>(arg0: &mut Exchange<T0>, arg1: u256, arg2: address, arg3: &0x2::clock::Clock) {
        check_version<T0>(arg0);
        let v0 = 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::instrument::is_refunding(instrument<T0>(arg0, arg1));
        if (!v0) {
            let v1 = 0x2::clock::timestamp_ms(arg3);
            let v2 = instrument<T0>(arg0, arg1);
            if (arg0.paused) {
                assert!(0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::instrument::is_settled(v2) && v1 >= 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::instrument::settled_at_ms(v2) + 1209600000, 4);
            };
            assert!(!0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::instrument::is_settled(v2) || v1 >= 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::instrument::claims_open_ms(v2), 39);
        };
        let v3 = instrument_mut<T0>(arg0, arg1);
        let (v4, v5, v6) = 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::instrument::take_claim(v3, arg2);
        let v7 = account_mut<T0>(arg0, arg2);
        0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::account::position_closed(v7);
        let v8 = 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::instrument::collateral_coin(0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::instrument::spec_of(instrument<T0>(arg0, arg1)));
        credit_coin<T0>(arg0, arg2, v8, v6);
        let v9 = Claimed{
            instrument : arg1,
            user       : arg2,
            amount     : v4,
            is_short   : v5,
            paid       : v6,
            refund     : v0,
        };
        0x2::event::emit<Claimed>(v9);
    }

    public fun claim_delay_ms<T0>(arg0: &Exchange<T0>) : u64 {
        arg0.claim_delay_ms
    }

    public fun coin_dust<T0>(arg0: &Exchange<T0>, arg1: 0x1::type_name::TypeName) : u64 {
        assert!(0x2::table::contains<0x1::type_name::TypeName, CoinInfo>(&arg0.coins, arg1), 23);
        0x2::table::borrow<0x1::type_name::TypeName, CoinInfo>(&arg0.coins, arg1).dust
    }

    public fun coin_info<T0>(arg0: &Exchange<T0>, arg1: 0x1::type_name::TypeName) : (u8, u32) {
        assert!(0x2::table::contains<0x1::type_name::TypeName, CoinInfo>(&arg0.coins, arg1), 23);
        let v0 = 0x2::table::borrow<0x1::type_name::TypeName, CoinInfo>(&arg0.coins, arg1);
        (v0.decimals, v0.underlying)
    }

    public fun coin_list<T0>(arg0: &Exchange<T0>) : vector<0x1::type_name::TypeName> {
        arg0.coin_list
    }

    public fun create<T0>(arg0: vector<u8>, arg1: vector<u8>, arg2: address, arg3: address, arg4: &mut 0x2::tx_context::TxContext) : (AdminCap, OperatorCap) {
        check_key(&arg0);
        check_key(&arg1);
        assert!(arg0 != arg1, 33);
        let v0 = Exchange<T0>{
            id                        : 0x2::object::new(arg4),
            version                   : 1,
            accounts                  : 0x2::table::new<address, 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::account::Account>(arg4),
            instruments               : 0x2::table::new<u256, 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::instrument::Instrument>(arg4),
            removed                   : 0x2::table::new<u256, bool>(arg4),
            vault                     : 0x2::bag::new(arg4),
            coins                     : 0x2::table::new<0x1::type_name::TypeName, CoinInfo>(arg4),
            coin_list                 : 0x1::vector::empty<0x1::type_name::TypeName>(),
            fees                      : 0,
            taker_fee_bps             : 30,
            price_key                 : arg0,
            risk_key                  : arg1,
            pending_price_key         : 0x1::option::none<Pending<vector<u8>>>(),
            pending_risk_key          : 0x1::option::none<Pending<vector<u8>>>(),
            house                     : arg2,
            pending_house             : 0x1::option::none<address>(),
            lent                      : 0,
            max_debt_default          : 1000000000,
            max_lent_bps              : 5000,
            emergency_address         : arg3,
            pending_emergency_address : 0x1::option::none<Pending<address>>(),
            pending_coins             : 0x2::table::new<0x1::type_name::TypeName, Pending<CoinInfo>>(arg4),
            sweeps                    : 0x2::table::new<u256, Pending<bool>>(arg4),
            paused                    : false,
            paused_at_ms              : 0,
            claim_delay_ms            : 900000,
            operator_epoch            : 0,
            frozen_from               : 0,
            notice_epoch              : 0,
        };
        let v1 = cash<T0>();
        let v2 = CoinInfo{
            decimals   : 6,
            underlying : 0,
            dust       : 0,
        };
        0x2::table::add<0x1::type_name::TypeName, CoinInfo>(&mut v0.coins, v1, v2);
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut v0.coin_list, v1);
        0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v0.vault, v1, 0x2::balance::zero<T0>());
        let v3 = &mut v0;
        ensure_account<T0>(v3, arg2, arg4);
        let v4 = 0x2::object::id<Exchange<T0>>(&v0);
        let v5 = ExchangeCreated{
            exchange : v4,
            house    : arg2,
        };
        0x2::event::emit<ExchangeCreated>(v5);
        let v6 = CoinAllowed{
            coin       : v1,
            decimals   : 6,
            underlying : 0,
            dust       : 0,
        };
        0x2::event::emit<CoinAllowed>(v6);
        0x2::transfer::share_object<Exchange<T0>>(v0);
        let v7 = AdminCap{
            id       : 0x2::object::new(arg4),
            exchange : v4,
        };
        let v8 = OperatorCap{
            id       : 0x2::object::new(arg4),
            exchange : v4,
            epoch    : 0,
        };
        (v7, v8)
    }

    public(friend) fun credit_cash<T0>(arg0: &mut Exchange<T0>, arg1: address, arg2: u64) {
        if (arg2 == 0) {
            return
        };
        let v0 = 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::account::debt(account<T0>(arg0, arg1));
        let v1 = 0x1::u64::min(v0, arg2);
        if (v1 > 0) {
            let v2 = account_mut<T0>(arg0, arg1);
            0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::account::set_debt(v2, v0 - v1);
            arg0.lent = arg0.lent - v1;
            let v3 = arg0.house;
            let v4 = account_mut<T0>(arg0, v3);
            0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::account::credit(v4, cash<T0>(), v1);
            let v5 = DebtChanged{
                user : arg1,
                debt : v0 - v1,
                lent : arg0.lent,
            };
            0x2::event::emit<DebtChanged>(v5);
        };
        0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::account::credit(account_mut<T0>(arg0, arg1), cash<T0>(), arg2 - v1);
    }

    public(friend) fun credit_coin<T0>(arg0: &mut Exchange<T0>, arg1: address, arg2: 0x1::type_name::TypeName, arg3: u64) {
        if (arg2 == cash<T0>()) {
            credit_cash<T0>(arg0, arg1, arg3);
        } else {
            0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::account::credit(account_mut<T0>(arg0, arg1), arg2, arg3);
        };
    }

    public(friend) fun debit_coin<T0>(arg0: &mut Exchange<T0>, arg1: address, arg2: 0x1::type_name::TypeName, arg3: u64) {
        0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::account::debit(account_mut<T0>(arg0, arg1), arg2, arg3);
    }

    public fun deposit<T0, T1>(arg0: &mut Exchange<T0>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        deposit_for<T0, T1>(arg0, v0, arg1, arg2);
    }

    public fun deposit_for<T0, T1>(arg0: &mut Exchange<T0>, arg1: address, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) {
        check_version<T0>(arg0);
        let v0 = 0x1::type_name::with_original_ids<T1>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, CoinInfo>(&arg0.coins, v0), 23);
        let v1 = 0x2::coin::value<T1>(&arg2);
        assert!(v1 > 0, 24);
        ensure_account<T0>(arg0, arg1, arg3);
        vault_join<T0, T1>(arg0, arg2);
        credit_coin<T0>(arg0, arg1, v0, v1);
        let v2 = Deposited{
            user   : arg1,
            coin   : v0,
            amount : v1,
        };
        0x2::event::emit<Deposited>(v2);
    }

    public fun emergency_address<T0>(arg0: &Exchange<T0>) : address {
        arg0.emergency_address
    }

    public fun emergency_refund<T0>(arg0: &AdminCap, arg1: &mut Exchange<T0>, arg2: u256, arg3: &0x2::clock::Clock) {
        check_admin<T0>(arg1, arg0);
        assert!(arg1.paused, 32);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(v0 >= arg1.paused_at_ms + 3600000, 42);
        let v1 = instrument<T0>(arg1, arg2);
        if (0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::instrument::is_settled(v1)) {
            assert!(0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::instrument::settled_claims(v1) == 0, 43);
            assert!(arg1.paused_at_ms <= 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::instrument::claims_open_ms(v1) && v0 < 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::instrument::settled_at_ms(v1) + 1209600000, 44);
        };
        refund_by_admin<T0>(arg1, arg2, arg3);
    }

    fun ensure_account<T0>(arg0: &mut Exchange<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        if (!0x2::table::contains<address, 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::account::Account>(&arg0.accounts, arg1)) {
            0x2::table::add<address, 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::account::Account>(&mut arg0.accounts, arg1, 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::account::new(arg2));
        };
    }

    public fun fees<T0>(arg0: &Exchange<T0>) : u64 {
        arg0.fees
    }

    public(friend) fun forgive<T0>(arg0: &mut Exchange<T0>, arg1: address) : u64 {
        let v0 = 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::account::debt(account<T0>(arg0, arg1));
        if (v0 == 0) {
            return 0
        };
        let v1 = account_mut<T0>(arg0, arg1);
        0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::account::set_debt(v1, 0);
        arg0.lent = arg0.lent - v0;
        let v2 = DebtChanged{
            user : arg1,
            debt : 0,
            lent : arg0.lent,
        };
        0x2::event::emit<DebtChanged>(v2);
        v0
    }

    public fun freeze_for_upgrade<T0>(arg0: &AdminCap, arg1: &mut Exchange<T0>) {
        check_admin<T0>(arg1, arg0);
        let v0 = arg1.version;
        arg1.frozen_from = v0;
        arg1.version = 0;
        void_notices<T0>(arg1);
        let v1 = Migrated{
            from : v0,
            to   : 0,
        };
        0x2::event::emit<Migrated>(v1);
    }

    public fun frozen_from<T0>(arg0: &Exchange<T0>) : u64 {
        arg0.frozen_from
    }

    public fun has_account<T0>(arg0: &Exchange<T0>, arg1: address) : bool {
        0x2::table::contains<address, 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::account::Account>(&arg0.accounts, arg1)
    }

    public(friend) fun holds_only_dust<T0>(arg0: &Exchange<T0>, arg1: address) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::type_name::TypeName>(&arg0.coin_list)) {
            let v1 = *0x1::vector::borrow<0x1::type_name::TypeName>(&arg0.coin_list, v0);
            if (0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::account::balance(account<T0>(arg0, arg1), &v1) > 0x2::table::borrow<0x1::type_name::TypeName, CoinInfo>(&arg0.coins, v1).dust) {
                return false
            };
            v0 = v0 + 1;
        };
        true
    }

    public fun house<T0>(arg0: &Exchange<T0>) : address {
        arg0.house
    }

    public(friend) fun instrument_mut<T0>(arg0: &mut Exchange<T0>, arg1: u256) : &mut 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::instrument::Instrument {
        assert!(0x2::table::contains<u256, 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::instrument::Instrument>(&arg0.instruments, arg1), 8);
        0x2::table::borrow_mut<u256, 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::instrument::Instrument>(&mut arg0.instruments, arg1)
    }

    public fun is_allowed_coin<T0>(arg0: &Exchange<T0>, arg1: 0x1::type_name::TypeName) : bool {
        0x2::table::contains<0x1::type_name::TypeName, CoinInfo>(&arg0.coins, arg1)
    }

    public fun is_listed<T0>(arg0: &Exchange<T0>, arg1: u256) : bool {
        0x2::table::contains<u256, 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::instrument::Instrument>(&arg0.instruments, arg1)
    }

    public fun is_paused<T0>(arg0: &Exchange<T0>) : bool {
        arg0.paused
    }

    public fun is_removed<T0>(arg0: &Exchange<T0>, arg1: u256) : bool {
        0x2::table::contains<u256, bool>(&arg0.removed, arg1)
    }

    public fun is_risk_revoked<T0>(arg0: &Exchange<T0>) : bool {
        0x1::vector::length<u8>(&arg0.risk_key) == 0
    }

    public(friend) fun lend<T0>(arg0: &mut Exchange<T0>, arg1: address, arg2: u64) : u64 {
        let v0 = arg0.house;
        debit_coin<T0>(arg0, v0, cash<T0>(), arg2);
        let v1 = 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::account::debt(account<T0>(arg0, arg1)) + arg2;
        assert!(v1 <= 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::account::max_debt(account<T0>(arg0, arg1), arg0.max_debt_default), 21);
        arg0.lent = arg0.lent + arg2;
        let v2 = account_mut<T0>(arg0, arg1);
        0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::account::set_debt(v2, v1);
        let v3 = DebtChanged{
            user : arg1,
            debt : v1,
            lent : arg0.lent,
        };
        0x2::event::emit<DebtChanged>(v3);
        v1
    }

    public fun lent<T0>(arg0: &Exchange<T0>) : u64 {
        arg0.lent
    }

    public fun list<T0>(arg0: &OperatorCap, arg1: &mut Exchange<T0>, arg2: 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::instrument::InstrumentSpec, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : u256 {
        check_operator<T0>(arg1, arg0);
        check_not_paused<T0>(arg1);
        assert!(!0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::instrument::is_grid(&arg2), 26);
        let v0 = 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::instrument::id_of(&arg2);
        add_instrument<T0>(arg1, v0, arg2, arg3, arg4);
        v0
    }

    public fun list_grid<T0>(arg0: &OperatorCap, arg1: &mut Exchange<T0>, arg2: u256, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        check_operator<T0>(arg1, arg0);
        check_not_paused<T0>(arg1);
        add_instrument<T0>(arg1, arg2, 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::instrument::grid_spec(arg2, cash<T0>()), arg3, arg4);
    }

    public fun max_debt_default<T0>(arg0: &Exchange<T0>) : u64 {
        arg0.max_debt_default
    }

    public fun max_lent_bps<T0>(arg0: &Exchange<T0>) : u64 {
        arg0.max_lent_bps
    }

    public fun migrate<T0>(arg0: &AdminCap, arg1: &mut Exchange<T0>) {
        assert!(arg0.exchange == 0x2::object::id<Exchange<T0>>(arg1), 2);
        assert!(arg1.version < 1, 1);
        assert!(arg1.frozen_from < 1, 38);
        let v0 = arg1.version;
        arg1.version = 1;
        void_notices<T0>(arg1);
        let v1 = Migrated{
            from : v0,
            to   : 1,
        };
        0x2::event::emit<Migrated>(v1);
    }

    public fun new_operator_cap<T0>(arg0: &AdminCap, arg1: &Exchange<T0>, arg2: &mut 0x2::tx_context::TxContext) : OperatorCap {
        check_admin<T0>(arg1, arg0);
        let v0 = OperatorCap{
            id       : 0x2::object::new(arg2),
            exchange : 0x2::object::id<Exchange<T0>>(arg1),
            epoch    : arg1.operator_epoch,
        };
        let v1 = OperatorCapIssued{
            cap   : 0x2::object::id<OperatorCap>(&v0),
            epoch : arg1.operator_epoch,
        };
        0x2::event::emit<OperatorCapIssued>(v1);
        v0
    }

    public fun notice_epoch<T0>(arg0: &Exchange<T0>) : u64 {
        arg0.notice_epoch
    }

    public fun paused_at_ms<T0>(arg0: &Exchange<T0>) : u64 {
        arg0.paused_at_ms
    }

    public fun pending_coin_info<T0>(arg0: &Exchange<T0>, arg1: 0x1::type_name::TypeName) : 0x1::option::Option<Pending<CoinInfo>> {
        if (0x2::table::contains<0x1::type_name::TypeName, Pending<CoinInfo>>(&arg0.pending_coins, arg1) && 0x2::table::borrow<0x1::type_name::TypeName, Pending<CoinInfo>>(&arg0.pending_coins, arg1).epoch == arg0.notice_epoch) {
            0x1::option::some<Pending<CoinInfo>>(*0x2::table::borrow<0x1::type_name::TypeName, Pending<CoinInfo>>(&arg0.pending_coins, arg1))
        } else {
            0x1::option::none<Pending<CoinInfo>>()
        }
    }

    public fun pending_emergency_address<T0>(arg0: &Exchange<T0>) : 0x1::option::Option<Pending<address>> {
        arg0.pending_emergency_address
    }

    public fun pending_house<T0>(arg0: &Exchange<T0>) : 0x1::option::Option<address> {
        arg0.pending_house
    }

    public fun pending_price_key<T0>(arg0: &Exchange<T0>) : 0x1::option::Option<Pending<vector<u8>>> {
        arg0.pending_price_key
    }

    public fun pending_requested_ms<T0: copy + drop + store>(arg0: &Pending<T0>) : u64 {
        arg0.requested_ms
    }

    public fun pending_risk_key<T0>(arg0: &Exchange<T0>) : 0x1::option::Option<Pending<vector<u8>>> {
        arg0.pending_risk_key
    }

    public fun pending_value<T0: copy + drop + store>(arg0: &Pending<T0>) : T0 {
        arg0.value
    }

    public fun price_key<T0>(arg0: &Exchange<T0>) : &vector<u8> {
        &arg0.price_key
    }

    public fun propose_house<T0>(arg0: &AdminCap, arg1: &mut Exchange<T0>, arg2: address) {
        check_admin<T0>(arg1, arg0);
        arg1.pending_house = 0x1::option::some<address>(arg2);
        let v0 = HouseProposed{house: arg2};
        0x2::event::emit<HouseProposed>(v0);
    }

    fun refund_by_admin<T0>(arg0: &mut Exchange<T0>, arg1: u256, arg2: &0x2::clock::Clock) {
        let v0 = instrument_mut<T0>(arg0, arg1);
        0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::instrument::enter_refund(v0, cash<T0>());
        let v1 = RefundStarted{
            instrument : arg1,
            by_admin   : true,
            pool       : 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::instrument::collateral(instrument<T0>(arg0, arg1)),
            at_ms      : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<RefundStarted>(v1);
    }

    public fun refund_unsettled<T0>(arg0: &mut Exchange<T0>, arg1: u256, arg2: &0x2::clock::Clock) {
        check_version<T0>(arg0);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = instrument<T0>(arg0, arg1);
        assert!(!0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::instrument::is_closed(v1), 30);
        let v2 = 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::instrument::expiry_ms(0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::instrument::spec_of(v1)) + 2592000000;
        assert!(v0 >= v2, 29);
        if (arg0.paused) {
            assert!(v0 >= v2 + 1209600000, 4);
        };
        let v3 = instrument_mut<T0>(arg0, arg1);
        0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::instrument::enter_refund(v3, cash<T0>());
        let v4 = RefundStarted{
            instrument : arg1,
            by_admin   : false,
            pool       : 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::instrument::collateral(instrument<T0>(arg0, arg1)),
            at_ms      : v0,
        };
        0x2::event::emit<RefundStarted>(v4);
    }

    public fun register<T0>(arg0: &mut Exchange<T0>, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        check_key(&arg1);
        let v0 = 0x2::tx_context::sender(arg2);
        ensure_account<T0>(arg0, v0, arg2);
        let v1 = account_mut<T0>(arg0, v0);
        0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::account::set_trading_pubkey(v1, arg1);
        let v2 = KeyRegistered{
            user           : v0,
            trading_pubkey : arg1,
            key_epoch      : 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::account::key_epoch(v1),
        };
        0x2::event::emit<KeyRegistered>(v2);
    }

    public fun remove_instrument<T0>(arg0: &mut Exchange<T0>, arg1: u256) {
        check_version<T0>(arg0);
        assert!(0x2::table::contains<u256, 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::instrument::Instrument>(&arg0.instruments, arg1), 8);
        let (_, v1) = 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::instrument::destroy(0x2::table::remove<u256, 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::instrument::Instrument>(&mut arg0.instruments, arg1));
        assert!(v1 == 0, 40);
        0x2::table::add<u256, bool>(&mut arg0.removed, arg1, true);
        if (0x2::table::contains<u256, Pending<bool>>(&arg0.sweeps, arg1)) {
            0x2::table::remove<u256, Pending<bool>>(&mut arg0.sweeps, arg1);
            let v2 = SweepCancelled{instrument: arg1};
            0x2::event::emit<SweepCancelled>(v2);
        };
        let v3 = InstrumentRemoved{
            instrument : arg1,
            dust       : v1,
        };
        0x2::event::emit<InstrumentRemoved>(v3);
    }

    public fun repay<T0>(arg0: &mut Exchange<T0>, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        check_version<T0>(arg0);
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x1::u64::min(arg1, 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::account::debt(account<T0>(arg0, v0)));
        assert!(v1 > 0, 20);
        let v2 = account_mut<T0>(arg0, v0);
        0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::account::debit_quietly(v2, cash<T0>(), v1);
        credit_cash<T0>(arg0, v0, v1);
    }

    public fun request_coin_info<T0, T1>(arg0: &AdminCap, arg1: &mut Exchange<T0>, arg2: u8, arg3: u32, arg4: u64, arg5: &0x2::clock::Clock) {
        check_admin<T0>(arg1, arg0);
        let v0 = 0x1::type_name::with_original_ids<T1>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, CoinInfo>(&arg1.coins, v0) && v0 != cash<T0>(), 17);
        assert!(arg2 <= 18 && arg3 != 0, 34);
        let v1 = 0x2::clock::timestamp_ms(arg5);
        if (0x2::table::contains<0x1::type_name::TypeName, Pending<CoinInfo>>(&arg1.pending_coins, v0)) {
            0x2::table::remove<0x1::type_name::TypeName, Pending<CoinInfo>>(&mut arg1.pending_coins, v0);
        };
        let v2 = CoinInfo{
            decimals   : arg2,
            underlying : arg3,
            dust       : arg4,
        };
        let v3 = Pending<CoinInfo>{
            value        : v2,
            requested_ms : v1,
            epoch        : arg1.notice_epoch,
        };
        0x2::table::add<0x1::type_name::TypeName, Pending<CoinInfo>>(&mut arg1.pending_coins, v0, v3);
        let v4 = CoinInfoRequested{
            coin        : v0,
            decimals    : arg2,
            underlying  : arg3,
            dust        : arg4,
            eligible_ms : v1 + 172800000,
            expires_ms  : v1 + 172800000 + 604800000,
        };
        0x2::event::emit<CoinInfoRequested>(v4);
    }

    public fun request_emergency_address<T0>(arg0: &AdminCap, arg1: &mut Exchange<T0>, arg2: address, arg3: &0x2::clock::Clock) {
        check_admin<T0>(arg1, arg0);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = Pending<address>{
            value        : arg2,
            requested_ms : v0,
            epoch        : arg1.notice_epoch,
        };
        arg1.pending_emergency_address = 0x1::option::some<Pending<address>>(v1);
        let v2 = EmergencyAddressRequested{
            to          : arg2,
            eligible_ms : v0 + 172800000,
            expires_ms  : v0 + 172800000 + 604800000,
        };
        0x2::event::emit<EmergencyAddressRequested>(v2);
    }

    public fun request_oracle_rotation<T0>(arg0: &AdminCap, arg1: &mut Exchange<T0>, arg2: u8, arg3: vector<u8>, arg4: &0x2::clock::Clock) {
        check_admin<T0>(arg1, arg0);
        check_key(&arg3);
        check_other_key<T0>(arg1, arg2, &arg3);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = Pending<vector<u8>>{
            value        : arg3,
            requested_ms : v0,
            epoch        : arg1.notice_epoch,
        };
        if (arg2 == 0) {
            arg1.pending_price_key = 0x1::option::some<Pending<vector<u8>>>(v1);
        } else {
            assert!(arg2 == 1, 31);
            arg1.pending_risk_key = 0x1::option::some<Pending<vector<u8>>>(v1);
        };
        let v2 = OracleRotationRequested{
            kind        : arg2,
            key         : arg3,
            eligible_ms : v0 + 172800000,
            expires_ms  : v0 + 172800000 + 604800000,
        };
        0x2::event::emit<OracleRotationRequested>(v2);
    }

    public fun request_sweep<T0>(arg0: &AdminCap, arg1: &mut Exchange<T0>, arg2: u256, arg3: &0x2::clock::Clock) {
        check_admin<T0>(arg1, arg0);
        assert!(0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::instrument::is_refunding(instrument<T0>(arg1, arg2)), 27);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        if (0x2::table::contains<u256, Pending<bool>>(&arg1.sweeps, arg2)) {
            0x2::table::remove<u256, Pending<bool>>(&mut arg1.sweeps, arg2);
        };
        let v1 = Pending<bool>{
            value        : true,
            requested_ms : v0,
            epoch        : arg1.notice_epoch,
        };
        0x2::table::add<u256, Pending<bool>>(&mut arg1.sweeps, arg2, v1);
        let v2 = SweepRequested{
            instrument  : arg2,
            eligible_ms : v0 + 172800000,
            expires_ms  : v0 + 172800000 + 604800000,
        };
        0x2::event::emit<SweepRequested>(v2);
    }

    public fun revoke_operators<T0>(arg0: &AdminCap, arg1: &mut Exchange<T0>) {
        check_admin<T0>(arg1, arg0);
        arg1.operator_epoch = arg1.operator_epoch + 1;
        let v0 = ConfigChanged{
            what  : b"operator_epoch",
            value : arg1.operator_epoch,
        };
        0x2::event::emit<ConfigChanged>(v0);
    }

    public fun revoke_oracle<T0>(arg0: &AdminCap, arg1: &mut Exchange<T0>, arg2: u8) {
        check_admin<T0>(arg1, arg0);
        if (arg2 == 0) {
            arg1.price_key = b"";
            arg1.pending_price_key = 0x1::option::none<Pending<vector<u8>>>();
        } else {
            assert!(arg2 == 1, 31);
            arg1.risk_key = b"";
            arg1.pending_risk_key = 0x1::option::none<Pending<vector<u8>>>();
        };
        let v0 = OracleRevoked{kind: arg2};
        0x2::event::emit<OracleRevoked>(v0);
    }

    public fun risk_key<T0>(arg0: &Exchange<T0>) : &vector<u8> {
        &arg0.risk_key
    }

    public fun rotate_oracle<T0>(arg0: &AdminCap, arg1: &mut Exchange<T0>, arg2: u8, arg3: &0x2::clock::Clock) {
        check_admin<T0>(arg1, arg0);
        let v0 = if (arg2 == 0) {
            &mut arg1.pending_price_key
        } else {
            assert!(arg2 == 1, 31);
            &mut arg1.pending_risk_key
        };
        assert!(0x1::option::is_some<Pending<vector<u8>>>(v0), 14);
        let v1 = 0x1::option::extract<Pending<vector<u8>>>(v0);
        check_due<T0, vector<u8>>(arg1, &v1, 0x2::clock::timestamp_ms(arg3));
        let v2 = v1.value;
        check_other_key<T0>(arg1, arg2, &v2);
        if (arg2 == 0) {
            arg1.price_key = v2;
        } else {
            arg1.risk_key = v2;
        };
        let v3 = OracleRotated{
            kind : arg2,
            key  : v2,
        };
        0x2::event::emit<OracleRotated>(v3);
    }

    public fun set_account_max_debt<T0>(arg0: &AdminCap, arg1: &mut Exchange<T0>, arg2: address, arg3: 0x1::option::Option<u64>) {
        check_admin<T0>(arg1, arg0);
        0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::account::set_max_debt(account_mut<T0>(arg1, arg2), arg3);
        let v0 = AccountMaxDebtSet{
            user : arg2,
            max  : arg3,
        };
        0x2::event::emit<AccountMaxDebtSet>(v0);
    }

    public fun set_claim_delay<T0>(arg0: &AdminCap, arg1: &mut Exchange<T0>, arg2: u64) {
        check_admin<T0>(arg1, arg0);
        assert!(arg2 >= 300000 && arg2 <= 86400000, 41);
        arg1.claim_delay_ms = arg2;
        let v0 = ConfigChanged{
            what  : b"claim_delay_ms",
            value : arg2,
        };
        0x2::event::emit<ConfigChanged>(v0);
    }

    public fun set_coin_info<T0, T1>(arg0: &AdminCap, arg1: &mut Exchange<T0>, arg2: &0x2::clock::Clock) {
        check_admin<T0>(arg1, arg0);
        let v0 = 0x1::type_name::with_original_ids<T1>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, Pending<CoinInfo>>(&arg1.pending_coins, v0), 14);
        let v1 = 0x2::table::remove<0x1::type_name::TypeName, Pending<CoinInfo>>(&mut arg1.pending_coins, v0);
        check_due<T0, CoinInfo>(arg1, &v1, 0x2::clock::timestamp_ms(arg2));
        *0x2::table::borrow_mut<0x1::type_name::TypeName, CoinInfo>(&mut arg1.coins, v0) = v1.value;
        let v2 = CoinInfoChanged{
            coin       : v0,
            decimals   : v1.value.decimals,
            underlying : v1.value.underlying,
            dust       : v1.value.dust,
        };
        0x2::event::emit<CoinInfoChanged>(v2);
    }

    public fun set_emergency_address<T0>(arg0: &AdminCap, arg1: &mut Exchange<T0>, arg2: &0x2::clock::Clock) {
        check_admin<T0>(arg1, arg0);
        assert!(0x1::option::is_some<Pending<address>>(&arg1.pending_emergency_address), 14);
        let v0 = 0x1::option::extract<Pending<address>>(&mut arg1.pending_emergency_address);
        check_due<T0, address>(arg1, &v0, 0x2::clock::timestamp_ms(arg2));
        arg1.emergency_address = v0.value;
        let v1 = EmergencyAddressChanged{to: v0.value};
        0x2::event::emit<EmergencyAddressChanged>(v1);
    }

    public fun set_margin<T0>(arg0: &mut Exchange<T0>, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        check_version<T0>(arg0);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(arg1 || 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::account::debt(account<T0>(arg0, v0)) == 0, 7);
        0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::account::set_margin_enabled(account_mut<T0>(arg0, v0), arg1);
        let v1 = MarginToggled{
            user    : v0,
            enabled : arg1,
        };
        0x2::event::emit<MarginToggled>(v1);
    }

    public fun set_max_debt_default<T0>(arg0: &AdminCap, arg1: &mut Exchange<T0>, arg2: u64) {
        check_admin<T0>(arg1, arg0);
        arg1.max_debt_default = arg2;
        let v0 = ConfigChanged{
            what  : b"max_debt_default",
            value : arg2,
        };
        0x2::event::emit<ConfigChanged>(v0);
    }

    public fun set_max_lent_bps<T0>(arg0: &AdminCap, arg1: &mut Exchange<T0>, arg2: u64) {
        check_admin<T0>(arg1, arg0);
        assert!(arg2 <= 10000, 12);
        arg1.max_lent_bps = arg2;
        let v0 = ConfigChanged{
            what  : b"max_lent_bps",
            value : arg2,
        };
        0x2::event::emit<ConfigChanged>(v0);
    }

    public fun set_paused<T0>(arg0: &AdminCap, arg1: &mut Exchange<T0>, arg2: bool, arg3: &0x2::clock::Clock) {
        check_admin<T0>(arg1, arg0);
        if (arg2 && !arg1.paused) {
            arg1.paused_at_ms = 0x2::clock::timestamp_ms(arg3);
        };
        if (!arg2) {
            arg1.paused_at_ms = 0;
        };
        arg1.paused = arg2;
        let v0 = if (arg2) {
            1
        } else {
            0
        };
        let v1 = ConfigChanged{
            what  : b"paused",
            value : v0,
        };
        0x2::event::emit<ConfigChanged>(v1);
    }

    public fun set_taker_fee<T0>(arg0: &AdminCap, arg1: &mut Exchange<T0>, arg2: u64) {
        check_admin<T0>(arg1, arg0);
        assert!(arg2 <= 500, 11);
        arg1.taker_fee_bps = arg2;
        let v0 = ConfigChanged{
            what  : b"taker_fee_bps",
            value : arg2,
        };
        0x2::event::emit<ConfigChanged>(v0);
    }

    public fun settle<T0>(arg0: &mut Exchange<T0>, arg1: 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::SettleProof, arg2: vector<u8>, arg3: &0x2::clock::Clock) {
        check_version<T0>(arg0);
        check_not_paused<T0>(arg0);
        0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::check_target(0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::settle_domain_of(&arg1), 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::settle_domain(), 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::settle_exchange(&arg1), 0x2::object::id<Exchange<T0>>(arg0));
        verify_price<T0, 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::SettleProof>(arg0, &arg1, &arg2);
        0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::check_settle_fresh(0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::settle_at_ms(&arg1), 0x2::clock::timestamp_ms(arg3));
        let v0 = 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::settle_instrument(&arg1);
        let v1 = 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::settle_payout(&arg1);
        let v2 = 0x2::clock::timestamp_ms(arg3);
        let v3 = arg0.claim_delay_ms;
        0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::instrument::settle(instrument_mut<T0>(arg0, v0), v1, v2, v2 + v3);
        let v4 = Settled{
            instrument     : v0,
            payout_per_lot : v1,
        };
        0x2::event::emit<Settled>(v4);
    }

    public(friend) fun signer_key<T0>(arg0: &Exchange<T0>, arg1: address) : vector<u8> {
        let v0 = *0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::account::trading_pubkey(account<T0>(arg0, arg1));
        assert!(0x1::vector::length<u8>(&v0) == 32, 19);
        v0
    }

    public fun sweep<T0, T1>(arg0: &AdminCap, arg1: &mut Exchange<T0>, arg2: u256, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        check_admin<T0>(arg1, arg0);
        assert!(0x2::table::contains<u256, Pending<bool>>(&arg1.sweeps, arg2), 14);
        let v0 = 0x2::table::remove<u256, Pending<bool>>(&mut arg1.sweeps, arg2);
        check_due<T0, bool>(arg1, &v0, 0x2::clock::timestamp_ms(arg3));
        let v1 = 0x1::type_name::with_original_ids<T1>();
        assert!(0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::instrument::collateral_coin(0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::instrument::spec_of(instrument<T0>(arg1, arg2))) == v1, 17);
        let v2 = instrument_mut<T0>(arg1, arg2);
        let v3 = 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::instrument::sweep(v2);
        let v4 = arg1.emergency_address;
        let v5 = Swept{
            instrument : arg2,
            coin       : v1,
            amount     : v3,
            to         : v4,
        };
        0x2::event::emit<Swept>(v5);
        if (v3 == 0) {
            return
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg1.vault, v1), v3), arg4), v4);
    }

    public fun sweep_requested_ms<T0>(arg0: &Exchange<T0>, arg1: u256) : 0x1::option::Option<u64> {
        if (0x2::table::contains<u256, Pending<bool>>(&arg0.sweeps, arg1) && 0x2::table::borrow<u256, Pending<bool>>(&arg0.sweeps, arg1).epoch == arg0.notice_epoch) {
            0x1::option::some<u64>(0x2::table::borrow<u256, Pending<bool>>(&arg0.sweeps, arg1).requested_ms)
        } else {
            0x1::option::none<u64>()
        }
    }

    public(friend) fun take_dust_to_house<T0>(arg0: &mut Exchange<T0>, arg1: address) : u64 {
        let v0 = arg0.house;
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&arg0.coin_list)) {
            let v3 = *0x1::vector::borrow<0x1::type_name::TypeName>(&arg0.coin_list, v2);
            let v4 = 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::account::balance(account<T0>(arg0, arg1), &v3);
            if (v4 > 0) {
                assert!(v4 <= 0x2::table::borrow<0x1::type_name::TypeName, CoinInfo>(&arg0.coins, v3).dust, 17);
                let v5 = account_mut<T0>(arg0, arg1);
                0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::account::debit_quietly(v5, v3, v4);
                credit_coin<T0>(arg0, v0, v3, v4);
                v1 = v1 + 1;
            };
            v2 = v2 + 1;
        };
        v1
    }

    public(friend) fun take_out<T0, T1>(arg0: &mut Exchange<T0>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(arg2 > 0, 35);
        let v0 = 0x1::type_name::with_original_ids<T1>();
        debit_coin<T0>(arg0, arg1, v0, arg2);
        let v1 = Withdrawn{
            user   : arg1,
            coin   : v0,
            amount : arg2,
        };
        0x2::event::emit<Withdrawn>(v1);
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.vault, v0), arg2), arg3)
    }

    public fun taker_fee_bps<T0>(arg0: &Exchange<T0>) : u64 {
        arg0.taker_fee_bps
    }

    public(friend) fun track_position<T0>(arg0: &mut Exchange<T0>, arg1: address, arg2: bool, arg3: bool) {
        if (!arg2 && arg3) {
            0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::account::position_opened(account_mut<T0>(arg0, arg1));
        } else if (arg2 && !arg3) {
            0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::account::position_closed(account_mut<T0>(arg0, arg1));
        };
    }

    public(friend) fun uid<T0>(arg0: &Exchange<T0>) : &0x2::object::UID {
        &arg0.id
    }

    public(friend) fun uid_mut<T0>(arg0: &mut Exchange<T0>) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public(friend) fun vault_join<T0, T1>(arg0: &mut Exchange<T0>, arg1: 0x2::coin::Coin<T1>) {
        let v0 = 0x1::type_name::with_original_ids<T1>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, CoinInfo>(&arg0.coins, v0), 23);
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.vault, v0)) {
            0x2::balance::join<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.vault, v0), 0x2::coin::into_balance<T1>(arg1));
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.vault, v0, 0x2::coin::into_balance<T1>(arg1));
        };
    }

    public(friend) fun vault_split<T0, T1>(arg0: &mut Exchange<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        if (arg1 == 0) {
            return 0x2::coin::zero<T1>(arg2)
        };
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.vault, 0x1::type_name::with_original_ids<T1>()), arg1), arg2)
    }

    public fun vault_value<T0, T1>(arg0: &Exchange<T0>) : u64 {
        let v0 = 0x1::type_name::with_original_ids<T1>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.vault, v0)) {
            0x2::balance::value<T1>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&arg0.vault, v0))
        } else {
            0
        }
    }

    public(friend) fun verify_price<T0, T1: drop>(arg0: &Exchange<T0>, arg1: &T1, arg2: &vector<u8>) {
        0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::verify<T1>(&arg0.price_key, arg1, arg2);
    }

    public(friend) fun verify_risk<T0, T1: drop>(arg0: &Exchange<T0>, arg1: &T1, arg2: &vector<u8>) {
        0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::oracle::verify<T1>(&arg0.risk_key, arg1, arg2);
    }

    public fun version<T0>(arg0: &Exchange<T0>) : u64 {
        arg0.version
    }

    fun void_notices<T0>(arg0: &mut Exchange<T0>) {
        arg0.notice_epoch = arg0.notice_epoch + 1;
        if (0x1::option::is_some<Pending<vector<u8>>>(&arg0.pending_price_key)) {
            arg0.pending_price_key = 0x1::option::none<Pending<vector<u8>>>();
            let v0 = OracleRotationCancelled{kind: 0};
            0x2::event::emit<OracleRotationCancelled>(v0);
        };
        if (0x1::option::is_some<Pending<vector<u8>>>(&arg0.pending_risk_key)) {
            arg0.pending_risk_key = 0x1::option::none<Pending<vector<u8>>>();
            let v1 = OracleRotationCancelled{kind: 1};
            0x2::event::emit<OracleRotationCancelled>(v1);
        };
        if (0x1::option::is_some<Pending<address>>(&arg0.pending_emergency_address)) {
            arg0.pending_emergency_address = 0x1::option::none<Pending<address>>();
            let v2 = ConfigChanged{
                what  : b"emergency_address_cancelled",
                value : 0,
            };
            0x2::event::emit<ConfigChanged>(v2);
        };
        if (0x1::option::is_some<address>(&arg0.pending_house)) {
            arg0.pending_house = 0x1::option::none<address>();
            let v3 = ConfigChanged{
                what  : b"house_proposal_cancelled",
                value : 0,
            };
            0x2::event::emit<ConfigChanged>(v3);
        };
    }

    public fun withdraw<T0, T1>(arg0: &mut Exchange<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        check_version<T0>(arg0);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::account::debt(account<T0>(arg0, v0)) == 0, 7);
        take_out<T0, T1>(arg0, v0, arg1, arg2)
    }

    public fun withdraw_fees<T0>(arg0: &AdminCap, arg1: &mut Exchange<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        check_admin<T0>(arg1, arg0);
        assert!(arg2 <= arg1.fees, 18);
        arg1.fees = arg1.fees - arg2;
        let v0 = FeesWithdrawn{amount: arg2};
        0x2::event::emit<FeesWithdrawn>(v0);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.vault, cash<T0>()), arg2), arg3)
    }

    // decompiled from Move bytecode v7
}

