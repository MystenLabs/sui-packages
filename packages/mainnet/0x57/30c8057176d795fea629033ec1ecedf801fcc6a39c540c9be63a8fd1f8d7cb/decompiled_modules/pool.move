module 0x5730c8057176d795fea629033ec1ecedf801fcc6a39c540c9be63a8fd1f8d7cb::pool {
    struct Pool<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        config_id: 0x2::object::ID,
        creator: address,
        creator_recipient: address,
        token_decimals: u8,
        total_supply: u64,
        tokens: 0x2::balance::Balance<T0>,
        quote: 0x2::balance::Balance<T1>,
        creator_fees: 0x2::balance::Balance<T1>,
        protocol_fees: 0x2::balance::Balance<T1>,
        phantom_quote: u64,
        graduation_quote: u64,
        reserved_tokens: u64,
        base_fee_bps: u64,
        creator_share_bps: u64,
        creator_tax_bps: u64,
        anti_snipe: bool,
        tick_spacing: u32,
        created_at_ms: u64,
        state: u8,
        sequence: u64,
        cetus_pool_id: 0x1::option::Option<0x2::object::ID>,
        position_lock_id: 0x1::option::Option<0x2::object::ID>,
        cetus_creation_cap: 0x1::option::Option<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::PoolCreationCap>,
    }

    struct Snapshot has copy, drop {
        pool_id: 0x2::object::ID,
        config_id: 0x2::object::ID,
        state: u8,
        sequence: u64,
        creator: address,
        creator_recipient: address,
        token_reserve: u64,
        quote_reserve: u64,
        creator_fees: u64,
        protocol_fees: u64,
        phantom_quote: u64,
        graduation_quote: u64,
        reserved_tokens: u64,
        tick_spacing: u32,
        cetus_pool_id: 0x1::option::Option<0x2::object::ID>,
        position_lock_id: 0x1::option::Option<0x2::object::ID>,
    }

    fun accrue<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x2::balance::Balance<T1>, arg2: u64, arg3: u64) {
        let v0 = 0x5730c8057176d795fea629033ec1ecedf801fcc6a39c540c9be63a8fd1f8d7cb::math::mul_div(arg2, arg0.creator_tax_bps, 10000) + 0x5730c8057176d795fea629033ec1ecedf801fcc6a39c540c9be63a8fd1f8d7cb::math::mul_div(0x5730c8057176d795fea629033ec1ecedf801fcc6a39c540c9be63a8fd1f8d7cb::math::mul_div(arg2, arg0.base_fee_bps, 10000), arg0.creator_share_bps, 10000);
        0x2::balance::join<T1>(&mut arg0.creator_fees, 0x2::balance::split<T1>(arg1, v0));
        0x2::balance::join<T1>(&mut arg0.protocol_fees, 0x2::balance::split<T1>(arg1, arg3 - v0));
    }

    public(friend) fun buy<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, bool) {
        assert!(0x2::clock::timestamp_ms(arg4) <= arg3, 5);
        let (v0, _, v2, v3, v4) = quote_buy<T0, T1>(arg0, 0x2::coin::value<T1>(&arg1), 0x2::tx_context::sender(arg5), arg4);
        assert!(v2 >= arg2, 3);
        let v5 = 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg1, v0, arg5));
        let v6 = &mut v5;
        accrue<T0, T1>(arg0, v6, v0, v3);
        0x2::balance::join<T1>(&mut arg0.quote, v5);
        let v7 = 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.tokens, v2), arg5);
        emit<T0, T1>(arg0, 1, v0, v2, v3, arg4, arg5);
        (v7, arg1, v4)
    }

    public(friend) fun claim_creator<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::withdraw_all<T1>(&mut arg0.creator_fees);
        0x2::balance::send_funds<T1>(v0, arg0.creator_recipient);
        emit<T0, T1>(arg0, 4, 0, 0x2::balance::value<T1>(&v0), 0, arg1, arg2);
    }

    public(friend) fun claim_protocol<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x5730c8057176d795fea629033ec1ecedf801fcc6a39c540c9be63a8fd1f8d7cb::config::Config<T1>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::object::id<0x5730c8057176d795fea629033ec1ecedf801fcc6a39c540c9be63a8fd1f8d7cb::config::Config<T1>>(arg1) == arg0.config_id, 0);
        let v0 = 0x2::balance::withdraw_all<T1>(&mut arg0.protocol_fees);
        0x2::balance::send_funds<T1>(v0, 0x5730c8057176d795fea629033ec1ecedf801fcc6a39c540c9be63a8fd1f8d7cb::config::protocol_recipient<T1>(arg1));
        emit<T0, T1>(arg0, 5, 0, 0x2::balance::value<T1>(&v0), 0, arg2, arg3);
    }

    public(friend) fun create<T0, T1>(arg0: &0x5730c8057176d795fea629033ec1ecedf801fcc6a39c540c9be63a8fd1f8d7cb::config::Config<T1>, arg1: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::PoolCreationCap, arg2: 0x2::coin::TreasuryCap<T0>, arg3: &mut 0x2::coin_registry::Currency<T0>, arg4: u64, arg5: address, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : Pool<T0, T1> {
        create_impl<T0, T1>(arg0, 0x1::option::some<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::PoolCreationCap>(arg1), arg2, arg3, arg4, arg5, arg6, arg7)
    }

    fun create_impl<T0, T1>(arg0: &0x5730c8057176d795fea629033ec1ecedf801fcc6a39c540c9be63a8fd1f8d7cb::config::Config<T1>, arg1: 0x1::option::Option<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::PoolCreationCap>, arg2: 0x2::coin::TreasuryCap<T0>, arg3: &mut 0x2::coin_registry::Currency<T0>, arg4: u64, arg5: address, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : Pool<T0, T1> {
        let (v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10) = 0x5730c8057176d795fea629033ec1ecedf801fcc6a39c540c9be63a8fd1f8d7cb::config::launch_terms<T1>(arg0);
        assert!(v1, 1);
        assert!(0x1::type_name::with_original_ids<T0>() != 0x1::type_name::with_original_ids<T1>(), 0);
        assert!(0x2::coin::total_supply<T0>(&arg2) == 0, 2);
        assert!(0x2::coin_registry::decimals<T0>(arg3) == v2, 0);
        assert!(arg4 <= v8, 0);
        0x2::coin_registry::make_supply_fixed<T0>(arg3, arg2);
        let v11 = Pool<T0, T1>{
            id                 : 0x2::object::new(arg7),
            config_id          : v0,
            creator            : 0x2::tx_context::sender(arg7),
            creator_recipient  : or_creator(arg5, 0x2::tx_context::sender(arg7)),
            token_decimals     : v2,
            total_supply       : v3,
            tokens             : 0x2::coin::mint_balance<T0>(&mut arg2, v3),
            quote              : 0x2::balance::zero<T1>(),
            creator_fees       : 0x2::balance::zero<T1>(),
            protocol_fees      : 0x2::balance::zero<T1>(),
            phantom_quote      : v4,
            graduation_quote   : v5,
            reserved_tokens    : 0x5730c8057176d795fea629033ec1ecedf801fcc6a39c540c9be63a8fd1f8d7cb::math::mul_div_ceil(v3, v4, v4 + v5),
            base_fee_bps       : v6,
            creator_share_bps  : v7,
            creator_tax_bps    : arg4,
            anti_snipe         : v9,
            tick_spacing       : v10,
            created_at_ms      : 0x2::clock::timestamp_ms(arg6),
            state              : 0,
            sequence           : 0,
            cetus_pool_id      : 0x1::option::none<0x2::object::ID>(),
            position_lock_id   : 0x1::option::none<0x2::object::ID>(),
            cetus_creation_cap : arg1,
        };
        0x5730c8057176d795fea629033ec1ecedf801fcc6a39c540c9be63a8fd1f8d7cb::events::pool_created(0x2::object::id<Pool<T0, T1>>(&v11), v11.config_id, 0x1::type_name::with_original_ids<T0>(), 0x1::type_name::with_original_ids<T1>(), v11.creator, v11.creator_recipient, v11.token_decimals, v11.total_supply, v11.phantom_quote, v11.graduation_quote, v11.reserved_tokens, v11.base_fee_bps, v11.creator_share_bps, v11.creator_tax_bps, v11.anti_snipe, v11.tick_spacing, v11.created_at_ms, creation_cap_id(&v11.cetus_creation_cap));
        let v12 = &mut v11;
        emit<T0, T1>(v12, 0, 0, 0, 0, arg6, arg7);
        v11
    }

    fun creation_cap_id(arg0: &0x1::option::Option<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::PoolCreationCap>) : 0x1::option::Option<0x2::object::ID> {
        if (0x1::option::is_some<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::PoolCreationCap>(arg0)) {
            0x1::option::some<0x2::object::ID>(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::PoolCreationCap>(0x1::option::borrow<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::PoolCreationCap>(arg0)))
        } else {
            0x1::option::none<0x2::object::ID>()
        }
    }

    fun emit<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u8, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        arg0.sequence = arg0.sequence + 1;
        0x5730c8057176d795fea629033ec1ecedf801fcc6a39c540c9be63a8fd1f8d7cb::events::market(0x2::object::id<Pool<T0, T1>>(arg0), arg0.sequence, arg1, arg2, arg3, arg4, arg0.state, 0x2::balance::value<T0>(&arg0.tokens), 0x2::balance::value<T1>(&arg0.quote), 0x2::balance::value<T1>(&arg0.creator_fees), 0x2::balance::value<T1>(&arg0.protocol_fees), arg0.creator_recipient, 0x2::tx_context::sender(arg6), 0x2::clock::timestamp_ms(arg5));
    }

    public(friend) fun finish_graduation<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        arg0.state = 1;
        arg0.cetus_pool_id = 0x1::option::some<0x2::object::ID>(arg1);
        arg0.position_lock_id = 0x1::option::some<0x2::object::ID>(arg2);
        emit<T0, T1>(arg0, 3, 0, 0, 0, arg3, arg4);
    }

    public(friend) fun lp_fee_routing<T0, T1>(arg0: &Pool<T0, T1>, arg1: &0x5730c8057176d795fea629033ec1ecedf801fcc6a39c540c9be63a8fd1f8d7cb::config::Config<T1>, arg2: 0x2::object::ID) : (address, address) {
        assert!(arg0.state == 1, 7);
        assert!(arg0.position_lock_id == 0x1::option::some<0x2::object::ID>(arg2), 0);
        assert!(0x2::object::id<0x5730c8057176d795fea629033ec1ecedf801fcc6a39c540c9be63a8fd1f8d7cb::config::Config<T1>>(arg1) == arg0.config_id, 0);
        (arg0.creator_recipient, 0x5730c8057176d795fea629033ec1ecedf801fcc6a39c540c9be63a8fd1f8d7cb::config::protocol_recipient<T1>(arg1))
    }

    fun or_creator(arg0: address, arg1: address) : address {
        if (arg0 == @0x0) {
            arg1
        } else {
            arg0
        }
    }

    public(friend) fun quote_buy<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64, arg2: address, arg3: &0x2::clock::Clock) : (u64, u64, u64, u64, bool) {
        assert!(arg0.state == 0, 7);
        let v0 = 0x5730c8057176d795fea629033ec1ecedf801fcc6a39c540c9be63a8fd1f8d7cb::math::buy_fee_bps(arg0.base_fee_bps, arg0.creator_tax_bps, arg0.anti_snipe, arg0.created_at_ms, arg2 == arg0.creator, 0x2::clock::timestamp_ms(arg3));
        let v1 = arg1;
        let v2 = 0x5730c8057176d795fea629033ec1ecedf801fcc6a39c540c9be63a8fd1f8d7cb::math::mul_div(arg1, 10000 - v0, 10000);
        let v3 = v2;
        let v4 = arg0.graduation_quote - 0x2::balance::value<T1>(&arg0.quote);
        if (v2 > v4) {
            v3 = v4;
            v1 = 0x5730c8057176d795fea629033ec1ecedf801fcc6a39c540c9be63a8fd1f8d7cb::math::mul_div_ceil(v4, 10000, 10000 - v0);
        };
        assert!(v3 > 0, 4);
        let v5 = 0x5730c8057176d795fea629033ec1ecedf801fcc6a39c540c9be63a8fd1f8d7cb::math::mul_div(v3, 0x2::balance::value<T0>(&arg0.tokens), virtual_quote<T0, T1>(arg0) + v3);
        assert!(v5 > 0, 3);
        assert!(0x2::balance::value<T0>(&arg0.tokens) - v5 >= arg0.reserved_tokens, 2);
        (v1, v3, v5, v1 - v3, 0x2::balance::value<T1>(&arg0.quote) + v3 == arg0.graduation_quote)
    }

    public(friend) fun quote_sell<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64) : (u64, u64) {
        assert!(arg0.state == 0, 7);
        assert!(arg1 > 0, 4);
        let v0 = 0x5730c8057176d795fea629033ec1ecedf801fcc6a39c540c9be63a8fd1f8d7cb::math::mul_div(arg1, virtual_quote<T0, T1>(arg0), 0x2::balance::value<T0>(&arg0.tokens) + arg1);
        let v1 = 0x5730c8057176d795fea629033ec1ecedf801fcc6a39c540c9be63a8fd1f8d7cb::math::mul_div(v0, 10000 - arg0.base_fee_bps - arg0.creator_tax_bps, 10000);
        assert!(v1 > 0, 3);
        (v0, v1)
    }

    public(friend) fun sell<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(0x2::clock::timestamp_ms(arg4) <= arg3, 5);
        let v0 = 0x2::coin::value<T0>(&arg1);
        let (v1, v2) = quote_sell<T0, T1>(arg0, v0);
        assert!(v2 >= arg2, 3);
        0x2::balance::join<T0>(&mut arg0.tokens, 0x2::coin::into_balance<T0>(arg1));
        let v3 = 0x2::balance::split<T1>(&mut arg0.quote, v1);
        let v4 = &mut v3;
        accrue<T0, T1>(arg0, v4, v1, v1 - v2);
        emit<T0, T1>(arg0, 2, v0, v2, v1 - v2, arg4, arg5);
        0x2::coin::from_balance<T1>(v3, arg5)
    }

    public(friend) fun set_creator_recipient<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: address, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.creator, 6);
        claim_creator<T0, T1>(arg0, arg2, arg3);
        arg0.creator_recipient = or_creator(arg1, arg0.creator);
        emit<T0, T1>(arg0, 6, 0, 0, 0, arg2, arg3);
    }

    public(friend) fun share<T0, T1>(arg0: Pool<T0, T1>) {
        0x2::transfer::share_object<Pool<T0, T1>>(arg0);
    }

    public(friend) fun snapshot<T0, T1>(arg0: &Pool<T0, T1>) : Snapshot {
        Snapshot{
            pool_id           : 0x2::object::id<Pool<T0, T1>>(arg0),
            config_id         : arg0.config_id,
            state             : arg0.state,
            sequence          : arg0.sequence,
            creator           : arg0.creator,
            creator_recipient : arg0.creator_recipient,
            token_reserve     : 0x2::balance::value<T0>(&arg0.tokens),
            quote_reserve     : 0x2::balance::value<T1>(&arg0.quote),
            creator_fees      : 0x2::balance::value<T1>(&arg0.creator_fees),
            protocol_fees     : 0x2::balance::value<T1>(&arg0.protocol_fees),
            phantom_quote     : arg0.phantom_quote,
            graduation_quote  : arg0.graduation_quote,
            reserved_tokens   : arg0.reserved_tokens,
            tick_spacing      : arg0.tick_spacing,
            cetus_pool_id     : arg0.cetus_pool_id,
            position_lock_id  : arg0.position_lock_id,
        }
    }

    public(friend) fun take_creation_cap<T0, T1>(arg0: &mut Pool<T0, T1>) : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::PoolCreationCap {
        0x1::option::extract<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::PoolCreationCap>(&mut arg0.cetus_creation_cap)
    }

    public(friend) fun take_graduation_reserves<T0, T1>(arg0: &mut Pool<T0, T1>) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, u64, u32) {
        assert!(arg0.state == 0 && 0x2::balance::value<T1>(&arg0.quote) == arg0.graduation_quote, 7);
        (0x2::balance::withdraw_all<T0>(&mut arg0.tokens), 0x2::balance::withdraw_all<T1>(&mut arg0.quote), arg0.phantom_quote, arg0.tick_spacing)
    }

    fun virtual_quote<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.quote) + arg0.phantom_quote
    }

    // decompiled from Move bytecode v7
}

