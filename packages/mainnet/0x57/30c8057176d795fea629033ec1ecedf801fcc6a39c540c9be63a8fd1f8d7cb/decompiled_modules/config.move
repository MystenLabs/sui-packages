module 0x5730c8057176d795fea629033ec1ecedf801fcc6a39c540c9be63a8fd1f8d7cb::config {
    struct Config<phantom T0> has key {
        id: 0x2::object::UID,
        enabled: bool,
        token_decimals: u8,
        supply: u64,
        phantom_quote: u64,
        graduation_quote: u64,
        base_fee_bps: u64,
        creator_share_bps: u64,
        creator_tax_cap_bps: u64,
        anti_snipe: bool,
        tick_spacing: u32,
        protocol_recipient: address,
    }

    fun assert_graduation_price_in_range(arg0: u64, arg1: u64, arg2: u64, arg3: u32) {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::tick_bound() - 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::tick_bound() % arg3;
        let v1 = 0x1::vector::empty<u128>();
        let v2 = &mut v1;
        0x1::vector::push_back<u128>(v2, 0x5730c8057176d795fea629033ec1ecedf801fcc6a39c540c9be63a8fd1f8d7cb::math::sqrt_price_x64(arg1, arg2, 0, true));
        0x1::vector::push_back<u128>(v2, 0x5730c8057176d795fea629033ec1ecedf801fcc6a39c540c9be63a8fd1f8d7cb::math::sqrt_price_x64(arg1, arg2, 0, false));
        0x1::vector::push_back<u128>(v2, 0x5730c8057176d795fea629033ec1ecedf801fcc6a39c540c9be63a8fd1f8d7cb::math::sqrt_price_x64(arg0, arg2, 0, true));
        0x1::vector::push_back<u128>(v2, 0x5730c8057176d795fea629033ec1ecedf801fcc6a39c540c9be63a8fd1f8d7cb::math::sqrt_price_x64(arg0, arg2, 0, false));
        0x1::vector::reverse<u128>(&mut v1);
        let v3 = 0;
        while (v3 < 0x1::vector::length<u128>(&v1)) {
            let v4 = 0x1::vector::pop_back<u128>(&mut v1);
            assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::neg_from(v0)) < v4 && v4 < 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(v0)), 0);
            v3 = v3 + 1;
        };
        0x1::vector::destroy_empty<u128>(v1);
    }

    public(friend) fun create<T0>(arg0: &0x884a8aceda89be24b53443769e868106084628dc2eb140ebc7059a8be21125f4::admin::AdminCap, arg1: u8, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: bool, arg9: u32, arg10: address, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 1 && arg2 <= 1000000000000000000, 0);
        assert!(arg3 > 0 && arg4 > 0, 0);
        assert!(arg3 <= 1000000000000000000 && arg4 <= 1000000000000000000, 0);
        assert!(arg5 <= 1000 && arg7 <= 1000, 0);
        assert!(arg6 <= 10000, 0);
        assert!(arg1 <= 18, 0);
        assert!(arg9 > 0 && arg9 <= 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::tick_bound(), 0);
        assert!(arg10 != @0x0, 0);
        let v0 = 0x5730c8057176d795fea629033ec1ecedf801fcc6a39c540c9be63a8fd1f8d7cb::math::mul_div_ceil(arg2, arg3, arg3 + arg4);
        assert!(v0 > 0 && v0 < arg2, 0);
        assert_graduation_price_in_range(arg2, v0, arg3 + arg4, arg9);
        let v1 = Config<T0>{
            id                  : 0x2::object::new(arg11),
            enabled             : true,
            token_decimals      : arg1,
            supply              : arg2,
            phantom_quote       : arg3,
            graduation_quote    : arg4,
            base_fee_bps        : arg5,
            creator_share_bps   : arg6,
            creator_tax_cap_bps : arg7,
            anti_snipe          : arg8,
            tick_spacing        : arg9,
            protocol_recipient  : arg10,
        };
        0x5730c8057176d795fea629033ec1ecedf801fcc6a39c540c9be63a8fd1f8d7cb::events::config_created<T0>(0x2::object::id<Config<T0>>(&v1), arg11);
        0x2::transfer::share_object<Config<T0>>(v1);
    }

    public(friend) fun launch_terms<T0>(arg0: &Config<T0>) : (0x2::object::ID, bool, u8, u64, u64, u64, u64, u64, u64, bool, u32) {
        (0x2::object::id<Config<T0>>(arg0), arg0.enabled, arg0.token_decimals, arg0.supply, arg0.phantom_quote, arg0.graduation_quote, arg0.base_fee_bps, arg0.creator_share_bps, arg0.creator_tax_cap_bps, arg0.anti_snipe, arg0.tick_spacing)
    }

    public(friend) fun protocol_recipient<T0>(arg0: &Config<T0>) : address {
        arg0.protocol_recipient
    }

    public(friend) fun set_enabled<T0>(arg0: &0x884a8aceda89be24b53443769e868106084628dc2eb140ebc7059a8be21125f4::admin::AdminCap, arg1: &mut Config<T0>, arg2: bool) {
        arg1.enabled = arg2;
        0x5730c8057176d795fea629033ec1ecedf801fcc6a39c540c9be63a8fd1f8d7cb::events::config_enabled(0x2::object::id<Config<T0>>(arg1), arg2);
    }

    public(friend) fun set_protocol_recipient<T0>(arg0: &0x884a8aceda89be24b53443769e868106084628dc2eb140ebc7059a8be21125f4::admin::AdminCap, arg1: &mut Config<T0>, arg2: address) {
        assert!(arg2 != @0x0, 0);
        arg1.protocol_recipient = arg2;
        0x5730c8057176d795fea629033ec1ecedf801fcc6a39c540c9be63a8fd1f8d7cb::events::protocol_recipient_set(0x2::object::id<Config<T0>>(arg1), arg2);
    }

    public(friend) fun tick_spacing<T0>(arg0: &Config<T0>) : u32 {
        arg0.tick_spacing
    }

    // decompiled from Move bytecode v7
}

