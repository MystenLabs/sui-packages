module 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse {
    struct HouseTakeEvent has copy, drop {
        house_take_amount: u64,
        coin_type: 0x1::type_name::TypeName,
    }

    struct DynamicFeeKey has copy, drop, store {
        dummy_field: bool,
    }

    struct HouseTakeRateKey has copy, drop, store {
        dummy_field: bool,
    }

    struct Unihouse has key {
        id: 0x2::object::UID,
        version_set: 0x2::vec_set::VecSet<u64>,
        manager_map: 0x2::vec_map::VecMap<0x1::type_name::TypeName, 0x1::option::Option<address>>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct GameKey<phantom T0> has copy, drop, store {
        game_name: 0x1::type_name::TypeName,
    }

    struct GameConfig has drop, store {
        daily_risk_limit: u64,
        current_epoch_risk_count: u64,
        last_epoch_risk_reset: u64,
    }

    struct HouseFeeConfig has drop, store {
        house_fee_rate: u64,
    }

    struct FeeTag has copy, drop, store {
        dummy_field: bool,
    }

    struct RedeemRequest<phantom T0> has store, key {
        id: 0x2::object::UID,
        s_coin: 0x2::coin::Coin<0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::house::StakedHouseCoin<T0>>,
        created_at: u64,
        sender: address,
    }

    struct CollectReward<phantom T0> has copy, drop {
        rule_type: 0x1::string::String,
        amount: u64,
    }

    struct WithdrawReward<phantom T0> has copy, drop {
        amount: u64,
    }

    struct RewardType<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct SingleGameResult<phantom T0, phantom T1> has copy, drop {
        bet_id: 0x1::option::Option<0x2::object::ID>,
        table_id: 0x1::option::Option<0x2::object::ID>,
        bet_type: u64,
        bet_number: 0x1::option::Option<u64>,
        bet_size: u64,
        bet_returned: u64,
        rand_result: u64,
        player: address,
        origin: 0x1::option::Option<0x1::string::String>,
    }

    struct BetResult<phantom T0, phantom T1> has copy, drop {
        bet_id: 0x1::option::Option<0x2::object::ID>,
        player: address,
        bet_type: u64,
        bet_number: 0x1::option::Option<u64>,
        bet_size: u64,
        bet_returned: u64,
        outcome: u64,
    }

    struct BetResults<phantom T0, phantom T1> has copy, drop {
        table_id: 0x1::option::Option<0x2::object::ID>,
        round_number: 0x1::option::Option<u64>,
        origin: 0x1::option::Option<0x1::string::String>,
        bets: vector<BetResult<T0, T1>>,
    }

    struct BlackjackGameResult<phantom T0, phantom T1> has copy, drop {
        table_id: 0x2::object::ID,
        round_number: u64,
        bet_size: u64,
        bet_returned: u64,
        player_hands: vector<0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::game_structs::BlackjackHand>,
        dealer_cards: vector<u8>,
        player: address,
        origin: 0x1::string::String,
    }

    struct Craps<phantom T0> has copy, drop {
        table_id: 0x2::object::ID,
        bet_id: 0x1::option::Option<0x2::object::ID>,
        player: address,
        bet_type: u64,
        bet_number: 0x1::option::Option<u64>,
        bet_size: u64,
    }

    struct PlinkoGameResult<phantom T0, phantom T1> has copy, drop {
        table_id: 0x1::option::Option<0x2::object::ID>,
        creator: 0x1::option::Option<address>,
        game_type: u8,
        ball_count: u64,
        bet_size: u64,
        bet_returned: u64,
        ball_outcomes: vector<0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::game_structs::BallOutcome>,
        bet_results: vector<0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::game_structs::BetResult<T0>>,
        origin: 0x1::string::String,
    }

    struct RangeGameResult<phantom T0, phantom T1> has copy, drop {
        player: address,
        origin: 0x1::string::String,
        bet_results: vector<0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::game_structs::RangeGame>,
    }

    struct GasObject has store, key {
        id: 0x2::object::UID,
        player: address,
        game_bytes: vector<vector<u8>>,
    }

    public fun split<T0, T1: drop>(arg0: &mut Unihouse, arg1: T1, arg2: u64) : 0x2::balance::Balance<T0> {
        let v0 = borrow_mut_config<T0, T1>(arg0);
        v0.current_epoch_risk_count = v0.current_epoch_risk_count + arg2;
        assert!(v0.current_epoch_risk_count <= v0.daily_risk_limit, 7);
        0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::house::split<T0>(borrow_house_mut<T0>(arg0), arg2)
    }

    public fun put<T0, T1: drop>(arg0: &mut Unihouse, arg1: T1, arg2: 0x2::coin::Coin<T0>) {
        assert!(game_config_exists<T0, T1>(arg0), 4);
        join<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(arg2));
    }

    public fun take<T0, T1: drop>(arg0: &mut Unihouse, arg1: T1, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(game_config_exists<T0, T1>(arg0), 4);
        0x2::coin::from_balance<T0>(split<T0, T1>(arg0, arg1, arg2), arg3)
    }

    public(friend) fun bet_result_v2<T0, T1>(arg0: 0x1::option::Option<0x2::object::ID>, arg1: address, arg2: u64, arg3: 0x1::option::Option<u64>, arg4: u64, arg5: u64, arg6: u64) : BetResult<T0, T1> {
        BetResult<T0, T1>{
            bet_id       : arg0,
            player       : arg1,
            bet_type     : arg2,
            bet_number   : arg3,
            bet_size     : arg4,
            bet_returned : arg5,
            outcome      : arg6,
        }
    }

    public fun deposit<T0>(arg0: &mut Unihouse, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::house::StakedHouseCoin<T0>> {
        let v0 = 0x2::coin::into_balance<T0>(arg1);
        let v1 = 0x2::balance::value<T0>(&v0) * get_house_take_rate(arg0) / 10000;
        let v2 = borrow_house_mut<T0>(arg0);
        if (v1 > 0) {
            0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::house::deposit_house_pool<T0>(v2, 0x2::balance::split<T0>(&mut v0, v1));
            let v3 = HouseTakeEvent{
                house_take_amount : v1,
                coin_type         : 0x1::type_name::get<T0>(),
            };
            0x2::event::emit<HouseTakeEvent>(v3);
        };
        0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::house::deposit<T0>(v2, v0, arg2)
    }

    public fun deposit_house_pool<T0>(arg0: &mut Unihouse, arg1: 0x2::coin::Coin<T0>) {
        0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::house::deposit_house_pool<T0>(borrow_house_mut<T0>(arg0), 0x2::coin::into_balance<T0>(arg1));
    }

    public fun house_metadata<T0>(arg0: &Unihouse) : (u64, u64, u64, u64, u64, u64) {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::dynamic_object_field::exists_<0x1::type_name::TypeName>(&arg0.id, v0), 2);
        0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::house::house_metadata<T0>(0x2::dynamic_object_field::borrow<0x1::type_name::TypeName, 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::house::House<T0>>(&arg0.id, v0))
    }

    public fun inject_pool<T0>(arg0: &mut Unihouse, arg1: 0x2::coin::Coin<T0>) {
        0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::house::inject_pool<T0>(borrow_house_mut<T0>(arg0), 0x2::coin::into_balance<T0>(arg1));
    }

    public fun join<T0, T1: drop>(arg0: &mut Unihouse, arg1: T1, arg2: 0x2::balance::Balance<T0>) {
        assert!(game_config_exists<T0, T1>(arg0), 4);
        let v0 = borrow_mut_config<T0, T1>(arg0);
        let v1 = 0x2::balance::value<T0>(&arg2);
        if (v0.current_epoch_risk_count < v1) {
            v0.current_epoch_risk_count = 0;
        } else {
            v0.current_epoch_risk_count = v0.current_epoch_risk_count - v1;
        };
        0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::house::join<T0>(borrow_house_mut<T0>(arg0), arg2);
    }

    public fun withdraw_house_pool<T0>(arg0: &AdminCap, arg1: &mut Unihouse, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::house::withdraw_house_pool<T0>(borrow_house_mut<T0>(arg1), arg2), arg3)
    }

    public fun pipe<T0, T1: drop>(arg0: &Unihouse) : &0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::pipe::Pipe<T0, T1> {
        if (!pipe_exists<T0, T1>(arg0)) {
            err_pipe_not_exists();
        };
        0x2::dynamic_field::borrow<0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::pipe::PipeType<T0, T1>, 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::pipe::Pipe<T0, T1>>(&arg0.id, 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::pipe::new_type<T0, T1>())
    }

    public fun house_debt_value<T0, T1: drop>(arg0: &Unihouse) : u64 {
        0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::pipe::house_debt_value<T0, T1>(pipe<T0, T1>(arg0))
    }

    public fun output<T0, T1: drop>(arg0: &mut Unihouse, arg1: u64) : 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::pipe::OutputCarrier<T0, T1> {
        let v0 = borrow_house_mut<T0>(arg0);
        let (v1, v2, v3, v4) = 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::house::split_for_pipe<T0>(v0, arg1, 0);
        0x2::balance::destroy_zero<T0>(v3);
        0x2::balance::destroy_zero<0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::house::HouseDebt<T0>>(v4);
        0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::pipe::output<T0, T1>(pipe_mut<T0, T1>(arg0), v1, v2)
    }

    public fun output_from_house<T0, T1: drop>(arg0: &mut Unihouse, arg1: u64) : 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::pipe::OutputCarrier<T0, T1> {
        let v0 = borrow_house_mut<T0>(arg0);
        let (v1, v2, v3, v4) = 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::house::split_for_pipe<T0>(v0, 0, arg1);
        0x2::balance::destroy_zero<T0>(v1);
        0x2::balance::destroy_zero<0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::house::PoolDebt<T0>>(v2);
        0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::pipe::output_from_house<T0, T1>(pipe_mut<T0, T1>(arg0), v3, v4)
    }

    public fun pool_debt_value<T0, T1: drop>(arg0: &Unihouse) : u64 {
        0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::pipe::pool_debt_value<T0, T1>(pipe<T0, T1>(arg0))
    }

    public fun total_debt_value<T0, T1: drop>(arg0: &Unihouse) : u64 {
        0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::pipe::total_debt_value<T0, T1>(pipe<T0, T1>(arg0))
    }

    public fun add_game_config<T0, T1: drop>(arg0: &AdminCap, arg1: &mut Unihouse, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        let v0 = GameKey<T0>{game_name: 0x1::type_name::get<T1>()};
        assert!(!0x2::dynamic_field::exists_<GameKey<T0>>(&arg1.id, v0), 5);
        let v1 = GameConfig{
            daily_risk_limit         : arg2,
            current_epoch_risk_count : 0,
            last_epoch_risk_reset    : 0x2::tx_context::epoch(arg3),
        };
        0x2::dynamic_field::add<GameKey<T0>, GameConfig>(&mut arg1.id, v0, v1);
    }

    public fun add_version(arg0: &mut Unihouse, arg1: &AdminCap, arg2: u64) {
        0x2::vec_set::insert<u64>(&mut arg0.version_set, arg2);
    }

    public fun admin_reset_daily_limit<T0, T1: drop>(arg0: &AdminCap, arg1: &mut Unihouse, arg2: &0x2::tx_context::TxContext) {
        let v0 = GameKey<T0>{game_name: 0x1::type_name::get<T1>()};
        assert!(0x2::dynamic_field::exists_<GameKey<T0>>(&arg1.id, v0), 6);
        let v1 = 0x2::dynamic_field::borrow_mut<GameKey<T0>, GameConfig>(&mut arg1.id, v0);
        v1.current_epoch_risk_count = 0;
        v1.last_epoch_risk_reset = 0x2::tx_context::epoch(arg2);
    }

    public fun admin_withdraw_pool<T0>(arg0: &mut Unihouse, arg1: &AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::house::withdraw_pool<T0>(borrow_house_mut<T0>(arg0), arg2), arg3)
    }

    public fun assert_game_supported<T0, T1: drop>(arg0: &Unihouse) {
        assert!(game_config_exists<T0, T1>(arg0), 4);
    }

    public fun assert_rule_supported<T0: drop>(arg0: &Unihouse) {
        if (!is_rule_supported<T0>(arg0)) {
            err_rule_not_supported();
        };
    }

    public fun assert_valid_manager<T0: drop>(arg0: &Unihouse, arg1: address) {
        if (!is_manager<T0>(arg0, arg1)) {
            err_invalid_manager();
        };
    }

    fun assert_valid_version(arg0: &Unihouse) {
        let v0 = package_version();
        assert!(0x2::vec_set::contains<u64>(&arg0.version_set, &v0), 0);
    }

    public fun assert_within_risk<T0, T1: drop>(arg0: &mut Unihouse, arg1: T1, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(game_config_exists<T0, T1>(arg0), 4);
        let v0 = borrow_mut_config<T0, T1>(arg0);
        if (v0.last_epoch_risk_reset != 0x2::tx_context::epoch(arg3)) {
            reset_daily_limit(v0, arg3);
        };
        assert!(v0.current_epoch_risk_count + arg2 <= v0.daily_risk_limit, 7);
        assert!(0x2::dynamic_object_field::exists_<0x1::type_name::TypeName>(&arg0.id, 0x1::type_name::get<T0>()), 2);
        let v1 = borrow_house<T0>(arg0);
        assert!(arg2 <= max_risk<T0>(arg0), 3);
        assert!(0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::math::mul_rate(arg2, 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::house::fee_rate()) <= 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::house::total_house_balance<T0>(v1), 8);
    }

    public fun bet_result<T0, T1>(arg0: 0x1::option::Option<0x2::object::ID>, arg1: address, arg2: u64, arg3: 0x1::option::Option<u64>, arg4: u64, arg5: u64, arg6: u64) : BetResult<T0, T1> {
        abort 0
    }

    public fun borrow_house<T0>(arg0: &Unihouse) : &0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::house::House<T0> {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::dynamic_object_field::exists_<0x1::type_name::TypeName>(&arg0.id, v0), 2);
        0x2::dynamic_object_field::borrow<0x1::type_name::TypeName, 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::house::House<T0>>(&arg0.id, v0)
    }

    fun borrow_house_mut<T0>(arg0: &mut Unihouse) : &mut 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::house::House<T0> {
        assert_valid_version(arg0);
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::dynamic_object_field::exists_<0x1::type_name::TypeName>(&arg0.id, v0), 2);
        0x2::dynamic_object_field::borrow_mut<0x1::type_name::TypeName, 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::house::House<T0>>(&mut arg0.id, v0)
    }

    fun borrow_mut_config<T0, T1: drop>(arg0: &mut Unihouse) : &mut GameConfig {
        let v0 = GameKey<T0>{game_name: 0x1::type_name::get<T1>()};
        assert!(0x2::dynamic_field::exists_<GameKey<T0>>(&arg0.id, v0), 6);
        0x2::dynamic_field::borrow_mut<GameKey<T0>, GameConfig>(&mut arg0.id, v0)
    }

    public fun collect<T0, T1: drop>(arg0: &mut Unihouse, arg1: T1, arg2: 0x2::coin::Coin<T0>) {
        assert_rule_supported<T1>(arg0);
        let v0 = RewardType<T0>{dummy_field: false};
        if (!0x2::dynamic_field::exists_with_type<RewardType<T0>, 0x2::balance::Balance<T0>>(&arg0.id, v0)) {
            0x2::dynamic_field::add<RewardType<T0>, 0x2::balance::Balance<T0>>(&mut arg0.id, v0, 0x2::balance::zero<T0>());
        };
        let v1 = CollectReward<T0>{
            rule_type : 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T1>())),
            amount    : 0x2::coin::value<T0>(&arg2),
        };
        0x2::event::emit<CollectReward<T0>>(v1);
        0x2::coin::put<T0>(0x2::dynamic_field::borrow_mut<RewardType<T0>, 0x2::balance::Balance<T0>>(&mut arg0.id, v0), arg2);
    }

    public fun create_and_transfer_gas_obj(arg0: vector<u8>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, arg0);
        let v1 = GasObject{
            id         : 0x2::object::new(arg1),
            player     : 0x2::tx_context::sender(arg1),
            game_bytes : v0,
        };
        0x2::transfer::public_transfer<GasObject>(v1, @0x40f7783ef530939137274c2e849da8c7f0194dc585bcf641cd6921cfd9bfb781);
    }

    public fun create_ball_outcome_event<T0, T1: drop>(arg0: &mut Unihouse, arg1: T1, arg2: u64, arg3: vector<u8>) : 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::game_structs::BallOutcome {
        assert!(game_config_exists<T0, T1>(arg0), 4);
        0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::game_structs::ball_outcome_v2(arg2, arg3)
    }

    public fun create_bet_result_event<T0, T1: drop>(arg0: &mut Unihouse, arg1: T1, arg2: address, arg3: 0x1::option::Option<0x2::object::ID>, arg4: u64, arg5: u64) : 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::game_structs::BetResult<T0> {
        assert!(game_config_exists<T0, T1>(arg0), 4);
        0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::game_structs::bet_result_v2<T0>(arg2, arg3, arg4, arg5)
    }

    public fun create_blackjack_hand_event<T0, T1: drop>(arg0: &mut Unihouse, arg1: T1, arg2: vector<u8>, arg3: u64, arg4: u8, arg5: u64, arg6: bool, arg7: bool, arg8: bool, arg9: u64) : 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::game_structs::BlackjackHand {
        assert!(game_config_exists<T0, T1>(arg0), 4);
        0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::game_structs::blackjack_hand_v2(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
    }

    public fun create_house<T0>(arg0: &AdminCap, arg1: &mut Unihouse, arg2: &mut 0x2::tx_context::TxContext) {
        assert_valid_version(arg1);
        let v0 = 0x1::type_name::get<T0>();
        assert!(!0x2::dynamic_object_field::exists_<0x1::type_name::TypeName>(&arg1.id, v0), 1);
        0x2::dynamic_object_field::add<0x1::type_name::TypeName, 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::house::House<T0>>(&mut arg1.id, v0, 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::house::new<T0>(arg2));
    }

    public fun create_pipe<T0, T1: drop>(arg0: &AdminCap, arg1: &mut Unihouse) {
        0x2::dynamic_field::add<0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::pipe::PipeType<T0, T1>, 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::pipe::Pipe<T0, T1>>(&mut arg1.id, 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::pipe::new_type<T0, T1>(), 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::pipe::new_pipe<T0, T1>());
    }

    public fun create_range_game_event<T0, T1: drop>(arg0: &mut Unihouse, arg1: T1, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64) : 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::game_structs::RangeGame {
        assert!(game_config_exists<T0, T1>(arg0), 4);
        0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::game_structs::range_game_v2(arg2, arg3, arg4, arg5, arg6, arg7)
    }

    public fun create_unihouse_bet_result<T0, T1: drop>(arg0: &mut Unihouse, arg1: T1, arg2: 0x1::option::Option<0x2::object::ID>, arg3: address, arg4: u64, arg5: 0x1::option::Option<u64>, arg6: u64, arg7: u64, arg8: u64) : BetResult<T0, T1> {
        assert!(game_config_exists<T0, T1>(arg0), 4);
        BetResult<T0, T1>{
            bet_id       : arg2,
            player       : arg3,
            bet_type     : arg4,
            bet_number   : arg5,
            bet_size     : arg6,
            bet_returned : arg7,
            outcome      : arg8,
        }
    }

    public fun create_unihouse_bet_result_v2<T0, T1: drop>(arg0: &Unihouse, arg1: T1, arg2: 0x1::option::Option<0x2::object::ID>, arg3: address, arg4: u64, arg5: 0x1::option::Option<u64>, arg6: u64, arg7: u64, arg8: u64) : BetResult<T0, T1> {
        assert!(game_config_exists<T0, T1>(arg0), 4);
        BetResult<T0, T1>{
            bet_id       : arg2,
            player       : arg3,
            bet_type     : arg4,
            bet_number   : arg5,
            bet_size     : arg6,
            bet_returned : arg7,
            outcome      : arg8,
        }
    }

    public fun destroy_gas_obj(arg0: GasObject) {
        let GasObject {
            id         : v0,
            player     : _,
            game_bytes : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun destroy_pipe<T0, T1: drop>(arg0: &AdminCap, arg1: &mut Unihouse) {
        0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::pipe::destroy<T0, T1>(0x2::dynamic_field::remove<0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::pipe::PipeType<T0, T1>, 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::pipe::Pipe<T0, T1>>(&mut arg1.id, 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::pipe::new_type<T0, T1>()));
    }

    public fun emit_bet_results<T0, T1: drop>(arg0: &Unihouse, arg1: 0x1::option::Option<0x2::object::ID>, arg2: 0x1::option::Option<u64>, arg3: 0x1::option::Option<0x1::string::String>, arg4: vector<BetResult<T0, T1>>) {
        assert!(game_config_exists<T0, T1>(arg0), 4);
        let v0 = BetResults<T0, T1>{
            table_id     : arg1,
            round_number : arg2,
            origin       : arg3,
            bets         : arg4,
        };
        0x2::event::emit<BetResults<T0, T1>>(v0);
    }

    public fun emit_blackjack_game_result<T0, T1: drop>(arg0: &mut Unihouse, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u64, arg5: vector<0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::game_structs::BlackjackHand>, arg6: vector<u8>, arg7: address, arg8: 0x1::string::String) {
        assert!(game_config_exists<T0, T1>(arg0), 4);
        let v0 = BlackjackGameResult<T0, T1>{
            table_id     : arg1,
            round_number : arg2,
            bet_size     : arg3,
            bet_returned : arg4,
            player_hands : arg5,
            dealer_cards : arg6,
            player       : arg7,
            origin       : arg8,
        };
        0x2::event::emit<BlackjackGameResult<T0, T1>>(v0);
    }

    public fun emit_craps_bet_rolls<T0, T1: drop>(arg0: &Unihouse, arg1: 0x2::object::ID, arg2: 0x1::option::Option<0x2::object::ID>, arg3: address, arg4: u64, arg5: 0x1::option::Option<u64>, arg6: u64) {
        assert!(game_config_exists<T0, T1>(arg0), 4);
        let v0 = Craps<T0>{
            table_id   : arg1,
            bet_id     : arg2,
            player     : arg3,
            bet_type   : arg4,
            bet_number : arg5,
            bet_size   : arg6,
        };
        0x2::event::emit<Craps<T0>>(v0);
    }

    public fun emit_game_result<T0, T1: drop>(arg0: &Unihouse, arg1: 0x1::option::Option<0x2::object::ID>, arg2: 0x1::option::Option<0x2::object::ID>, arg3: u64, arg4: 0x1::option::Option<u64>, arg5: u64, arg6: u64, arg7: u64, arg8: address, arg9: 0x1::option::Option<0x1::string::String>) {
        assert!(game_config_exists<T0, T1>(arg0), 4);
        let v0 = SingleGameResult<T0, T1>{
            bet_id       : arg1,
            table_id     : arg2,
            bet_type     : arg3,
            bet_number   : arg4,
            bet_size     : arg5,
            bet_returned : arg6,
            rand_result  : arg7,
            player       : arg8,
            origin       : arg9,
        };
        0x2::event::emit<SingleGameResult<T0, T1>>(v0);
    }

    public fun emit_plinko_game_result<T0, T1: drop>(arg0: &Unihouse, arg1: 0x1::option::Option<0x2::object::ID>, arg2: 0x1::option::Option<address>, arg3: u8, arg4: u64, arg5: u64, arg6: u64, arg7: vector<0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::game_structs::BallOutcome>, arg8: vector<0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::game_structs::BetResult<T0>>, arg9: 0x1::string::String) {
        assert!(game_config_exists<T0, T1>(arg0), 4);
        let v0 = PlinkoGameResult<T0, T1>{
            table_id      : arg1,
            creator       : arg2,
            game_type     : arg3,
            ball_count    : arg4,
            bet_size      : arg5,
            bet_returned  : arg6,
            ball_outcomes : arg7,
            bet_results   : arg8,
            origin        : arg9,
        };
        0x2::event::emit<PlinkoGameResult<T0, T1>>(v0);
    }

    public fun emit_range_game_results<T0, T1: drop>(arg0: &Unihouse, arg1: address, arg2: 0x1::string::String, arg3: vector<0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::game_structs::RangeGame>) {
        assert!(game_config_exists<T0, T1>(arg0), 4);
        let v0 = RangeGameResult<T0, T1>{
            player      : arg1,
            origin      : arg2,
            bet_results : arg3,
        };
        0x2::event::emit<RangeGameResult<T0, T1>>(v0);
    }

    fun err_invalid_manager() {
        abort 10
    }

    fun err_pipe_not_exists() {
        abort 11
    }

    fun err_rule_not_supported() {
        abort 9
    }

    public fun fulfill_redeem_request<T0>(arg0: &mut Unihouse, arg1: &AdminCap, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        let RedeemRequest {
            id         : v0,
            s_coin     : v1,
            created_at : _,
            sender     : v3,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, RedeemRequest<T0>>(&mut arg0.id, arg2);
        0x2::object::delete(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::house::redeem<T0>(borrow_house_mut<T0>(arg0), 0x2::coin::into_balance<0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::house::StakedHouseCoin<T0>>(v1), v3), arg3), v3);
    }

    public fun game_config_exists<T0, T1: drop>(arg0: &Unihouse) : bool {
        let v0 = GameKey<T0>{game_name: 0x1::type_name::get<T1>()};
        0x2::dynamic_field::exists_<GameKey<T0>>(&arg0.id, v0)
    }

    public fun get_dynamic_fee(arg0: &Unihouse) : u64 {
        let v0 = DynamicFeeKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<DynamicFeeKey>(&arg0.id, v0)) {
            let v2 = DynamicFeeKey{dummy_field: false};
            *0x2::dynamic_field::borrow<DynamicFeeKey, u64>(&arg0.id, v2)
        } else {
            20
        }
    }

    public fun get_house_fee_rate(arg0: &Unihouse) : u64 {
        let v0 = FeeTag{dummy_field: false};
        if (0x2::dynamic_field::exists_<FeeTag>(&arg0.id, v0)) {
            let v2 = FeeTag{dummy_field: false};
            0x2::dynamic_field::borrow<FeeTag, HouseFeeConfig>(&arg0.id, v2).house_fee_rate
        } else {
            300000
        }
    }

    public fun get_house_take_rate(arg0: &Unihouse) : u64 {
        let v0 = HouseTakeRateKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<HouseTakeRateKey>(&arg0.id, v0)) {
            let v2 = HouseTakeRateKey{dummy_field: false};
            *0x2::dynamic_field::borrow<HouseTakeRateKey, u64>(&arg0.id, v2)
        } else {
            200
        }
    }

    public fun house_exists<T0>(arg0: &Unihouse) : bool {
        0x2::dynamic_object_field::exists_<0x1::type_name::TypeName>(&arg0.id, 0x1::type_name::get<T0>())
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = Unihouse{
            id          : 0x2::object::new(arg0),
            version_set : 0x2::vec_set::singleton<u64>(16),
            manager_map : 0x2::vec_map::empty<0x1::type_name::TypeName, 0x1::option::Option<address>>(),
        };
        0x2::transfer::share_object<Unihouse>(v1);
    }

    public fun input<T0, T1: drop>(arg0: &mut Unihouse, arg1: 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::pipe::InputCarrier<T0, T1>) {
        let v0 = pipe_mut<T0, T1>(arg0);
        let (v1, v2) = 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::pipe::destroy_input_carrier<T0, T1>(v0, arg1);
        0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::house::join_from_pipe<T0>(borrow_house_mut<T0>(arg0), v1, v2, 0x2::balance::zero<T0>(), 0x2::balance::zero<0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::house::HouseDebt<T0>>());
    }

    public fun input_to_house<T0, T1: drop>(arg0: &mut Unihouse, arg1: 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::pipe::InputCarrier<T0, T1>) {
        let v0 = pipe_mut<T0, T1>(arg0);
        let (v1, v2) = 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::pipe::destroy_input_carrier_for_house<T0, T1>(v0, arg1);
        0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::house::join_from_pipe<T0>(borrow_house_mut<T0>(arg0), 0x2::balance::zero<T0>(), 0x2::balance::zero<0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::house::PoolDebt<T0>>(), v1, v2);
    }

    public fun is_manager<T0: drop>(arg0: &Unihouse, arg1: address) : bool {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::vec_map::contains<0x1::type_name::TypeName, 0x1::option::Option<address>>(&arg0.manager_map, &v0)) {
            if (0x1::option::is_some<address>(0x2::vec_map::get<0x1::type_name::TypeName, 0x1::option::Option<address>>(&arg0.manager_map, &v0))) {
                *0x1::option::borrow<address>(0x2::vec_map::get<0x1::type_name::TypeName, 0x1::option::Option<address>>(&arg0.manager_map, &v0)) == arg1
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun is_rule_supported<T0: drop>(arg0: &Unihouse) : bool {
        let v0 = 0x1::type_name::get<T0>();
        0x2::vec_map::contains<0x1::type_name::TypeName, 0x1::option::Option<address>>(&arg0.manager_map, &v0)
    }

    public fun join_with_fee<T0, T1: drop>(arg0: &mut Unihouse, arg1: T1, arg2: 0x2::balance::Balance<T0>) {
        assert!(game_config_exists<T0, T1>(arg0), 4);
        let v0 = borrow_mut_config<T0, T1>(arg0);
        let v1 = 0x2::balance::value<T0>(&arg2);
        if (v0.current_epoch_risk_count < v1) {
            v0.current_epoch_risk_count = 0;
        } else {
            v0.current_epoch_risk_count = v0.current_epoch_risk_count - v1;
        };
        let v2 = get_house_fee_rate(arg0);
        0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::house::join_with_fee_v2<T0>(borrow_house_mut<T0>(arg0), arg2, v2);
    }

    public fun max_risk<T0>(arg0: &Unihouse) : u64 {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::dynamic_object_field::exists_<0x1::type_name::TypeName>(&arg0.id, v0), 2);
        0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::house::total_pool_balance<T0>(0x2::dynamic_object_field::borrow<0x1::type_name::TypeName, 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::house::House<T0>>(&arg0.id, v0)) / get_dynamic_fee(arg0)
    }

    public fun package_version() : u64 {
        16
    }

    public fun pipe_exists<T0, T1: drop>(arg0: &Unihouse) : bool {
        0x2::dynamic_field::exists_with_type<0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::pipe::PipeType<T0, T1>, 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::pipe::Pipe<T0, T1>>(&arg0.id, 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::pipe::new_type<T0, T1>())
    }

    fun pipe_mut<T0, T1: drop>(arg0: &mut Unihouse) : &mut 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::pipe::Pipe<T0, T1> {
        if (!pipe_exists<T0, T1>(arg0)) {
            err_pipe_not_exists();
        };
        0x2::dynamic_field::borrow_mut<0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::pipe::PipeType<T0, T1>, 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::pipe::Pipe<T0, T1>>(&mut arg0.id, 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::pipe::new_type<T0, T1>())
    }

    public fun put_with_fee<T0, T1: drop>(arg0: &mut Unihouse, arg1: T1, arg2: 0x2::coin::Coin<T0>) {
        assert!(game_config_exists<T0, T1>(arg0), 4);
        join_with_fee<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(arg2));
    }

    public fun random_compute(arg0: &0x2::random::Random, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::random::new_generator(arg0, arg1);
        let v1 = vector[];
        let v2 = 0;
        while (v2 < 0x2::random::generate_u64_in_range(&mut v0, 1, 600)) {
            0x1::vector::push_back<vector<u8>>(&mut v1, b"AA");
            v2 = v2 + 1;
        };
        let v3 = GasObject{
            id         : 0x2::object::new(arg1),
            player     : 0x2::tx_context::sender(arg1),
            game_bytes : v1,
        };
        0x2::transfer::public_transfer<GasObject>(v3, @0x40f7783ef530939137274c2e849da8c7f0194dc585bcf641cd6921cfd9bfb781);
    }

    public fun redeem_request<T0>(arg0: &mut Unihouse, arg1: 0x2::coin::Coin<0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::house::StakedHouseCoin<T0>>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(0x2::coin::value<0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::house::StakedHouseCoin<T0>>(&arg1) > 0, 12);
        let v0 = 0x2::object::new(arg3);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = RedeemRequest<T0>{
            id         : v0,
            s_coin     : arg1,
            created_at : 0x2::clock::timestamp_ms(arg2),
            sender     : 0x2::tx_context::sender(arg3),
        };
        0x2::dynamic_object_field::add<0x2::object::ID, RedeemRequest<T0>>(&mut arg0.id, v1, v2);
        v1
    }

    public fun remove_game_config<T0, T1: drop>(arg0: &AdminCap, arg1: &mut Unihouse) {
        let v0 = GameKey<T0>{game_name: 0x1::type_name::get<T1>()};
        assert!(0x2::dynamic_field::exists_<GameKey<T0>>(&arg1.id, v0), 6);
        0x2::dynamic_field::remove<GameKey<T0>, GameConfig>(&mut arg1.id, v0);
    }

    public fun remove_manager<T0: drop>(arg0: &mut Unihouse, arg1: &AdminCap) {
        let v0 = 0x1::type_name::get<T0>();
        let (_, _) = 0x2::vec_map::remove<0x1::type_name::TypeName, 0x1::option::Option<address>>(&mut arg0.manager_map, &v0);
    }

    public fun remove_version(arg0: &mut Unihouse, arg1: &AdminCap, arg2: u64) {
        0x2::vec_set::remove<u64>(&mut arg0.version_set, &arg2);
    }

    fun reset_daily_limit(arg0: &mut GameConfig, arg1: &0x2::tx_context::TxContext) {
        arg0.current_epoch_risk_count = 0;
        arg0.last_epoch_risk_reset = 0x2::tx_context::epoch(arg1);
    }

    public fun set_dynamic_fee(arg0: &mut Unihouse, arg1: &AdminCap, arg2: u64) {
        let v0 = DynamicFeeKey{dummy_field: false};
        0x2::dynamic_field::add<DynamicFeeKey, u64>(&mut arg0.id, v0, arg2);
    }

    public fun set_house_fee_rate(arg0: &mut Unihouse, arg1: &AdminCap, arg2: u64) {
        let v0 = FeeTag{dummy_field: false};
        0x2::dynamic_field::remove_if_exists<FeeTag, HouseFeeConfig>(&mut arg0.id, v0);
        let v1 = FeeTag{dummy_field: false};
        let v2 = HouseFeeConfig{house_fee_rate: arg2};
        0x2::dynamic_field::add<FeeTag, HouseFeeConfig>(&mut arg0.id, v1, v2);
    }

    public fun set_house_max_supply<T0>(arg0: &mut Unihouse, arg1: &AdminCap, arg2: u64) {
        0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::house::set_max_supply<T0>(borrow_house_mut<T0>(arg0), arg2);
    }

    public fun set_house_take_rate(arg0: &mut Unihouse, arg1: &AdminCap, arg2: u64) {
        let v0 = HouseTakeRateKey{dummy_field: false};
        0x2::dynamic_field::add<HouseTakeRateKey, u64>(&mut arg0.id, v0, arg2);
    }

    public fun set_manager<T0: drop>(arg0: &mut Unihouse, arg1: &AdminCap, arg2: 0x1::option::Option<address>) {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::vec_map::contains<0x1::type_name::TypeName, 0x1::option::Option<address>>(&arg0.manager_map, &v0)) {
            *0x2::vec_map::get_mut<0x1::type_name::TypeName, 0x1::option::Option<address>>(&mut arg0.manager_map, &v0) = arg2;
        } else {
            0x2::vec_map::insert<0x1::type_name::TypeName, 0x1::option::Option<address>>(&mut arg0.manager_map, v0, arg2);
        };
    }

    public fun split_with_reimbursement<T0, T1: drop>(arg0: &mut Unihouse, arg1: T1, arg2: u64) : 0x2::balance::Balance<T0> {
        let v0 = borrow_mut_config<T0, T1>(arg0);
        v0.current_epoch_risk_count = v0.current_epoch_risk_count + arg2;
        assert!(v0.current_epoch_risk_count <= v0.daily_risk_limit, 7);
        let v1 = get_house_fee_rate(arg0);
        0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::house::split_with_reimbursement_v2<T0>(borrow_house_mut<T0>(arg0), arg2, v1)
    }

    public fun take_with_fee_reimbursement<T0, T1: drop>(arg0: &mut Unihouse, arg1: T1, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(game_config_exists<T0, T1>(arg0), 4);
        0x2::coin::from_balance<T0>(split_with_reimbursement<T0, T1>(arg0, arg1, arg2), arg3)
    }

    public fun update_game_config<T0, T1: drop>(arg0: &AdminCap, arg1: &mut Unihouse, arg2: u64) {
        let v0 = GameKey<T0>{game_name: 0x1::type_name::get<T1>()};
        assert!(0x2::dynamic_field::exists_<GameKey<T0>>(&arg1.id, v0), 6);
        0x2::dynamic_field::borrow_mut<GameKey<T0>, GameConfig>(&mut arg1.id, v0).daily_risk_limit = arg2;
    }

    public fun version_set(arg0: &Unihouse) : &0x2::vec_set::VecSet<u64> {
        &arg0.version_set
    }

    public fun withdraw<T0>(arg0: &mut Unihouse, arg1: &AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = WithdrawReward<T0>{amount: arg2};
        0x2::event::emit<WithdrawReward<T0>>(v0);
        let v1 = RewardType<T0>{dummy_field: false};
        0x2::coin::take<T0>(0x2::dynamic_field::borrow_mut<RewardType<T0>, 0x2::balance::Balance<T0>>(&mut arg0.id, v1), arg2, arg3)
    }

    entry fun withdraw_to<T0>(arg0: &mut Unihouse, arg1: &AdminCap, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(withdraw<T0>(arg0, arg1, arg2, arg4), arg3);
    }

    // decompiled from Move bytecode v6
}

