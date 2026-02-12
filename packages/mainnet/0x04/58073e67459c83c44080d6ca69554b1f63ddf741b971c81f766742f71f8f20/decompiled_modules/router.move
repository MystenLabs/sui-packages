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

    struct RouterSwapCapExtended<T0, T1> {
        router_data: T0,
        wrapper_data: T1,
    }

    struct RouterDataV1 {
        expected_amount_out: u64,
        slippage: u64,
        protocol_fee_recipient: address,
        integrator_fee_config: IntegratorFeeConfig,
        take_fees_on_coin_in: bool,
    }

    struct WrapperDataV1<phantom T0> {
        balance_in: 0x2::balance::Balance<T0>,
        first_swap: SwapMetadata,
        previous_swap: SwapMetadata,
        final_swap: SwapMetadata,
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

    fun assert_admin_has_authorized_package(arg0: &0x2::object::UID) {
        assert!(0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::admin::has_authorized(arg0), 0);
    }

    fun assert_correct_amount_out(arg0: u64, arg1: u64) {
        assert!(arg0 == arg1, 2);
    }

    public fun assert_expected_balance_in_w1<T0, T1, T2>(arg0: &RouterSwapCapExtended<T0, WrapperDataV1<T1>>, arg1: &0x2::balance::Balance<T2>) {
        assert!(arg0.wrapper_data.previous_swap.type == type_to_bytes<T2>() && arg0.wrapper_data.previous_swap.amount == 0x2::balance::value<T2>(arg1), 1);
    }

    public fun assert_expected_coin_in<T0, T1>(arg0: &RouterSwapCap<T0>, arg1: &0x2::coin::Coin<T1>) {
        abort 404
    }

    fun assert_previous_swap_was_valid<T0, T1>(arg0: &RouterSwapCapExtended<T0, WrapperDataV1<T1>>) {
        let v0 = &arg0.wrapper_data;
        assert!(v0.previous_swap.type == v0.final_swap.type || v0.previous_swap.amount == 0, 4);
    }

    fun assert_route_starts_with_non_zero_value(arg0: u64) {
        assert!(arg0 > 0, 1);
    }

    public fun begin_router_tx<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: 0x1::option::Option<address>, arg3: 0x1::option::Option<u64>, arg4: 0x1::option::Option<address>) : RouterSwapCap<T0> {
        abort 404
    }

    public fun begin_router_tx_and_collect_fees<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::protocol_fee::ProtocolFeeConfig, arg3: &0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::treasury::Treasury, arg4: 0x1::option::Option<address>, arg5: 0x1::option::Option<u64>, arg6: 0x1::option::Option<address>, arg7: &mut 0x2::tx_context::TxContext) : RouterSwapCap<T0> {
        abort 404
    }

    public fun begin_router_tx_and_collect_sui_fee<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::protocol_fee::ProtocolFeeConfig, arg3: &0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::treasury::Treasury, arg4: address, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: u64, arg7: 0x1::option::Option<address>, arg8: &mut 0x2::tx_context::TxContext) : RouterSwapCap<T0> {
        abort 404
    }

    public fun begin_router_tx_r1_w1<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: u64, arg3: &0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::protocol_fee::ProtocolFeeConfig, arg4: &0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::treasury::Treasury, arg5: address, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : RouterSwapCapExtended<RouterDataV1, WrapperDataV1<T0>> {
        let v0 = 0x2::coin::into_balance<T0>(arg0);
        let v1 = 0x2::balance::value<T0>(&v0);
        assert_route_starts_with_non_zero_value(v1);
        let v2 = if (arg5 != @0x0 && arg6 != 0) {
            let v3 = 0x2::coin::take<T0>(&mut v0, 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::protocol_fee::take_percent_base_18(v1, arg6), arg7);
            collect_integrator_fee<T0>(arg3, arg4, v3, arg5, arg7)
        } else {
            IntegratorFeeConfig{recipient: @0x0, fee_percent_base_18: 0}
        };
        let v4 = RouterDataV1{
            expected_amount_out    : arg1,
            slippage               : arg2,
            protocol_fee_recipient : 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::protocol_fee::dev_wallet(arg3),
            integrator_fee_config  : v2,
            take_fees_on_coin_in   : true,
        };
        let v5 = SwapMetadata{
            type   : type_to_bytes<T0>(),
            amount : 0x2::balance::value<T0>(&v0),
        };
        let v6 = SwapMetadata{
            type   : b"",
            amount : 0,
        };
        let v7 = SwapMetadata{
            type   : type_to_bytes<T1>(),
            amount : 0,
        };
        let v8 = WrapperDataV1<T0>{
            balance_in    : v0,
            first_swap    : v5,
            previous_swap : v6,
            final_swap    : v7,
        };
        RouterSwapCapExtended<RouterDataV1, WrapperDataV1<T0>>{
            router_data  : v4,
            wrapper_data : v8,
        }
    }

    public fun begin_router_tx_sui_r1_w1<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: u64, arg3: &0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::protocol_fee::ProtocolFeeConfig, arg4: &0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::treasury::Treasury, arg5: address, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : RouterSwapCapExtended<RouterDataV1, WrapperDataV1<T0>> {
        let v0 = 0x2::coin::into_balance<T0>(arg0);
        let v1 = 0x2::balance::value<T0>(&v0);
        assert_route_starts_with_non_zero_value(v1);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg6) == arg7, 6);
        let v2 = RouterDataV1{
            expected_amount_out    : arg1,
            slippage               : arg2,
            protocol_fee_recipient : 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::protocol_fee::dev_wallet(arg3),
            integrator_fee_config  : collect_integrator_fee<0x2::sui::SUI>(arg3, arg4, arg6, arg5, arg8),
            take_fees_on_coin_in   : false,
        };
        let v3 = SwapMetadata{
            type   : type_to_bytes<T0>(),
            amount : v1,
        };
        let v4 = SwapMetadata{
            type   : b"",
            amount : 0,
        };
        let v5 = SwapMetadata{
            type   : type_to_bytes<T1>(),
            amount : 0,
        };
        let v6 = WrapperDataV1<T0>{
            balance_in    : v0,
            first_swap    : v3,
            previous_swap : v4,
            final_swap    : v5,
        };
        RouterSwapCapExtended<RouterDataV1, WrapperDataV1<T0>>{
            router_data  : v2,
            wrapper_data : v6,
        }
    }

    fun calculate_percentage(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (1000000000000000000 as u128)) as u64)
    }

    fun collect_integrator_fee<T0>(arg0: &0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::protocol_fee::ProtocolFeeConfig, arg1: &0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::treasury::Treasury, arg2: 0x2::coin::Coin<T0>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) : IntegratorFeeConfig {
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::protocol_fee::distribute_protocol_fees<T0>(arg0, arg1, &mut arg2, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, arg3);
        IntegratorFeeConfig{
            recipient           : arg3,
            fee_percent_base_18 : 0x2::coin::value<T0>(&arg2),
        }
    }

    public fun end_router_tx<T0, T1>(arg0: RouterSwapCap<T0>, arg1: &mut 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) {
        abort 404
    }

    public fun end_router_tx_and_pay_fees<T0, T1>(arg0: RouterSwapCap<T0>, arg1: &mut 0x2::coin::Coin<T1>, arg2: &0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::protocol_fee::ProtocolFeeConfig, arg3: &0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::treasury::Treasury, arg4: &mut 0x2::tx_context::TxContext) {
        abort 404
    }

    public fun end_router_tx_r1_w1<T0, T1>(arg0: RouterSwapCapExtended<RouterDataV1, WrapperDataV1<T0>>, arg1: &mut 0x2::balance::Balance<T1>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_previous_swap_was_valid<RouterDataV1, T0>(&arg0);
        let v0 = &mut arg0;
        update_final_swap_metadata<RouterDataV1, T0>(v0);
        let v1 = 0x2::balance::value<T1>(arg1);
        assert_correct_amount_out(arg0.wrapper_data.final_swap.amount, v1);
        let RouterSwapCapExtended {
            router_data  : v2,
            wrapper_data : v3,
        } = arg0;
        let WrapperDataV1 {
            balance_in    : v4,
            first_swap    : v5,
            previous_swap : _,
            final_swap    : v7,
        } = v3;
        let v8 = v7;
        let v9 = v5;
        let RouterDataV1 {
            expected_amount_out    : v10,
            slippage               : v11,
            protocol_fee_recipient : v12,
            integrator_fee_config  : v13,
            take_fees_on_coin_in   : v14,
        } = v2;
        let v15 = v13;
        0x2::balance::destroy_zero<T0>(v4);
        if (v1 > v10) {
            let v16 = v1 - v10;
            let v17 = 0x2::coin::take<T1>(arg1, v16, arg2);
            if (v15.recipient == @0x0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v17, v12);
            } else {
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut v17, v16 / 2, arg2), v15.recipient);
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v17, v12);
            };
        } else {
            assert!(v1 >= v10 - (((v10 as u128) * (v11 as u128) / 1000000000000000000) as u64), 5);
        };
        let v18 = if (v14) {
            v9.type
        } else {
            type_to_bytes<0x2::sui::SUI>()
        };
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::events::emit_swap_completed_event(v9.type, v9.amount, v8.type, v8.amount, v15.recipient, v18, v15.fee_percent_base_18, 0x1::option::none<address>(), arg2);
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
        abort 404
    }

    public fun initiate_path_by_percent<T0>(arg0: &mut RouterSwapCap<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        abort 404
    }

    public fun initiate_path_by_percent_w1<T0, T1>(arg0: &mut RouterSwapCapExtended<T0, WrapperDataV1<T1>>, arg1: u64) : 0x2::balance::Balance<T1> {
        let v0 = &arg0.wrapper_data;
        let v1 = if (arg1 == 0) {
            0x2::balance::value<T1>(&v0.balance_in)
        } else {
            calculate_percentage(v0.first_swap.amount, arg1)
        };
        initiate_path_w1<T0, T1>(arg0, v1)
    }

    public fun initiate_path_w1<T0, T1>(arg0: &mut RouterSwapCapExtended<T0, WrapperDataV1<T1>>, arg1: u64) : 0x2::balance::Balance<T1> {
        assert_previous_swap_was_valid<T0, T1>(arg0);
        update_final_swap_metadata<T0, T1>(arg0);
        update_previous_swap_metadata<T0, T1>(arg0, type_to_bytes<T1>(), arg1);
        0x2::balance::split<T1>(&mut arg0.wrapper_data.balance_in, arg1)
    }

    fun type_to_bytes<T0>() : vector<u8> {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        *0x1::ascii::as_bytes(0x1::type_name::as_string(&v0))
    }

    fun update_final_swap_metadata<T0, T1>(arg0: &mut RouterSwapCapExtended<T0, WrapperDataV1<T1>>) {
        arg0.wrapper_data.final_swap.amount = arg0.wrapper_data.final_swap.amount + arg0.wrapper_data.previous_swap.amount;
    }

    public fun update_path_metadata<T0, T1>(arg0: &mut RouterSwapCap<T0>, arg1: &0x2::object::UID, arg2: u64) {
        abort 404
    }

    public fun update_path_metadata_w1<T0, T1, T2>(arg0: &mut RouterSwapCapExtended<T0, WrapperDataV1<T1>>, arg1: &0x2::object::UID, arg2: u64) {
        assert_admin_has_authorized_package(arg1);
        update_previous_swap_metadata<T0, T1>(arg0, type_to_bytes<T2>(), arg2);
    }

    fun update_previous_swap_metadata<T0, T1>(arg0: &mut RouterSwapCapExtended<T0, WrapperDataV1<T1>>, arg1: vector<u8>, arg2: u64) {
        let v0 = SwapMetadata{
            type   : arg1,
            amount : arg2,
        };
        arg0.wrapper_data.previous_swap = v0;
    }

    // decompiled from Move bytecode v6
}

