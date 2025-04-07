module 0xaec914fe1ed3be0aa3fc3cc610cccba02ace491ab45589035f657e1097c75faa::router {
    struct ROUTER has drop {
        dummy_field: bool,
    }

    struct RouterMetadata has copy, drop {
        typeName: vector<u8>,
        amount: u64,
    }

    struct RouterCap<phantom T0> {
        coin: 0x2::coin::Coin<T0>,
        first_swap: RouterMetadata,
        previous_swap: RouterMetadata,
        final_swap: RouterMetadata,
        take_fees_on_coin_out: bool,
    }

    fun assert_fee_was_not_taken_from_coin_in(arg0: bool) {
        assert!(arg0, 6);
    }

    fun assert_fee_was_taken_from_coin_in(arg0: bool) {
        assert!(!arg0, 6);
    }

    fun assert_previous_swap_was_valid<T0>(arg0: &RouterCap<T0>) {
        assert!(is_valid_final_swap<T0>(arg0), 4);
    }

    fun assert_route_starts_with_non_zero_value(arg0: u64) {
        assert!(arg0 > 0, 1);
    }

    fun assert_route_starts_with_zero_value(arg0: u64) {
        assert!(arg0 == 0, 1);
    }

    public fun begin_router_stake_and_collect_fees<T0>(arg0: vector<u8>, arg1: 0x2::coin::Coin<T0>, arg2: &0xaec914fe1ed3be0aa3fc3cc610cccba02ace491ab45589035f657e1097c75faa::protocol_fee::ProtocolFeeConfig, arg3: &0xaec914fe1ed3be0aa3fc3cc610cccba02ace491ab45589035f657e1097c75faa::nft::NftConfig, arg4: &mut 0xaec914fe1ed3be0aa3fc3cc610cccba02ace491ab45589035f657e1097c75faa::treasury::Treasury, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : RouterCap<T0> {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert_route_starts_with_non_zero_value(v0);
        0xaec914fe1ed3be0aa3fc3cc610cccba02ace491ab45589035f657e1097c75faa::protocol_fee::distribute_protocol_fees<T0>(arg2, arg4, &mut arg1, arg6);
        0xaec914fe1ed3be0aa3fc3cc610cccba02ace491ab45589035f657e1097c75faa::nft::zero_obj_mint_with_points(arg3, arg4, 0xaec914fe1ed3be0aa3fc3cc610cccba02ace491ab45589035f657e1097c75faa::nft::get_points_per_lending(arg3), arg5, arg6);
        let v1 = RouterMetadata{
            typeName : 0xaec914fe1ed3be0aa3fc3cc610cccba02ace491ab45589035f657e1097c75faa::utils::type_to_bytes<T0>(),
            amount   : v0,
        };
        let v2 = RouterMetadata{
            typeName : arg0,
            amount   : 0,
        };
        let v3 = RouterMetadata{
            typeName : b"",
            amount   : 0,
        };
        RouterCap<T0>{
            coin                  : arg1,
            first_swap            : v1,
            previous_swap         : v3,
            final_swap            : v2,
            take_fees_on_coin_out : false,
        }
    }

    public fun begin_router_unstake<T0>(arg0: vector<u8>, arg1: 0x2::coin::Coin<T0>) : RouterCap<T0> {
        assert_route_starts_with_zero_value(0x2::coin::value<T0>(&arg1));
        let v0 = RouterMetadata{
            typeName : arg0,
            amount   : 0,
        };
        let v1 = RouterMetadata{
            typeName : 0xaec914fe1ed3be0aa3fc3cc610cccba02ace491ab45589035f657e1097c75faa::utils::type_to_bytes<T0>(),
            amount   : 0,
        };
        let v2 = RouterMetadata{
            typeName : b"",
            amount   : 0,
        };
        RouterCap<T0>{
            coin                  : arg1,
            first_swap            : v0,
            previous_swap         : v2,
            final_swap            : v1,
            take_fees_on_coin_out : true,
        }
    }

    fun calculate_percentage(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / 1000000000000000000) as u64)
    }

    public fun end_router_stake<T0>(arg0: RouterCap<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 != 0x2::tx_context::sender(arg2), 0);
        assert_previous_swap_was_valid<T0>(&arg0);
        let v0 = &mut arg0;
        update_final_swap_metadata<T0>(v0);
        assert_fee_was_taken_from_coin_in(arg0.take_fees_on_coin_out);
        let RouterCap {
            coin                  : v1,
            first_swap            : v2,
            previous_swap         : _,
            final_swap            : v4,
            take_fees_on_coin_out : _,
        } = arg0;
        let v6 = v4;
        let v7 = v2;
        0x2::coin::destroy_zero<T0>(v1);
        0xaec914fe1ed3be0aa3fc3cc610cccba02ace491ab45589035f657e1097c75faa::events::emit_stake_completed_event(v7.typeName, v7.amount, v6.typeName, 0, arg1, arg2);
    }

    public fun end_router_unstake_and_pay_fees<T0>(arg0: RouterCap<T0>, arg1: &0xaec914fe1ed3be0aa3fc3cc610cccba02ace491ab45589035f657e1097c75faa::protocol_fee::ProtocolFeeConfig, arg2: &0xaec914fe1ed3be0aa3fc3cc610cccba02ace491ab45589035f657e1097c75faa::nft::NftConfig, arg3: &mut 0xaec914fe1ed3be0aa3fc3cc610cccba02ace491ab45589035f657e1097c75faa::treasury::Treasury, arg4: address, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg4 != 0x2::tx_context::sender(arg6), 0);
        assert_previous_swap_was_valid<T0>(&arg0);
        let v0 = &mut arg0;
        update_final_swap_metadata<T0>(v0);
        assert_fee_was_not_taken_from_coin_in(arg0.take_fees_on_coin_out);
        let RouterCap {
            coin                  : v1,
            first_swap            : v2,
            previous_swap         : _,
            final_swap            : v4,
            take_fees_on_coin_out : _,
        } = arg0;
        let v6 = v4;
        let v7 = v2;
        let v8 = v1;
        0xaec914fe1ed3be0aa3fc3cc610cccba02ace491ab45589035f657e1097c75faa::protocol_fee::distribute_protocol_fees<T0>(arg1, arg3, &mut v8, arg6);
        0xaec914fe1ed3be0aa3fc3cc610cccba02ace491ab45589035f657e1097c75faa::nft::zero_obj_mint_with_points(arg2, arg3, 0xaec914fe1ed3be0aa3fc3cc610cccba02ace491ab45589035f657e1097c75faa::nft::get_points_per_lending(arg2), arg5, arg6);
        0xaec914fe1ed3be0aa3fc3cc610cccba02ace491ab45589035f657e1097c75faa::events::emit_unstake_completed_event(v7.typeName, 0, v6.typeName, v6.amount, arg4, arg6);
        v8
    }

    fun init(arg0: ROUTER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_share_object<0xaec914fe1ed3be0aa3fc3cc610cccba02ace491ab45589035f657e1097c75faa::flash_loan::FlashLoanGlobalConfig>(0xaec914fe1ed3be0aa3fc3cc610cccba02ace491ab45589035f657e1097c75faa::flash_loan::create_config<ROUTER>(&arg0, arg1));
        0x2::transfer::public_share_object<0xaec914fe1ed3be0aa3fc3cc610cccba02ace491ab45589035f657e1097c75faa::nft::NftConfig>(0xaec914fe1ed3be0aa3fc3cc610cccba02ace491ab45589035f657e1097c75faa::nft::create_config<ROUTER>(&arg0, arg1));
        0x2::transfer::public_share_object<0xaec914fe1ed3be0aa3fc3cc610cccba02ace491ab45589035f657e1097c75faa::staking::StakeConfig>(0xaec914fe1ed3be0aa3fc3cc610cccba02ace491ab45589035f657e1097c75faa::staking::create_config<ROUTER>(&arg0, arg1));
        0x2::transfer::public_share_object<0xaec914fe1ed3be0aa3fc3cc610cccba02ace491ab45589035f657e1097c75faa::protocol_fee::ProtocolFeeConfig>(0xaec914fe1ed3be0aa3fc3cc610cccba02ace491ab45589035f657e1097c75faa::protocol_fee::create_config<ROUTER>(&arg0, arg1));
        0x2::transfer::public_share_object<0xaec914fe1ed3be0aa3fc3cc610cccba02ace491ab45589035f657e1097c75faa::treasury::Treasury>(0xaec914fe1ed3be0aa3fc3cc610cccba02ace491ab45589035f657e1097c75faa::treasury::create_treasury(arg1));
        0x2::transfer::public_transfer<0xaec914fe1ed3be0aa3fc3cc610cccba02ace491ab45589035f657e1097c75faa::admin::AdminCap>(0xaec914fe1ed3be0aa3fc3cc610cccba02ace491ab45589035f657e1097c75faa::admin::create_admin_cap(arg1), v0);
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<ROUTER>(arg0, arg1), v0);
    }

    public fun initiate_path_by_percent<T0>(arg0: &mut RouterCap<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = if (arg1 == 0) {
            0x2::coin::value<T0>(&arg0.coin)
        } else {
            0x1::u64::min(calculate_percentage(arg0.first_swap.amount, arg1), 0x2::coin::value<T0>(&arg0.coin))
        };
        initiate_path_stake<T0>(arg0, v0, arg2)
    }

    public fun initiate_path_stake<T0>(arg0: &mut RouterCap<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_previous_swap_was_valid<T0>(arg0);
        update_final_swap_metadata<T0>(arg0);
        update_previous_swap_metadata<T0>(arg0, 0xaec914fe1ed3be0aa3fc3cc610cccba02ace491ab45589035f657e1097c75faa::utils::type_to_bytes<T0>(), arg1);
        0x2::coin::split<T0>(&mut arg0.coin, arg1, arg2)
    }

    public fun initiate_path_unstake<T0>(arg0: &mut RouterCap<T0>) {
        assert_previous_swap_was_valid<T0>(arg0);
        update_final_swap_metadata<T0>(arg0);
        update_previous_swap_metadata<T0>(arg0, 0xaec914fe1ed3be0aa3fc3cc610cccba02ace491ab45589035f657e1097c75faa::utils::type_to_bytes<T0>(), 0);
    }

    fun is_valid_final_swap<T0>(arg0: &RouterCap<T0>) : bool {
        arg0.previous_swap.typeName == arg0.final_swap.typeName || arg0.previous_swap.amount == 0
    }

    public(friend) fun update_final_swap_metadata<T0>(arg0: &mut RouterCap<T0>) {
        arg0.final_swap.amount = arg0.final_swap.amount + arg0.previous_swap.amount;
    }

    public fun update_path_metadata_stake<T0>(arg0: &mut RouterCap<T0>, arg1: vector<u8>, arg2: u64) {
        update_previous_swap_metadata<T0>(arg0, arg1, arg2);
    }

    public fun update_path_metadata_unstake<T0>(arg0: &mut RouterCap<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::coin::join<T0>(&mut arg0.coin, arg1);
        update_previous_swap_metadata<T0>(arg0, 0xaec914fe1ed3be0aa3fc3cc610cccba02ace491ab45589035f657e1097c75faa::utils::type_to_bytes<T0>(), 0x2::coin::value<T0>(&arg1));
    }

    public(friend) fun update_previous_swap_metadata<T0>(arg0: &mut RouterCap<T0>, arg1: vector<u8>, arg2: u64) {
        let v0 = RouterMetadata{
            typeName : arg1,
            amount   : arg2,
        };
        arg0.previous_swap = v0;
    }

    // decompiled from Move bytecode v6
}

