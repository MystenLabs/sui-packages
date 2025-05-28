module 0xaec914fe1ed3be0aa3fc3cc610cccba02ace491ab45589035f657e1097c75faa::swap {
    struct ROUTER has drop {
        dummy_field: bool,
    }

    struct RouterMetadata has copy, drop {
        typeName: vector<u8>,
        amount: u64,
    }

    struct RouterCap<phantom T0, phantom T1> {
        coin_in: 0x2::coin::Coin<T0>,
        coin_out: 0x2::coin::Coin<T1>,
        first_swap: RouterMetadata,
        previous_swap: RouterMetadata,
        final_swap: RouterMetadata,
    }

    public fun assert_expected_coin_in<T0, T1>(arg0: &RouterCap<T0, T1>, arg1: &0x2::coin::Coin<T1>) {
        assert!(is_valid_swap<T0, T1>(arg0, arg1), 1);
    }

    fun assert_previous_swap_was_valid<T0, T1>(arg0: &RouterCap<T0, T1>) {
        assert!(is_valid_final_swap<T0, T1>(arg0), 4);
    }

    fun assert_route_starts_with_non_zero_value(arg0: u64) {
        assert!(arg0 > 0, 1);
    }

    public fun begin_swap_router<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x2::tx_context::TxContext) : RouterCap<T0, T1> {
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert_route_starts_with_non_zero_value(v0);
        let v1 = RouterMetadata{
            typeName : 0xaec914fe1ed3be0aa3fc3cc610cccba02ace491ab45589035f657e1097c75faa::utils::type_to_bytes<T0>(),
            amount   : v0,
        };
        let v2 = RouterMetadata{
            typeName : 0xaec914fe1ed3be0aa3fc3cc610cccba02ace491ab45589035f657e1097c75faa::utils::type_to_bytes<T1>(),
            amount   : 0,
        };
        let v3 = RouterMetadata{
            typeName : b"",
            amount   : 0,
        };
        RouterCap<T0, T1>{
            coin_in       : arg0,
            coin_out      : 0x2::coin::zero<T1>(arg1),
            first_swap    : v1,
            previous_swap : v3,
            final_swap    : v2,
        }
    }

    fun calculate_percentage(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / 1000000000000000000) as u64)
    }

    public fun end_swap_router<T0, T1>(arg0: RouterCap<T0, T1>, arg1: &0xaec914fe1ed3be0aa3fc3cc610cccba02ace491ab45589035f657e1097c75faa::protocol_fee::ProtocolFeeConfig, arg2: &0xaec914fe1ed3be0aa3fc3cc610cccba02ace491ab45589035f657e1097c75faa::nft::NftConfig, arg3: &mut 0xaec914fe1ed3be0aa3fc3cc610cccba02ace491ab45589035f657e1097c75faa::treasury::Treasury, arg4: address, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(arg4 != 0x2::tx_context::sender(arg6), 0);
        assert_previous_swap_was_valid<T0, T1>(&arg0);
        let v0 = &mut arg0;
        update_final_swap_metadata<T0, T1>(v0);
        let RouterCap {
            coin_in       : v1,
            coin_out      : v2,
            first_swap    : v3,
            previous_swap : _,
            final_swap    : v5,
        } = arg0;
        let v6 = v5;
        let v7 = v3;
        let v8 = v2;
        0xaec914fe1ed3be0aa3fc3cc610cccba02ace491ab45589035f657e1097c75faa::protocol_fee::distribute_protocol_fees<T1>(arg1, arg3, &mut v8, arg6);
        0xaec914fe1ed3be0aa3fc3cc610cccba02ace491ab45589035f657e1097c75faa::nft::zero_obj_mint_with_points(arg2, arg3, 0xaec914fe1ed3be0aa3fc3cc610cccba02ace491ab45589035f657e1097c75faa::nft::get_points_per_swap(arg2), arg5, arg6);
        0x2::coin::destroy_zero<T0>(v1);
        0xaec914fe1ed3be0aa3fc3cc610cccba02ace491ab45589035f657e1097c75faa::events::emit_swap_completed_event(v7.typeName, v7.amount, v6.typeName, v6.amount, arg4, arg6);
        v8
    }

    public fun initiate_path<T0, T1>(arg0: &mut RouterCap<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_previous_swap_was_valid<T0, T1>(arg0);
        update_final_swap_metadata<T0, T1>(arg0);
        update_previous_swap_metadata<T0, T1>(arg0, 0xaec914fe1ed3be0aa3fc3cc610cccba02ace491ab45589035f657e1097c75faa::utils::type_to_bytes<T0>(), arg1);
        0x2::coin::split<T0>(&mut arg0.coin_in, arg1, arg2)
    }

    public fun initiate_path_by_percent<T0, T1>(arg0: &mut RouterCap<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = if (arg1 == 0) {
            0x2::coin::value<T0>(&arg0.coin_in)
        } else {
            0x1::u64::min(calculate_percentage(arg0.first_swap.amount, arg1), 0x2::coin::value<T0>(&arg0.coin_in))
        };
        initiate_path<T0, T1>(arg0, v0, arg2)
    }

    fun is_valid_final_swap<T0, T1>(arg0: &RouterCap<T0, T1>) : bool {
        arg0.previous_swap.typeName == arg0.final_swap.typeName || arg0.previous_swap.amount == 0
    }

    fun is_valid_swap<T0, T1>(arg0: &RouterCap<T0, T1>, arg1: &0x2::coin::Coin<T1>) : bool {
        arg0.previous_swap.typeName == 0xaec914fe1ed3be0aa3fc3cc610cccba02ace491ab45589035f657e1097c75faa::utils::type_to_bytes<T1>() && arg0.previous_swap.amount == 0x2::coin::value<T1>(arg1)
    }

    public(friend) fun update_final_swap_metadata<T0, T1>(arg0: &mut RouterCap<T0, T1>) {
        arg0.final_swap.amount = arg0.final_swap.amount + arg0.previous_swap.amount;
    }

    public fun update_path_metadata<T0, T1>(arg0: &mut RouterCap<T0, T1>, arg1: 0x2::coin::Coin<T1>) {
        0x2::coin::join<T1>(&mut arg0.coin_out, arg1);
        update_previous_swap_metadata<T0, T1>(arg0, 0xaec914fe1ed3be0aa3fc3cc610cccba02ace491ab45589035f657e1097c75faa::utils::type_to_bytes<T1>(), 0x2::coin::value<T1>(&arg1));
    }

    public(friend) fun update_previous_swap_metadata<T0, T1>(arg0: &mut RouterCap<T0, T1>, arg1: vector<u8>, arg2: u64) {
        let v0 = RouterMetadata{
            typeName : arg1,
            amount   : arg2,
        };
        arg0.previous_swap = v0;
    }

    // decompiled from Move bytecode v6
}

