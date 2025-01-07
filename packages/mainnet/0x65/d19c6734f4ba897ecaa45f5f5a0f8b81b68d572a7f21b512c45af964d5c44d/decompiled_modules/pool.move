module 0x65d19c6734f4ba897ecaa45f5f5a0f8b81b68d572a7f21b512c45af964d5c44d::pool {
    struct POOL has drop {
        dummy_field: bool,
    }

    struct Pool<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        coin_a: 0x2::balance::Balance<T0>,
        coin_b: 0x2::balance::Balance<T1>,
        tick_spacing: u32,
        fee_rate: u64,
        liquidity: u128,
        current_sqrt_price: u128,
        current_tick_index: 0x65d19c6734f4ba897ecaa45f5f5a0f8b81b68d572a7f21b512c45af964d5c44d::i32::I32,
        fee_growth_global_a: u128,
        fee_growth_global_b: u128,
        fee_protocol_coin_a: u64,
        fee_protocol_coin_b: u64,
        tick_manager: 0x65d19c6734f4ba897ecaa45f5f5a0f8b81b68d572a7f21b512c45af964d5c44d::tick::TickManager,
        rewarder_manager: 0x65d19c6734f4ba897ecaa45f5f5a0f8b81b68d572a7f21b512c45af964d5c44d::rewarder::RewarderManager,
        position_manager: 0x65d19c6734f4ba897ecaa45f5f5a0f8b81b68d572a7f21b512c45af964d5c44d::position::PositionManager,
        is_pause: bool,
        index: u64,
        url: 0x1::string::String,
    }

    struct FlashSwapReceipt<phantom T0, phantom T1> {
        pool_id: 0x2::object::ID,
        a2b: bool,
        partner_id: 0x2::object::ID,
        pay_amount: u64,
        ref_fee_amount: u64,
    }

    public fun flash_swap<T0, T1>(arg0: &0x65d19c6734f4ba897ecaa45f5f5a0f8b81b68d572a7f21b512c45af964d5c44d::config::GlobalConfig, arg1: &mut Pool<T0, T1>, arg2: bool, arg3: bool, arg4: u64, arg5: u128, arg6: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, FlashSwapReceipt<T0, T1>) {
        let v0 = FlashSwapReceipt<T0, T1>{
            pool_id        : 0x2::object::id<Pool<T0, T1>>(arg1),
            a2b            : arg2,
            partner_id     : 0x2::object::id_from_address(@0x0),
            pay_amount     : 0,
            ref_fee_amount : 0,
        };
        (0x2::balance::zero<T0>(), 0x2::balance::zero<T1>(), v0)
    }

    public fun repay_flash_swap<T0, T1>(arg0: &0x65d19c6734f4ba897ecaa45f5f5a0f8b81b68d572a7f21b512c45af964d5c44d::config::GlobalConfig, arg1: &mut Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<T1>, arg4: FlashSwapReceipt<T0, T1>) {
        0x2::balance::destroy_zero<T0>(arg2);
        0x2::balance::destroy_zero<T1>(arg3);
        let FlashSwapReceipt {
            pool_id        : _,
            a2b            : _,
            partner_id     : _,
            pay_amount     : _,
            ref_fee_amount : _,
        } = arg4;
    }

    // decompiled from Move bytecode v6
}

