module 0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::account {
    struct RetiredKey has copy, drop, store {
        dummy_field: bool,
    }

    struct BoundKey has copy, drop, store {
        dummy_field: bool,
    }

    struct RegisteredCharger has copy, drop, store {
        witness: 0x1::type_name::TypeName,
    }

    struct ApprovedCharger has copy, drop, store {
        config_id: 0x2::object::ID,
        witness: 0x1::type_name::TypeName,
    }

    struct KeyBound has copy, drop {
        agent_id: 0x2::object::ID,
        key_id: 0x1::string::String,
    }

    struct ChallengeAnswered has copy, drop {
        agent_id: 0x2::object::ID,
        key_id: 0x1::string::String,
        nonce: vector<u8>,
        pubkey_hash: vector<u8>,
    }

    struct Config has key {
        id: 0x2::object::UID,
        treasury: address,
        coin_type: 0x1::type_name::TypeName,
        paused: bool,
        max_account_micro: u64,
        max_charge_micro: u64,
        max_day_micro: u64,
        issuer_epoch: u64,
    }

    struct IssuerCap has store, key {
        id: 0x2::object::UID,
        config_id: 0x2::object::ID,
        epoch: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        config_id: 0x2::object::ID,
    }

    struct AccountKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct Account<phantom T0> has store {
        balance: 0x2::balance::Balance<T0>,
        config_id: 0x2::object::ID,
        next_seq: u64,
        day: u64,
        spent_today: u64,
        max_charge_micro: u64,
        max_day_micro: u64,
    }

    struct Deposited has copy, drop {
        agent_id: 0x2::object::ID,
        depositor: address,
        amount: u64,
        balance_after: u64,
    }

    struct Charged has copy, drop {
        agent_id: 0x2::object::ID,
        key_id: 0x1::option::Option<0x1::string::String>,
        amount: u64,
        seq: u64,
        treasury: address,
    }

    struct Withdrawn has copy, drop {
        agent_id: 0x2::object::ID,
        recipient: address,
        amount: u64,
        balance_after: u64,
    }

    struct PolicySet has copy, drop {
        agent_id: 0x2::object::ID,
        max_charge_micro: u64,
        max_day_micro: u64,
    }

    public fun account_balance<T0>(arg0: &0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::Aion) : u64 {
        let v0 = AccountKey<T0>{dummy_field: false};
        if (!0x2::dynamic_field::exists<AccountKey<T0>>(0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::uid(arg0), v0)) {
            return 0
        };
        let v1 = AccountKey<T0>{dummy_field: false};
        0x2::balance::value<T0>(&0x2::dynamic_field::borrow<AccountKey<T0>, Account<T0>>(0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::uid(arg0), v1).balance)
    }

    public fun answer_challenge(arg0: &0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::Aion, arg1: &0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::OwnerCap, arg2: vector<u8>, arg3: vector<u8>) {
        0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::check_owner(arg0, arg1);
        emit_challenge(arg0, arg2, arg3);
    }

    public fun approve_charger<T0: drop>(arg0: &Config, arg1: &mut 0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::Aion, arg2: &0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::OwnerCap) {
        0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::check_owner(arg1, arg2);
        assert_live(arg1);
        let v0 = ApprovedCharger{
            config_id : 0x2::object::id<Config>(arg0),
            witness   : 0x1::type_name::with_defining_ids<T0>(),
        };
        if (!0x2::dynamic_field::exists<ApprovedCharger>(0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::uid(arg1), v0)) {
            0x2::dynamic_field::add<ApprovedCharger, bool>(0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::uid_mut(arg1), v0, true);
        };
    }

    fun assert_admin(arg0: &Config, arg1: &AdminCap) {
        assert!(arg1.config_id == 0x2::object::id<Config>(arg0), 100);
    }

    fun assert_coin_type<T0>(arg0: &Config) {
        assert!(0x1::type_name::with_defining_ids<T0>() == arg0.coin_type, 102);
    }

    public(friend) fun assert_live(arg0: &0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::Aion) {
        assert!(!is_retired(arg0), 115);
    }

    public fun bind_key(arg0: &Config, arg1: &IssuerCap, arg2: &mut 0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::Aion, arg3: 0x1::string::String) {
        assert_live(arg2);
        assert!(arg1.config_id == 0x2::object::id<Config>(arg0), 100);
        assert!(arg1.epoch == arg0.issuer_epoch, 111);
        assert!(!arg0.paused, 101);
        assert!(0x1::string::length(&arg3) > 0 && 0x1::string::length(&arg3) <= 128, 116);
        let v0 = BoundKey{dummy_field: false};
        if (0x2::dynamic_field::exists<BoundKey>(0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::uid(arg2), v0)) {
            let v1 = BoundKey{dummy_field: false};
            0x2::dynamic_field::remove<BoundKey, 0x1::string::String>(0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::uid_mut(arg2), v1);
        };
        let v2 = BoundKey{dummy_field: false};
        0x2::dynamic_field::add<BoundKey, 0x1::string::String>(0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::uid_mut(arg2), v2, arg3);
        0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::bind_issuer_key(arg2, arg3);
        let v3 = KeyBound{
            agent_id : 0x2::object::id<0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::Aion>(arg2),
            key_id   : arg3,
        };
        0x2::event::emit<KeyBound>(v3);
    }

    public fun bound_key(arg0: &0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::Aion) : 0x1::string::String {
        let v0 = BoundKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists<BoundKey>(0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::uid(arg0), v0), 118);
        let v1 = BoundKey{dummy_field: false};
        let v2 = *0x2::dynamic_field::borrow<BoundKey, 0x1::string::String>(0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::uid(arg0), v1);
        assert!(*0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::key_id(arg0) == 0x1::option::some<0x1::string::String>(v2), 118);
        v2
    }

    public fun charge<T0>(arg0: &Config, arg1: &IssuerCap, arg2: &mut 0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::Aion, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.config_id == 0x2::object::id<Config>(arg0), 100);
        assert!(arg1.epoch == arg0.issuer_epoch, 111);
        do_charge<T0>(arg0, arg2, arg3, arg4, arg5, arg6);
    }

    public fun charge_authorized<T0, T1: drop>(arg0: T1, arg1: &Config, arg2: &mut 0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::Aion, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        let v1 = RegisteredCharger{witness: v0};
        assert!(0x2::dynamic_field::exists<RegisteredCharger>(&arg1.id, v1), 119);
        let v2 = ApprovedCharger{
            config_id : 0x2::object::id<Config>(arg1),
            witness   : v0,
        };
        assert!(0x2::dynamic_field::exists<ApprovedCharger>(0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::uid(arg2), v2), 120);
        bound_key(arg2);
        do_charge<T0>(arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public fun deposit<T0>(arg0: &Config, arg1: &mut 0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::Aion, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        assert_live(arg1);
        assert!(!arg0.paused, 101);
        assert_coin_type<T0>(arg0);
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 > 0, 103);
        let v1 = AccountKey<T0>{dummy_field: false};
        if (!0x2::dynamic_field::exists<AccountKey<T0>>(0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::uid(arg1), v1)) {
            let v2 = AccountKey<T0>{dummy_field: false};
            let v3 = Account<T0>{
                balance          : 0x2::balance::zero<T0>(),
                config_id        : 0x2::object::id<Config>(arg0),
                next_seq         : 0,
                day              : 0,
                spent_today      : 0,
                max_charge_micro : arg0.max_charge_micro,
                max_day_micro    : arg0.max_day_micro,
            };
            0x2::dynamic_field::add<AccountKey<T0>, Account<T0>>(0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::uid_mut(arg1), v2, v3);
        };
        let v4 = AccountKey<T0>{dummy_field: false};
        let v5 = 0x2::dynamic_field::borrow_mut<AccountKey<T0>, Account<T0>>(0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::uid_mut(arg1), v4);
        assert!(v5.config_id == 0x2::object::id<Config>(arg0), 105);
        0x2::balance::join<T0>(&mut v5.balance, 0x2::coin::into_balance<T0>(arg2));
        let v6 = 0x2::balance::value<T0>(&v5.balance);
        assert!(v6 <= arg0.max_account_micro, 106);
        let v7 = Deposited{
            agent_id      : 0x2::object::id<0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::Aion>(arg1),
            depositor     : 0x2::tx_context::sender(arg3),
            amount        : v0,
            balance_after : v6,
        };
        0x2::event::emit<Deposited>(v7);
    }

    fun do_charge<T0>(arg0: &Config, arg1: &mut 0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::Aion, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_live(arg1);
        assert!(!arg0.paused, 101);
        assert_coin_type<T0>(arg0);
        assert!(arg2 > 0, 103);
        let v0 = AccountKey<T0>{dummy_field: false};
        assert!(0x2::dynamic_field::exists<AccountKey<T0>>(0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::uid(arg1), v0), 104);
        let v1 = AccountKey<T0>{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow_mut<AccountKey<T0>, Account<T0>>(0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::uid_mut(arg1), v1);
        assert!(v2.config_id == 0x2::object::id<Config>(arg0), 105);
        assert!(arg3 == v2.next_seq, 110);
        assert!(arg2 <= min(v2.max_charge_micro, arg0.max_charge_micro), 108);
        let v3 = 0x2::clock::timestamp_ms(arg4) / 86400000;
        if (v2.day != v3) {
            v2.day = v3;
            v2.spent_today = 0;
        };
        assert!(v2.spent_today + arg2 <= min(v2.max_day_micro, arg0.max_day_micro), 109);
        assert!(0x2::balance::value<T0>(&v2.balance) >= arg2, 107);
        v2.next_seq = arg3 + 1;
        v2.spent_today = v2.spent_today + arg2;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v2.balance, arg2), arg5), arg0.treasury);
        let v4 = Charged{
            agent_id : 0x2::object::id<0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::Aion>(arg1),
            key_id   : *0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::key_id(arg1),
            amount   : arg2,
            seq      : arg3,
            treasury : arg0.treasury,
        };
        0x2::event::emit<Charged>(v4);
    }

    fun emit_challenge(arg0: &0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::Aion, arg1: vector<u8>, arg2: vector<u8>) {
        assert_live(arg0);
        assert!(0x1::vector::length<u8>(&arg1) == 32 && 0x1::vector::length<u8>(&arg2) == 32, 117);
        let v0 = ChallengeAnswered{
            agent_id    : 0x2::object::id<0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::Aion>(arg0),
            key_id      : bound_key(arg0),
            nonce       : arg1,
            pubkey_hash : arg2,
        };
        0x2::event::emit<ChallengeAnswered>(v0);
    }

    public fun has_account<T0>(arg0: &0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::Aion) : bool {
        let v0 = AccountKey<T0>{dummy_field: false};
        0x2::dynamic_field::exists<AccountKey<T0>>(0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::uid(arg0), v0)
    }

    public fun is_paused(arg0: &Config) : bool {
        arg0.paused
    }

    public fun is_retired(arg0: &0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::Aion) : bool {
        let v0 = RetiredKey{dummy_field: false};
        0x2::dynamic_field::exists<RetiredKey>(0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::uid(arg0), v0)
    }

    public fun issuer_epoch(arg0: &Config) : u64 {
        arg0.issuer_epoch
    }

    fun min(arg0: u64, arg1: u64) : u64 {
        if (arg0 < arg1) {
            arg0
        } else {
            arg1
        }
    }

    public fun next_seq<T0>(arg0: &0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::Aion) : u64 {
        let v0 = AccountKey<T0>{dummy_field: false};
        assert!(0x2::dynamic_field::exists<AccountKey<T0>>(0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::uid(arg0), v0), 104);
        let v1 = AccountKey<T0>{dummy_field: false};
        0x2::dynamic_field::borrow<AccountKey<T0>, Account<T0>>(0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::uid(arg0), v1).next_seq
    }

    public fun register_charger<T0: drop>(arg0: &mut Config, arg1: &AdminCap) {
        assert_admin(arg0, arg1);
        let v0 = RegisteredCharger{witness: 0x1::type_name::with_defining_ids<T0>()};
        if (!0x2::dynamic_field::exists<RegisteredCharger>(&arg0.id, v0)) {
            0x2::dynamic_field::add<RegisteredCharger, bool>(&mut arg0.id, v0, true);
        };
    }

    public fun remove_charger<T0: drop>(arg0: &Config, arg1: &mut 0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::Aion, arg2: &0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::OwnerCap) {
        0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::check_owner(arg1, arg2);
        let v0 = ApprovedCharger{
            config_id : 0x2::object::id<Config>(arg0),
            witness   : 0x1::type_name::with_defining_ids<T0>(),
        };
        if (0x2::dynamic_field::exists<ApprovedCharger>(0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::uid(arg1), v0)) {
            0x2::dynamic_field::remove<ApprovedCharger, bool>(0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::uid_mut(arg1), v0);
        };
    }

    public fun retire_v2<T0>(arg0: &mut 0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::Aion, arg1: &0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::OwnerCap) {
        0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::check_owner(arg0, arg1);
        assert_live(arg0);
        assert!(account_balance<T0>(arg0) == 0, 114);
        let v0 = RetiredKey{dummy_field: false};
        0x2::dynamic_field::add<RetiredKey, bool>(0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::uid_mut(arg0), v0, true);
        0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::events::emit_agent_retired(0x2::object::id<0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::Aion>(arg0));
    }

    public fun revoke_charger<T0: drop>(arg0: &mut Config, arg1: &AdminCap) {
        assert_admin(arg0, arg1);
        let v0 = RegisteredCharger{witness: 0x1::type_name::with_defining_ids<T0>()};
        if (0x2::dynamic_field::exists<RegisteredCharger>(&arg0.id, v0)) {
            0x2::dynamic_field::remove<RegisteredCharger, bool>(&mut arg0.id, v0);
        };
    }

    public fun rotate_issuer(arg0: &mut Config, arg1: &AdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg1);
        arg0.issuer_epoch = arg0.issuer_epoch + 1;
        let v0 = IssuerCap{
            id        : 0x2::object::new(arg3),
            config_id : 0x2::object::id<Config>(arg0),
            epoch     : arg0.issuer_epoch,
        };
        0x2::transfer::public_transfer<IssuerCap>(v0, arg2);
    }

    public fun set_limits(arg0: &mut Config, arg1: &AdminCap, arg2: u64, arg3: u64, arg4: u64) {
        assert_admin(arg0, arg1);
        arg0.max_account_micro = arg2;
        arg0.max_charge_micro = arg3;
        arg0.max_day_micro = arg4;
    }

    public fun set_paused(arg0: &mut Config, arg1: &AdminCap, arg2: bool) {
        assert_admin(arg0, arg1);
        arg0.paused = arg2;
    }

    public fun set_policy<T0>(arg0: &Config, arg1: &mut 0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::Aion, arg2: &0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::OwnerCap, arg3: u64, arg4: u64) {
        0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::check_owner(arg1, arg2);
        let v0 = AccountKey<T0>{dummy_field: false};
        assert!(0x2::dynamic_field::exists<AccountKey<T0>>(0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::uid(arg1), v0), 104);
        assert!(arg3 <= arg0.max_charge_micro && arg4 <= arg0.max_day_micro, 112);
        let v1 = AccountKey<T0>{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow_mut<AccountKey<T0>, Account<T0>>(0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::uid_mut(arg1), v1);
        assert!(v2.config_id == 0x2::object::id<Config>(arg0), 105);
        v2.max_charge_micro = arg3;
        v2.max_day_micro = arg4;
        let v3 = PolicySet{
            agent_id         : 0x2::object::id<0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::Aion>(arg1),
            max_charge_micro : arg3,
            max_day_micro    : arg4,
        };
        0x2::event::emit<PolicySet>(v3);
    }

    public fun set_treasury(arg0: &mut Config, arg1: &AdminCap, arg2: address) {
        assert_admin(arg0, arg1);
        arg0.treasury = arg2;
    }

    public fun setup<T0>(arg0: 0x2::package::UpgradeCap, arg1: address, arg2: address, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::with_defining_ids<Config>();
        let v1 = 0x1::ascii::into_bytes(0x1::type_name::address_string(&v0));
        assert!(0x2::package::upgrade_package(&arg0) == 0x2::object::id_from_address(0x2::address::from_ascii_bytes(&v1)), 113);
        let v2 = if (arg1 != @0x0) {
            if (arg2 != @0x0) {
                arg1 != arg2
            } else {
                false
            }
        } else {
            false
        };
        assert!(v2, 121);
        let v3 = Config{
            id                : 0x2::object::new(arg6),
            treasury          : arg2,
            coin_type         : 0x1::type_name::with_defining_ids<T0>(),
            paused            : false,
            max_account_micro : arg3,
            max_charge_micro  : arg4,
            max_day_micro     : arg5,
            issuer_epoch      : 0,
        };
        let v4 = 0x2::object::id<Config>(&v3);
        0x2::transfer::public_transfer<0x2::package::UpgradeCap>(arg0, arg1);
        let v5 = AdminCap{
            id        : 0x2::object::new(arg6),
            config_id : v4,
        };
        0x2::transfer::public_transfer<AdminCap>(v5, arg1);
        let v6 = IssuerCap{
            id        : 0x2::object::new(arg6),
            config_id : v4,
            epoch     : 0,
        };
        0x2::transfer::public_transfer<IssuerCap>(v6, arg2);
        0x2::transfer::share_object<Config>(v3);
    }

    public fun spent_today<T0>(arg0: &0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::Aion) : u64 {
        let v0 = AccountKey<T0>{dummy_field: false};
        assert!(0x2::dynamic_field::exists<AccountKey<T0>>(0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::uid(arg0), v0), 104);
        let v1 = AccountKey<T0>{dummy_field: false};
        0x2::dynamic_field::borrow<AccountKey<T0>, Account<T0>>(0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::uid(arg0), v1).spent_today
    }

    public fun treasury(arg0: &Config) : address {
        arg0.treasury
    }

    public fun withdraw<T0>(arg0: &mut 0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::Aion, arg1: &0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::OwnerCap, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::check_owner(arg0, arg1);
        assert!(arg2 > 0, 103);
        let v0 = AccountKey<T0>{dummy_field: false};
        assert!(0x2::dynamic_field::exists<AccountKey<T0>>(0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::uid(arg0), v0), 104);
        let v1 = AccountKey<T0>{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow_mut<AccountKey<T0>, Account<T0>>(0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::uid_mut(arg0), v1);
        assert!(0x2::balance::value<T0>(&v2.balance) >= arg2, 107);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v2.balance, arg2), arg4), arg3);
        let v3 = Withdrawn{
            agent_id      : 0x2::object::id<0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::Aion>(arg0),
            recipient     : arg3,
            amount        : arg2,
            balance_after : 0x2::balance::value<T0>(&v2.balance),
        };
        0x2::event::emit<Withdrawn>(v3);
    }

    // decompiled from Move bytecode v7
}

