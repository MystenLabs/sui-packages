module 0x8cc2eed1b1012881a623e9bafd58ff0f17a8c5f807662631e623acf7779a78ee::borrow_incentive {
    struct BucketV2BorrowIncentive has drop {
        dummy_field: bool,
    }

    struct StakeData<phantom T0> has store {
        unit: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::Double,
        reward: 0x2::balance::Balance<T0>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct VaultRewarderRegistry has key {
        id: 0x2::object::UID,
        vault_rewarders: 0x2::table::Table<0x2::object::ID, 0x2::vec_set::VecSet<0x2::object::ID>>,
        versions: 0x2::vec_set::VecSet<u16>,
        managers: 0x2::vec_set::VecSet<address>,
    }

    struct VaultRewarder<phantom T0> has key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
        source: 0x2::balance::Balance<T0>,
        pool: 0x2::balance::Balance<T0>,
        flow_rate: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::Double,
        stake_table: 0x2::table::Table<address, StakeData<T0>>,
        unit: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::Double,
        timestamp: u64,
    }

    struct RequestChecker<phantom T0> {
        vault_id: 0x2::object::ID,
        rewarder_ids: 0x2::vec_set::VecSet<0x2::object::ID>,
        request: 0x9f835c21d21f8ce519fec17d679cd38243ef2643ad879e7048ba77374be4036e::request::UpdateRequest<T0>,
    }

    public fun id<T0>(arg0: &VaultRewarder<T0>) : 0x2::object::ID {
        0x2::object::id<VaultRewarder<T0>>(arg0)
    }

    public fun add_manager(arg0: &mut VaultRewarderRegistry, arg1: &AdminCap, arg2: address) {
        0x2::vec_set::insert<address>(&mut arg0.managers, arg2);
    }

    public fun add_version(arg0: &mut VaultRewarderRegistry, arg1: &AdminCap, arg2: u16) {
        0x2::vec_set::insert<u16>(&mut arg0.versions, arg2);
    }

    fun assert_correct_vault<T0, T1>(arg0: &VaultRewarder<T1>, arg1: &0x9f835c21d21f8ce519fec17d679cd38243ef2643ad879e7048ba77374be4036e::vault::Vault<T0>) {
        if (arg0.vault_id != 0x9f835c21d21f8ce519fec17d679cd38243ef2643ad879e7048ba77374be4036e::vault::id<T0>(arg1)) {
            err_wrong_vault();
        };
    }

    fun assert_sender_is_manager(arg0: &VaultRewarderRegistry, arg1: &0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest) {
        let v0 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::request_address(arg1);
        if (!0x2::vec_set::contains<address>(&arg0.managers, &v0)) {
            err_sender_is_not_manager();
        };
    }

    fun assert_unchecked_rewarder<T0, T1>(arg0: &RequestChecker<T0>, arg1: &VaultRewarder<T1>) {
        let v0 = id<T1>(arg1);
        if (!0x2::vec_set::contains<0x2::object::ID>(&arg0.rewarder_ids, &v0)) {
            err_invalid_rewarder();
        };
    }

    fun assert_valid_package_version(arg0: &VaultRewarderRegistry) {
        let v0 = package_version();
        if (!0x2::vec_set::contains<u16>(&arg0.versions, &v0)) {
            err_invalid_package_version();
        };
    }

    public fun claim<T0, T1>(arg0: &VaultRewarderRegistry, arg1: &mut VaultRewarder<T1>, arg2: &0x9f835c21d21f8ce519fec17d679cd38243ef2643ad879e7048ba77374be4036e::vault::Vault<T0>, arg3: &0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert_valid_package_version(arg0);
        let v0 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::request_address(arg3);
        settle_reward<T0, T1>(arg1, arg2, v0, arg4);
        let v1 = 0x2::coin::from_balance<T1>(0x2::balance::withdraw_all<T1>(&mut 0x2::table::borrow_mut<address, StakeData<T1>>(&mut arg1.stake_table, v0).reward), arg5);
        0x8cc2eed1b1012881a623e9bafd58ff0f17a8c5f807662631e623acf7779a78ee::borrow_incentive_events::emit_claim_reward<T0, T1>(id<T1>(arg1), v0, 0x2::coin::value<T1>(&v1));
        v1
    }

    public fun create<T0, T1>(arg0: &mut VaultRewarderRegistry, arg1: &AdminCap, arg2: &0x9f835c21d21f8ce519fec17d679cd38243ef2643ad879e7048ba77374be4036e::vault::Vault<T0>, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert_valid_package_version(arg0);
        let v0 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::from_fraction(arg3, arg4);
        let v1 = VaultRewarder<T1>{
            id          : 0x2::object::new(arg6),
            vault_id    : 0x9f835c21d21f8ce519fec17d679cd38243ef2643ad879e7048ba77374be4036e::vault::id<T0>(arg2),
            source      : 0x2::balance::zero<T1>(),
            pool        : 0x2::balance::zero<T1>(),
            flow_rate   : v0,
            stake_table : 0x2::table::new<address, StakeData<T1>>(arg6),
            unit        : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::from(0),
            timestamp   : arg5,
        };
        let v2 = 0x2::object::id<VaultRewarder<T1>>(&v1);
        0x2::transfer::share_object<VaultRewarder<T1>>(v1);
        let v3 = 0x9f835c21d21f8ce519fec17d679cd38243ef2643ad879e7048ba77374be4036e::vault::id<T0>(arg2);
        if (0x2::table::contains<0x2::object::ID, 0x2::vec_set::VecSet<0x2::object::ID>>(&arg0.vault_rewarders, v3)) {
            0x2::vec_set::insert<0x2::object::ID>(0x2::table::borrow_mut<0x2::object::ID, 0x2::vec_set::VecSet<0x2::object::ID>>(&mut arg0.vault_rewarders, v3), v2);
        } else {
            0x2::table::add<0x2::object::ID, 0x2::vec_set::VecSet<0x2::object::ID>>(&mut arg0.vault_rewarders, v3, 0x2::vec_set::singleton<0x2::object::ID>(v2));
        };
        0x8cc2eed1b1012881a623e9bafd58ff0f17a8c5f807662631e623acf7779a78ee::borrow_incentive_events::emit_rewarder_created<T0, T1>(0x9f835c21d21f8ce519fec17d679cd38243ef2643ad879e7048ba77374be4036e::vault::id<T0>(arg2), v2, arg5, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::to_scaled_val(v0));
    }

    public fun deposit_to_pool<T0>(arg0: &mut VaultRewarder<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut arg0.pool, 0x2::coin::into_balance<T0>(arg1));
    }

    public fun deposit_to_source<T0>(arg0: &mut VaultRewarder<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x8cc2eed1b1012881a623e9bafd58ff0f17a8c5f807662631e623acf7779a78ee::borrow_incentive_events::emit_source_changed<T0>(id<T0>(arg0), 0x2::coin::value<T0>(&arg1), true);
        0x2::balance::join<T0>(&mut arg0.source, 0x2::coin::into_balance<T0>(arg1));
    }

    entry fun deposit_to_source_and_set_flow_rate<T0, T1>(arg0: &VaultRewarderRegistry, arg1: &mut VaultRewarder<T1>, arg2: &0x9f835c21d21f8ce519fec17d679cd38243ef2643ad879e7048ba77374be4036e::vault::Vault<T0>, arg3: &0x2::clock::Clock, arg4: 0x2::coin::Coin<T1>, arg5: u64, arg6: &0x2::tx_context::TxContext) {
        deposit_to_source<T1>(arg1, arg4);
        let v0 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::request(arg6);
        update_flow_rate<T0, T1>(arg0, arg1, arg2, arg3, 0x2::coin::value<T1>(&arg4), arg5, &v0);
    }

    public fun destroy_checker<T0>(arg0: &VaultRewarderRegistry, arg1: RequestChecker<T0>) : 0x9f835c21d21f8ce519fec17d679cd38243ef2643ad879e7048ba77374be4036e::request::UpdateRequest<T0> {
        assert_valid_package_version(arg0);
        let RequestChecker {
            vault_id     : _,
            rewarder_ids : v1,
            request      : v2,
        } = arg1;
        let v3 = v2;
        let v4 = v1;
        if (!0x2::vec_set::is_empty<0x2::object::ID>(&v4)) {
            err_missing_rewarder_check();
        };
        let v5 = BucketV2BorrowIncentive{dummy_field: false};
        0x9f835c21d21f8ce519fec17d679cd38243ef2643ad879e7048ba77374be4036e::request::add_witness<T0, BucketV2BorrowIncentive>(&mut v3, v5);
        v3
    }

    fun err_invalid_package_version() {
        abort 205
    }

    fun err_invalid_rewarder() {
        abort 201
    }

    fun err_invalid_timestamp() {
        abort 203
    }

    fun err_missing_rewarder_check() {
        abort 202
    }

    fun err_sender_is_not_manager() {
        abort 206
    }

    fun err_wrong_vault() {
        abort 204
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = VaultRewarderRegistry{
            id              : 0x2::object::new(arg0),
            vault_rewarders : 0x2::table::new<0x2::object::ID, 0x2::vec_set::VecSet<0x2::object::ID>>(arg0),
            versions        : 0x2::vec_set::singleton<u16>(package_version()),
            managers        : 0x2::vec_set::singleton<address>(0x2::tx_context::sender(arg0)),
        };
        0x2::transfer::share_object<VaultRewarderRegistry>(v1);
    }

    public fun new_checker<T0>(arg0: &VaultRewarderRegistry, arg1: 0x9f835c21d21f8ce519fec17d679cd38243ef2643ad879e7048ba77374be4036e::request::UpdateRequest<T0>) : RequestChecker<T0> {
        assert_valid_package_version(arg0);
        let v0 = 0x9f835c21d21f8ce519fec17d679cd38243ef2643ad879e7048ba77374be4036e::request::vault_id<T0>(&arg1);
        let v1 = if (0x2::table::contains<0x2::object::ID, 0x2::vec_set::VecSet<0x2::object::ID>>(&arg0.vault_rewarders, v0)) {
            *0x2::table::borrow<0x2::object::ID, 0x2::vec_set::VecSet<0x2::object::ID>>(&arg0.vault_rewarders, v0)
        } else {
            0x2::vec_set::empty<0x2::object::ID>()
        };
        RequestChecker<T0>{
            vault_id     : v0,
            rewarder_ids : v1,
            request      : arg1,
        }
    }

    public fun package_version() : u16 {
        2
    }

    public fun realtime_reward_amount<T0, T1>(arg0: &VaultRewarder<T1>, arg1: &0x9f835c21d21f8ce519fec17d679cd38243ef2643ad879e7048ba77374be4036e::vault::Vault<T0>, arg2: address, arg3: &0x2::clock::Clock) : u64 {
        let v0 = if (stake_exists<T1>(arg0, arg2)) {
            0x2::balance::value<T1>(&0x2::table::borrow<address, StakeData<T1>>(&arg0.stake_table, arg2).reward)
        } else {
            0
        };
        v0 + unsettled_reward_amount<T0, T1>(arg0, arg1, arg2, arg3)
    }

    fun realtime_rewarder_release_and_unit<T0, T1>(arg0: &VaultRewarder<T1>, arg1: &0x9f835c21d21f8ce519fec17d679cd38243ef2643ad879e7048ba77374be4036e::vault::Vault<T0>, arg2: &0x2::clock::Clock) : (u64, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::Double, bool) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = arg0.timestamp;
        if (v0 > v1 && 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::limited_supply::supply(0x9f835c21d21f8ce519fec17d679cd38243ef2643ad879e7048ba77374be4036e::vault::limited_supply<T0>(arg1)) > 0) {
            let v5 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::floor(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::mul_u64(arg0.flow_rate, v0 - v1));
            let v6 = v5;
            let v7 = 0x2::balance::value<T1>(&arg0.source);
            if (v5 > v7) {
                v6 = v7;
            };
            (v6, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::add(arg0.unit, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::from_fraction(v6, 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::limited_supply::supply(0x9f835c21d21f8ce519fec17d679cd38243ef2643ad879e7048ba77374be4036e::vault::limited_supply<T0>(arg1)))), true)
        } else {
            (0, arg0.unit, false)
        }
    }

    public fun remove_manager(arg0: &mut VaultRewarderRegistry, arg1: &AdminCap, arg2: address) {
        0x2::vec_set::remove<address>(&mut arg0.managers, &arg2);
    }

    public fun remove_rewarder<T0>(arg0: &mut VaultRewarderRegistry, arg1: &AdminCap, arg2: &0x9f835c21d21f8ce519fec17d679cd38243ef2643ad879e7048ba77374be4036e::vault::Vault<T0>, arg3: 0x2::object::ID) {
        0x2::vec_set::remove<0x2::object::ID>(0x2::table::borrow_mut<0x2::object::ID, 0x2::vec_set::VecSet<0x2::object::ID>>(&mut arg0.vault_rewarders, 0x9f835c21d21f8ce519fec17d679cd38243ef2643ad879e7048ba77374be4036e::vault::id<T0>(arg2)), &arg3);
    }

    public fun remove_version(arg0: &mut VaultRewarderRegistry, arg1: &AdminCap, arg2: u16) {
        0x2::vec_set::remove<u16>(&mut arg0.versions, &arg2);
    }

    entry fun set_flow_rate<T0, T1>(arg0: &VaultRewarderRegistry, arg1: &mut VaultRewarder<T1>, arg2: &0x9f835c21d21f8ce519fec17d679cd38243ef2643ad879e7048ba77374be4036e::vault::Vault<T0>, arg3: &0x2::clock::Clock, arg4: u64, arg5: u64, arg6: &0x2::tx_context::TxContext) {
        let v0 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::request(arg6);
        update_flow_rate<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, &v0);
    }

    entry fun set_rewarder_timestamp<T0, T1>(arg0: &VaultRewarderRegistry, arg1: &mut VaultRewarder<T1>, arg2: &0x9f835c21d21f8ce519fec17d679cd38243ef2643ad879e7048ba77374be4036e::vault::Vault<T0>, arg3: &0x2::clock::Clock, arg4: u64, arg5: &0x2::tx_context::TxContext) {
        assert_valid_package_version(arg0);
        let v0 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::request(arg5);
        assert_sender_is_manager(arg0, &v0);
        source_to_pool<T0, T1>(arg1, arg2, arg3);
        arg1.timestamp = arg4;
    }

    fun settle_reward<T0, T1>(arg0: &mut VaultRewarder<T1>, arg1: &0x9f835c21d21f8ce519fec17d679cd38243ef2643ad879e7048ba77374be4036e::vault::Vault<T0>, arg2: address, arg3: &0x2::clock::Clock) : u64 {
        source_to_pool<T0, T1>(arg0, arg1, arg3);
        let v0 = 0x2::balance::split<T1>(&mut arg0.pool, unsettled_reward_amount<T0, T1>(arg0, arg1, arg2, arg3));
        if (stake_exists<T1>(arg0, arg2)) {
            let v2 = 0x2::table::borrow_mut<address, StakeData<T1>>(&mut arg0.stake_table, arg2);
            v2.unit = arg0.unit;
            0x2::balance::join<T1>(&mut v2.reward, v0)
        } else {
            let v3 = StakeData<T1>{
                unit   : arg0.unit,
                reward : v0,
            };
            0x2::table::add<address, StakeData<T1>>(&mut arg0.stake_table, arg2, v3);
            0x2::balance::value<T1>(&v0)
        }
    }

    fun source_to_pool<T0, T1>(arg0: &mut VaultRewarder<T1>, arg1: &0x9f835c21d21f8ce519fec17d679cd38243ef2643ad879e7048ba77374be4036e::vault::Vault<T0>, arg2: &0x2::clock::Clock) {
        assert_correct_vault<T0, T1>(arg0, arg1);
        let (v0, v1, v2) = realtime_rewarder_release_and_unit<T0, T1>(arg0, arg1, arg2);
        if (v2) {
            arg0.timestamp = 0x2::clock::timestamp_ms(arg2);
        };
        arg0.unit = v1;
        0x2::balance::join<T1>(&mut arg0.pool, 0x2::balance::split<T1>(&mut arg0.source, v0));
    }

    public fun stake_exists<T0>(arg0: &VaultRewarder<T0>, arg1: address) : bool {
        0x2::table::contains<address, StakeData<T0>>(&arg0.stake_table, arg1)
    }

    fun unsettled_reward_amount<T0, T1>(arg0: &VaultRewarder<T1>, arg1: &0x9f835c21d21f8ce519fec17d679cd38243ef2643ad879e7048ba77374be4036e::vault::Vault<T0>, arg2: address, arg3: &0x2::clock::Clock) : u64 {
        assert_correct_vault<T0, T1>(arg0, arg1);
        if (0x9f835c21d21f8ce519fec17d679cd38243ef2643ad879e7048ba77374be4036e::vault::position_exists<T0>(arg1, arg2)) {
            let (_, v2, _) = realtime_rewarder_release_and_unit<T0, T1>(arg0, arg1, arg3);
            let v4 = if (stake_exists<T1>(arg0, arg2)) {
                0x2::table::borrow<address, StakeData<T1>>(&arg0.stake_table, arg2).unit
            } else {
                0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::from(0)
            };
            let (_, v6, _) = 0x9f835c21d21f8ce519fec17d679cd38243ef2643ad879e7048ba77374be4036e::vault::get_raw_position_data<T0>(arg1, arg2);
            let v8 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::floor(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::mul_u64(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::sub(v2, v4), v6));
            let v9 = v8;
            if (v8 > 0x2::balance::value<T1>(&arg0.pool)) {
                v9 = 0x2::balance::value<T1>(&arg0.pool);
            };
            v9
        } else {
            0
        }
    }

    public fun update<T0, T1>(arg0: &VaultRewarderRegistry, arg1: &mut RequestChecker<T0>, arg2: &0x9f835c21d21f8ce519fec17d679cd38243ef2643ad879e7048ba77374be4036e::vault::Vault<T0>, arg3: &mut VaultRewarder<T1>, arg4: &0x2::clock::Clock) {
        assert_valid_package_version(arg0);
        assert_unchecked_rewarder<T0, T1>(arg1, arg3);
        source_to_pool<T0, T1>(arg3, arg2, arg4);
        settle_reward<T0, T1>(arg3, arg2, 0x9f835c21d21f8ce519fec17d679cd38243ef2643ad879e7048ba77374be4036e::request::account<T0>(&arg1.request), arg4);
        let v0 = id<T1>(arg3);
        0x2::vec_set::remove<0x2::object::ID>(&mut arg1.rewarder_ids, &v0);
    }

    public fun update_flow_rate<T0, T1>(arg0: &VaultRewarderRegistry, arg1: &mut VaultRewarder<T1>, arg2: &0x9f835c21d21f8ce519fec17d679cd38243ef2643ad879e7048ba77374be4036e::vault::Vault<T0>, arg3: &0x2::clock::Clock, arg4: u64, arg5: u64, arg6: &0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest) {
        assert_valid_package_version(arg0);
        assert_sender_is_manager(arg0, arg6);
        source_to_pool<T0, T1>(arg1, arg2, arg3);
        let v0 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::from_fraction(arg4, arg5);
        0x8cc2eed1b1012881a623e9bafd58ff0f17a8c5f807662631e623acf7779a78ee::borrow_incentive_events::emit_flow_rate_changed<T0, T1>(id<T1>(arg1), 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::to_scaled_val(v0));
        arg1.flow_rate = v0;
    }

    public fun update_rewarder_timestamp<T0, T1>(arg0: &VaultRewarderRegistry, arg1: &mut VaultRewarder<T1>, arg2: &0x9f835c21d21f8ce519fec17d679cd38243ef2643ad879e7048ba77374be4036e::vault::Vault<T0>, arg3: &0x2::clock::Clock, arg4: u64, arg5: &0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest) {
        if (arg4 < 0x2::clock::timestamp_ms(arg3)) {
            err_invalid_timestamp();
        };
        assert_valid_package_version(arg0);
        assert_sender_is_manager(arg0, arg5);
        source_to_pool<T0, T1>(arg1, arg2, arg3);
        arg1.timestamp = arg4;
    }

    public fun withdraw_from_source<T0, T1>(arg0: &VaultRewarderRegistry, arg1: &mut VaultRewarder<T1>, arg2: &0x9f835c21d21f8ce519fec17d679cd38243ef2643ad879e7048ba77374be4036e::vault::Vault<T0>, arg3: &AdminCap, arg4: &0x2::clock::Clock, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert_valid_package_version(arg0);
        source_to_pool<T0, T1>(arg1, arg2, arg4);
        0x8cc2eed1b1012881a623e9bafd58ff0f17a8c5f807662631e623acf7779a78ee::borrow_incentive_events::emit_source_changed<T1>(id<T1>(arg1), arg5, false);
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg1.source, arg5), arg6)
    }

    entry fun withdraw_from_source_to<T0, T1>(arg0: &VaultRewarderRegistry, arg1: &mut VaultRewarder<T1>, arg2: &0x9f835c21d21f8ce519fec17d679cd38243ef2643ad879e7048ba77374be4036e::vault::Vault<T0>, arg3: &AdminCap, arg4: &0x2::clock::Clock, arg5: u64, arg6: address, arg7: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(withdraw_from_source<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg7), arg6);
    }

    // decompiled from Move bytecode v6
}

