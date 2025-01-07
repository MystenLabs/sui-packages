module 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router {
    struct ROUTER has drop {
        dummy_field: bool,
    }

    struct SwapMetadata has copy, drop {
        type: vector<u8>,
        amount: u64,
    }

    struct IntegratorFeeConfig has copy, drop {
        recipient: address,
        fee_percent_base_18: u64,
    }

    struct RouterSwapCap<phantom T0> {
        coin_in: 0x2::coin::Coin<T0>,
        min_amount_out: u64,
        first_swap: SwapMetadata,
        previous_swap: SwapMetadata,
        final_swap: SwapMetadata,
        integrator_fee_config: IntegratorFeeConfig,
        take_fees_on_coin_out: bool,
        referrer: 0x1::option::Option<address>,
    }

    fun assert_acceptable_slippage_on_amount_out(arg0: u64, arg1: u64) {
        assert!(arg0 <= arg1, 5);
    }

    fun assert_admin_has_authorized_package(arg0: &0x2::object::UID) {
        assert!(0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::admin::has_authorized(arg0), 0);
    }

    fun assert_correct_amount_out(arg0: u64, arg1: u64) {
        assert!(arg0 == arg1, 2);
    }

    public fun assert_expected_coin_in<T0, T1>(arg0: &RouterSwapCap<T0>, arg1: &0x2::coin::Coin<T1>) {
        assert!(is_valid_swap<T0, T1>(arg0, arg1), 1);
    }

    fun assert_fee_was_not_taken_from_coin_in(arg0: bool) {
        assert!(arg0, 6);
    }

    fun assert_fee_was_taken_from_coin_in(arg0: bool) {
        assert!(!arg0, 6);
    }

    fun assert_previous_swap_was_valid<T0>(arg0: &RouterSwapCap<T0>) {
        assert!(is_valid_final_swap<T0>(arg0), 4);
    }

    fun assert_route_finished_with_non_zero_value(arg0: u64) {
        assert!(arg0 > 0, 2);
    }

    fun assert_route_starts_with_non_zero_value(arg0: u64) {
        assert!(arg0 > 0, 1);
    }

    public fun begin_router_tx<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: 0x1::option::Option<address>, arg3: 0x1::option::Option<u64>, arg4: 0x1::option::Option<address>) : RouterSwapCap<T0> {
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert_route_starts_with_non_zero_value(v0);
        let v1 = if (0x1::option::is_some<address>(&arg2) && 0x1::option::is_some<u64>(&arg3)) {
            IntegratorFeeConfig{recipient: 0x1::option::extract<address>(&mut arg2), fee_percent_base_18: 0x1::option::extract<u64>(&mut arg3)}
        } else {
            IntegratorFeeConfig{recipient: @0x0, fee_percent_base_18: 0}
        };
        let v2 = SwapMetadata{
            type   : type_to_bytes<T0>(),
            amount : v0,
        };
        let v3 = SwapMetadata{
            type   : b"",
            amount : 0,
        };
        let v4 = SwapMetadata{
            type   : type_to_bytes<T1>(),
            amount : 0,
        };
        RouterSwapCap<T0>{
            coin_in               : arg0,
            min_amount_out        : arg1,
            first_swap            : v2,
            previous_swap         : v3,
            final_swap            : v4,
            integrator_fee_config : v1,
            take_fees_on_coin_out : true,
            referrer              : arg4,
        }
    }

    public fun begin_router_tx_and_collect_fees<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::protocol_fee::ProtocolFeeConfig, arg3: &0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::treasury::Treasury, arg4: 0x1::option::Option<address>, arg5: 0x1::option::Option<u64>, arg6: 0x1::option::Option<address>, arg7: &mut 0x2::tx_context::TxContext) : RouterSwapCap<T0> {
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert_route_starts_with_non_zero_value(v0);
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::protocol_fee::distribute_protocol_fees<T0>(arg2, arg3, &mut arg0, arg7);
        let v1 = if (0x1::option::is_some<address>(&arg4) && 0x1::option::is_some<u64>(&arg5)) {
            let v2 = 0x1::option::extract<address>(&mut arg4);
            let v3 = 0x1::option::extract<u64>(&mut arg5);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0, 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::protocol_fee::take_percent_base_18(v0, v3), arg7), v2);
            IntegratorFeeConfig{recipient: v2, fee_percent_base_18: v3}
        } else {
            IntegratorFeeConfig{recipient: @0x0, fee_percent_base_18: 0}
        };
        let v4 = SwapMetadata{
            type   : type_to_bytes<T0>(),
            amount : v0,
        };
        let v5 = SwapMetadata{
            type   : b"",
            amount : 0,
        };
        let v6 = SwapMetadata{
            type   : type_to_bytes<T1>(),
            amount : 0,
        };
        RouterSwapCap<T0>{
            coin_in               : arg0,
            min_amount_out        : arg1,
            first_swap            : v4,
            previous_swap         : v5,
            final_swap            : v6,
            integrator_fee_config : v1,
            take_fees_on_coin_out : false,
            referrer              : arg6,
        }
    }

    fun calculate_percentage(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (10000 as u128)) as u64)
    }

    public fun end_router_tx<T0, T1>(arg0: RouterSwapCap<T0>, arg1: &mut 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_previous_swap_was_valid<T0>(&arg0);
        let v0 = &mut arg0;
        update_final_swap_metadata<T0>(v0);
        let v1 = 0x2::coin::value<T1>(arg1);
        assert_correct_amount_out(arg0.final_swap.amount, v1);
        assert_acceptable_slippage_on_amount_out(arg0.min_amount_out, v1);
        assert_route_finished_with_non_zero_value(v1);
        assert_fee_was_taken_from_coin_in(arg0.take_fees_on_coin_out);
        let RouterSwapCap {
            coin_in               : v2,
            min_amount_out        : _,
            first_swap            : v4,
            previous_swap         : _,
            final_swap            : v6,
            integrator_fee_config : v7,
            take_fees_on_coin_out : _,
            referrer              : v9,
        } = arg0;
        let v10 = v7;
        let v11 = v6;
        let v12 = v4;
        0x2::coin::destroy_zero<T0>(v2);
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::events::emit_swap_completed_event(v12.type, v12.amount, v11.type, v11.amount, v10.recipient, v10.fee_percent_base_18, v9, arg2);
    }

    public fun end_router_tx_and_pay_fees<T0, T1>(arg0: RouterSwapCap<T0>, arg1: &mut 0x2::coin::Coin<T1>, arg2: &0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::protocol_fee::ProtocolFeeConfig, arg3: &0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::treasury::Treasury, arg4: &mut 0x2::tx_context::TxContext) {
        assert_previous_swap_was_valid<T0>(&arg0);
        let v0 = &mut arg0;
        update_final_swap_metadata<T0>(v0);
        let v1 = 0x2::coin::value<T1>(arg1);
        assert_correct_amount_out(arg0.final_swap.amount, v1);
        assert_acceptable_slippage_on_amount_out(arg0.min_amount_out, v1);
        assert_route_finished_with_non_zero_value(v1);
        assert_fee_was_not_taken_from_coin_in(arg0.take_fees_on_coin_out);
        let RouterSwapCap {
            coin_in               : v2,
            min_amount_out        : _,
            first_swap            : v4,
            previous_swap         : _,
            final_swap            : v6,
            integrator_fee_config : v7,
            take_fees_on_coin_out : _,
            referrer              : v9,
        } = arg0;
        let v10 = v7;
        let v11 = v6;
        let v12 = v4;
        0x2::coin::destroy_zero<T0>(v2);
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::protocol_fee::distribute_protocol_fees<T1>(arg2, arg3, arg1, arg4);
        if (v10.recipient != @0x0 && v10.fee_percent_base_18 != 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(arg1, 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::protocol_fee::take_percent_base_18(0x2::coin::value<T1>(arg1), v10.fee_percent_base_18), arg4), v10.recipient);
        };
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::events::emit_swap_completed_event(v12.type, v12.amount, v11.type, v11.amount, v10.recipient, v10.fee_percent_base_18, v9, arg4);
    }

    fun init(arg0: ROUTER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::admin::AdminCap>(0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::admin::create_admin_cap(arg1), v0);
        let (v1, v2) = 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::protocol_fee::create_config<ROUTER>(&arg0, arg1);
        0x2::transfer::public_share_object<0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::protocol_fee::ProtocolFeeConfig>(v1);
        0x2::transfer::public_transfer<0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::protocol_fee::ChangeFeeCap>(v2, v0);
        0x2::transfer::public_share_object<0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::treasury::Treasury>(0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::treasury::create_treasury(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<ROUTER>(arg0, arg1), v0);
    }

    public fun initiate_path<T0>(arg0: &mut RouterSwapCap<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_previous_swap_was_valid<T0>(arg0);
        update_final_swap_metadata<T0>(arg0);
        update_previous_swap_metadata<T0>(arg0, type_to_bytes<T0>(), arg1);
        0x2::coin::split<T0>(&mut arg0.coin_in, arg1, arg2)
    }

    public fun initiate_path_by_percent<T0>(arg0: &mut RouterSwapCap<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = if (arg1 == 0) {
            0x2::coin::value<T0>(&arg0.coin_in)
        } else {
            0x1::u64::min(calculate_percentage(arg0.first_swap.amount, arg1), 0x2::coin::value<T0>(&arg0.coin_in))
        };
        initiate_path<T0>(arg0, v0, arg2)
    }

    fun is_valid_final_swap<T0>(arg0: &RouterSwapCap<T0>) : bool {
        arg0.previous_swap.type == arg0.final_swap.type || arg0.previous_swap.amount == 0
    }

    fun is_valid_swap<T0, T1>(arg0: &RouterSwapCap<T0>, arg1: &0x2::coin::Coin<T1>) : bool {
        arg0.previous_swap.type == type_to_bytes<T1>() && arg0.previous_swap.amount == 0x2::coin::value<T1>(arg1)
    }

    fun type_to_bytes<T0>() : vector<u8> {
        let v0 = 0x1::type_name::get<T0>();
        *0x1::ascii::as_bytes(0x1::type_name::borrow_string(&v0))
    }

    fun update_final_swap_metadata<T0>(arg0: &mut RouterSwapCap<T0>) {
        arg0.final_swap.amount = arg0.final_swap.amount + arg0.previous_swap.amount;
    }

    public fun update_path_metadata<T0, T1>(arg0: &mut RouterSwapCap<T0>, arg1: &0x2::object::UID, arg2: u64) {
        assert_admin_has_authorized_package(arg1);
        update_previous_swap_metadata<T0>(arg0, type_to_bytes<T1>(), arg2);
    }

    fun update_previous_swap_metadata<T0>(arg0: &mut RouterSwapCap<T0>, arg1: vector<u8>, arg2: u64) {
        let v0 = SwapMetadata{
            type   : arg1,
            amount : arg2,
        };
        arg0.previous_swap = v0;
    }

    // decompiled from Move bytecode v6
}

