module 0x53320ba3d81fb7295bf9fafb2ce4e6bd1d2498e4143f7438271173b627e1646e::router {
    struct ROUTER has drop {
        dummy_field: bool,
    }

    struct SwapMetadata has copy, drop {
        typeName: vector<u8>,
        amount: u64,
    }

    struct RouterSwapCap<phantom T0> {
        coin_in: 0x2::coin::Coin<T0>,
        min_amount_out: u64,
        first_swap: SwapMetadata,
        previous_swap: SwapMetadata,
        final_swap: SwapMetadata,
        take_fees_on_coin_out: bool,
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

    fun assert_route_starts_with_non_zero_value(arg0: u64) {
        assert!(arg0 > 0, 1);
    }

    public fun begin_router_tx<T0, T1>(arg0: vector<u8>, arg1: 0x2::coin::Coin<T0>, arg2: u64) : RouterSwapCap<T0> {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert_route_starts_with_non_zero_value(v0);
        let v1 = SwapMetadata{
            typeName : type_to_bytes<T0>(),
            amount   : v0,
        };
        let v2 = SwapMetadata{
            typeName : arg0,
            amount   : 0,
        };
        let v3 = SwapMetadata{
            typeName : b"",
            amount   : 0,
        };
        RouterSwapCap<T0>{
            coin_in               : arg1,
            min_amount_out        : arg2,
            first_swap            : v1,
            previous_swap         : v3,
            final_swap            : v2,
            take_fees_on_coin_out : true,
        }
    }

    public fun begin_router_tx_and_collect_fees<T0>(arg0: vector<u8>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &0x53320ba3d81fb7295bf9fafb2ce4e6bd1d2498e4143f7438271173b627e1646e::protocol_fee::ProtocolFeeConfig, arg4: &0x53320ba3d81fb7295bf9fafb2ce4e6bd1d2498e4143f7438271173b627e1646e::treasury::Treasury, arg5: &mut 0x2::tx_context::TxContext) : RouterSwapCap<T0> {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert_route_starts_with_non_zero_value(v0);
        0x53320ba3d81fb7295bf9fafb2ce4e6bd1d2498e4143f7438271173b627e1646e::protocol_fee::distribute_protocol_fees<T0>(arg3, arg4, &mut arg1, arg5);
        let v1 = SwapMetadata{
            typeName : type_to_bytes<T0>(),
            amount   : v0,
        };
        let v2 = SwapMetadata{
            typeName : arg0,
            amount   : 0,
        };
        let v3 = SwapMetadata{
            typeName : b"",
            amount   : 0,
        };
        RouterSwapCap<T0>{
            coin_in               : arg1,
            min_amount_out        : arg2,
            first_swap            : v1,
            previous_swap         : v3,
            final_swap            : v2,
            take_fees_on_coin_out : false,
        }
    }

    fun calculate_percentage(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / 1000000000000000000) as u64)
    }

    public fun end_router_tx<T0>(arg0: RouterSwapCap<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert_previous_swap_was_valid<T0>(&arg0);
        let v0 = &mut arg0;
        update_final_swap_metadata<T0>(v0);
        assert_fee_was_taken_from_coin_in(arg0.take_fees_on_coin_out);
        let RouterSwapCap {
            coin_in               : v1,
            min_amount_out        : _,
            first_swap            : v3,
            previous_swap         : _,
            final_swap            : v5,
            take_fees_on_coin_out : _,
        } = arg0;
        let v7 = v5;
        let v8 = v3;
        0x2::coin::destroy_zero<T0>(v1);
        0x53320ba3d81fb7295bf9fafb2ce4e6bd1d2498e4143f7438271173b627e1646e::events::emit_swap_completed_event(v8.typeName, v8.amount, v7.typeName, v7.amount, arg1);
    }

    public fun end_router_tx_and_pay_fees<T0, T1>(arg0: RouterSwapCap<T0>, arg1: &mut 0x2::coin::Coin<T1>, arg2: &0x53320ba3d81fb7295bf9fafb2ce4e6bd1d2498e4143f7438271173b627e1646e::protocol_fee::ProtocolFeeConfig, arg3: &0x53320ba3d81fb7295bf9fafb2ce4e6bd1d2498e4143f7438271173b627e1646e::treasury::Treasury, arg4: &mut 0x2::tx_context::TxContext) {
        assert_previous_swap_was_valid<T0>(&arg0);
        let v0 = &mut arg0;
        update_final_swap_metadata<T0>(v0);
        assert_fee_was_not_taken_from_coin_in(arg0.take_fees_on_coin_out);
        let RouterSwapCap {
            coin_in               : v1,
            min_amount_out        : _,
            first_swap            : v3,
            previous_swap         : _,
            final_swap            : v5,
            take_fees_on_coin_out : _,
        } = arg0;
        let v7 = v5;
        let v8 = v3;
        0x2::coin::destroy_zero<T0>(v1);
        0x53320ba3d81fb7295bf9fafb2ce4e6bd1d2498e4143f7438271173b627e1646e::protocol_fee::distribute_protocol_fees<T1>(arg2, arg3, arg1, arg4);
        0x53320ba3d81fb7295bf9fafb2ce4e6bd1d2498e4143f7438271173b627e1646e::events::emit_swap_completed_event(v8.typeName, v8.amount, v7.typeName, v7.amount, arg4);
    }

    fun init(arg0: ROUTER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x53320ba3d81fb7295bf9fafb2ce4e6bd1d2498e4143f7438271173b627e1646e::admin::AdminCap>(0x53320ba3d81fb7295bf9fafb2ce4e6bd1d2498e4143f7438271173b627e1646e::admin::create_admin_cap(arg1), v0);
        let (v1, v2) = 0x53320ba3d81fb7295bf9fafb2ce4e6bd1d2498e4143f7438271173b627e1646e::protocol_fee::create_config<ROUTER>(&arg0, arg1);
        0x2::transfer::public_share_object<0x53320ba3d81fb7295bf9fafb2ce4e6bd1d2498e4143f7438271173b627e1646e::protocol_fee::ProtocolFeeConfig>(v1);
        0x2::transfer::public_transfer<0x53320ba3d81fb7295bf9fafb2ce4e6bd1d2498e4143f7438271173b627e1646e::protocol_fee::ChangeFeeCap>(v2, v0);
        0x2::transfer::public_share_object<0x53320ba3d81fb7295bf9fafb2ce4e6bd1d2498e4143f7438271173b627e1646e::treasury::Treasury>(0x53320ba3d81fb7295bf9fafb2ce4e6bd1d2498e4143f7438271173b627e1646e::treasury::create_treasury(arg1));
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
        arg0.previous_swap.typeName == arg0.final_swap.typeName || arg0.previous_swap.amount == 0
    }

    fun is_valid_swap<T0, T1>(arg0: &RouterSwapCap<T0>, arg1: &0x2::coin::Coin<T1>) : bool {
        arg0.previous_swap.typeName == type_to_bytes<T1>() && arg0.previous_swap.amount == 0x2::coin::value<T1>(arg1)
    }

    fun type_to_bytes<T0>() : vector<u8> {
        let v0 = 0x1::type_name::get<T0>();
        *0x1::ascii::as_bytes(0x1::type_name::borrow_string(&v0))
    }

    fun update_final_swap_metadata<T0>(arg0: &mut RouterSwapCap<T0>) {
        arg0.final_swap.amount = arg0.final_swap.amount + arg0.previous_swap.amount;
    }

    public fun update_path_metadata<T0>(arg0: vector<u8>, arg1: &mut RouterSwapCap<T0>, arg2: u64) {
        update_previous_swap_metadata<T0>(arg1, arg0, arg2);
    }

    fun update_previous_swap_metadata<T0>(arg0: &mut RouterSwapCap<T0>, arg1: vector<u8>, arg2: u64) {
        let v0 = SwapMetadata{
            typeName : arg1,
            amount   : arg2,
        };
        arg0.previous_swap = v0;
    }

    // decompiled from Move bytecode v6
}

