module 0x5a6ae39fd84a871e94c88badc7689debae22119461ba1581f674bfe50acc1271::distribution {
    struct DISTRIBUTION has drop {
        dummy_field: bool,
    }

    struct SetupCap has key {
        id: 0x2::object::UID,
    }

    struct PoolCap has store, key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
    }

    struct IKADropClaimed has store {
        claimed: u64,
        timestamp_ms: u64,
        human_id_sbt_id: 0x1::option::Option<0x2::object::ID>,
    }

    struct IKADrop has key {
        id: 0x2::object::UID,
        amount: u64,
        normalized_amount: u64,
        claimed: u64,
        normalized_claimed: u64,
        human_id_required: bool,
        claim_history: vector<IKADropClaimed>,
    }

    struct AirdropConfig has store {
        start_time_ms: u64,
        end_time_ms: u64,
        end_penalty_time_ms: u64,
        start_per_coin_penalty: u64,
    }

    struct Recipient has store {
        amount: u64,
        human_id_required: bool,
    }

    struct AirdropPool has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>,
        penalty_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        hashes: 0x2::vec_set::VecSet<address>,
        recipients: 0x2::table::Table<address, Recipient>,
        total_pool_amount: u64,
        config: 0x1::option::Option<AirdropConfig>,
    }

    public fun claim(arg0: &mut AirdropPool, arg1: &mut IKADrop, arg2: u64, arg3: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA> {
        claim_internal(arg0, arg1, arg2, arg3, false, 0x1::option::none<0x2::object::ID>(), arg4, arg5)
    }

    fun claim_internal(arg0: &mut AirdropPool, arg1: &mut IKADrop, arg2: u64, arg3: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg4: bool, arg5: 0x1::option::Option<0x2::object::ID>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA> {
        assert!(arg1.amount > 0, 10);
        assert!(arg1.amount >= arg2, 11);
        let v0 = 0x2::clock::timestamp_ms(arg6);
        if (arg1.human_id_required) {
            assert!(arg4 && 0x1::option::is_some<0x2::object::ID>(&arg5), 16);
            let v1 = IKADropClaimed{
                claimed         : arg2,
                timestamp_ms    : v0,
                human_id_sbt_id : arg5,
            };
            0x1::vector::push_back<IKADropClaimed>(&mut arg1.claim_history, v1);
        } else {
            let v2 = IKADropClaimed{
                claimed         : arg2,
                timestamp_ms    : v0,
                human_id_sbt_id : 0x1::option::none<0x2::object::ID>(),
            };
            0x1::vector::push_back<IKADropClaimed>(&mut arg1.claim_history, v2);
        };
        assert!(0x1::option::is_some<AirdropConfig>(&arg0.config), 12);
        let v3 = 0x1::option::borrow<AirdropConfig>(&arg0.config);
        assert!(v0 >= v3.start_time_ms && v0 <= v3.end_time_ms, 12);
        let v4 = if (v0 >= v3.end_penalty_time_ms) {
            0
        } else {
            let v5 = (arg2 as u256) * (v3.start_per_coin_penalty as u256) * (1000000000000000000 - ((v0 - v3.start_time_ms) as u256) * 1000000000000000000 / ((v3.end_penalty_time_ms - v3.start_time_ms) as u256)) / 1000000000000000000;
            if (v5 < 10000 && v5 > 0) {
                1
            } else {
                ((v5 / 10000) as u64)
            }
        };
        assert!(0x2::coin::value<0x2::sui::SUI>(arg3) >= v4, 13);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.penalty_balance, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(arg3, v4, arg7)));
        arg1.amount = arg1.amount - arg2;
        arg1.normalized_amount = arg1.amount / 1000000000;
        arg1.claimed = arg1.claimed + arg2;
        arg1.normalized_claimed = arg1.claimed / 1000000000;
        0x2::coin::from_balance<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>(0x2::balance::split<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>(&mut arg0.balance, arg2), arg7)
    }

    public fun claim_sbt(arg0: &mut AirdropPool, arg1: &mut IKADrop, arg2: u64, arg3: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x53ddebd997f0e57dc899d598f12001930e228dddadf268a41d4c9a7c1df47a97::sbt::SoulBoundToken, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA> {
        assert!(0x4527711bfa5dc375903e431f43e013e59c1973864b37270d4c2355b0bbc64ec0::sbt_verifier::verify_sbt_for_circuit_and_action(arg4, 19423862195071118118035339997374069146889939500094220754464143644873512189952, 7, arg5), 15);
        claim_internal(arg0, arg1, arg2, arg3, true, 0x1::option::some<0x2::object::ID>(0x2::object::id<0x53ddebd997f0e57dc899d598f12001930e228dddadf268a41d4c9a7c1df47a97::sbt::SoulBoundToken>(arg4)), arg5, arg6)
    }

    public fun collect_penalty(arg0: &mut AirdropPool, arg1: &PoolCap, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(0x2::object::uid_to_inner(&arg0.id) == arg1.pool_id, 14);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.penalty_balance, 0x2::balance::value<0x2::sui::SUI>(&arg0.penalty_balance)), arg2)
    }

    public fun collect_remaining_balance(arg0: &mut AirdropPool, arg1: &PoolCap, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA> {
        assert!(0x2::object::uid_to_inner(&arg0.id) == arg1.pool_id, 14);
        assert!(0x1::option::is_some<AirdropConfig>(&arg0.config) && 0x2::clock::timestamp_ms(arg2) >= 0x1::option::borrow<AirdropConfig>(&arg0.config).end_time_ms, 12);
        0x2::coin::from_balance<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>(0x2::balance::split<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>(&mut arg0.balance, 0x2::balance::value<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>(&arg0.balance)), arg3)
    }

    public fun distribute(arg0: &mut AirdropPool, arg1: vector<address>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::vec_set::size<address>(&arg0.hashes) == 0, 6);
        assert!(0x2::balance::value<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>(&arg0.balance) > 0, 8);
        0x1::vector::reverse<address>(&mut arg1);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg1)) {
            let v1 = 0x1::vector::pop_back<address>(&mut arg1);
            assert!(0x2::table::contains<address, Recipient>(&arg0.recipients, v1), 7);
            let Recipient {
                amount            : v2,
                human_id_required : v3,
            } = 0x2::table::remove<address, Recipient>(&mut arg0.recipients, v1);
            let v4 = IKADrop{
                id                 : 0x2::object::new(arg2),
                amount             : v2,
                normalized_amount  : v2 / 1000000000,
                claimed            : 0,
                normalized_claimed : 0,
                human_id_required  : v3,
                claim_history      : 0x1::vector::empty<IKADropClaimed>(),
            };
            0x2::transfer::transfer<IKADrop>(v4, v1);
            v0 = v0 + 1;
        };
        0x1::vector::destroy_empty<address>(arg1);
    }

    public fun fund_pool(arg0: &mut AirdropPool, arg1: 0x2::coin::Coin<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>) {
        assert!(0x2::table::length<address, Recipient>(&arg0.recipients) > 0, 6);
        assert!(0x2::vec_set::size<address>(&arg0.hashes) == 0, 6);
        assert!(0x2::balance::value<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>(&arg0.balance) == 0, 9);
        assert!(0x2::coin::value<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>(&arg1) == arg0.total_pool_amount, 4);
        0x2::coin::put<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>(&mut arg0.balance, arg1);
    }

    fun init(arg0: DISTRIBUTION, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<DISTRIBUTION>(arg0, arg1);
        let v0 = 0x2::object::new(arg1);
        let v1 = AirdropPool{
            id                : v0,
            balance           : 0x2::balance::zero<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>(),
            penalty_balance   : 0x2::balance::zero<0x2::sui::SUI>(),
            hashes            : 0x2::vec_set::empty<address>(),
            recipients        : 0x2::table::new<address, Recipient>(arg1),
            total_pool_amount : 0,
            config            : 0x1::option::none<AirdropConfig>(),
        };
        0x2::transfer::share_object<AirdropPool>(v1);
        let v2 = SetupCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<SetupCap>(v2, 0x2::tx_context::sender(arg1));
        let v3 = PoolCap{
            id      : 0x2::object::new(arg1),
            pool_id : 0x2::object::uid_to_inner(&v0),
        };
        0x2::transfer::transfer<PoolCap>(v3, 0x2::tx_context::sender(arg1));
    }

    public fun is_human_id_required(arg0: &IKADrop) : bool {
        arg0.human_id_required
    }

    public fun prepare_recipients(arg0: &mut AirdropPool, arg1: vector<address>, arg2: vector<u64>, arg3: vector<bool>) {
        assert!(0x1::vector::length<address>(&arg1) == 0x1::vector::length<u64>(&arg2) && 0x1::vector::length<address>(&arg1) == 0x1::vector::length<bool>(&arg3), 3);
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<vector<address>>(&arg1));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<vector<u64>>(&arg2));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<vector<bool>>(&arg3));
        let v1 = 0x2::address::from_bytes(0x2::hash::blake2b256(&v0));
        assert!(0x2::vec_set::contains<address>(&arg0.hashes, &v1), 2);
        0x2::vec_set::remove<address>(&mut arg0.hashes, &v1);
        let v2 = 0;
        while (v2 < 0x1::vector::length<address>(&arg1)) {
            let v3 = 0x1::vector::pop_back<u64>(&mut arg2);
            arg0.total_pool_amount = arg0.total_pool_amount + v3;
            let v4 = Recipient{
                amount            : v3,
                human_id_required : 0x1::vector::pop_back<bool>(&mut arg3),
            };
            0x2::table::add<address, Recipient>(&mut arg0.recipients, 0x1::vector::pop_back<address>(&mut arg1), v4);
            v2 = v2 + 1;
        };
    }

    public fun set_config(arg0: &mut AirdropPool, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: &PoolCap) {
        assert!(arg1 < arg3, 12);
        assert!(arg3 < arg2, 12);
        assert!(arg4 > 0, 4);
        assert!(0x2::object::uid_to_inner(&arg0.id) == arg5.pool_id, 14);
        if (0x1::option::is_some<AirdropConfig>(&arg0.config)) {
            let v0 = 0x1::option::borrow_mut<AirdropConfig>(&mut arg0.config);
            v0.start_time_ms = arg1;
            v0.end_time_ms = arg2;
            v0.end_penalty_time_ms = arg3;
            v0.start_per_coin_penalty = arg4;
        } else {
            let v1 = AirdropConfig{
                start_time_ms          : arg1,
                end_time_ms            : arg2,
                end_penalty_time_ms    : arg3,
                start_per_coin_penalty : arg4,
            };
            0x1::option::fill<AirdropConfig>(&mut arg0.config, v1);
        };
    }

    public fun setup(arg0: &mut AirdropPool, arg1: SetupCap, arg2: vector<address>) {
        let SetupCap { id: v0 } = arg1;
        0x2::object::delete(v0);
        0x1::vector::reverse<address>(&mut arg2);
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&arg2)) {
            let v2 = 0x1::vector::pop_back<address>(&mut arg2);
            assert!(!0x2::vec_set::contains<address>(&arg0.hashes, &v2), 1);
            0x2::vec_set::insert<address>(&mut arg0.hashes, v2);
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<address>(arg2);
    }

    // decompiled from Move bytecode v6
}

