module 0x3d72b6111a46cd0baee2c3ad89ab46f8b2f82b1f2dc9ba451ee911b93ddd0525::giveaway {
    struct Giveaway has copy, drop, store {
        dummy_field: bool,
    }

    struct GiveawayRegistryKey has copy, drop, store {
        dummy_field: bool,
    }

    struct GiveawayRegistry has store, key {
        id: 0x2::object::UID,
        version_set: 0x2::vec_set::VecSet<u64>,
        is_enabled: bool,
        next_giveaway_id: u64,
        active_giveaways: vector<u64>,
    }

    struct GiveawayKey has copy, drop, store {
        pos0: u64,
    }

    struct GiveawayEntryKey has copy, drop, store {
        pos0: address,
    }

    struct GiveawayEntry has store, key {
        id: 0x2::object::UID,
        count: u64,
    }

    struct GiveawayObject has store, key {
        id: 0x2::object::UID,
        giveaway_id: u64,
        created_at_ms: u64,
        entry_deadline_ms: u64,
        claim_deadline_ms: 0x1::option::Option<u64>,
        min_daily_streak: 0x1::option::Option<u64>,
        min_vip_level: 0x1::option::Option<u64>,
        apply_anti_bot_penalty: bool,
        rewards: vector<GiveawayReward>,
        winners: vector<0x1::option::Option<address>>,
        reward_coin_claims: vector<vector<bool>>,
        candidate_players: vector<address>,
        total_participants: u64,
        is_settled: bool,
        settled_at_ms: 0x1::option::Option<u64>,
    }

    struct GiveawayReward has drop, store {
        coin_rewards: vector<GiveawayCoinReward>,
    }

    struct GiveawayCoinReward has drop, store {
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
        sweet_house_id: 0x2::object::ID,
        rakeback_pool_total_snapshot: u64,
    }

    struct GiveawayRegistryCreatedEvent has copy, drop {
        is_enabled: bool,
    }

    struct GiveawayRegistryEnabledEvent has copy, drop {
        previous_is_enabled: bool,
        is_enabled: bool,
    }

    struct GiveawayRegistryVersionChangedEvent has copy, drop {
        version_number: u64,
        is_added: bool,
    }

    struct GiveawayCreatedEvent has copy, drop {
        giveaway_id: u64,
        entry_deadline_ms: u64,
        claim_deadline_ms: 0x1::option::Option<u64>,
        min_daily_streak: 0x1::option::Option<u64>,
        min_vip_level: 0x1::option::Option<u64>,
        apply_anti_bot_penalty: bool,
        reward_count: u64,
    }

    struct GiveawayRewardCoinUpsertedEvent has copy, drop {
        giveaway_id: u64,
        reward_index: u64,
        coin_type: 0x1::type_name::TypeName,
        previous_amount: u64,
        new_amount: u64,
        is_new_reward_index: bool,
        is_new_coin: bool,
    }

    struct GiveawayEntryEvent has copy, drop {
        giveaway_id: u64,
        player: address,
        total_participants: u64,
        candidate_count: u64,
    }

    struct GiveawaySettledEvent has copy, drop {
        giveaway_id: u64,
        settled_at_ms: u64,
        winner_count: u64,
        winners: vector<0x1::option::Option<address>>,
    }

    struct GiveawayRewardClaimedEvent<phantom T0> has copy, drop {
        giveaway_id: u64,
        player: address,
        reward_index: u64,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    fun add_or_increase_giveaway_reward_coin_internal<T0>(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: &0x2::clock::Clock, arg2: u64, arg3: u64, arg4: u64) {
        assert!(arg4 > 0, 13843786661487116348);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = 0x2::object::id<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse>(arg0);
        let v2 = 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::total_rakeback_pool_balance<T0>(arg0);
        let v3 = borrow_giveaway_registry_mut(arg0);
        assert!(v3.is_enabled, 13835905387905613832);
        let v4 = borrow_giveaway_mut(v3, arg2);
        assert!(!v4.is_settled, 13839001625535512602);
        assert!(0x2::clock::timestamp_ms(arg1) <= v4.entry_deadline_ms, 13836468355039166476);
        let v5 = 0x1::vector::length<GiveawayReward>(&v4.rewards);
        assert!(arg3 <= v5, 13843505242344849466);
        let v6 = 0;
        let v7 = false;
        let v8 = false;
        if (arg3 == v5) {
            assert!(v5 < 200, 13837312822919233552);
            let v9 = GiveawayCoinReward{
                coin_type                    : v0,
                amount                       : arg4,
                sweet_house_id               : v1,
                rakeback_pool_total_snapshot : v2,
            };
            let v10 = 0x1::vector::empty<GiveawayCoinReward>();
            0x1::vector::push_back<GiveawayCoinReward>(&mut v10, v9);
            0x1::vector::push_back<GiveawayReward>(&mut v4.rewards, make_reward(v10));
            v7 = true;
            v8 = true;
        } else {
            let v11 = 0x1::vector::borrow_mut<GiveawayReward>(&mut v4.rewards, arg3);
            let v12 = false;
            let v13 = 0;
            while (v13 < 0x1::vector::length<GiveawayCoinReward>(&v11.coin_rewards)) {
                let v14 = 0x1::vector::borrow_mut<GiveawayCoinReward>(&mut v11.coin_rewards, v13);
                if (v14.coin_type == v0) {
                    v6 = v14.amount;
                    assert!(arg4 > v14.amount, 13844349783239491648);
                    v14.amount = arg4;
                    v12 = true;
                    break
                };
                v13 = v13 + 1;
            };
            if (!v12) {
                assert!(0x1::vector::length<GiveawayCoinReward>(&v11.coin_rewards) < 100, 13837875906016903188);
                let v15 = GiveawayCoinReward{
                    coin_type                    : v0,
                    amount                       : arg4,
                    sweet_house_id               : v1,
                    rakeback_pool_total_snapshot : v2,
                };
                0x1::vector::push_back<GiveawayCoinReward>(&mut v11.coin_rewards, v15);
                v8 = true;
            };
        };
        let v16 = 0;
        let v17 = 0;
        while (v17 < 0x1::vector::length<GiveawayReward>(&v4.rewards)) {
            let v18 = 0x1::vector::borrow<GiveawayReward>(&v4.rewards, v17);
            let v19 = 0;
            while (v19 < 0x1::vector::length<GiveawayCoinReward>(&v18.coin_rewards)) {
                let v20 = 0x1::vector::borrow<GiveawayCoinReward>(&v18.coin_rewards, v19);
                if (v20.coin_type == v0) {
                    v16 = v16 + v20.amount;
                };
                v19 = v19 + 1;
            };
            v17 = v17 + 1;
        };
        assert!(0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::total_rakeback_pool_balance<T0>(arg0) >= v16, 13844068497241210942);
        let v21 = GiveawayRewardCoinUpsertedEvent{
            giveaway_id         : arg2,
            reward_index        : arg3,
            coin_type           : v0,
            previous_amount     : v6,
            new_amount          : arg4,
            is_new_reward_index : v7,
            is_new_coin         : v8,
        };
        0x2::event::emit<GiveawayRewardCoinUpsertedEvent>(v21);
    }

    public fun admin_add_or_increase_giveaway_reward_coin<T0>(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::AdminCap, arg2: &0x2::clock::Clock, arg3: u64, arg4: u64, arg5: u64) {
        assert!(registry_exists(arg0), 13835342858858725380);
        add_or_increase_giveaway_reward_coin_internal<T0>(arg0, arg2, arg3, arg4, arg5);
    }

    public fun admin_add_version(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::AdminCap, arg2: u64) {
        let v0 = borrow_giveaway_registry_mut_unchecked(arg0);
        if (!0x2::vec_set::contains<u64>(&v0.version_set, &arg2)) {
            0x2::vec_set::insert<u64>(&mut v0.version_set, arg2);
            let v1 = GiveawayRegistryVersionChangedEvent{
                version_number : arg2,
                is_added       : true,
            };
            0x2::event::emit<GiveawayRegistryVersionChangedEvent>(v1);
        };
    }

    public fun admin_create_giveaway(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::AdminCap, arg2: &0x2::clock::Clock, arg3: u64, arg4: 0x1::option::Option<u64>, arg5: 0x1::option::Option<u64>, arg6: 0x1::option::Option<u64>, arg7: vector<GiveawayReward>, arg8: bool, arg9: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(registry_exists(arg0), 13835342197433761796);
        create_giveaway_internal(arg0, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
    }

    public fun admin_create_registry(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        create_registry_internal(arg0, arg2);
    }

    public fun admin_remove_version(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::AdminCap, arg2: u64) {
        let v0 = borrow_giveaway_registry_mut_unchecked(arg0);
        remove_version_internal(v0, arg2);
    }

    public fun admin_set_registry_enabled(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::AdminCap, arg2: bool) {
        set_registry_enabled_internal(arg0, arg2);
    }

    fun apply_anti_bot_gas_penalty(arg0: &mut 0x2::tx_context::TxContext) {
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::create_and_transfer_gas_object(b"GIVEAWAY_ANTI_BOT", arg0);
    }

    fun assert_valid_version(arg0: &GiveawayRegistry) {
        let v0 = package_version();
        assert!(0x2::vec_set::contains<u64>(&arg0.version_set, &v0), 13842940522864640054);
    }

    fun assign_winners(arg0: &mut GiveawayObject, arg1: &0x2::random::Random, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::option::Option<address>>();
        let v1 = 0x1::vector::empty<vector<bool>>();
        let v2 = 0x1::vector::empty<address>();
        let v3 = 0;
        while (v3 < 0x1::vector::length<address>(&arg0.candidate_players)) {
            0x1::vector::push_back<address>(&mut v2, *0x1::vector::borrow<address>(&arg0.candidate_players, v3));
            v3 = v3 + 1;
        };
        let v4 = 0x2::random::new_generator(arg1, arg2);
        let v5 = 0;
        while (v5 < 0x1::vector::length<GiveawayReward>(&arg0.rewards)) {
            let v6 = 0x1::vector::borrow<GiveawayReward>(&arg0.rewards, v5);
            let v7 = 0x1::vector::empty<bool>();
            let v8 = 0;
            while (v8 < 0x1::vector::length<GiveawayCoinReward>(&v6.coin_rewards)) {
                0x1::vector::push_back<bool>(&mut v7, false);
                v8 = v8 + 1;
            };
            if (0x1::vector::length<address>(&v2) == 0 && 0x1::vector::length<address>(&arg0.candidate_players) > 0) {
                let v9 = 0;
                while (v9 < 0x1::vector::length<address>(&arg0.candidate_players)) {
                    0x1::vector::push_back<address>(&mut v2, *0x1::vector::borrow<address>(&arg0.candidate_players, v9));
                    v9 = v9 + 1;
                };
            };
            if (0x1::vector::length<address>(&v2) > 0) {
                0x1::vector::push_back<0x1::option::Option<address>>(&mut v0, 0x1::option::some<address>(0x1::vector::swap_remove<address>(&mut v2, 0x2::random::generate_u64_in_range(&mut v4, 0, 0x1::vector::length<address>(&v2) - 1))));
                0x1::vector::push_back<vector<bool>>(&mut v1, v7);
            } else {
                0x1::vector::push_back<0x1::option::Option<address>>(&mut v0, 0x1::option::none<address>());
                0x1::vector::push_back<vector<bool>>(&mut v1, v7);
            };
            v5 = v5 + 1;
        };
        arg0.winners = v0;
        arg0.reward_coin_claims = v1;
    }

    public fun borrow_giveaway(arg0: &GiveawayRegistry, arg1: u64) : &GiveawayObject {
        assert_valid_version(arg0);
        assert!(giveaway_exists(arg0, arg1), 13836185471313051658);
        let v0 = GiveawayKey{pos0: arg1};
        0x2::dynamic_object_field::borrow<GiveawayKey, GiveawayObject>(&arg0.id, v0)
    }

    fun borrow_giveaway_mut(arg0: &mut GiveawayRegistry, arg1: u64) : &mut GiveawayObject {
        assert!(giveaway_exists(arg0, arg1), 13836185492787888138);
        let v0 = GiveawayKey{pos0: arg1};
        0x2::dynamic_object_field::borrow_mut<GiveawayKey, GiveawayObject>(&mut arg0.id, v0)
    }

    public fun borrow_giveaway_registry(arg0: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse) : &GiveawayRegistry {
        let v0 = borrow_giveaway_registry_unchecked(arg0);
        assert_valid_version(v0);
        v0
    }

    fun borrow_giveaway_registry_mut(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse) : &mut GiveawayRegistry {
        let v0 = borrow_giveaway_registry_mut_unchecked(arg0);
        assert_valid_version(v0);
        v0
    }

    fun borrow_giveaway_registry_mut_unchecked(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse) : &mut GiveawayRegistry {
        let v0 = Giveaway{dummy_field: false};
        let v1 = GiveawayRegistryKey{dummy_field: false};
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::operator_borrow_operator_dof_mut<Giveaway, GiveawayRegistryKey, GiveawayRegistry>(arg0, v0, v1)
    }

    fun borrow_giveaway_registry_unchecked(arg0: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse) : &GiveawayRegistry {
        let v0 = GiveawayRegistryKey{dummy_field: false};
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::borrow_operator_dof<Giveaway, GiveawayRegistryKey, GiveawayRegistry>(arg0, v0)
    }

    public fun claim_reward_coin<T0>(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: &0x2::clock::Clock, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(registry_exists(arg0), 13835344022794862596);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = borrow_giveaway_registry_mut(arg0);
        let v2 = borrow_giveaway_mut(v1, arg2);
        assert!(v2.is_settled, 13839284702535155740);
        if (0x1::option::is_some<u64>(&v2.claim_deadline_ms)) {
            assert!(0x2::clock::timestamp_ms(arg1) <= *0x1::option::borrow<u64>(&v2.claim_deadline_ms), 13839566194691866654);
        };
        let v3 = 0x1::type_name::with_defining_ids<T0>();
        let (v4, v5, v6, v7, v8, v9) = find_claimable_reward_coin_slot(&v2.winners, &v2.rewards, &v2.reward_coin_claims, v0, &v3);
        assert!(v4, 13840410696931803172);
        assert!(v5, 13840129226249928738);
        assert!(v6, 13839847755568054304);
        *0x1::vector::borrow_mut<bool>(0x1::vector::borrow_mut<vector<bool>>(&mut v2.reward_coin_claims, v7), v8) = true;
        if (v9 == 0) {
            return 0x2::coin::zero<T0>(arg3)
        };
        assert!(0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::total_rakeback_pool_balance<T0>(arg0) >= v9, 13842662565466013748);
        let v10 = Giveaway{dummy_field: false};
        let v11 = GiveawayRewardClaimedEvent<T0>{
            giveaway_id  : arg2,
            player       : v0,
            reward_index : v7,
            coin_type    : v3,
            amount       : v9,
        };
        0x2::event::emit<GiveawayRewardClaimedEvent<T0>>(v11);
        0x2::coin::from_balance<T0>(0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::operator_take_from_rakeback_pool<T0, Giveaway>(arg0, v10, v9), arg3)
    }

    fun copy_winner_slots(arg0: &vector<0x1::option::Option<address>>) : vector<0x1::option::Option<address>> {
        let v0 = 0x1::vector::empty<0x1::option::Option<address>>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::option::Option<address>>(arg0)) {
            0x1::vector::push_back<0x1::option::Option<address>>(&mut v0, *0x1::vector::borrow<0x1::option::Option<address>>(arg0, v1));
            v1 = v1 + 1;
        };
        v0
    }

    fun count_winners(arg0: &vector<0x1::option::Option<address>>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::option::Option<address>>(arg0)) {
            if (0x1::option::is_some<address>(0x1::vector::borrow<0x1::option::Option<address>>(arg0, v1))) {
                v0 = v0 + 1;
            };
            v1 = v1 + 1;
        };
        v0
    }

    fun create_giveaway_internal(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: &0x2::clock::Clock, arg2: u64, arg3: 0x1::option::Option<u64>, arg4: 0x1::option::Option<u64>, arg5: 0x1::option::Option<u64>, arg6: vector<GiveawayReward>, arg7: bool, arg8: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(arg2 > v0, 13840971331898114088);
        if (0x1::option::is_some<u64>(&arg3)) {
            let v1 = 0x1::option::borrow<u64>(&arg3);
            assert!(*v1 > arg2, 13841252824054825002);
            assert!(*v1 - arg2 >= 86400000, 13841534303326634028);
        };
        ensure_reward_shape(&arg6);
        validate_reward_coin_configuration_on_create(arg0, &arg6);
        let v2 = borrow_giveaway_registry_mut(arg0);
        assert!(v2.is_enabled, 13835904838149799944);
        let v3 = v2.next_giveaway_id;
        v2.next_giveaway_id = v3 + 1;
        let v4 = GiveawayObject{
            id                     : 0x2::object::new(arg8),
            giveaway_id            : v3,
            created_at_ms          : v0,
            entry_deadline_ms      : arg2,
            claim_deadline_ms      : arg3,
            min_daily_streak       : arg4,
            min_vip_level          : arg5,
            apply_anti_bot_penalty : arg7,
            rewards                : arg6,
            winners                : 0x1::vector::empty<0x1::option::Option<address>>(),
            reward_coin_claims     : 0x1::vector::empty<vector<bool>>(),
            candidate_players      : 0x1::vector::empty<address>(),
            total_participants     : 0,
            is_settled             : false,
            settled_at_ms          : 0x1::option::none<u64>(),
        };
        let v5 = GiveawayKey{pos0: v3};
        0x2::dynamic_object_field::add<GiveawayKey, GiveawayObject>(&mut v2.id, v5, v4);
        push_active_giveaway(v2, v3);
        let v6 = GiveawayCreatedEvent{
            giveaway_id            : v3,
            entry_deadline_ms      : arg2,
            claim_deadline_ms      : arg3,
            min_daily_streak       : arg4,
            min_vip_level          : arg5,
            apply_anti_bot_penalty : arg7,
            reward_count           : 0x1::vector::length<GiveawayReward>(&arg6),
        };
        0x2::event::emit<GiveawayCreatedEvent>(v6);
        let v7 = borrow_giveaway(v2, v3);
        let v8 = 0;
        while (v8 < 0x1::vector::length<GiveawayReward>(&v7.rewards)) {
            let v9 = 0x1::vector::borrow<GiveawayReward>(&v7.rewards, v8);
            let v10 = 0;
            while (v10 < 0x1::vector::length<GiveawayCoinReward>(&v9.coin_rewards)) {
                let v11 = 0x1::vector::borrow<GiveawayCoinReward>(&v9.coin_rewards, v10);
                let v12 = GiveawayRewardCoinUpsertedEvent{
                    giveaway_id         : v3,
                    reward_index        : v8,
                    coin_type           : v11.coin_type,
                    previous_amount     : 0,
                    new_amount          : v11.amount,
                    is_new_reward_index : true,
                    is_new_coin         : true,
                };
                0x2::event::emit<GiveawayRewardCoinUpsertedEvent>(v12);
                v10 = v10 + 1;
            };
            v8 = v8 + 1;
        };
        v3
    }

    fun create_registry_internal(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(!registry_exists(arg0), 13835622572898975750);
        let v0 = GiveawayRegistry{
            id               : 0x2::object::new(arg1),
            version_set      : 0x2::vec_set::singleton<u64>(0),
            is_enabled       : true,
            next_giveaway_id : 0,
            active_giveaways : 0x1::vector::empty<u64>(),
        };
        let v1 = Giveaway{dummy_field: false};
        let v2 = GiveawayRegistryKey{dummy_field: false};
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::operator_add_operator_dof<Giveaway, GiveawayRegistryKey, GiveawayRegistry>(arg0, v1, v2, v0);
        let v3 = GiveawayRegistryCreatedEvent{is_enabled: true};
        0x2::event::emit<GiveawayRegistryCreatedEvent>(v3);
    }

    fun ensure_player_eligible(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: 0x1::option::Option<u64>, arg2: 0x1::option::Option<u64>, arg3: address, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        if (0x1::option::is_some<u64>(&arg1)) {
            let v0 = 0x1::option::borrow<u64>(&arg1);
            let (v1, _, _, _, v5) = 0xf6e2790a50f0618f65d78c598fdc5852650fcfee86528c24043c0de02af27d9::daily_streak::read_and_sync_user_daily_streak_state(arg0, arg3, arg4, arg5);
            assert!(!v5, 13841817221412487214);
            assert!(v1 >= *v0, 13842098700684296240);
        };
        if (0x1::option::is_some<u64>(&arg2)) {
            let (v6, _) = 0x25980ae9e9d1a5c204a1a9f7dcccad313305567e9bce7ec99b64009b1680e24f::vip::read_player_vip_data(arg0, arg3, arg5);
            assert!(v6 >= *0x1::option::borrow<u64>(&arg2), 13842380201430941746);
        };
    }

    fun ensure_reward_shape(arg0: &vector<GiveawayReward>) {
        let v0 = 0x1::vector::length<GiveawayReward>(arg0);
        assert!(v0 <= 200, 13837311753472376848);
        if (v0 == 0) {
            return
        };
        let v1 = 0;
        while (v1 < v0) {
            let v2 = 0x1::vector::borrow<GiveawayReward>(arg0, v1);
            let v3 = 0x1::vector::length<GiveawayCoinReward>(&v2.coin_rewards);
            assert!(v3 > 0, 13838156212762640406);
            assert!(v3 <= 100, 13837874742080765972);
            let v4 = 0x1::vector::empty<0x1::type_name::TypeName>();
            let v5 = 0;
            while (v5 < v3) {
                let v6 = &0x1::vector::borrow<GiveawayCoinReward>(&v2.coin_rewards, v5).coin_type;
                let (v7, _) = 0x1::vector::index_of<0x1::type_name::TypeName>(&v4, v6);
                assert!(!v7, 13840689526208790566);
                0x1::vector::push_back<0x1::type_name::TypeName>(&mut v4, *v6);
                v5 = v5 + 1;
            };
            v1 = v1 + 1;
        };
    }

    entry fun enter_giveaway(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: &0x2::clock::Clock, arg2: &0x2::random::Random, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(registry_exists(arg0), 13835343039247351812);
        let v1 = borrow_giveaway_registry(arg0);
        assert!(v1.is_enabled, 13835906014970839048);
        let v2 = borrow_giveaway(v1, arg3);
        assert!(!v2.is_settled, 13839002248305770522);
        assert!(0x2::clock::timestamp_ms(arg1) <= v2.entry_deadline_ms, 13836469007874195468);
        ensure_player_eligible(arg0, v2.min_daily_streak, v2.min_vip_level, v0, arg1, arg4);
        let v3 = borrow_giveaway_registry_mut(arg0);
        let v4 = borrow_giveaway_mut(v3, arg3);
        assert!(!v4.is_settled, 13839002312730279962);
        assert!(0x2::clock::timestamp_ms(arg1) <= v4.entry_deadline_ms, 13836469042233933836);
        let v5 = GiveawayEntryKey{pos0: v0};
        assert!(!0x2::dynamic_object_field::exists_<GiveawayEntryKey>(&v4.id, v5), 13836750530095677454);
        let v6 = GiveawayEntry{
            id    : 0x2::object::new(arg4),
            count : 1,
        };
        0x2::dynamic_object_field::add<GiveawayEntryKey, GiveawayEntry>(&mut v4.id, v5, v6);
        v4.total_participants = v4.total_participants + 1;
        reservoir_sample_player(v4, v0, arg2, arg4);
        let v7 = GiveawayEntryEvent{
            giveaway_id        : arg3,
            player             : v0,
            total_participants : v4.total_participants,
            candidate_count    : 0x1::vector::length<address>(&v4.candidate_players),
        };
        0x2::event::emit<GiveawayEntryEvent>(v7);
        if (v4.apply_anti_bot_penalty) {
            apply_anti_bot_gas_penalty(arg4);
        };
    }

    fun find_claimable_reward_coin_slot(arg0: &vector<0x1::option::Option<address>>, arg1: &vector<GiveawayReward>, arg2: &vector<vector<bool>>, arg3: address, arg4: &0x1::type_name::TypeName) : (bool, bool, bool, u64, u64, u64) {
        let v0 = false;
        let v1 = false;
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::option::Option<address>>(arg0)) {
            let v3 = 0x1::vector::borrow<0x1::option::Option<address>>(arg0, v2);
            if (0x1::option::is_some<address>(v3)) {
                if (*0x1::option::borrow<address>(v3) == arg3) {
                    v0 = true;
                    let (v4, v5, v6) = find_reward_coin(0x1::vector::borrow<GiveawayReward>(arg1, v2), arg4);
                    if (v4) {
                        v1 = true;
                        if (!*0x1::vector::borrow<bool>(0x1::vector::borrow<vector<bool>>(arg2, v2), v5)) {
                            return (true, true, true, v2, v5, v6)
                        };
                    };
                };
            };
            v2 = v2 + 1;
        };
        (v0, v1, false, 0, 0, 0)
    }

    fun find_reward_coin(arg0: &GiveawayReward, arg1: &0x1::type_name::TypeName) : (bool, u64, u64) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<GiveawayCoinReward>(&arg0.coin_rewards)) {
            let v1 = 0x1::vector::borrow<GiveawayCoinReward>(&arg0.coin_rewards, v0);
            if (&v1.coin_type == arg1) {
                return (true, v0, v1.amount)
            };
            v0 = v0 + 1;
        };
        (false, 0, 0)
    }

    fun giveaway_exists(arg0: &GiveawayRegistry, arg1: u64) : bool {
        let v0 = GiveawayKey{pos0: arg1};
        0x2::dynamic_object_field::exists_<GiveawayKey>(&arg0.id, v0)
    }

    public fun make_coin_reward<T0>(arg0: u64) : GiveawayCoinReward {
        GiveawayCoinReward{
            coin_type                    : 0x1::type_name::with_defining_ids<T0>(),
            amount                       : arg0,
            sweet_house_id               : 0x2::object::id_from_address(@0x0),
            rakeback_pool_total_snapshot : 0,
        }
    }

    public fun make_coin_reward_for_house<T0>(arg0: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: u64) : GiveawayCoinReward {
        let v0 = if (0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::house_exists<T0>(arg0)) {
            0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::total_rakeback_pool_balance<T0>(arg0)
        } else {
            0
        };
        GiveawayCoinReward{
            coin_type                    : 0x1::type_name::with_defining_ids<T0>(),
            amount                       : arg1,
            sweet_house_id               : 0x2::object::id<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse>(arg0),
            rakeback_pool_total_snapshot : v0,
        }
    }

    public fun make_reward(arg0: vector<GiveawayCoinReward>) : GiveawayReward {
        let v0 = 0x1::vector::length<GiveawayCoinReward>(&arg0);
        assert!(v0 > 0, 13838155100366110742);
        assert!(v0 <= 100, 13837873629684236308);
        let v1 = 0x1::vector::empty<0x1::type_name::TypeName>();
        let v2 = 0;
        while (v2 < v0) {
            let v3 = &0x1::vector::borrow<GiveawayCoinReward>(&arg0, v2).coin_type;
            let (v4, _) = 0x1::vector::index_of<0x1::type_name::TypeName>(&v1, v3);
            assert!(!v4, 13840688409517293606);
            0x1::vector::push_back<0x1::type_name::TypeName>(&mut v1, *v3);
            v2 = v2 + 1;
        };
        GiveawayReward{coin_rewards: arg0}
    }

    public fun manager_add_or_increase_giveaway_reward_coin<T0>(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::ManagerRegistry, arg2: &0x2::clock::Clock, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::assert_is_manager<Giveaway>(arg1, 0x2::tx_context::sender(arg6));
        assert!(registry_exists(arg0), 13835342944758071300);
        add_or_increase_giveaway_reward_coin_internal<T0>(arg0, arg2, arg3, arg4, arg5);
    }

    public fun manager_create_giveaway(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::ManagerRegistry, arg2: &0x2::clock::Clock, arg3: u64, arg4: 0x1::option::Option<u64>, arg5: 0x1::option::Option<u64>, arg6: 0x1::option::Option<u64>, arg7: vector<GiveawayReward>, arg8: bool, arg9: &mut 0x2::tx_context::TxContext) : u64 {
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::assert_is_manager<Giveaway>(arg1, 0x2::tx_context::sender(arg9));
        assert!(registry_exists(arg0), 13835342313397878788);
        create_giveaway_internal(arg0, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
    }

    public fun manager_create_registry(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::ManagerRegistry, arg2: &mut 0x2::tx_context::TxContext) {
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::assert_is_manager<Giveaway>(arg1, 0x2::tx_context::sender(arg2));
        create_registry_internal(arg0, arg2);
    }

    public fun manager_remove_version(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::ManagerRegistry, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::assert_is_manager<Giveaway>(arg1, 0x2::tx_context::sender(arg3));
        let v0 = borrow_giveaway_registry_mut_unchecked(arg0);
        remove_version_internal(v0, arg2);
    }

    public fun manager_set_registry_enabled(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::ManagerRegistry, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::assert_is_manager<Giveaway>(arg1, 0x2::tx_context::sender(arg3));
        set_registry_enabled_internal(arg0, arg2);
    }

    fun move_to_settled(arg0: &mut GiveawayRegistry, arg1: u64) {
        let (v0, v1) = 0x1::vector::index_of<u64>(&arg0.active_giveaways, &arg1);
        if (v0) {
            0x1::vector::swap_remove<u64>(&mut arg0.active_giveaways, v1);
        };
    }

    fun package_version() : u64 {
        0
    }

    fun push_active_giveaway(arg0: &mut GiveawayRegistry, arg1: u64) {
        0x1::vector::push_back<u64>(&mut arg0.active_giveaways, arg1);
    }

    fun registry_exists(arg0: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse) : bool {
        let v0 = GiveawayRegistryKey{dummy_field: false};
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::dof_exists<GiveawayRegistryKey>(arg0, v0)
    }

    fun remove_version_internal(arg0: &mut GiveawayRegistry, arg1: u64) {
        assert!(0x2::vec_set::contains<u64>(&arg0.version_set, &arg1), 13843222234064683064);
        0x2::vec_set::remove<u64>(&mut arg0.version_set, &arg1);
        let v0 = GiveawayRegistryVersionChangedEvent{
            version_number : arg1,
            is_added       : false,
        };
        0x2::event::emit<GiveawayRegistryVersionChangedEvent>(v0);
    }

    fun reservoir_sample_player(arg0: &mut GiveawayObject, arg1: address, arg2: &0x2::random::Random, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::random::new_generator(arg2, arg3);
        if (0x1::vector::length<address>(&arg0.candidate_players) < 200) {
            0x1::vector::push_back<address>(&mut arg0.candidate_players, arg1);
            return
        };
        let v1 = arg0.total_participants;
        let v2 = if (v1 == 0) {
            0
        } else {
            v1 - 1
        };
        if (0x2::random::generate_u64_in_range(&mut v0, 0, v2) < 200) {
            *0x1::vector::borrow_mut<address>(&mut arg0.candidate_players, 0x2::random::generate_u64_in_range(&mut v0, 0, 200 - 1)) = arg1;
        };
    }

    fun set_registry_enabled_internal(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: bool) {
        assert!(registry_exists(arg0), 13835341243951022084);
        let v0 = borrow_giveaway_registry_mut(arg0);
        let v1 = v0.is_enabled;
        v0.is_enabled = arg1;
        if (v1 != arg1) {
            let v2 = GiveawayRegistryEnabledEvent{
                previous_is_enabled : v1,
                is_enabled          : arg1,
            };
            0x2::event::emit<GiveawayRegistryEnabledEvent>(v2);
        };
    }

    entry fun settle_giveaway(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: &0x2::clock::Clock, arg2: &0x2::random::Random, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(registry_exists(arg0), 13835343498808852484);
        let v0 = borrow_giveaway_registry_mut(arg0);
        let v1 = borrow_giveaway_mut(v0, arg3);
        assert!(!v1.is_settled, 13839002694982369306);
        assert!(0x2::clock::timestamp_ms(arg1) > v1.entry_deadline_ms, 13838721224300494872);
        assert!(0x1::vector::length<GiveawayReward>(&v1.rewards) > 0, 13837595328688226322);
        assign_winners(v1, arg2, arg4);
        let v2 = 0x2::clock::timestamp_ms(arg1);
        v1.is_settled = true;
        v1.settled_at_ms = 0x1::option::some<u64>(v2);
        let v3 = borrow_giveaway_registry_mut(arg0);
        move_to_settled(v3, arg3);
        let v4 = GiveawaySettledEvent{
            giveaway_id   : arg3,
            settled_at_ms : v2,
            winner_count  : count_winners(&v1.winners),
            winners       : copy_winner_slots(&v1.winners),
        };
        0x2::event::emit<GiveawaySettledEvent>(v4);
    }

    fun validate_reward_coin_configuration_on_create(arg0: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: &vector<GiveawayReward>) {
        let v0 = 0x1::vector::empty<0x1::type_name::TypeName>();
        let v1 = 0x1::vector::empty<u64>();
        let v2 = 0x1::vector::empty<u64>();
        let v3 = 0;
        while (v3 < 0x1::vector::length<GiveawayReward>(arg1)) {
            let v4 = 0x1::vector::borrow<GiveawayReward>(arg1, v3);
            let v5 = 0;
            while (v5 < 0x1::vector::length<GiveawayCoinReward>(&v4.coin_rewards)) {
                let v6 = 0x1::vector::borrow<GiveawayCoinReward>(&v4.coin_rewards, v5);
                assert!(v6.amount > 0, 13843785845443330108);
                assert!(0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::house_exists_by_type(arg0, v6.coin_type), 13844630283258757186);
                assert!(v6.sweet_house_id == 0x2::object::id<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse>(arg0), 13844911766825533508);
                let (v7, v8) = 0x1::vector::index_of<0x1::type_name::TypeName>(&v0, &v6.coin_type);
                if (v7) {
                    let v9 = 0x1::vector::borrow_mut<u64>(&mut v1, v8);
                    *v9 = *v9 + v6.amount;
                    let v10 = 0x1::vector::borrow_mut<u64>(&mut v2, v8);
                    if (v6.rakeback_pool_total_snapshot < *v10) {
                        *v10 = v6.rakeback_pool_total_snapshot;
                    };
                } else {
                    0x1::vector::push_back<0x1::type_name::TypeName>(&mut v0, v6.coin_type);
                    0x1::vector::push_back<u64>(&mut v1, v6.amount);
                    0x1::vector::push_back<u64>(&mut v2, v6.rakeback_pool_total_snapshot);
                };
                v5 = v5 + 1;
            };
            v3 = v3 + 1;
        };
        let v11 = 0;
        while (v11 < 0x1::vector::length<0x1::type_name::TypeName>(&v0)) {
            assert!(*0x1::vector::borrow<u64>(&v2, v11) >= *0x1::vector::borrow<u64>(&v1, v11), 13844067457859125310);
            v11 = v11 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

