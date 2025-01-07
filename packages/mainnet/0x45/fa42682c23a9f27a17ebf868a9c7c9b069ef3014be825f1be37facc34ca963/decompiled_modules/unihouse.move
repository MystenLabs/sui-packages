module 0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse {
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

    struct VoucherConfigKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct VoucherConfig has store, key {
        id: 0x2::object::UID,
        rules: vector<u64>,
    }

    struct RedeemRequest<phantom T0> has store, key {
        id: 0x2::object::UID,
        s_coin: 0x2::coin::Coin<0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::house::StakedHouseCoin<T0>>,
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
        player_hands: vector<0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::game_structs::BlackjackHand>,
        dealer_cards: vector<u8>,
        player: address,
        origin: 0x1::string::String,
    }

    struct PlinkoGameResult<phantom T0, phantom T1> has copy, drop {
        table_id: 0x1::option::Option<0x2::object::ID>,
        creator: 0x1::option::Option<address>,
        game_type: u8,
        ball_count: u64,
        bet_size: u64,
        bet_returned: u64,
        ball_outcomes: vector<0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::game_structs::BallOutcome>,
        bet_results: vector<0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::game_structs::BetResult<T0>>,
        origin: 0x1::string::String,
    }

    struct RangeGameResult<phantom T0, phantom T1> has copy, drop {
        player: address,
        origin: 0x1::string::String,
        bet_results: vector<0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::game_structs::RangeGame>,
    }

    public fun put<T0, T1: drop>(arg0: &mut Unihouse, arg1: T1, arg2: 0x2::coin::Coin<T0>) {
        assert!(game_config_exists<T0, T1>(arg0), 4);
        join<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(arg2));
    }

    public fun take<T0, T1: drop>(arg0: &mut Unihouse, arg1: T1, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(game_config_exists<T0, T1>(arg0), 4);
        0x2::coin::from_balance<T0>(split<T0, T1>(arg0, arg1, arg2), arg3)
    }

    public fun deposit<T0>(arg0: &mut Unihouse, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::house::StakedHouseCoin<T0>> {
        0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::house::deposit<T0>(borrow_house_mut<T0>(arg0), 0x2::coin::into_balance<T0>(arg1), arg2)
    }

    public fun deposit_house_pool<T0>(arg0: &mut Unihouse, arg1: 0x2::coin::Coin<T0>) {
        0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::house::deposit_house_pool<T0>(borrow_house_mut<T0>(arg0), 0x2::coin::into_balance<T0>(arg1));
    }

    public fun house_metadata<T0>(arg0: &Unihouse) : (u64, u64, u64, u64) {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::dynamic_object_field::exists_<0x1::type_name::TypeName>(&arg0.id, v0), 2);
        0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::house::house_metadata<T0>(0x2::dynamic_object_field::borrow<0x1::type_name::TypeName, 0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::house::House<T0>>(&arg0.id, v0))
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
        0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::house::join<T0>(borrow_house_mut<T0>(arg0), arg2);
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
        0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::house::join_with_fee<T0>(borrow_house_mut<T0>(arg0), arg2);
    }

    public fun max_risk<T0>(arg0: &Unihouse) : u64 {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::dynamic_object_field::exists_<0x1::type_name::TypeName>(&arg0.id, v0), 2);
        0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::house::max_risk<T0>(0x2::dynamic_object_field::borrow<0x1::type_name::TypeName, 0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::house::House<T0>>(&arg0.id, v0))
    }

    public fun split<T0, T1: drop>(arg0: &mut Unihouse, arg1: T1, arg2: u64) : 0x2::balance::Balance<T0> {
        let v0 = borrow_mut_config<T0, T1>(arg0);
        v0.current_epoch_risk_count = v0.current_epoch_risk_count + arg2;
        assert!(v0.current_epoch_risk_count <= v0.daily_risk_limit, 8);
        0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::house::split<T0>(borrow_house_mut<T0>(arg0), arg2)
    }

    public fun split_with_reimbursement<T0, T1: drop>(arg0: &mut Unihouse, arg1: T1, arg2: u64) : 0x2::balance::Balance<T0> {
        let v0 = borrow_mut_config<T0, T1>(arg0);
        v0.current_epoch_risk_count = v0.current_epoch_risk_count + arg2;
        assert!(v0.current_epoch_risk_count <= v0.daily_risk_limit, 8);
        0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::house::split_with_reimbursement<T0>(borrow_house_mut<T0>(arg0), arg2)
    }

    public fun withdraw_house_pool<T0>(arg0: &AdminCap, arg1: &mut Unihouse, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::house::withdraw_house_pool<T0>(borrow_house_mut<T0>(arg1), arg2), arg3)
    }

    public fun output<T0, T1: drop>(arg0: &mut Unihouse, arg1: u64) : 0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::pipe::OutputCarrier<T0, T1> {
        let v0 = borrow_house_mut<T0>(arg0);
        let (v1, v2) = 0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::house::split_for_pipe<T0>(v0, arg1, false);
        0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::pipe::output<T0, T1>(borrow_pipe_mut<T0, T1>(arg0), v1, v2)
    }

    public fun add_game_config<T0, T1: drop>(arg0: &AdminCap, arg1: &mut Unihouse, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        let v0 = GameKey<T0>{game_name: 0x1::type_name::get<T1>()};
        assert!(!0x2::dynamic_field::exists_<GameKey<T0>>(&arg1.id, v0), 6);
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
        assert!(0x2::dynamic_field::exists_<GameKey<T0>>(&arg1.id, v0), 7);
        let v1 = 0x2::dynamic_field::borrow_mut<GameKey<T0>, GameConfig>(&mut arg1.id, v0);
        v1.current_epoch_risk_count = 0;
        v1.last_epoch_risk_reset = 0x2::tx_context::epoch(arg2);
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

    fun assert_valid_voucher_value<T0, T1>(arg0: &Unihouse, arg1: &0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::voucher::UnihouseVoucher<T0, T1>) {
        let v0 = voucher_max_value<T0>(arg0);
        if (0x1::option::is_none<u64>(&v0)) {
            return
        };
        assert!(0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::voucher::value<T0, T1>(arg1) <= 0x1::option::destroy_some<u64>(v0), 5);
    }

    public fun assert_within_risk<T0, T1: drop>(arg0: &mut Unihouse, arg1: T1, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(game_config_exists<T0, T1>(arg0), 4);
        let v0 = borrow_mut_config<T0, T1>(arg0);
        if (v0.last_epoch_risk_reset != 0x2::tx_context::epoch(arg3)) {
            reset_daily_limit(v0, arg3);
        };
        assert!(v0.current_epoch_risk_count + arg2 <= v0.daily_risk_limit, 8);
        assert!(0x2::dynamic_object_field::exists_<0x1::type_name::TypeName>(&arg0.id, 0x1::type_name::get<T0>()), 2);
        let v1 = borrow_house<T0>(arg0);
        assert!(arg2 <= 0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::house::max_risk<T0>(v1), 3);
        assert!(0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::math::mul_rate(arg2, 0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::house::fee_rate()) <= 0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::house::house_balance<T0>(v1), 9);
    }

    public fun bet_result<T0, T1>(arg0: 0x1::option::Option<0x2::object::ID>, arg1: address, arg2: u64, arg3: 0x1::option::Option<u64>, arg4: u64, arg5: u64, arg6: u64) : BetResult<T0, T1> {
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

    public fun borrow_house<T0>(arg0: &Unihouse) : &0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::house::House<T0> {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::dynamic_object_field::exists_<0x1::type_name::TypeName>(&arg0.id, v0), 2);
        0x2::dynamic_object_field::borrow<0x1::type_name::TypeName, 0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::house::House<T0>>(&arg0.id, v0)
    }

    fun borrow_house_mut<T0>(arg0: &mut Unihouse) : &mut 0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::house::House<T0> {
        assert_valid_version(arg0);
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::dynamic_object_field::exists_<0x1::type_name::TypeName>(&arg0.id, v0), 2);
        0x2::dynamic_object_field::borrow_mut<0x1::type_name::TypeName, 0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::house::House<T0>>(&mut arg0.id, v0)
    }

    fun borrow_mut_config<T0, T1: drop>(arg0: &mut Unihouse) : &mut GameConfig {
        let v0 = GameKey<T0>{game_name: 0x1::type_name::get<T1>()};
        assert!(0x2::dynamic_field::exists_<GameKey<T0>>(&arg0.id, v0), 7);
        0x2::dynamic_field::borrow_mut<GameKey<T0>, GameConfig>(&mut arg0.id, v0)
    }

    public fun borrow_pipe<T0, T1: drop>(arg0: &Unihouse) : &0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::pipe::Pipe<T0, T1> {
        if (!pipe_exists<T0, T1>(arg0)) {
            err_pipe_not_exists();
        };
        0x2::dynamic_field::borrow<0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::pipe::PipeType<T0, T1>, 0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::pipe::Pipe<T0, T1>>(&arg0.id, 0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::pipe::new_type<T0, T1>())
    }

    fun borrow_pipe_mut<T0, T1: drop>(arg0: &mut Unihouse) : &mut 0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::pipe::Pipe<T0, T1> {
        if (!pipe_exists<T0, T1>(arg0)) {
            err_pipe_not_exists();
        };
        0x2::dynamic_field::borrow_mut<0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::pipe::PipeType<T0, T1>, 0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::pipe::Pipe<T0, T1>>(&mut arg0.id, 0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::pipe::new_type<T0, T1>())
    }

    public fun buy_voucher<T0, T1>(arg0: &mut Unihouse, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::voucher::UnihouseVoucher<T0, T1> {
        0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::house::voucher_deposit<T0>(borrow_house_mut<T0>(arg0), arg1);
        0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::voucher::mint<T0, T1>(0x2::coin::value<T0>(&arg1), 0x2::clock::timestamp_ms(arg2) + 7776000000, arg3)
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

    public fun create_house<T0>(arg0: &AdminCap, arg1: &mut Unihouse, arg2: &mut 0x2::tx_context::TxContext) {
        assert_valid_version(arg1);
        let v0 = 0x1::type_name::get<T0>();
        assert!(!0x2::dynamic_object_field::exists_<0x1::type_name::TypeName>(&arg1.id, v0), 1);
        0x2::dynamic_object_field::add<0x1::type_name::TypeName, 0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::house::House<T0>>(&mut arg1.id, v0, 0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::house::new<T0>(arg2));
    }

    public fun create_pipe<T0, T1: drop>(arg0: &AdminCap, arg1: &mut Unihouse) {
        0x2::dynamic_field::add<0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::pipe::PipeType<T0, T1>, 0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::pipe::Pipe<T0, T1>>(&mut arg1.id, 0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::pipe::new_type<T0, T1>(), 0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::pipe::new_pipe<T0, T1>());
    }

    public fun destroy_pipe<T0, T1: drop>(arg0: &AdminCap, arg1: &mut Unihouse) {
        0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::pipe::destroy<T0, T1>(0x2::dynamic_field::remove<0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::pipe::PipeType<T0, T1>, 0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::pipe::Pipe<T0, T1>>(&mut arg1.id, 0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::pipe::new_type<T0, T1>()));
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

    public fun emit_blackjack_game_result<T0, T1: drop>(arg0: &mut Unihouse, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u64, arg5: vector<0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::game_structs::BlackjackHand>, arg6: vector<u8>, arg7: address, arg8: 0x1::string::String) {
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

    public fun emit_plinko_game_result<T0, T1: drop>(arg0: &Unihouse, arg1: 0x1::option::Option<0x2::object::ID>, arg2: 0x1::option::Option<address>, arg3: u8, arg4: u64, arg5: u64, arg6: u64, arg7: vector<0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::game_structs::BallOutcome>, arg8: vector<0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::game_structs::BetResult<T0>>, arg9: 0x1::string::String) {
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

    public fun emit_range_game_results<T0, T1: drop>(arg0: &Unihouse, arg1: address, arg2: 0x1::string::String, arg3: vector<0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::game_structs::RangeGame>) {
        assert!(game_config_exists<T0, T1>(arg0), 4);
        let v0 = RangeGameResult<T0, T1>{
            player      : arg1,
            origin      : arg2,
            bet_results : arg3,
        };
        0x2::event::emit<RangeGameResult<T0, T1>>(v0);
    }

    fun err_invalid_manager() {
        abort 11
    }

    fun err_pipe_not_exists() {
        abort 12
    }

    fun err_rule_not_supported() {
        abort 10
    }

    public fun fulfill_redeem_request<T0>(arg0: &mut Unihouse, arg1: &AdminCap, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        let RedeemRequest {
            id         : v0,
            s_coin     : v1,
            created_at : _,
            sender     : v3,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, RedeemRequest<T0>>(&mut arg0.id, arg2);
        0x2::object::delete(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::house::redeem<T0>(borrow_house_mut<T0>(arg0), 0x2::coin::into_balance<0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::house::StakedHouseCoin<T0>>(v1), v3), arg3), v3);
    }

    public fun game_config_exists<T0, T1: drop>(arg0: &Unihouse) : bool {
        let v0 = GameKey<T0>{game_name: 0x1::type_name::get<T1>()};
        0x2::dynamic_field::exists_<GameKey<T0>>(&arg0.id, v0)
    }

    public fun house_exists<T0>(arg0: &Unihouse) : bool {
        0x2::dynamic_object_field::exists_<0x1::type_name::TypeName>(&arg0.id, 0x1::type_name::get<T0>())
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = Unihouse{
            id          : 0x2::object::new(arg0),
            version_set : 0x2::vec_set::singleton<u64>(0),
            manager_map : 0x2::vec_map::empty<0x1::type_name::TypeName, 0x1::option::Option<address>>(),
        };
        0x2::transfer::share_object<Unihouse>(v1);
    }

    public fun input<T0, T1: drop>(arg0: &mut Unihouse, arg1: 0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::pipe::InputCarrier<T0, T1>) {
        let v0 = borrow_pipe_mut<T0, T1>(arg0);
        let (v1, v2) = 0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::pipe::destroy_input_carrier<T0, T1>(arg1, v0);
        0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::house::join_from_pipe<T0>(borrow_house_mut<T0>(arg0), v1, v2, false);
    }

    public fun input_to_house<T0, T1: drop>(arg0: &mut Unihouse, arg1: 0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::pipe::InputCarrier<T0, T1>) {
        let v0 = borrow_pipe_mut<T0, T1>(arg0);
        let (v1, v2) = 0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::pipe::destroy_input_carrier<T0, T1>(arg1, v0);
        0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::house::join_from_pipe<T0>(borrow_house_mut<T0>(arg0), v1, v2, true);
    }

    public fun is_manager<T0: drop>(arg0: &Unihouse, arg1: address) : bool {
        let v0 = 0x1::type_name::get<T0>();
        0x2::vec_map::contains<0x1::type_name::TypeName, 0x1::option::Option<address>>(&arg0.manager_map, &v0) && 0x1::option::is_some<address>(0x2::vec_map::get<0x1::type_name::TypeName, 0x1::option::Option<address>>(&arg0.manager_map, &v0)) && *0x1::option::borrow<address>(0x2::vec_map::get<0x1::type_name::TypeName, 0x1::option::Option<address>>(&arg0.manager_map, &v0)) == arg1
    }

    public fun is_rule_supported<T0: drop>(arg0: &Unihouse) : bool {
        let v0 = 0x1::type_name::get<T0>();
        0x2::vec_map::contains<0x1::type_name::TypeName, 0x1::option::Option<address>>(&arg0.manager_map, &v0)
    }

    public fun output_from_house<T0, T1: drop>(arg0: &mut Unihouse, arg1: u64) : 0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::pipe::OutputCarrier<T0, T1> {
        let v0 = borrow_house_mut<T0>(arg0);
        let (v1, v2) = 0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::house::split_for_pipe<T0>(v0, arg1, true);
        0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::pipe::output<T0, T1>(borrow_pipe_mut<T0, T1>(arg0), v1, v2)
    }

    public fun package_version() : u64 {
        0
    }

    public fun pipe_exists<T0, T1: drop>(arg0: &Unihouse) : bool {
        0x2::dynamic_field::exists_with_type<0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::pipe::PipeType<T0, T1>, 0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::pipe::Pipe<T0, T1>>(&arg0.id, 0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::pipe::new_type<T0, T1>())
    }

    public fun put_with_fee<T0, T1: drop>(arg0: &mut Unihouse, arg1: T1, arg2: 0x2::coin::Coin<T0>) {
        assert!(game_config_exists<T0, T1>(arg0), 4);
        join_with_fee<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(arg2));
    }

    public fun redeem_request<T0>(arg0: &mut Unihouse, arg1: 0x2::coin::Coin<0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::house::StakedHouseCoin<T0>>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
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

    public fun redeem_voucher<T0, T1>(arg0: &mut Unihouse, arg1: &mut 0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::voucher::UnihouseVoucher<T0, T1>, arg2: &0x2::clock::Clock, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_valid_voucher_value<T0, T1>(arg0, arg1);
        0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::voucher::deduct<T0, T1>(arg1, arg2, arg3);
        0x2::coin::from_balance<T0>(0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::house::split_for_voucher<T0>(borrow_house_mut<T0>(arg0), arg3), arg4)
    }

    public fun remove_game_config<T0, T1: drop>(arg0: &AdminCap, arg1: &mut Unihouse) {
        let v0 = GameKey<T0>{game_name: 0x1::type_name::get<T1>()};
        assert!(0x2::dynamic_field::exists_<GameKey<T0>>(&arg1.id, v0), 7);
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

    public fun set_house_max_supply<T0>(arg0: &mut Unihouse, arg1: &AdminCap, arg2: u64) {
        0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::house::set_max_supply<T0>(borrow_house_mut<T0>(arg0), arg2);
    }

    public fun set_manager<T0: drop>(arg0: &mut Unihouse, arg1: &AdminCap, arg2: 0x1::option::Option<address>) {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::vec_map::contains<0x1::type_name::TypeName, 0x1::option::Option<address>>(&arg0.manager_map, &v0)) {
            *0x2::vec_map::get_mut<0x1::type_name::TypeName, 0x1::option::Option<address>>(&mut arg0.manager_map, &v0) = arg2;
        } else {
            0x2::vec_map::insert<0x1::type_name::TypeName, 0x1::option::Option<address>>(&mut arg0.manager_map, v0, arg2);
        };
    }

    public fun set_voucher_config<T0>(arg0: &AdminCap, arg1: &mut Unihouse, arg2: vector<u64>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = VoucherConfigKey<T0>{dummy_field: false};
        if (0x2::dynamic_object_field::exists_with_type<VoucherConfigKey<T0>, VoucherConfig>(&arg1.id, v0)) {
            0x2::dynamic_object_field::borrow_mut<VoucherConfigKey<T0>, VoucherConfig>(&mut arg1.id, v0).rules = arg2;
        } else {
            let v1 = VoucherConfig{
                id    : 0x2::object::new(arg3),
                rules : arg2,
            };
            0x2::dynamic_object_field::add<VoucherConfigKey<T0>, VoucherConfig>(&mut arg1.id, v0, v1);
        };
    }

    public fun take_with_fee_reimbursement<T0, T1: drop>(arg0: &mut Unihouse, arg1: T1, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(game_config_exists<T0, T1>(arg0), 4);
        0x2::coin::from_balance<T0>(split_with_reimbursement<T0, T1>(arg0, arg1, arg2), arg3)
    }

    public fun update_game_config<T0, T1: drop>(arg0: &AdminCap, arg1: &mut Unihouse, arg2: u64) {
        let v0 = GameKey<T0>{game_name: 0x1::type_name::get<T1>()};
        assert!(0x2::dynamic_field::exists_<GameKey<T0>>(&arg1.id, v0), 7);
        0x2::dynamic_field::borrow_mut<GameKey<T0>, GameConfig>(&mut arg1.id, v0).daily_risk_limit = arg2;
    }

    public fun version_set(arg0: &Unihouse) : &0x2::vec_set::VecSet<u64> {
        &arg0.version_set
    }

    public fun voucher_max_value<T0>(arg0: &Unihouse) : 0x1::option::Option<u64> {
        let v0 = VoucherConfigKey<T0>{dummy_field: false};
        if (0x2::dynamic_object_field::exists_with_type<VoucherConfigKey<T0>, VoucherConfig>(&arg0.id, v0)) {
            0x1::option::some<u64>(*0x1::vector::borrow<u64>(&0x2::dynamic_object_field::borrow<VoucherConfigKey<T0>, VoucherConfig>(&arg0.id, v0).rules, 0))
        } else {
            0x1::option::none<u64>()
        }
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

