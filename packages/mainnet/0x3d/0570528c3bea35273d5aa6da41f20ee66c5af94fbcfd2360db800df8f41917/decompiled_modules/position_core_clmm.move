module 0xb4fae2fd636b996f92234b4d373cc92ce4486e67885d3c314610dd5426504b9::position_core_clmm {
    struct ACreateConfig has drop {
        dummy_field: bool,
    }

    struct AModifyConfig has drop {
        dummy_field: bool,
    }

    struct AMigrate has drop {
        dummy_field: bool,
    }

    struct ADeleverage has drop {
        dummy_field: bool,
    }

    struct ARebalance has drop {
        dummy_field: bool,
    }

    struct CreatePositionTicket<phantom T0, phantom T1, T2> {
        config_id: 0x2::object::ID,
        tick_a: T2,
        tick_b: T2,
        dx: u64,
        dy: u64,
        delta_l: u128,
        principal_x: 0x2::balance::Balance<T0>,
        principal_y: 0x2::balance::Balance<T1>,
        borrowed_x: 0x2::balance::Balance<T0>,
        borrowed_y: 0x2::balance::Balance<T1>,
        debt_bag: 0xb4fae2fd636b996f92234b4d373cc92ce4486e67885d3c314610dd5426504b9::supply_pool::FacilDebtBag,
    }

    struct Position<phantom T0, phantom T1, T2> has key {
        id: 0x2::object::UID,
        config_id: 0x2::object::ID,
        lp_position: T2,
        col_x: 0x2::balance::Balance<T0>,
        col_y: 0x2::balance::Balance<T1>,
        debt_bag: 0xb4fae2fd636b996f92234b4d373cc92ce4486e67885d3c314610dd5426504b9::supply_pool::FacilDebtBag,
        collected_fees: 0xb4fae2fd636b996f92234b4d373cc92ce4486e67885d3c314610dd5426504b9::balance_bag::BalanceBag,
        ticket_active: bool,
        version: u16,
    }

    struct PositionCap has store, key {
        id: 0x2::object::UID,
        position_id: 0x2::object::ID,
    }

    struct PythConfig has copy, drop, store {
        max_age_secs: u64,
        pio_allowlist: 0x2::vec_map::VecMap<0x1::type_name::TypeName, 0x2::object::ID>,
    }

    struct PositionConfig has key {
        id: 0x2::object::UID,
        pool_object_id: 0x2::object::ID,
        allow_new_positions: bool,
        lend_facil_cap: 0xb4fae2fd636b996f92234b4d373cc92ce4486e67885d3c314610dd5426504b9::supply_pool::LendFacilCap,
        min_liq_start_price_delta_bps: u16,
        min_init_margin_bps: u16,
        allowed_oracles: 0x2::bag::Bag,
        deleverage_margin_bps: u16,
        base_deleverage_factor_bps: u16,
        liq_margin_bps: u16,
        base_liq_factor_bps: u16,
        liq_bonus_bps: u16,
        max_position_l: u128,
        max_global_l: u128,
        current_global_l: u128,
        rebalance_fee_bps: u16,
        liq_fee_bps: u16,
        position_creation_fee_sui: u64,
        version: u16,
    }

    struct DeleverageTicket {
        position_id: 0x2::object::ID,
        can_repay_x: bool,
        can_repay_y: bool,
        info: DeleverageInfo,
    }

    struct ReductionRepaymentTicket<phantom T0, phantom T1> {
        sx: 0xb4fae2fd636b996f92234b4d373cc92ce4486e67885d3c314610dd5426504b9::supply_pool::FacilDebtShare<T0>,
        sy: 0xb4fae2fd636b996f92234b4d373cc92ce4486e67885d3c314610dd5426504b9::supply_pool::FacilDebtShare<T1>,
        info: ReductionInfo,
    }

    struct RebalanceReceipt {
        id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        collected_amm_fee_x: u64,
        collected_amm_fee_y: u64,
        collected_amm_rewards: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
        fees_taken: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
        delta_l: u128,
        delta_x: u64,
        delta_y: u64,
        x_repaid: u64,
        y_repaid: u64,
    }

    struct PositionCreationInfo has copy, drop {
        position_id: 0x2::object::ID,
        config_id: 0x2::object::ID,
        sqrt_pa_x64: u128,
        sqrt_pb_x64: u128,
        l: u128,
        x0: u64,
        y0: u64,
        cx: u64,
        cy: u64,
        dx: u64,
        dy: u64,
        creation_fee_amt_sui: u64,
    }

    struct DeleverageInfo has copy, drop {
        position_id: 0x2::object::ID,
        model: 0xb4fae2fd636b996f92234b4d373cc92ce4486e67885d3c314610dd5426504b9::position_model_clmm::PositionModel,
        oracle_price_x128: u256,
        sqrt_pool_price_x64: u128,
        delta_l: u128,
        delta_x: u64,
        delta_y: u64,
        x_repaid: u64,
        y_repaid: u64,
    }

    struct LiquidationInfo has copy, drop {
        position_id: 0x2::object::ID,
        model: 0xb4fae2fd636b996f92234b4d373cc92ce4486e67885d3c314610dd5426504b9::position_model_clmm::PositionModel,
        oracle_price_x128: u256,
        x_repaid: u64,
        y_repaid: u64,
        liquidator_reward_x: u64,
        liquidator_reward_y: u64,
        liquidation_fee_x: u64,
        liquidation_fee_y: u64,
    }

    struct ReductionInfo has copy, drop {
        position_id: 0x2::object::ID,
        model: 0xb4fae2fd636b996f92234b4d373cc92ce4486e67885d3c314610dd5426504b9::position_model_clmm::PositionModel,
        oracle_price_x128: u256,
        sqrt_pool_price_x64: u128,
        delta_l: u128,
        delta_x: u64,
        delta_y: u64,
        withdrawn_x: u64,
        withdrawn_y: u64,
        x_repaid: u64,
        y_repaid: u64,
    }

    struct AddCollateralInfo has copy, drop {
        position_id: 0x2::object::ID,
        amount_x: u64,
        amount_y: u64,
        is_rebalance: bool,
    }

    struct AddLiquidityInfo has copy, drop {
        position_id: 0x2::object::ID,
        sqrt_pool_price_x64: u128,
        delta_l: u128,
        delta_x: u64,
        delta_y: u64,
    }

    struct RepayDebtInfo has copy, drop {
        position_id: 0x2::object::ID,
        x_repaid: u64,
        y_repaid: u64,
    }

    struct RebalanceInfo has copy, drop {
        id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        collected_amm_fee_x: u64,
        collected_amm_fee_y: u64,
        collected_amm_rewards: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
        fees_taken: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
        delta_l: u128,
        delta_x: u64,
        delta_y: u64,
        x_repaid: u64,
        y_repaid: u64,
    }

    public(friend) fun a_deleverage() : ADeleverage {
        ADeleverage{dummy_field: false}
    }

    public(friend) fun a_rebalance() : ARebalance {
        ARebalance{dummy_field: false}
    }

    public(friend) fun add_amount_to_map<T0>(arg0: &mut 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>, arg1: u64) {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(arg0, &v0)) {
            let v1 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, u64>(arg0, &v0);
            *v1 = *v1 + arg1;
        } else {
            0x2::vec_map::insert<0x1::type_name::TypeName, u64>(arg0, v0, arg1);
        };
    }

    public fun add_collateral_x<T0, T1, T2: store>(arg0: &mut Position<T0, T1, T2>, arg1: &PositionCap, arg2: 0x2::balance::Balance<T0>) {
        check_position_version<T0, T1, T2>(arg0);
        assert!(arg1.position_id == 0x2::object::id<Position<T0, T1, T2>>(arg0), 7);
        0x2::balance::join<T0>(&mut arg0.col_x, arg2);
        let v0 = AddCollateralInfo{
            position_id  : 0x2::object::id<Position<T0, T1, T2>>(arg0),
            amount_x     : 0x2::balance::value<T0>(&arg2),
            amount_y     : 0,
            is_rebalance : false,
        };
        0x2::event::emit<AddCollateralInfo>(v0);
    }

    public fun add_collateral_y<T0, T1, T2: store>(arg0: &mut Position<T0, T1, T2>, arg1: &PositionCap, arg2: 0x2::balance::Balance<T1>) {
        check_position_version<T0, T1, T2>(arg0);
        assert!(arg1.position_id == 0x2::object::id<Position<T0, T1, T2>>(arg0), 7);
        0x2::balance::join<T1>(&mut arg0.col_y, arg2);
        let v0 = AddCollateralInfo{
            position_id  : 0x2::object::id<Position<T0, T1, T2>>(arg0),
            amount_x     : 0,
            amount_y     : 0x2::balance::value<T1>(&arg2),
            is_rebalance : false,
        };
        0x2::event::emit<AddCollateralInfo>(v0);
    }

    public(friend) fun add_liquidity_info_constructor(arg0: 0x2::object::ID, arg1: u128, arg2: u128, arg3: u64, arg4: u64) : AddLiquidityInfo {
        AddLiquidityInfo{
            position_id         : arg0,
            sqrt_pool_price_x64 : arg1,
            delta_l             : arg2,
            delta_x             : arg3,
            delta_y             : arg4,
        }
    }

    public(friend) fun ali_delta_l(arg0: &AddLiquidityInfo) : u128 {
        arg0.delta_l
    }

    public(friend) fun ali_delta_x(arg0: &AddLiquidityInfo) : u64 {
        arg0.delta_x
    }

    public(friend) fun ali_delta_y(arg0: &AddLiquidityInfo) : u64 {
        arg0.delta_y
    }

    public(friend) fun ali_emit(arg0: AddLiquidityInfo) {
        0x2::event::emit<AddLiquidityInfo>(arg0);
    }

    public fun allow_new_positions(arg0: &PositionConfig) : bool {
        arg0.allow_new_positions
    }

    public fun allowed_oracles(arg0: &PositionConfig) : &0x2::bag::Bag {
        &arg0.allowed_oracles
    }

    public fun base_deleverage_factor_bps(arg0: &PositionConfig) : u16 {
        arg0.base_deleverage_factor_bps
    }

    public fun base_liq_factor_bps(arg0: &PositionConfig) : u16 {
        arg0.base_liq_factor_bps
    }

    public(friend) fun borrowed_x<T0, T1, T2>(arg0: &CreatePositionTicket<T0, T1, T2>) : &0x2::balance::Balance<T0> {
        &arg0.borrowed_x
    }

    public(friend) fun borrowed_x_mut<T0, T1, T2>(arg0: &mut CreatePositionTicket<T0, T1, T2>) : &mut 0x2::balance::Balance<T0> {
        &mut arg0.borrowed_x
    }

    public(friend) fun borrowed_y<T0, T1, T2>(arg0: &CreatePositionTicket<T0, T1, T2>) : &0x2::balance::Balance<T1> {
        &arg0.borrowed_y
    }

    public(friend) fun borrowed_y_mut<T0, T1, T2>(arg0: &mut CreatePositionTicket<T0, T1, T2>) : &mut 0x2::balance::Balance<T1> {
        &mut arg0.borrowed_y
    }

    public(friend) fun calc_borrow_amt(arg0: u64, arg1: u64) : (u64, u64) {
        if (arg0 > arg1) {
            (0, arg0 - arg1)
        } else {
            (arg1 - arg0, 0)
        }
    }

    public(friend) fun calc_liq_fee_from_reward(arg0: &PositionConfig, arg1: u64) : u64 {
        0xb4fae2fd636b996f92234b4d373cc92ce4486e67885d3c314610dd5426504b9::util::muldiv(arg1, (arg0.liq_bonus_bps as u64) * (arg0.liq_fee_bps as u64), (10000 + (arg0.liq_bonus_bps as u64)) * 10000)
    }

    public(friend) fun check_config_version(arg0: &PositionConfig) {
        assert!(arg0.version == 1, 16);
    }

    public(friend) fun check_position_version<T0, T1, T2>(arg0: &Position<T0, T1, T2>) {
        assert!(arg0.version == 1, 17);
    }

    public(friend) fun check_versions<T0, T1, T2>(arg0: &Position<T0, T1, T2>, arg1: &PositionConfig) {
        check_config_version(arg1);
        check_position_version<T0, T1, T2>(arg0);
    }

    public fun col_x<T0, T1, T2>(arg0: &Position<T0, T1, T2>) : &0x2::balance::Balance<T0> {
        &arg0.col_x
    }

    public(friend) fun col_x_mut<T0, T1, T2>(arg0: &mut Position<T0, T1, T2>) : &mut 0x2::balance::Balance<T0> {
        &mut arg0.col_x
    }

    public fun col_y<T0, T1, T2>(arg0: &Position<T0, T1, T2>) : &0x2::balance::Balance<T1> {
        &arg0.col_y
    }

    public(friend) fun col_y_mut<T0, T1, T2>(arg0: &mut Position<T0, T1, T2>) : &mut 0x2::balance::Balance<T1> {
        &mut arg0.col_y
    }

    public(friend) fun collected_amm_rewards_mut(arg0: &mut RebalanceReceipt) : &mut 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64> {
        &mut arg0.collected_amm_rewards
    }

    public(friend) fun collected_fees_mut<T0, T1, T2>(arg0: &mut Position<T0, T1, T2>) : &mut 0xb4fae2fd636b996f92234b4d373cc92ce4486e67885d3c314610dd5426504b9::balance_bag::BalanceBag {
        &mut arg0.collected_fees
    }

    public fun config_add_empty_pyth_config(arg0: &mut PositionConfig, arg1: &mut 0x2::tx_context::TxContext) : 0xa0501135cff2a49568b1fd32407372300f57ebc5949aaabbcc33d16028c58222::access::ActionRequest {
        let v0 = PythConfig{
            max_age_secs  : 0,
            pio_allowlist : 0x2::vec_map::empty<0x1::type_name::TypeName, 0x2::object::ID>(),
        };
        0x2::bag::add<0x1::type_name::TypeName, PythConfig>(&mut arg0.allowed_oracles, 0x1::type_name::get<PythConfig>(), v0);
        let v1 = AModifyConfig{dummy_field: false};
        0xa0501135cff2a49568b1fd32407372300f57ebc5949aaabbcc33d16028c58222::access::new_request<AModifyConfig>(v1, arg1)
    }

    public fun consume_rebalance_receipt<T0, T1, T2: store>(arg0: &mut Position<T0, T1, T2>, arg1: RebalanceReceipt) {
        assert!(arg1.position_id == 0x2::object::id<Position<T0, T1, T2>>(arg0), 9);
        arg0.ticket_active = false;
        let RebalanceReceipt {
            id                    : v0,
            position_id           : v1,
            collected_amm_fee_x   : v2,
            collected_amm_fee_y   : v3,
            collected_amm_rewards : v4,
            fees_taken            : v5,
            delta_l               : v6,
            delta_x               : v7,
            delta_y               : v8,
            x_repaid              : v9,
            y_repaid              : v10,
        } = arg1;
        let v11 = RebalanceInfo{
            id                    : v0,
            position_id           : v1,
            collected_amm_fee_x   : v2,
            collected_amm_fee_y   : v3,
            collected_amm_rewards : v4,
            fees_taken            : v5,
            delta_l               : v6,
            delta_x               : v7,
            delta_y               : v8,
            x_repaid              : v9,
            y_repaid              : v10,
        };
        0x2::event::emit<RebalanceInfo>(v11);
    }

    public(friend) fun cpt_config_id<T0, T1, T2>(arg0: &CreatePositionTicket<T0, T1, T2>) : 0x2::object::ID {
        arg0.config_id
    }

    public(friend) fun cpt_debt_bag<T0, T1, T2>(arg0: &CreatePositionTicket<T0, T1, T2>) : &0xb4fae2fd636b996f92234b4d373cc92ce4486e67885d3c314610dd5426504b9::supply_pool::FacilDebtBag {
        &arg0.debt_bag
    }

    public(friend) fun cpt_debt_bag_mut<T0, T1, T2>(arg0: &mut CreatePositionTicket<T0, T1, T2>) : &mut 0xb4fae2fd636b996f92234b4d373cc92ce4486e67885d3c314610dd5426504b9::supply_pool::FacilDebtBag {
        &mut arg0.debt_bag
    }

    public fun create_empty_config(arg0: 0x2::object::ID, arg1: &mut 0x2::tx_context::TxContext) : (0x2::object::ID, 0xa0501135cff2a49568b1fd32407372300f57ebc5949aaabbcc33d16028c58222::access::ActionRequest) {
        let v0 = 0xb4fae2fd636b996f92234b4d373cc92ce4486e67885d3c314610dd5426504b9::supply_pool::create_lend_facil_cap(arg1);
        let v1 = PositionConfig{
            id                            : 0x2::object::new(arg1),
            pool_object_id                : arg0,
            allow_new_positions           : false,
            lend_facil_cap                : v0,
            min_liq_start_price_delta_bps : 0,
            min_init_margin_bps           : 0,
            allowed_oracles               : 0x2::bag::new(arg1),
            deleverage_margin_bps         : 0,
            base_deleverage_factor_bps    : 0,
            liq_margin_bps                : 0,
            base_liq_factor_bps           : 0,
            liq_bonus_bps                 : 0,
            max_position_l                : 0,
            max_global_l                  : 0,
            current_global_l              : 0,
            rebalance_fee_bps             : 0,
            liq_fee_bps                   : 0,
            position_creation_fee_sui     : 0,
            version                       : 1,
        };
        0x2::transfer::share_object<PositionConfig>(v1);
        let v2 = ACreateConfig{dummy_field: false};
        (0x2::object::id<0xb4fae2fd636b996f92234b4d373cc92ce4486e67885d3c314610dd5426504b9::supply_pool::LendFacilCap>(&v0), 0xa0501135cff2a49568b1fd32407372300f57ebc5949aaabbcc33d16028c58222::access::new_request<ACreateConfig>(v2, arg1))
    }

    public fun create_rebalance_receipt<T0, T1, T2: store>(arg0: &mut Position<T0, T1, T2>, arg1: &PositionConfig, arg2: &mut 0x2::tx_context::TxContext) : (RebalanceReceipt, 0xa0501135cff2a49568b1fd32407372300f57ebc5949aaabbcc33d16028c58222::access::ActionRequest) {
        check_versions<T0, T1, T2>(arg0, arg1);
        assert!(arg0.config_id == 0x2::object::uid_to_inner(&arg1.id), 4);
        assert!(arg0.ticket_active == false, 8);
        arg0.ticket_active = true;
        let v0 = RebalanceReceipt{
            id                    : 0x2::object::id_from_address(0x2::tx_context::fresh_object_address(arg2)),
            position_id           : 0x2::object::id<Position<T0, T1, T2>>(arg0),
            collected_amm_fee_x   : 0,
            collected_amm_fee_y   : 0,
            collected_amm_rewards : 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(),
            fees_taken            : 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(),
            delta_l               : 0,
            delta_x               : 0,
            delta_y               : 0,
            x_repaid              : 0,
            y_repaid              : 0,
        };
        let v1 = ARebalance{dummy_field: false};
        (v0, 0xa0501135cff2a49568b1fd32407372300f57ebc5949aaabbcc33d16028c58222::access::new_request<ARebalance>(v1, arg2))
    }

    public fun current_global_l(arg0: &PositionConfig) : u128 {
        arg0.current_global_l
    }

    public(friend) fun decrease_current_global_l(arg0: &mut PositionConfig, arg1: u128) {
        arg0.current_global_l = arg0.current_global_l - arg1;
    }

    public(friend) fun deleverage_info_constructor(arg0: 0x2::object::ID, arg1: 0xb4fae2fd636b996f92234b4d373cc92ce4486e67885d3c314610dd5426504b9::position_model_clmm::PositionModel, arg2: u256, arg3: u128, arg4: u128, arg5: u64, arg6: u64, arg7: u64, arg8: u64) : DeleverageInfo {
        DeleverageInfo{
            position_id         : arg0,
            model               : arg1,
            oracle_price_x128   : arg2,
            sqrt_pool_price_x64 : arg3,
            delta_l             : arg4,
            delta_x             : arg5,
            delta_y             : arg6,
            x_repaid            : arg7,
            y_repaid            : arg8,
        }
    }

    public fun deleverage_margin_bps(arg0: &PositionConfig) : u16 {
        arg0.deleverage_margin_bps
    }

    public(friend) fun deleverage_ticket_constructor(arg0: 0x2::object::ID, arg1: bool, arg2: bool, arg3: DeleverageInfo) : DeleverageTicket {
        DeleverageTicket{
            position_id : arg0,
            can_repay_x : arg1,
            can_repay_y : arg2,
            info        : arg3,
        }
    }

    public fun deleverage_ticket_repay_x<T0, T1, T2, T3: store>(arg0: &mut Position<T0, T1, T3>, arg1: &PositionConfig, arg2: &mut DeleverageTicket, arg3: &mut 0xb4fae2fd636b996f92234b4d373cc92ce4486e67885d3c314610dd5426504b9::supply_pool::Pool<T0, T2>, arg4: &0x2::clock::Clock) {
        assert!(arg2.position_id == 0x2::object::id<Position<T0, T1, T3>>(arg0), 9);
        assert!(arg0.config_id == 0x2::object::uid_to_inner(&arg1.id), 4);
        if (!arg2.can_repay_x) {
            return
        };
        let v0 = 0xb4fae2fd636b996f92234b4d373cc92ce4486e67885d3c314610dd5426504b9::supply_pool::fdb_take_all<T2>(&mut arg0.debt_bag);
        let (_, v2) = 0xb4fae2fd636b996f92234b4d373cc92ce4486e67885d3c314610dd5426504b9::supply_pool::repay_max_possible<T0, T2>(arg3, &mut v0, &mut arg0.col_x, arg4);
        0xb4fae2fd636b996f92234b4d373cc92ce4486e67885d3c314610dd5426504b9::supply_pool::fdb_add<T0, T2>(&mut arg0.debt_bag, v0);
        arg2.can_repay_x = false;
        arg2.info.x_repaid = v2;
    }

    public fun deleverage_ticket_repay_y<T0, T1, T2, T3: store>(arg0: &mut Position<T0, T1, T3>, arg1: &PositionConfig, arg2: &mut DeleverageTicket, arg3: &mut 0xb4fae2fd636b996f92234b4d373cc92ce4486e67885d3c314610dd5426504b9::supply_pool::Pool<T1, T2>, arg4: &0x2::clock::Clock) {
        assert!(arg2.position_id == 0x2::object::id<Position<T0, T1, T3>>(arg0), 9);
        assert!(arg0.config_id == 0x2::object::uid_to_inner(&arg1.id), 4);
        if (!arg2.can_repay_y) {
            return
        };
        let v0 = 0xb4fae2fd636b996f92234b4d373cc92ce4486e67885d3c314610dd5426504b9::supply_pool::fdb_take_all<T2>(&mut arg0.debt_bag);
        let (_, v2) = 0xb4fae2fd636b996f92234b4d373cc92ce4486e67885d3c314610dd5426504b9::supply_pool::repay_max_possible<T1, T2>(arg3, &mut v0, &mut arg0.col_y, arg4);
        arg2.info.y_repaid = v2;
        0xb4fae2fd636b996f92234b4d373cc92ce4486e67885d3c314610dd5426504b9::supply_pool::fdb_add<T1, T2>(&mut arg0.debt_bag, v0);
        arg2.can_repay_y = false;
    }

    public(friend) fun delta_l<T0, T1, T2>(arg0: &CreatePositionTicket<T0, T1, T2>) : u128 {
        arg0.delta_l
    }

    public(friend) fun destroy_create_position_ticket<T0, T1, T2>(arg0: CreatePositionTicket<T0, T1, T2>) : (0x2::object::ID, T2, T2, u64, u64, u128, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, 0xb4fae2fd636b996f92234b4d373cc92ce4486e67885d3c314610dd5426504b9::supply_pool::FacilDebtBag) {
        let CreatePositionTicket {
            config_id   : v0,
            tick_a      : v1,
            tick_b      : v2,
            dx          : v3,
            dy          : v4,
            delta_l     : v5,
            principal_x : v6,
            principal_y : v7,
            borrowed_x  : v8,
            borrowed_y  : v9,
            debt_bag    : v10,
        } = arg0;
        (v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10)
    }

    public fun destroy_deleverage_ticket<T0, T1, T2: store>(arg0: &mut Position<T0, T1, T2>, arg1: DeleverageTicket) {
        assert!(arg1.position_id == 0x2::object::id<Position<T0, T1, T2>>(arg0), 9);
        assert!(arg1.can_repay_x == false, 10);
        assert!(arg1.can_repay_y == false, 10);
        let DeleverageTicket {
            position_id : _,
            can_repay_x : _,
            can_repay_y : _,
            info        : v3,
        } = arg1;
        0x2::event::emit<DeleverageInfo>(v3);
        arg0.ticket_active = false;
    }

    public fun destroy_reduction_ticket<T0, T1>(arg0: ReductionRepaymentTicket<T0, T1>) {
        assert!(0xb4fae2fd636b996f92234b4d373cc92ce4486e67885d3c314610dd5426504b9::supply_pool::fds_value_x64<T0>(&arg0.sx) == 0, 10);
        assert!(0xb4fae2fd636b996f92234b4d373cc92ce4486e67885d3c314610dd5426504b9::supply_pool::fds_value_x64<T1>(&arg0.sy) == 0, 10);
        let ReductionRepaymentTicket {
            sx   : v0,
            sy   : v1,
            info : v2,
        } = arg0;
        0xb4fae2fd636b996f92234b4d373cc92ce4486e67885d3c314610dd5426504b9::supply_pool::fds_destroy_zero<T0>(v0);
        0xb4fae2fd636b996f92234b4d373cc92ce4486e67885d3c314610dd5426504b9::supply_pool::fds_destroy_zero<T1>(v1);
        0x2::event::emit<ReductionInfo>(v2);
    }

    public(friend) fun dx<T0, T1, T2>(arg0: &CreatePositionTicket<T0, T1, T2>) : u64 {
        arg0.dx
    }

    public(friend) fun dy<T0, T1, T2>(arg0: &CreatePositionTicket<T0, T1, T2>) : u64 {
        arg0.dy
    }

    public(friend) fun emit_liquidation_info(arg0: 0x2::object::ID, arg1: 0xb4fae2fd636b996f92234b4d373cc92ce4486e67885d3c314610dd5426504b9::position_model_clmm::PositionModel, arg2: u256, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64) {
        let v0 = LiquidationInfo{
            position_id         : arg0,
            model               : arg1,
            oracle_price_x128   : arg2,
            x_repaid            : arg3,
            y_repaid            : arg4,
            liquidator_reward_x : arg5,
            liquidator_reward_y : arg6,
            liquidation_fee_x   : arg7,
            liquidation_fee_y   : arg8,
        };
        0x2::event::emit<LiquidationInfo>(v0);
    }

    public(friend) fun emit_position_creation_info(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u128, arg3: u128, arg4: u128, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64) {
        let v0 = PositionCreationInfo{
            position_id          : arg0,
            config_id            : arg1,
            sqrt_pa_x64          : arg2,
            sqrt_pb_x64          : arg3,
            l                    : arg4,
            x0                   : arg5,
            y0                   : arg6,
            cx                   : arg7,
            cy                   : arg8,
            dx                   : arg9,
            dy                   : arg10,
            creation_fee_amt_sui : arg11,
        };
        0x2::event::emit<PositionCreationInfo>(v0);
    }

    public(friend) fun increase_collected_amm_fee_x(arg0: &mut RebalanceReceipt, arg1: u64) {
        arg0.collected_amm_fee_x = arg0.collected_amm_fee_x + arg1;
    }

    public(friend) fun increase_collected_amm_fee_y(arg0: &mut RebalanceReceipt, arg1: u64) {
        arg0.collected_amm_fee_y = arg0.collected_amm_fee_y + arg1;
    }

    public(friend) fun increase_current_global_l(arg0: &mut PositionConfig, arg1: u128) {
        arg0.current_global_l = arg0.current_global_l + arg1;
    }

    public(friend) fun increase_delta_l(arg0: &mut RebalanceReceipt, arg1: u128) {
        arg0.delta_l = arg0.delta_l + arg1;
    }

    public(friend) fun increase_delta_x(arg0: &mut RebalanceReceipt, arg1: u64) {
        arg0.delta_x = arg0.delta_x + arg1;
    }

    public(friend) fun increase_delta_y(arg0: &mut RebalanceReceipt, arg1: u64) {
        arg0.delta_y = arg0.delta_y + arg1;
    }

    public(friend) fun init_margin_is_valid(arg0: &PositionConfig, arg1: &0xb4fae2fd636b996f92234b4d373cc92ce4486e67885d3c314610dd5426504b9::position_model_clmm::PositionModel, arg2: u256, arg3: u256) : bool {
        let v0 = ((arg0.min_init_margin_bps as u128) << 64) / 10000;
        if (0xb4fae2fd636b996f92234b4d373cc92ce4486e67885d3c314610dd5426504b9::position_model_clmm::margin_x64(arg1, arg2) < v0) {
            return false
        };
        if (0xb4fae2fd636b996f92234b4d373cc92ce4486e67885d3c314610dd5426504b9::position_model_clmm::margin_x64(arg1, arg3) < v0) {
            return false
        };
        true
    }

    public(friend) fun lend_facil_cap(arg0: &PositionConfig) : &0xb4fae2fd636b996f92234b4d373cc92ce4486e67885d3c314610dd5426504b9::supply_pool::LendFacilCap {
        &arg0.lend_facil_cap
    }

    public fun liq_bonus_bps(arg0: &PositionConfig) : u16 {
        arg0.liq_bonus_bps
    }

    public fun liq_fee_bps(arg0: &PositionConfig) : u16 {
        arg0.liq_fee_bps
    }

    public fun liq_margin_bps(arg0: &PositionConfig) : u16 {
        arg0.liq_margin_bps
    }

    public(friend) fun liq_margin_is_valid(arg0: &PositionConfig, arg1: &0xb4fae2fd636b996f92234b4d373cc92ce4486e67885d3c314610dd5426504b9::position_model_clmm::PositionModel, arg2: u256, arg3: u256) : bool {
        let v0 = (arg0.min_liq_start_price_delta_bps as u256);
        let v1 = ((arg0.liq_margin_bps as u128) << 64) / 10000;
        if (0xb4fae2fd636b996f92234b4d373cc92ce4486e67885d3c314610dd5426504b9::position_model_clmm::margin_x64(arg1, arg2 - arg2 * v0 / 10000) < v1) {
            return false
        };
        if (0xb4fae2fd636b996f92234b4d373cc92ce4486e67885d3c314610dd5426504b9::position_model_clmm::margin_x64(arg1, arg3 + arg3 * v0 / 10000) < v1) {
            return false
        };
        true
    }

    public fun lp_position<T0, T1, T2>(arg0: &Position<T0, T1, T2>) : &T2 {
        &arg0.lp_position
    }

    public(friend) fun lp_position_mut<T0, T1, T2>(arg0: &mut Position<T0, T1, T2>) : &mut T2 {
        &mut arg0.lp_position
    }

    public fun max_global_l(arg0: &PositionConfig) : u128 {
        arg0.max_global_l
    }

    public fun max_position_l(arg0: &PositionConfig) : u128 {
        arg0.max_position_l
    }

    public fun migrate_config(arg0: &mut PositionConfig, arg1: &mut 0x2::tx_context::TxContext) : 0xa0501135cff2a49568b1fd32407372300f57ebc5949aaabbcc33d16028c58222::access::ActionRequest {
        assert!(arg0.version < 1, 18);
        arg0.version = 1;
        let v0 = AMigrate{dummy_field: false};
        0xa0501135cff2a49568b1fd32407372300f57ebc5949aaabbcc33d16028c58222::access::new_request<AMigrate>(v0, arg1)
    }

    public fun migrate_position<T0, T1, T2>(arg0: &mut Position<T0, T1, T2>, arg1: &mut 0x2::tx_context::TxContext) : 0xa0501135cff2a49568b1fd32407372300f57ebc5949aaabbcc33d16028c58222::access::ActionRequest {
        assert!(arg0.version < 1, 18);
        arg0.version = 1;
        let v0 = AMigrate{dummy_field: false};
        0xa0501135cff2a49568b1fd32407372300f57ebc5949aaabbcc33d16028c58222::access::new_request<AMigrate>(v0, arg1)
    }

    public fun min_init_margin_bps(arg0: &PositionConfig) : u16 {
        arg0.min_init_margin_bps
    }

    public fun min_liq_start_price_delta_bps(arg0: &PositionConfig) : u16 {
        arg0.min_liq_start_price_delta_bps
    }

    public(friend) fun new_create_position_ticket<T0, T1, T2>(arg0: 0x2::object::ID, arg1: T2, arg2: T2, arg3: u64, arg4: u64, arg5: u128, arg6: 0x2::balance::Balance<T0>, arg7: 0x2::balance::Balance<T1>, arg8: 0x2::balance::Balance<T0>, arg9: 0x2::balance::Balance<T1>, arg10: 0xb4fae2fd636b996f92234b4d373cc92ce4486e67885d3c314610dd5426504b9::supply_pool::FacilDebtBag) : CreatePositionTicket<T0, T1, T2> {
        CreatePositionTicket<T0, T1, T2>{
            config_id   : arg0,
            tick_a      : arg1,
            tick_b      : arg2,
            dx          : arg3,
            dy          : arg4,
            delta_l     : arg5,
            principal_x : arg6,
            principal_y : arg7,
            borrowed_x  : arg8,
            borrowed_y  : arg9,
            debt_bag    : arg10,
        }
    }

    public fun pc_position_id(arg0: &PositionCap) : 0x2::object::ID {
        arg0.position_id
    }

    public fun pool_object_id(arg0: &PositionConfig) : 0x2::object::ID {
        arg0.pool_object_id
    }

    public(friend) fun position_cap_constructor(arg0: 0x2::object::ID, arg1: &mut 0x2::tx_context::TxContext) : PositionCap {
        PositionCap{
            id          : 0x2::object::new(arg1),
            position_id : arg0,
        }
    }

    public fun position_config_id<T0, T1, T2>(arg0: &Position<T0, T1, T2>) : 0x2::object::ID {
        arg0.config_id
    }

    public(friend) fun position_constructor<T0, T1, T2>(arg0: 0x2::object::ID, arg1: T2, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<T1>, arg4: 0xb4fae2fd636b996f92234b4d373cc92ce4486e67885d3c314610dd5426504b9::supply_pool::FacilDebtBag, arg5: 0xb4fae2fd636b996f92234b4d373cc92ce4486e67885d3c314610dd5426504b9::balance_bag::BalanceBag, arg6: &mut 0x2::tx_context::TxContext) : Position<T0, T1, T2> {
        Position<T0, T1, T2>{
            id             : 0x2::object::new(arg6),
            config_id      : arg0,
            lp_position    : arg1,
            col_x          : arg2,
            col_y          : arg3,
            debt_bag       : arg4,
            collected_fees : arg5,
            ticket_active  : false,
            version        : 1,
        }
    }

    public fun position_creation_fee_sui(arg0: &PositionConfig) : u64 {
        arg0.position_creation_fee_sui
    }

    public fun position_debt_bag<T0, T1, T2>(arg0: &Position<T0, T1, T2>) : &0xb4fae2fd636b996f92234b4d373cc92ce4486e67885d3c314610dd5426504b9::supply_pool::FacilDebtBag {
        &arg0.debt_bag
    }

    public(friend) fun position_debt_bag_mut<T0, T1, T2>(arg0: &mut Position<T0, T1, T2>) : &mut 0xb4fae2fd636b996f92234b4d373cc92ce4486e67885d3c314610dd5426504b9::supply_pool::FacilDebtBag {
        &mut arg0.debt_bag
    }

    public(friend) fun position_share_object<T0, T1, T2: store>(arg0: Position<T0, T1, T2>) {
        0x2::transfer::share_object<Position<T0, T1, T2>>(arg0);
    }

    public(friend) fun principal_x<T0, T1, T2>(arg0: &CreatePositionTicket<T0, T1, T2>) : &0x2::balance::Balance<T0> {
        &arg0.principal_x
    }

    public(friend) fun principal_y<T0, T1, T2>(arg0: &CreatePositionTicket<T0, T1, T2>) : &0x2::balance::Balance<T1> {
        &arg0.principal_y
    }

    public fun pyth_config_allow_pio(arg0: &mut PositionConfig, arg1: 0x1::type_name::TypeName, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) : 0xa0501135cff2a49568b1fd32407372300f57ebc5949aaabbcc33d16028c58222::access::ActionRequest {
        0x2::vec_map::insert<0x1::type_name::TypeName, 0x2::object::ID>(&mut 0x2::bag::borrow_mut<0x1::type_name::TypeName, PythConfig>(&mut arg0.allowed_oracles, 0x1::type_name::get<PythConfig>()).pio_allowlist, arg1, arg2);
        let v0 = AModifyConfig{dummy_field: false};
        0xa0501135cff2a49568b1fd32407372300f57ebc5949aaabbcc33d16028c58222::access::new_request<AModifyConfig>(v0, arg3)
    }

    public fun pyth_config_disallow_pio(arg0: &mut PositionConfig, arg1: 0x1::type_name::TypeName, arg2: &mut 0x2::tx_context::TxContext) : 0xa0501135cff2a49568b1fd32407372300f57ebc5949aaabbcc33d16028c58222::access::ActionRequest {
        let (_, _) = 0x2::vec_map::remove<0x1::type_name::TypeName, 0x2::object::ID>(&mut 0x2::bag::borrow_mut<0x1::type_name::TypeName, PythConfig>(&mut arg0.allowed_oracles, 0x1::type_name::get<PythConfig>()).pio_allowlist, &arg1);
        let v2 = AModifyConfig{dummy_field: false};
        0xa0501135cff2a49568b1fd32407372300f57ebc5949aaabbcc33d16028c58222::access::new_request<AModifyConfig>(v2, arg2)
    }

    public fun rebalance_fee_bps(arg0: &PositionConfig) : u16 {
        arg0.rebalance_fee_bps
    }

    public fun rebalance_repay_debt_x<T0, T1, T2, T3: store>(arg0: &mut Position<T0, T1, T3>, arg1: &mut 0x2::balance::Balance<T0>, arg2: &mut RebalanceReceipt, arg3: &mut 0xb4fae2fd636b996f92234b4d373cc92ce4486e67885d3c314610dd5426504b9::supply_pool::Pool<T0, T2>, arg4: &0x2::clock::Clock) {
        assert!(arg2.position_id == 0x2::object::id<Position<T0, T1, T3>>(arg0), 9);
        let v0 = 0xb4fae2fd636b996f92234b4d373cc92ce4486e67885d3c314610dd5426504b9::supply_pool::fdb_take_all<T2>(&mut arg0.debt_bag);
        let (_, v2) = 0xb4fae2fd636b996f92234b4d373cc92ce4486e67885d3c314610dd5426504b9::supply_pool::repay_max_possible<T0, T2>(arg3, &mut v0, arg1, arg4);
        0xb4fae2fd636b996f92234b4d373cc92ce4486e67885d3c314610dd5426504b9::supply_pool::fdb_add<T0, T2>(&mut arg0.debt_bag, v0);
        arg2.x_repaid = arg2.x_repaid + v2;
    }

    public fun rebalance_repay_debt_y<T0, T1, T2, T3: store>(arg0: &mut Position<T0, T1, T3>, arg1: &mut 0x2::balance::Balance<T1>, arg2: &mut RebalanceReceipt, arg3: &mut 0xb4fae2fd636b996f92234b4d373cc92ce4486e67885d3c314610dd5426504b9::supply_pool::Pool<T1, T2>, arg4: &0x2::clock::Clock) {
        assert!(arg2.position_id == 0x2::object::id<Position<T0, T1, T3>>(arg0), 9);
        let v0 = 0xb4fae2fd636b996f92234b4d373cc92ce4486e67885d3c314610dd5426504b9::supply_pool::fdb_take_all<T2>(&mut arg0.debt_bag);
        let (_, v2) = 0xb4fae2fd636b996f92234b4d373cc92ce4486e67885d3c314610dd5426504b9::supply_pool::repay_max_possible<T1, T2>(arg3, &mut v0, arg1, arg4);
        0xb4fae2fd636b996f92234b4d373cc92ce4486e67885d3c314610dd5426504b9::supply_pool::fdb_add<T1, T2>(&mut arg0.debt_bag, v0);
        arg2.y_repaid = arg2.y_repaid + v2;
    }

    public(friend) fun reduction_info_constructor(arg0: 0x2::object::ID, arg1: 0xb4fae2fd636b996f92234b4d373cc92ce4486e67885d3c314610dd5426504b9::position_model_clmm::PositionModel, arg2: u256, arg3: u128, arg4: u128, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64) : ReductionInfo {
        ReductionInfo{
            position_id         : arg0,
            model               : arg1,
            oracle_price_x128   : arg2,
            sqrt_pool_price_x64 : arg3,
            delta_l             : arg4,
            delta_x             : arg5,
            delta_y             : arg6,
            withdrawn_x         : arg7,
            withdrawn_y         : arg8,
            x_repaid            : arg9,
            y_repaid            : arg10,
        }
    }

    public(friend) fun reduction_repayment_ticket_constructor<T0, T1>(arg0: 0xb4fae2fd636b996f92234b4d373cc92ce4486e67885d3c314610dd5426504b9::supply_pool::FacilDebtShare<T0>, arg1: 0xb4fae2fd636b996f92234b4d373cc92ce4486e67885d3c314610dd5426504b9::supply_pool::FacilDebtShare<T1>, arg2: ReductionInfo) : ReductionRepaymentTicket<T0, T1> {
        ReductionRepaymentTicket<T0, T1>{
            sx   : arg0,
            sy   : arg1,
            info : arg2,
        }
    }

    public fun reduction_ticket_calc_repay_amt_x<T0, T1, T2>(arg0: &ReductionRepaymentTicket<T1, T2>, arg1: &mut 0xb4fae2fd636b996f92234b4d373cc92ce4486e67885d3c314610dd5426504b9::supply_pool::Pool<T0, T1>, arg2: &0x2::clock::Clock) : u64 {
        0xb4fae2fd636b996f92234b4d373cc92ce4486e67885d3c314610dd5426504b9::supply_pool::calc_repay_by_shares<T0, T1>(arg1, 0xb4fae2fd636b996f92234b4d373cc92ce4486e67885d3c314610dd5426504b9::supply_pool::fds_facil_id<T1>(&arg0.sx), 0xb4fae2fd636b996f92234b4d373cc92ce4486e67885d3c314610dd5426504b9::supply_pool::fds_value_x64<T1>(&arg0.sx), arg2)
    }

    public fun reduction_ticket_calc_repay_amt_y<T0, T1, T2>(arg0: &ReductionRepaymentTicket<T1, T2>, arg1: &mut 0xb4fae2fd636b996f92234b4d373cc92ce4486e67885d3c314610dd5426504b9::supply_pool::Pool<T0, T2>, arg2: &0x2::clock::Clock) : u64 {
        0xb4fae2fd636b996f92234b4d373cc92ce4486e67885d3c314610dd5426504b9::supply_pool::calc_repay_by_shares<T0, T2>(arg1, 0xb4fae2fd636b996f92234b4d373cc92ce4486e67885d3c314610dd5426504b9::supply_pool::fds_facil_id<T2>(&arg0.sy), 0xb4fae2fd636b996f92234b4d373cc92ce4486e67885d3c314610dd5426504b9::supply_pool::fds_value_x64<T2>(&arg0.sy), arg2)
    }

    public fun reduction_ticket_repay_x<T0, T1, T2>(arg0: &mut ReductionRepaymentTicket<T1, T2>, arg1: &mut 0xb4fae2fd636b996f92234b4d373cc92ce4486e67885d3c314610dd5426504b9::supply_pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: &0x2::clock::Clock) {
        arg0.info.x_repaid = 0x2::balance::value<T0>(&arg2);
        0xb4fae2fd636b996f92234b4d373cc92ce4486e67885d3c314610dd5426504b9::supply_pool::repay<T0, T1>(arg1, 0xb4fae2fd636b996f92234b4d373cc92ce4486e67885d3c314610dd5426504b9::supply_pool::fds_withdraw_all<T1>(&mut arg0.sx), arg2, arg3);
    }

    public fun reduction_ticket_repay_y<T0, T1, T2>(arg0: &mut ReductionRepaymentTicket<T1, T2>, arg1: &mut 0xb4fae2fd636b996f92234b4d373cc92ce4486e67885d3c314610dd5426504b9::supply_pool::Pool<T0, T2>, arg2: 0x2::balance::Balance<T0>, arg3: &0x2::clock::Clock) {
        arg0.info.y_repaid = 0x2::balance::value<T0>(&arg2);
        0xb4fae2fd636b996f92234b4d373cc92ce4486e67885d3c314610dd5426504b9::supply_pool::repay<T0, T2>(arg1, 0xb4fae2fd636b996f92234b4d373cc92ce4486e67885d3c314610dd5426504b9::supply_pool::fds_withdraw_all<T2>(&mut arg0.sy), arg2, arg3);
    }

    public fun repay_debt_x<T0, T1, T2, T3: store>(arg0: &mut Position<T0, T1, T3>, arg1: &PositionCap, arg2: &mut 0x2::balance::Balance<T0>, arg3: &mut 0xb4fae2fd636b996f92234b4d373cc92ce4486e67885d3c314610dd5426504b9::supply_pool::Pool<T0, T2>, arg4: &0x2::clock::Clock) {
        check_position_version<T0, T1, T3>(arg0);
        assert!(arg1.position_id == 0x2::object::id<Position<T0, T1, T3>>(arg0), 7);
        let v0 = 0xb4fae2fd636b996f92234b4d373cc92ce4486e67885d3c314610dd5426504b9::supply_pool::fdb_take_all<T2>(&mut arg0.debt_bag);
        let (_, v2) = 0xb4fae2fd636b996f92234b4d373cc92ce4486e67885d3c314610dd5426504b9::supply_pool::repay_max_possible<T0, T2>(arg3, &mut v0, arg2, arg4);
        0xb4fae2fd636b996f92234b4d373cc92ce4486e67885d3c314610dd5426504b9::supply_pool::fdb_add<T0, T2>(&mut arg0.debt_bag, v0);
        let v3 = RepayDebtInfo{
            position_id : 0x2::object::id<Position<T0, T1, T3>>(arg0),
            x_repaid    : v2,
            y_repaid    : 0,
        };
        0x2::event::emit<RepayDebtInfo>(v3);
    }

    public fun repay_debt_y<T0, T1, T2, T3: store>(arg0: &mut Position<T0, T1, T3>, arg1: &PositionCap, arg2: &mut 0x2::balance::Balance<T1>, arg3: &mut 0xb4fae2fd636b996f92234b4d373cc92ce4486e67885d3c314610dd5426504b9::supply_pool::Pool<T1, T2>, arg4: &0x2::clock::Clock) {
        check_position_version<T0, T1, T3>(arg0);
        assert!(arg1.position_id == 0x2::object::id<Position<T0, T1, T3>>(arg0), 7);
        let v0 = 0xb4fae2fd636b996f92234b4d373cc92ce4486e67885d3c314610dd5426504b9::supply_pool::fdb_take_all<T2>(&mut arg0.debt_bag);
        let (_, v2) = 0xb4fae2fd636b996f92234b4d373cc92ce4486e67885d3c314610dd5426504b9::supply_pool::repay_max_possible<T1, T2>(arg3, &mut v0, arg2, arg4);
        0xb4fae2fd636b996f92234b4d373cc92ce4486e67885d3c314610dd5426504b9::supply_pool::fdb_add<T1, T2>(&mut arg0.debt_bag, v0);
        let v3 = RepayDebtInfo{
            position_id : 0x2::object::id<Position<T0, T1, T3>>(arg0),
            x_repaid    : 0,
            y_repaid    : v2,
        };
        0x2::event::emit<RepayDebtInfo>(v3);
    }

    public(friend) fun rr_position_id(arg0: &RebalanceReceipt) : 0x2::object::ID {
        arg0.position_id
    }

    public fun set_allow_new_positions(arg0: &mut PositionConfig, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) : 0xa0501135cff2a49568b1fd32407372300f57ebc5949aaabbcc33d16028c58222::access::ActionRequest {
        arg0.allow_new_positions = arg1;
        let v0 = AModifyConfig{dummy_field: false};
        0xa0501135cff2a49568b1fd32407372300f57ebc5949aaabbcc33d16028c58222::access::new_request<AModifyConfig>(v0, arg2)
    }

    public fun set_base_deleverage_factor_bps(arg0: &mut PositionConfig, arg1: u16, arg2: &mut 0x2::tx_context::TxContext) : 0xa0501135cff2a49568b1fd32407372300f57ebc5949aaabbcc33d16028c58222::access::ActionRequest {
        arg0.base_deleverage_factor_bps = arg1;
        let v0 = AModifyConfig{dummy_field: false};
        0xa0501135cff2a49568b1fd32407372300f57ebc5949aaabbcc33d16028c58222::access::new_request<AModifyConfig>(v0, arg2)
    }

    public fun set_base_liq_factor_bps(arg0: &mut PositionConfig, arg1: u16, arg2: &mut 0x2::tx_context::TxContext) : 0xa0501135cff2a49568b1fd32407372300f57ebc5949aaabbcc33d16028c58222::access::ActionRequest {
        arg0.base_liq_factor_bps = arg1;
        let v0 = AModifyConfig{dummy_field: false};
        0xa0501135cff2a49568b1fd32407372300f57ebc5949aaabbcc33d16028c58222::access::new_request<AModifyConfig>(v0, arg2)
    }

    public fun set_deleverage_margin_bps(arg0: &mut PositionConfig, arg1: u16, arg2: &mut 0x2::tx_context::TxContext) : 0xa0501135cff2a49568b1fd32407372300f57ebc5949aaabbcc33d16028c58222::access::ActionRequest {
        assert!(arg1 > arg0.liq_margin_bps, 19);
        arg0.deleverage_margin_bps = arg1;
        let v0 = AModifyConfig{dummy_field: false};
        0xa0501135cff2a49568b1fd32407372300f57ebc5949aaabbcc33d16028c58222::access::new_request<AModifyConfig>(v0, arg2)
    }

    public(friend) fun set_delta_l(arg0: &mut DeleverageInfo, arg1: u128) {
        arg0.delta_l = arg1;
    }

    public(friend) fun set_delta_x(arg0: &mut DeleverageInfo, arg1: u64) {
        arg0.delta_x = arg1;
    }

    public(friend) fun set_delta_y(arg0: &mut DeleverageInfo, arg1: u64) {
        arg0.delta_y = arg1;
    }

    public fun set_liq_bonus_bps(arg0: &mut PositionConfig, arg1: u16, arg2: &mut 0x2::tx_context::TxContext) : 0xa0501135cff2a49568b1fd32407372300f57ebc5949aaabbcc33d16028c58222::access::ActionRequest {
        arg0.liq_bonus_bps = arg1;
        let v0 = AModifyConfig{dummy_field: false};
        0xa0501135cff2a49568b1fd32407372300f57ebc5949aaabbcc33d16028c58222::access::new_request<AModifyConfig>(v0, arg2)
    }

    public fun set_liq_fee_bps(arg0: &mut PositionConfig, arg1: u16, arg2: &mut 0x2::tx_context::TxContext) : 0xa0501135cff2a49568b1fd32407372300f57ebc5949aaabbcc33d16028c58222::access::ActionRequest {
        arg0.liq_fee_bps = arg1;
        let v0 = AModifyConfig{dummy_field: false};
        0xa0501135cff2a49568b1fd32407372300f57ebc5949aaabbcc33d16028c58222::access::new_request<AModifyConfig>(v0, arg2)
    }

    public fun set_liq_margin_bps(arg0: &mut PositionConfig, arg1: u16, arg2: &mut 0x2::tx_context::TxContext) : 0xa0501135cff2a49568b1fd32407372300f57ebc5949aaabbcc33d16028c58222::access::ActionRequest {
        assert!(arg1 < arg0.deleverage_margin_bps, 19);
        arg0.liq_margin_bps = arg1;
        let v0 = AModifyConfig{dummy_field: false};
        0xa0501135cff2a49568b1fd32407372300f57ebc5949aaabbcc33d16028c58222::access::new_request<AModifyConfig>(v0, arg2)
    }

    public fun set_max_global_l(arg0: &mut PositionConfig, arg1: u128, arg2: &mut 0x2::tx_context::TxContext) : 0xa0501135cff2a49568b1fd32407372300f57ebc5949aaabbcc33d16028c58222::access::ActionRequest {
        arg0.max_global_l = arg1;
        let v0 = AModifyConfig{dummy_field: false};
        0xa0501135cff2a49568b1fd32407372300f57ebc5949aaabbcc33d16028c58222::access::new_request<AModifyConfig>(v0, arg2)
    }

    public fun set_max_position_l(arg0: &mut PositionConfig, arg1: u128, arg2: &mut 0x2::tx_context::TxContext) : 0xa0501135cff2a49568b1fd32407372300f57ebc5949aaabbcc33d16028c58222::access::ActionRequest {
        arg0.max_position_l = arg1;
        let v0 = AModifyConfig{dummy_field: false};
        0xa0501135cff2a49568b1fd32407372300f57ebc5949aaabbcc33d16028c58222::access::new_request<AModifyConfig>(v0, arg2)
    }

    public fun set_min_init_margin_bps(arg0: &mut PositionConfig, arg1: u16, arg2: &mut 0x2::tx_context::TxContext) : 0xa0501135cff2a49568b1fd32407372300f57ebc5949aaabbcc33d16028c58222::access::ActionRequest {
        arg0.min_init_margin_bps = arg1;
        let v0 = AModifyConfig{dummy_field: false};
        0xa0501135cff2a49568b1fd32407372300f57ebc5949aaabbcc33d16028c58222::access::new_request<AModifyConfig>(v0, arg2)
    }

    public fun set_min_liq_start_price_delta_bps(arg0: &mut PositionConfig, arg1: u16, arg2: &mut 0x2::tx_context::TxContext) : 0xa0501135cff2a49568b1fd32407372300f57ebc5949aaabbcc33d16028c58222::access::ActionRequest {
        arg0.min_liq_start_price_delta_bps = arg1;
        let v0 = AModifyConfig{dummy_field: false};
        0xa0501135cff2a49568b1fd32407372300f57ebc5949aaabbcc33d16028c58222::access::new_request<AModifyConfig>(v0, arg2)
    }

    public fun set_position_creation_fee_sui(arg0: &mut PositionConfig, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0xa0501135cff2a49568b1fd32407372300f57ebc5949aaabbcc33d16028c58222::access::ActionRequest {
        arg0.position_creation_fee_sui = arg1;
        let v0 = AModifyConfig{dummy_field: false};
        0xa0501135cff2a49568b1fd32407372300f57ebc5949aaabbcc33d16028c58222::access::new_request<AModifyConfig>(v0, arg2)
    }

    public fun set_pyth_config_max_age_secs(arg0: &mut PositionConfig, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0xa0501135cff2a49568b1fd32407372300f57ebc5949aaabbcc33d16028c58222::access::ActionRequest {
        0x2::bag::borrow_mut<0x1::type_name::TypeName, PythConfig>(&mut arg0.allowed_oracles, 0x1::type_name::get<PythConfig>()).max_age_secs = arg1;
        let v0 = AModifyConfig{dummy_field: false};
        0xa0501135cff2a49568b1fd32407372300f57ebc5949aaabbcc33d16028c58222::access::new_request<AModifyConfig>(v0, arg2)
    }

    public fun set_rebalance_fee_bps(arg0: &mut PositionConfig, arg1: u16, arg2: &mut 0x2::tx_context::TxContext) : 0xa0501135cff2a49568b1fd32407372300f57ebc5949aaabbcc33d16028c58222::access::ActionRequest {
        arg0.rebalance_fee_bps = arg1;
        let v0 = AModifyConfig{dummy_field: false};
        0xa0501135cff2a49568b1fd32407372300f57ebc5949aaabbcc33d16028c58222::access::new_request<AModifyConfig>(v0, arg2)
    }

    public(friend) fun set_ticket_active<T0, T1, T2>(arg0: &mut Position<T0, T1, T2>, arg1: bool) {
        arg0.ticket_active = arg1;
    }

    public(friend) fun take_rebalance_fee<T0, T1, T2, T3>(arg0: &mut Position<T0, T1, T2>, arg1: u16, arg2: &mut 0x2::balance::Balance<T3>, arg3: &mut RebalanceReceipt) {
        let v0 = 0xb4fae2fd636b996f92234b4d373cc92ce4486e67885d3c314610dd5426504b9::util::muldiv(0x2::balance::value<T3>(arg2), (arg1 as u64), 10000);
        0xb4fae2fd636b996f92234b4d373cc92ce4486e67885d3c314610dd5426504b9::balance_bag::add<T3>(&mut arg0.collected_fees, 0x2::balance::split<T3>(arg2, v0));
        let v1 = &mut arg3.fees_taken;
        add_amount_to_map<T3>(v1, v0);
    }

    public(friend) fun ticket_active<T0, T1, T2>(arg0: &Position<T0, T1, T2>) : bool {
        arg0.ticket_active
    }

    public(friend) fun validate_debt_info(arg0: &PositionConfig, arg1: &0xb4fae2fd636b996f92234b4d373cc92ce4486e67885d3c314610dd5426504b9::debt_info::DebtInfo) : 0xb4fae2fd636b996f92234b4d373cc92ce4486e67885d3c314610dd5426504b9::debt_info::ValidatedDebtInfo {
        0xb4fae2fd636b996f92234b4d373cc92ce4486e67885d3c314610dd5426504b9::debt_info::validate(arg1, 0x2::object::id<0xb4fae2fd636b996f92234b4d373cc92ce4486e67885d3c314610dd5426504b9::supply_pool::LendFacilCap>(&arg0.lend_facil_cap))
    }

    public(friend) fun validate_price_info(arg0: &PositionConfig, arg1: &0xb4fae2fd636b996f92234b4d373cc92ce4486e67885d3c314610dd5426504b9::pyth::PythPriceInfo) : 0xb4fae2fd636b996f92234b4d373cc92ce4486e67885d3c314610dd5426504b9::pyth::ValidatedPythPriceInfo {
        let v0 = 0x2::bag::borrow<0x1::type_name::TypeName, PythConfig>(&arg0.allowed_oracles, 0x1::type_name::get<PythConfig>());
        0xb4fae2fd636b996f92234b4d373cc92ce4486e67885d3c314610dd5426504b9::pyth::validate(arg1, v0.max_age_secs, &v0.pio_allowlist)
    }

    // decompiled from Move bytecode v6
}

