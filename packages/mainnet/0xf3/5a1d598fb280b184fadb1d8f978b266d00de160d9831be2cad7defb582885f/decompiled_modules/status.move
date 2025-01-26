module 0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::status {
    struct NewEndTime<phantom T0> has copy, drop {
        ms: u64,
    }

    struct Refer<phantom T0> has copy, drop {
        referrer: address,
        refered: address,
    }

    struct AddShares<phantom T0> has copy, drop {
        coin_type: 0x1::ascii::String,
        shares: u64,
        total_shares: u64,
    }

    struct Earn<phantom T0> has copy, drop {
        account: address,
        coin_type: 0x1::ascii::String,
        amount: u64,
        from_holders: bool,
    }

    struct Status<phantom T0> has store, key {
        id: 0x2::object::UID,
        start_time: u64,
        end_time: u64,
        winners: vector<address>,
        total_shares: u64,
        pool_states: 0x2::vec_map::VecMap<0x1::type_name::TypeName, 0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::pool_state::PoolState>,
        referral_whitelist: 0x2::vec_set::VecSet<address>,
        voucher_whitelist: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
        user_profiles: 0x2::table::Table<address, 0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::profile::Profile>,
        leaderboard: 0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::leaderboard::Leaderboard,
    }

    struct Starter<phantom T0> has store, key {
        id: 0x2::object::UID,
    }

    struct AccountInfo has copy, drop {
        coin_types: vector<0x1::ascii::String>,
        holders_rewards: vector<u64>,
        referral_rewards: vector<u64>,
        shares: u64,
        referrer: 0x1::option::Option<address>,
        referral_score: u64,
    }

    public fun new<T0>(arg0: &mut 0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::admin::AdminCap<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (Status<T0>, Starter<T0>) {
        let v0 = Status<T0>{
            id                 : 0x2::object::new(arg2),
            start_time         : max_u64(),
            end_time           : max_u64(),
            winners            : vector[],
            total_shares       : 0,
            pool_states        : 0x2::vec_map::empty<0x1::type_name::TypeName, 0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::pool_state::PoolState>(),
            referral_whitelist : 0x2::vec_set::empty<address>(),
            voucher_whitelist  : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
            user_profiles      : 0x2::table::new<address, 0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::profile::Profile>(arg2),
            leaderboard        : 0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::leaderboard::new(arg1),
        };
        0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::admin::set_status_id<T0>(arg0, 0x2::object::id<Status<T0>>(&v0));
        let v1 = Starter<T0>{id: 0x2::object::new(arg2)};
        (v0, v1)
    }

    public fun leaderboard<T0>(arg0: &Status<T0>) : &0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::leaderboard::Leaderboard {
        &arg0.leaderboard
    }

    public(friend) fun add_pool<T0>(arg0: &mut Status<T0>, arg1: 0x1::type_name::TypeName, arg2: 0x2::object::ID) {
        if (0x2::vec_map::contains<0x1::type_name::TypeName, 0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::pool_state::PoolState>(pool_states<T0>(arg0), &arg1)) {
            err_pool_already_created();
        };
        0x2::vec_map::insert<0x1::type_name::TypeName, 0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::pool_state::PoolState>(&mut arg0.pool_states, arg1, 0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::pool_state::new(arg2, 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::double::from(0)));
    }

    public fun add_referrer<T0>(arg0: &mut Status<T0>, arg1: &0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::admin::AdminCap<T0>, arg2: address) {
        if (!0x2::vec_set::contains<address>(referral_whitelist<T0>(arg0), &arg2)) {
            0x2::vec_set::insert<address>(&mut arg0.referral_whitelist, arg2);
        };
    }

    public fun add_voucher_type<T0, T1>(arg0: &mut Status<T0>, arg1: &0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::admin::AdminCap<T0>) {
        let v0 = 0x1::type_name::get<T1>();
        if (!0x2::vec_set::contains<0x1::type_name::TypeName>(voucher_whitelist<T0>(arg0), &v0)) {
            0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.voucher_whitelist, v0);
        };
    }

    public fun assert_game_is_ended<T0>(arg0: &Status<T0>, arg1: &0x2::clock::Clock) {
        if (0x2::clock::timestamp_ms(arg1) <= arg0.end_time) {
            err_game_is_not_ended();
        };
    }

    public fun assert_game_is_not_ended<T0>(arg0: &Status<T0>, arg1: &0x2::clock::Clock) {
        if (0x2::clock::timestamp_ms(arg1) > arg0.end_time) {
            err_game_is_ended();
        };
    }

    public fun assert_game_is_started<T0>(arg0: &Status<T0>, arg1: &0x2::clock::Clock) {
        if (0x2::clock::timestamp_ms(arg1) < arg0.start_time) {
            err_game_is_not_started();
        };
    }

    public fun end_time<T0>(arg0: &Status<T0>) : u64 {
        arg0.end_time
    }

    fun err_game_is_ended() {
        abort 3
    }

    fun err_game_is_not_ended() {
        abort 2
    }

    fun err_game_is_not_started() {
        abort 1
    }

    fun err_invalid_referrer() {
        abort 5
    }

    fun err_pool_already_created() {
        abort 4
    }

    fun err_self_refer() {
        abort 6
    }

    public fun get_account_info<T0>(arg0: &Status<T0>, arg1: address) : 0x1::option::Option<AccountInfo> {
        if (0x2::table::contains<address, 0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::profile::Profile>(user_profiles<T0>(arg0), arg1)) {
            let v1 = 0x2::vec_map::keys<0x1::type_name::TypeName, 0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::pool_state::PoolState>(pool_states<T0>(arg0));
            let v2 = &v1;
            let v3 = vector[];
            let v4 = 0;
            while (v4 < 0x1::vector::length<0x1::type_name::TypeName>(v2)) {
                0x1::vector::push_back<u64>(&mut v3, realtime_holders_reward<T0>(arg0, arg1, 0x1::vector::borrow<0x1::type_name::TypeName>(v2, v4)));
                v4 = v4 + 1;
            };
            let v5 = &v1;
            let v6 = vector[];
            let v7 = 0;
            while (v7 < 0x1::vector::length<0x1::type_name::TypeName>(v5)) {
                0x1::vector::push_back<u64>(&mut v6, realtime_referral_reward<T0>(arg0, arg1, 0x1::vector::borrow<0x1::type_name::TypeName>(v5, v7)));
                v7 = v7 + 1;
            };
            let v8 = 0x1::vector::empty<0x1::ascii::String>();
            0x1::vector::reverse<0x1::type_name::TypeName>(&mut v1);
            let v9 = 0;
            while (v9 < 0x1::vector::length<0x1::type_name::TypeName>(&v1)) {
                0x1::vector::push_back<0x1::ascii::String>(&mut v8, 0x1::type_name::into_string(0x1::vector::pop_back<0x1::type_name::TypeName>(&mut v1)));
                v9 = v9 + 1;
            };
            0x1::vector::destroy_empty<0x1::type_name::TypeName>(v1);
            let v10 = 0x2::table::borrow<address, 0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::profile::Profile>(user_profiles<T0>(arg0), arg1);
            let v11 = AccountInfo{
                coin_types       : v8,
                holders_rewards  : v3,
                referral_rewards : v6,
                shares           : 0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::profile::shares(v10),
                referrer         : 0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::profile::referrer(v10),
                referral_score   : 0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::profile::referral_score(v10),
            };
            0x1::option::some<AccountInfo>(v11)
        } else {
            0x1::option::none<AccountInfo>()
        }
    }

    public(friend) fun handle_final<T0>(arg0: &mut Status<T0>, arg1: &0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::config::Config<T0>, arg2: &0x2::clock::Clock, arg3: address, arg4: u64) {
        let v0 = 0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::config::max_winner_count<T0>(arg1);
        let v1 = 0;
        while (v1 < 0x1::u64::min(arg4, v0)) {
            if (0x1::vector::length<address>(&arg0.winners) == v0) {
                0x1::vector::remove<address>(&mut arg0.winners, 0);
            };
            0x1::vector::push_back<address>(&mut arg0.winners, arg3);
            v1 = v1 + 1;
        };
        let v2 = 0x2::clock::timestamp_ms(arg2);
        let v3 = arg0.end_time + arg4 * 0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::config::time_increment<T0>(arg1);
        let v4 = v3;
        let v5 = 0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::config::end_time_hard_cap<T0>(arg1);
        if (v3 > v2 + v5) {
            v4 = v2 + v5;
        };
        if (arg0.end_time < v4) {
            arg0.end_time = v4;
            let v6 = NewEndTime<T0>{ms: v4};
            0x2::event::emit<NewEndTime<T0>>(v6);
        };
    }

    public(friend) fun handle_holders<T0, T1>(arg0: &mut Status<T0>, arg1: address, arg2: u64, arg3: u64) {
        let v0 = 0x1::type_name::get<T1>();
        arg0.total_shares = total_shares<T0>(arg0) + arg2;
        0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::pool_state::add_unit(0x2::vec_map::get_mut<0x1::type_name::TypeName, 0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::pool_state::PoolState>(&mut arg0.pool_states, &v0), 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::double::from_fraction(arg3, total_shares<T0>(arg0)));
        0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::leaderboard::insert(&mut arg0.leaderboard, arg1, 0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::profile::add_shares(0x2::table::borrow_mut<address, 0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::profile::Profile>(&mut arg0.user_profiles, arg1), arg2));
        let v1 = AddShares<T0>{
            coin_type    : 0x1::type_name::into_string(v0),
            shares       : arg2,
            total_shares : total_shares<T0>(arg0),
        };
        0x2::event::emit<AddShares<T0>>(v1);
    }

    public(friend) fun handle_redeem<T0, T1>(arg0: &mut Status<T0>, arg1: address) {
        update_user_state<T0>(arg0, arg1, 0x1::option::none<address>());
        arg0.total_shares = total_shares<T0>(arg0) + 1;
        0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::leaderboard::insert(&mut arg0.leaderboard, arg1, 0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::profile::add_shares(0x2::table::borrow_mut<address, 0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::profile::Profile>(&mut arg0.user_profiles, arg1), 1));
        let v0 = AddShares<T0>{
            coin_type    : 0x1::type_name::into_string(0x1::type_name::get<T1>()),
            shares       : 1,
            total_shares : total_shares<T0>(arg0),
        };
        0x2::event::emit<AddShares<T0>>(v0);
    }

    public(friend) fun handle_referrer<T0, T1>(arg0: &mut Status<T0>, arg1: &0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::config::Config<T0>, arg2: address, arg3: 0x1::option::Option<address>, arg4: u64) : 0x1::option::Option<address> {
        update_user_state<T0>(arg0, arg2, arg3);
        let v0 = 0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::profile::referrer(0x2::table::borrow<address, 0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::profile::Profile>(user_profiles<T0>(arg0), arg2));
        if (0x1::option::is_some<address>(&v0)) {
            let v1 = 0x1::option::destroy_some<address>(v0);
            if (!is_valid_referrer<T0>(arg0, arg1, v1)) {
                err_invalid_referrer();
            };
            if (v1 == arg2) {
                err_self_refer();
            };
            update_user_state<T0>(arg0, v1, 0x1::option::none<address>());
            if (arg4 > 0) {
                let v2 = 0x1::type_name::get<T1>();
                0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::user_state::rebate(0x2::vec_map::get_mut<0x1::type_name::TypeName, 0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::user_state::UserState>(0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::profile::states_mut(0x2::table::borrow_mut<address, 0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::profile::Profile>(&mut arg0.user_profiles, v1)), &v2), arg4);
                let v3 = Earn<T0>{
                    account      : v1,
                    coin_type    : 0x1::type_name::into_string(v2),
                    amount       : arg4,
                    from_holders : false,
                };
                0x2::event::emit<Earn<T0>>(v3);
            };
        };
        v0
    }

    public fun is_valid_referrer<T0>(arg0: &Status<T0>, arg1: &0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::config::Config<T0>, arg2: address) : bool {
        0x2::vec_set::contains<address>(referral_whitelist<T0>(arg0), &arg2) || 0x2::table::contains<address, 0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::profile::Profile>(user_profiles<T0>(arg0), arg2) && 0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::profile::shares(0x2::table::borrow<address, 0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::profile::Profile>(user_profiles<T0>(arg0), arg2)) >= 0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::config::referral_threshold<T0>(arg1)
    }

    public fun is_valid_voucher<T0, T1>(arg0: &Status<T0>) : bool {
        let v0 = 0x1::type_name::get<T1>();
        0x2::vec_set::contains<0x1::type_name::TypeName>(voucher_whitelist<T0>(arg0), &v0)
    }

    public fun max_u64() : u64 {
        18446744073709551615
    }

    public fun pending_holders_reward<T0>(arg0: &Status<T0>, arg1: address, arg2: &0x1::type_name::TypeName) : u64 {
        if (0x2::vec_map::contains<0x1::type_name::TypeName, 0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::pool_state::PoolState>(pool_states<T0>(arg0), arg2) && 0x2::table::contains<address, 0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::profile::Profile>(user_profiles<T0>(arg0), arg1)) {
            let v1 = 0x2::table::borrow<address, 0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::profile::Profile>(user_profiles<T0>(arg0), arg1);
            let v2 = if (0x2::vec_map::contains<0x1::type_name::TypeName, 0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::user_state::UserState>(0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::profile::states(v1), arg2)) {
                0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::user_state::unit(0x2::vec_map::get<0x1::type_name::TypeName, 0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::user_state::UserState>(0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::profile::states(v1), arg2))
            } else {
                0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::double::from(0)
            };
            0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::double::floor(0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::double::mul_u64(0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::double::sub(0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::pool_state::unit(0x2::vec_map::get<0x1::type_name::TypeName, 0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::pool_state::PoolState>(pool_states<T0>(arg0), arg2)), v2), 0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::profile::shares(v1)))
        } else {
            0
        }
    }

    public fun pool_states<T0>(arg0: &Status<T0>) : &0x2::vec_map::VecMap<0x1::type_name::TypeName, 0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::pool_state::PoolState> {
        &arg0.pool_states
    }

    public fun realtime_holders_reward<T0>(arg0: &Status<T0>, arg1: address, arg2: &0x1::type_name::TypeName) : u64 {
        let v0 = if (0x2::table::contains<address, 0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::profile::Profile>(user_profiles<T0>(arg0), arg1) && 0x2::vec_map::contains<0x1::type_name::TypeName, 0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::user_state::UserState>(0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::profile::states(0x2::table::borrow<address, 0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::profile::Profile>(user_profiles<T0>(arg0), arg1)), arg2)) {
            0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::user_state::holders_reward(0x2::vec_map::get<0x1::type_name::TypeName, 0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::user_state::UserState>(0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::profile::states(0x2::table::borrow<address, 0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::profile::Profile>(user_profiles<T0>(arg0), arg1)), arg2))
        } else {
            0
        };
        pending_holders_reward<T0>(arg0, arg1, arg2) + v0
    }

    public fun realtime_referral_reward<T0>(arg0: &Status<T0>, arg1: address, arg2: &0x1::type_name::TypeName) : u64 {
        if (0x2::table::contains<address, 0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::profile::Profile>(user_profiles<T0>(arg0), arg1) && 0x2::vec_map::contains<0x1::type_name::TypeName, 0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::user_state::UserState>(0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::profile::states(0x2::table::borrow<address, 0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::profile::Profile>(user_profiles<T0>(arg0), arg1)), arg2)) {
            0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::user_state::referral_reward(0x2::vec_map::get<0x1::type_name::TypeName, 0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::user_state::UserState>(0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::profile::states(0x2::table::borrow<address, 0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::profile::Profile>(user_profiles<T0>(arg0), arg1)), arg2))
        } else {
            0
        }
    }

    public fun receive<T0, T1: store + key>(arg0: &mut Status<T0>, arg1: &mut 0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::admin::AdminCap<T0>, arg2: &0x2::clock::Clock, arg3: 0x2::transfer::Receiving<T1>) : T1 {
        assert_game_is_ended<T0>(arg0, arg2);
        0x2::transfer::public_receive<T1>(&mut arg0.id, arg3)
    }

    public fun referral_whitelist<T0>(arg0: &Status<T0>) : &0x2::vec_set::VecSet<address> {
        &arg0.referral_whitelist
    }

    public fun remove_referrer<T0>(arg0: &mut Status<T0>, arg1: &0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::admin::AdminCap<T0>, arg2: address) {
        if (0x2::vec_set::contains<address>(referral_whitelist<T0>(arg0), &arg2)) {
            0x2::vec_set::remove<address>(&mut arg0.referral_whitelist, &arg2);
        };
    }

    public fun remove_voucher_type<T0, T1>(arg0: &mut Status<T0>, arg1: &0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::admin::AdminCap<T0>) {
        let v0 = 0x1::type_name::get<T1>();
        if (0x2::vec_set::contains<0x1::type_name::TypeName>(voucher_whitelist<T0>(arg0), &v0)) {
            0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg0.voucher_whitelist, &v0);
        };
    }

    public fun start<T0>(arg0: &mut Status<T0>, arg1: &0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::config::Config<T0>, arg2: Starter<T0>, arg3: u64) {
        let Starter { id: v0 } = arg2;
        0x2::object::delete(v0);
        arg0.start_time = arg3;
        arg0.end_time = arg3 + 0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::config::initial_countdown<T0>(arg1);
        let v1 = NewEndTime<T0>{ms: end_time<T0>(arg0)};
        0x2::event::emit<NewEndTime<T0>>(v1);
    }

    public fun start_time<T0>(arg0: &Status<T0>) : u64 {
        arg0.start_time
    }

    public fun total_shares<T0>(arg0: &Status<T0>) : u64 {
        arg0.total_shares
    }

    public fun try_get_referrer<T0>(arg0: &Status<T0>, arg1: address) : 0x1::option::Option<address> {
        if (0x2::table::contains<address, 0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::profile::Profile>(user_profiles<T0>(arg0), arg1)) {
            0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::profile::referrer(0x2::table::borrow<address, 0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::profile::Profile>(user_profiles<T0>(arg0), arg1))
        } else {
            0x1::option::none<address>()
        }
    }

    public(friend) fun update_user_state<T0>(arg0: &mut Status<T0>, arg1: address, arg2: 0x1::option::Option<address>) {
        if (!0x2::table::contains<address, 0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::profile::Profile>(user_profiles<T0>(arg0), arg1)) {
            let v0 = 0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::profile::new(arg2);
            if (0x1::option::is_some<address>(&arg2)) {
                let v1 = 0x1::option::destroy_some<address>(arg2);
                0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::profile::set_referrer(&mut v0, v1);
                if (!0x2::table::contains<address, 0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::profile::Profile>(&arg0.user_profiles, v1)) {
                    update_user_state<T0>(arg0, v1, 0x1::option::none<address>());
                };
                0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::profile::add_score(0x2::table::borrow_mut<address, 0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::profile::Profile>(&mut arg0.user_profiles, v1));
                let v2 = Refer<T0>{
                    referrer : v1,
                    refered  : arg1,
                };
                0x2::event::emit<Refer<T0>>(v2);
            };
            let v3 = 0x2::vec_map::keys<0x1::type_name::TypeName, 0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::pool_state::PoolState>(pool_states<T0>(arg0));
            0x1::vector::reverse<0x1::type_name::TypeName>(&mut v3);
            let v4 = 0;
            while (v4 < 0x1::vector::length<0x1::type_name::TypeName>(&v3)) {
                let v5 = 0x1::vector::pop_back<0x1::type_name::TypeName>(&mut v3);
                0x2::vec_map::insert<0x1::type_name::TypeName, 0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::user_state::UserState>(0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::profile::states_mut(&mut v0), v5, 0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::user_state::new(0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::pool_state::unit(0x2::vec_map::get<0x1::type_name::TypeName, 0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::pool_state::PoolState>(pool_states<T0>(arg0), &v5))));
                v4 = v4 + 1;
            };
            0x1::vector::destroy_empty<0x1::type_name::TypeName>(v3);
            0x2::table::add<address, 0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::profile::Profile>(&mut arg0.user_profiles, arg1, v0);
        } else {
            let v6 = 0x2::vec_map::keys<0x1::type_name::TypeName, 0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::pool_state::PoolState>(pool_states<T0>(arg0));
            0x1::vector::reverse<0x1::type_name::TypeName>(&mut v6);
            let v7 = 0;
            while (v7 < 0x1::vector::length<0x1::type_name::TypeName>(&v6)) {
                let v8 = 0x1::vector::pop_back<0x1::type_name::TypeName>(&mut v6);
                let v9 = 0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::pool_state::unit(0x2::vec_map::get<0x1::type_name::TypeName, 0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::pool_state::PoolState>(&arg0.pool_states, &v8));
                let v10 = 0x2::table::borrow_mut<address, 0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::profile::Profile>(&mut arg0.user_profiles, arg1);
                let v11 = 0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::profile::shares(v10);
                if (0x2::vec_map::contains<0x1::type_name::TypeName, 0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::user_state::UserState>(0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::profile::states(v10), &v8)) {
                    let v12 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, 0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::user_state::UserState>(0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::profile::states_mut(v10), &v8);
                    let v13 = 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::double::floor(0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::double::mul_u64(0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::double::sub(v9, 0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::user_state::unit(v12)), v11));
                    if (v13 > 0) {
                        0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::user_state::settle(v12, v13);
                        let v14 = Earn<T0>{
                            account      : arg1,
                            coin_type    : 0x1::type_name::into_string(v8),
                            amount       : v13,
                            from_holders : true,
                        };
                        0x2::event::emit<Earn<T0>>(v14);
                    };
                    0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::user_state::set_unit(v12, v9);
                } else {
                    let v15 = if (v11 > 0) {
                        let v16 = 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::double::floor(0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::double::mul_u64(v9, v11));
                        let v17 = 0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::user_state::new(v9);
                        if (v16 > 0) {
                            0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::user_state::settle(&mut v17, v16);
                            let v18 = Earn<T0>{
                                account      : arg1,
                                coin_type    : 0x1::type_name::into_string(v8),
                                amount       : v16,
                                from_holders : true,
                            };
                            0x2::event::emit<Earn<T0>>(v18);
                        };
                        v17
                    } else {
                        0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::user_state::new(v9)
                    };
                    0x2::vec_map::insert<0x1::type_name::TypeName, 0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::user_state::UserState>(0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::profile::states_mut(v10), v8, v15);
                };
                v7 = v7 + 1;
            };
            0x1::vector::destroy_empty<0x1::type_name::TypeName>(v6);
            let v19 = 0x2::table::borrow_mut<address, 0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::profile::Profile>(&mut arg0.user_profiles, arg1);
            let v20 = if (0x1::option::is_some<address>(&arg2)) {
                let v21 = 0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::profile::referrer(v19);
                0x1::option::is_none<address>(&v21)
            } else {
                false
            };
            if (v20) {
                let v22 = 0x1::option::destroy_some<address>(arg2);
                0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::profile::set_referrer(v19, v22);
                0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::profile::add_score(0x2::table::borrow_mut<address, 0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::profile::Profile>(&mut arg0.user_profiles, v22));
                let v23 = Refer<T0>{
                    referrer : v22,
                    refered  : arg1,
                };
                0x2::event::emit<Refer<T0>>(v23);
            };
        };
    }

    public fun user_profiles<T0>(arg0: &Status<T0>) : &0x2::table::Table<address, 0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::profile::Profile> {
        &arg0.user_profiles
    }

    public(friend) fun user_profiles_mut<T0>(arg0: &mut Status<T0>) : &mut 0x2::table::Table<address, 0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::profile::Profile> {
        &mut arg0.user_profiles
    }

    public fun voucher_whitelist<T0>(arg0: &Status<T0>) : &0x2::vec_set::VecSet<0x1::type_name::TypeName> {
        &arg0.voucher_whitelist
    }

    public fun winners<T0>(arg0: &Status<T0>) : &vector<address> {
        &arg0.winners
    }

    // decompiled from Move bytecode v6
}

