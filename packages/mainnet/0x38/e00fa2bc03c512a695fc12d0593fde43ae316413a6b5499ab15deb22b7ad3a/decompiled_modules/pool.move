module 0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::pool {
    struct LSP<phantom T0, phantom T1> has drop {
        dummy_field: bool,
    }

    struct KdxLpToken<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
        lsp: 0x2::coin::Coin<LSP<T0, T1>>,
    }

    struct Pool<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        token_y: 0x2::balance::Balance<T1>,
        token_x: 0x2::balance::Balance<T0>,
        lsp_supply: 0x2::balance::Supply<LSP<T0, T1>>,
        lsp_locked: 0x2::balance::Balance<LSP<T0, T1>>,
        lp_fee_percent: u64,
        protocol_fee_percent: u64,
        protocol_fee_x: 0x2::balance::Balance<T0>,
        protocol_fee_y: 0x2::balance::Balance<T1>,
        is_stable: bool,
        scaleX: u64,
        scaleY: u64,
    }

    struct PoolCap has store, key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
    }

    struct PoolCreatedEvent has copy, drop {
        pool_id: 0x2::object::ID,
        creator: address,
        lp_fee_percent: u64,
        protocol_fee_percent: u64,
        is_stable: bool,
        scaleX: u64,
        scaleY: u64,
    }

    struct LiquidityAddedEvent has copy, drop {
        pool_id: 0x2::object::ID,
        liquidity_provider: address,
        amount_x: u64,
        amount_y: u64,
        reserve_x: u64,
        reserve_y: u64,
        lsp_minted: u64,
    }

    struct LiquidityRemovedEvent has copy, drop {
        pool_id: 0x2::object::ID,
        liquidity_provider: address,
        amount_x: u64,
        amount_y: u64,
        reserve_x: u64,
        reserve_y: u64,
        lsp_burned: u64,
    }

    struct SwapEvent<phantom T0> has copy, drop {
        pool_id: 0x2::object::ID,
        user: address,
        reserve_x: u64,
        reserve_y: u64,
        amount_in: u64,
        amount_out: u64,
    }

    public fun id<T0, T1>(arg0: &Pool<T0, T1>) : 0x2::object::ID {
        *0x2::object::uid_as_inner(&arg0.id)
    }

    public(friend) fun new<T0, T1>(arg0: &0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::default_config::DefaultConfig, arg1: bool, arg2: &0x2::coin::CoinMetadata<T0>, arg3: &0x2::coin::CoinMetadata<T1>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (Pool<T0, T1>, PoolCap) {
        let (v0, v1) = 0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::default_config::fee(arg0, arg1, arg4);
        assert!(((v0 + v1) as u128) <= 0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::constants::fee_scalling(), 0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::error::wrongFee());
        let v2 = LSP<T0, T1>{dummy_field: false};
        let v3 = Pool<T0, T1>{
            id                   : 0x2::object::new(arg5),
            token_y              : 0x2::balance::zero<T1>(),
            token_x              : 0x2::balance::zero<T0>(),
            lsp_supply           : 0x2::balance::create_supply<LSP<T0, T1>>(v2),
            lsp_locked           : 0x2::balance::zero<LSP<T0, T1>>(),
            lp_fee_percent       : v0,
            protocol_fee_percent : v1,
            protocol_fee_x       : 0x2::balance::zero<T0>(),
            protocol_fee_y       : 0x2::balance::zero<T1>(),
            is_stable            : arg1,
            scaleX               : get_scale_from_coinmetadata<T0>(arg2),
            scaleY               : get_scale_from_coinmetadata<T1>(arg3),
        };
        let (v4, v5, v6, v7, v8) = configs<T0, T1>(&v3);
        let v9 = PoolCreatedEvent{
            pool_id              : id<T0, T1>(&v3),
            creator              : 0x2::tx_context::sender(arg5),
            lp_fee_percent       : v4,
            protocol_fee_percent : v5,
            is_stable            : v6,
            scaleX               : v7,
            scaleY               : v8,
        };
        0x2::event::emit<PoolCreatedEvent>(v9);
        let v10 = PoolCap{
            id      : 0x2::object::new(arg5),
            pool_id : 0x2::object::id<Pool<T0, T1>>(&v3),
        };
        (v3, v10)
    }

    public fun transfer<T0, T1>(arg0: Pool<T0, T1>) {
        0x2::transfer::share_object<Pool<T0, T1>>(arg0);
    }

    public(friend) fun add_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) : (KdxLpToken<T0, T1>, 0x1::option::Option<0x2::coin::Coin<T0>>, 0x1::option::Option<0x2::coin::Coin<T1>>, 0x1::option::Option<LiquidityAddedEvent>) {
        let v0 = 0x2::coin::value<T0>(&arg2);
        let v1 = 0x2::coin::value<T1>(&arg1);
        assert!(v1 > 0 && v0 > 0, 0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::error::zeroAmount());
        let (v2, v3) = get_amount_for_add_liquidity<T0, T1>(arg0, v0, v1, arg4, arg3);
        let v4 = 0x1::option::none<0x2::coin::Coin<T0>>();
        let v5 = 0x1::option::none<0x2::coin::Coin<T1>>();
        if (v0 > v2) {
            0x1::option::fill<0x2::coin::Coin<T0>>(&mut v4, 0x2::coin::split<T0>(&mut arg2, v0 - v2, arg6));
        };
        if (v1 > v3) {
            0x1::option::fill<0x2::coin::Coin<T1>>(&mut v5, 0x2::coin::split<T1>(&mut arg1, v1 - v3, arg6));
        };
        let v6 = mint_lsp_token<T0, T1>(arg0, 0x2::coin::into_balance<T0>(arg2), 0x2::coin::into_balance<T1>(arg1), arg6);
        let (v7, v8, _) = get_reserves<T0, T1>(arg0);
        let v10 = KdxLpToken<T0, T1>{
            id      : 0x2::object::new(arg6),
            pool_id : *0x2::object::uid_as_inner(&arg0.id),
            lsp     : v6,
        };
        let v11 = if (arg5) {
            0x1::option::some<LiquidityAddedEvent>(emit_liquidity_added_event(*0x2::object::uid_as_inner(&arg0.id), 0x2::tx_context::sender(arg6), v2, v3, v8, v7, 0x2::coin::value<LSP<T0, T1>>(&v6)))
        } else {
            0x1::option::none<LiquidityAddedEvent>()
        };
        (v10, v4, v5, v11)
    }

    fun assert_lp_value_is_increased(arg0: bool, arg1: u64, arg2: u64, arg3: u128, arg4: u128, arg5: u128, arg6: u128) {
        if (arg0) {
            assert!(0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::utils::lp_value(arg5, arg1, arg6, arg2) > 0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::utils::lp_value(arg3, arg1, arg4, arg2), 0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::error::incorrectPoolConstantPostSwap());
        } else {
            assert!(arg5 * arg6 > arg3 * arg4, 0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::error::incorrectPoolConstantPostSwap());
        };
    }

    public(friend) fun claim_fee<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: u64, arg3: &0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::admin_access::AdminAccess, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        (0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.protocol_fee_x, arg1), arg4), 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.protocol_fee_y, arg2), arg4))
    }

    public fun configs<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64, bool, u64, u64) {
        (arg0.lp_fee_percent, arg0.protocol_fee_percent, arg0.is_stable, arg0.scaleX, arg0.scaleY)
    }

    fun emit_liquidity_added_event(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) : LiquidityAddedEvent {
        let v0 = LiquidityAddedEvent{
            pool_id            : arg0,
            liquidity_provider : arg1,
            amount_x           : arg2,
            amount_y           : arg3,
            reserve_x          : arg4,
            reserve_y          : arg5,
            lsp_minted         : arg6,
        };
        0x2::event::emit<LiquidityAddedEvent>(v0);
        v0
    }

    fun emit_liquidity_removed_event(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) : LiquidityRemovedEvent {
        let v0 = LiquidityRemovedEvent{
            pool_id            : arg0,
            liquidity_provider : arg1,
            amount_x           : arg2,
            amount_y           : arg3,
            reserve_x          : arg4,
            reserve_y          : arg5,
            lsp_burned         : arg6,
        };
        0x2::event::emit<LiquidityRemovedEvent>(v0);
        v0
    }

    fun emit_swap_event<T0>(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : SwapEvent<T0> {
        let v0 = SwapEvent<T0>{
            pool_id    : arg0,
            user       : arg1,
            reserve_x  : arg2,
            reserve_y  : arg3,
            amount_in  : arg4,
            amount_out : arg5,
        };
        0x2::event::emit<SwapEvent<T0>>(v0);
        v0
    }

    fun get_amount_for_add_liquidity<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : (u64, u64) {
        let (v0, v1, _) = get_reserves<T0, T1>(arg0);
        if (v1 == 0 && v0 == 0) {
            (arg1, arg2)
        } else {
            let v5 = get_token_amount_to_maintain_ratio(arg1, v1, v0);
            if (v5 <= arg2) {
                assert!(v5 >= arg4, 0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::error::liquidityInsufficientBAmount());
                (arg1, v5)
            } else {
                let v6 = get_token_amount_to_maintain_ratio(arg2, v0, v1);
                assert!(v6 <= arg1, 0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::error::liquidityOverLimitADesired());
                assert!(v6 >= arg3, 0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::error::liquidityInsufficientAAmount());
                (v6, arg2)
            }
        }
    }

    public fun get_pool_id(arg0: &PoolCap) : 0x2::object::ID {
        arg0.pool_id
    }

    public fun get_reserves<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64, u64) {
        (0x2::balance::value<T1>(&arg0.token_y), 0x2::balance::value<T0>(&arg0.token_x), 0x2::balance::supply_value<LSP<T0, T1>>(&arg0.lsp_supply))
    }

    fun get_scale_from_coinmetadata<T0>(arg0: &0x2::coin::CoinMetadata<T0>) : u64 {
        0x2::math::pow(10, 0x2::coin::get_decimals<T0>(arg0))
    }

    fun get_token_amount_to_maintain_ratio(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg0 > 0, 0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::error::amountZero());
        assert!(arg1 > 0 && arg2 > 0, 0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::error::reserveZero());
        (0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::safe_math::safe_mul_div_u64(arg0, arg2, arg1) as u64)
    }

    public fun is_stable<T0, T1>(arg0: &Pool<T0, T1>) : bool {
        arg0.is_stable
    }

    public fun lp_destroy_zero<T0, T1>(arg0: KdxLpToken<T0, T1>) {
        let KdxLpToken {
            id      : v0,
            pool_id : _,
            lsp     : v2,
        } = arg0;
        0x2::coin::destroy_zero<LSP<T0, T1>>(v2);
        0x2::object::delete(v0);
    }

    public fun lp_token_join<T0, T1>(arg0: &mut KdxLpToken<T0, T1>, arg1: KdxLpToken<T0, T1>) {
        assert!(arg0.pool_id == arg1.pool_id, 0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::error::invalidLPToken());
        let KdxLpToken {
            id      : v0,
            pool_id : _,
            lsp     : v2,
        } = arg1;
        0x2::object::delete(v0);
        0x2::coin::join<LSP<T0, T1>>(&mut arg0.lsp, v2);
    }

    public fun lp_token_pool_id<T0, T1>(arg0: &KdxLpToken<T0, T1>) : &0x2::object::ID {
        &arg0.pool_id
    }

    public fun lp_token_split<T0, T1>(arg0: &mut KdxLpToken<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : KdxLpToken<T0, T1> {
        KdxLpToken<T0, T1>{
            id      : 0x2::object::new(arg2),
            pool_id : arg0.pool_id,
            lsp     : 0x2::coin::split<LSP<T0, T1>>(&mut arg0.lsp, arg1, arg2),
        }
    }

    public fun lp_token_value<T0, T1>(arg0: &KdxLpToken<T0, T1>) : u64 {
        0x2::coin::value<LSP<T0, T1>>(&arg0.lsp)
    }

    fun mint_lsp_token<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: 0x2::balance::Balance<T1>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<LSP<T0, T1>> {
        let (v0, v1, _) = get_reserves<T0, T1>(arg0);
        let v3 = 0x2::balance::supply_value<LSP<T0, T1>>(&arg0.lsp_supply);
        let v4 = if (v3 == 0) {
            let v5 = (0x2::math::sqrt_u128((0x2::balance::value<T0>(&arg1) as u128) * (0x2::balance::value<T1>(&arg2) as u128)) as u64);
            assert!(v5 > 0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::constants::minimal_liquidity(), 0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::error::notEnoughInitialLiquidity());
            0x2::balance::join<LSP<T0, T1>>(&mut arg0.lsp_locked, 0x2::balance::increase_supply<LSP<T0, T1>>(&mut arg0.lsp_supply, 0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::constants::minimal_liquidity()));
            v5 - 0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::constants::minimal_liquidity()
        } else {
            0x2::math::min(0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::safe_math::safe_mul_div_u64(0x2::balance::value<T0>(&arg1), v3, v1), 0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::safe_math::safe_mul_div_u64(0x2::balance::value<T1>(&arg2), v3, v0))
        };
        assert!(v4 > 0, 0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::error::liquidityInsufficientMinted());
        0x2::balance::join<T0>(&mut arg0.token_x, arg1);
        0x2::balance::join<T1>(&mut arg0.token_y, arg2);
        0x2::coin::from_balance<LSP<T0, T1>>(0x2::balance::increase_supply<LSP<T0, T1>>(&mut arg0.lsp_supply, v4), arg3)
    }

    public fun read_liquidity_added_event(arg0: &LiquidityAddedEvent) : (0x2::object::ID, address, u64, u64, u64, u64, u64) {
        (arg0.pool_id, arg0.liquidity_provider, arg0.amount_x, arg0.amount_y, arg0.reserve_x, arg0.reserve_y, arg0.lsp_minted)
    }

    public fun read_liquidity_removed_event(arg0: &LiquidityRemovedEvent) : (0x2::object::ID, address, u64, u64, u64, u64, u64) {
        (arg0.pool_id, arg0.liquidity_provider, arg0.amount_x, arg0.amount_y, arg0.reserve_x, arg0.reserve_y, arg0.lsp_burned)
    }

    public fun read_swap_event<T0>(arg0: &SwapEvent<T0>) : (0x2::object::ID, address, u64, u64, u64, u64) {
        (arg0.pool_id, arg0.user, arg0.reserve_x, arg0.reserve_y, arg0.amount_in, arg0.amount_out)
    }

    public(friend) fun remove_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: KdxLpToken<T0, T1>, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x1::option::Option<LiquidityRemovedEvent>) {
        assert!(arg1.pool_id == *0x2::object::uid_as_inner(&arg0.id), 0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::error::invalidLPToken());
        assert!(lp_token_value<T0, T1>(&arg1) > 0, 0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::error::zeroAmount());
        let v0 = lp_token_value<T0, T1>(&arg1);
        let (v1, v2, v3) = get_reserves<T0, T1>(arg0);
        let v4 = 0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::safe_math::safe_mul_div_u64(v1, lp_token_value<T0, T1>(&arg1), v3);
        let v5 = 0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::safe_math::safe_mul_div_u64(v2, lp_token_value<T0, T1>(&arg1), v3);
        assert!(v4 > 0 && v5 > 0, 0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::error::zeroAmount());
        0x2::balance::decrease_supply<LSP<T0, T1>>(&mut arg0.lsp_supply, 0x2::coin::into_balance<LSP<T0, T1>>(0x2::coin::split<LSP<T0, T1>>(&mut arg1.lsp, v0, arg3)));
        let KdxLpToken {
            id      : v6,
            pool_id : _,
            lsp     : v8,
        } = arg1;
        0x2::object::delete(v6);
        0x2::coin::destroy_zero<LSP<T0, T1>>(v8);
        let (v9, v10, _) = get_reserves<T0, T1>(arg0);
        let v12 = if (arg2) {
            0x1::option::some<LiquidityRemovedEvent>(emit_liquidity_removed_event(*0x2::object::uid_as_inner(&arg0.id), 0x2::tx_context::sender(arg3), v5, v4, v10, v9, v0))
        } else {
            0x1::option::none<LiquidityRemovedEvent>()
        };
        (0x2::coin::take<T0>(&mut arg0.token_x, v5, arg3), 0x2::coin::take<T1>(&mut arg0.token_y, v4, arg3), v12)
    }

    public(friend) fun set_fee<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: u64, arg3: &0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::admin_access::AdminAccess) {
        arg0.lp_fee_percent = arg1;
        arg0.protocol_fee_percent = arg2;
    }

    public(friend) fun swap_token_x<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x1::option::Option<SwapEvent<T0>>) {
        assert!(0x2::coin::value<T0>(&arg1) > 0, 0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::error::zeroAmount());
        let v0 = 0x2::coin::into_balance<T0>(arg1);
        let (v1, v2, _) = get_reserves<T0, T1>(arg0);
        assert!(v1 > 0 && v2 > 0, 0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::error::reservesEmpty());
        let v4 = if (arg0.is_stable) {
            0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::utils::get_input_price_stable(0x2::balance::value<T0>(&v0), v2, v1, arg0.lp_fee_percent, arg0.scaleX, arg0.scaleY)
        } else {
            0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::utils::get_input_price_uncorrelated(0x2::balance::value<T0>(&v0), v2, v1, arg0.lp_fee_percent)
        };
        assert!(v4 >= arg2, 0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::error::swapOutLessthanExpected());
        0x2::balance::join<T0>(&mut arg0.token_x, v0);
        0x2::balance::join<T0>(&mut arg0.protocol_fee_x, 0x2::coin::into_balance<T0>(0x2::coin::take<T0>(&mut v0, (((0x2::balance::value<T0>(&v0) as u128) * (arg0.protocol_fee_percent as u128) / (0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::constants::fee_scalling() as u128)) as u64), arg4)));
        let (v5, v6, _) = get_reserves<T0, T1>(arg0);
        assert_lp_value_is_increased(arg0.is_stable, arg0.scaleX, arg0.scaleY, (v2 as u128), (v1 as u128), (v6 as u128), (v5 as u128));
        let v8 = if (arg3) {
            0x1::option::some<SwapEvent<T0>>(emit_swap_event<T0>(*0x2::object::uid_as_inner(&arg0.id), 0x2::tx_context::sender(arg4), v6, v5, 0x2::balance::value<T0>(&v0), v4))
        } else {
            0x1::option::none<SwapEvent<T0>>()
        };
        (0x2::coin::take<T1>(&mut arg0.token_y, v4, arg4), v8)
    }

    public(friend) fun swap_token_y<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x1::option::Option<SwapEvent<T1>>) {
        assert!(0x2::coin::value<T1>(&arg1) > 0, 0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::error::zeroAmount());
        let v0 = 0x2::coin::into_balance<T1>(arg1);
        let (v1, v2, _) = get_reserves<T0, T1>(arg0);
        assert!(v1 > 0 && v2 > 0, 0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::error::reservesEmpty());
        let v4 = if (arg0.is_stable) {
            0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::utils::get_input_price_stable(0x2::balance::value<T1>(&v0), v1, v2, arg0.lp_fee_percent, arg0.scaleY, arg0.scaleX)
        } else {
            0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::utils::get_input_price_uncorrelated(0x2::balance::value<T1>(&v0), v1, v2, arg0.lp_fee_percent)
        };
        assert!(v4 >= arg2, 0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::error::swapOutLessthanExpected());
        0x2::balance::join<T1>(&mut arg0.token_y, v0);
        0x2::balance::join<T1>(&mut arg0.protocol_fee_y, 0x2::coin::into_balance<T1>(0x2::coin::take<T1>(&mut v0, (((0x2::balance::value<T1>(&v0) as u128) * (arg0.protocol_fee_percent as u128) / 0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::constants::fee_scalling()) as u64), arg4)));
        let (v5, v6, _) = get_reserves<T0, T1>(arg0);
        assert_lp_value_is_increased(arg0.is_stable, arg0.scaleX, arg0.scaleY, (v2 as u128), (v1 as u128), (v6 as u128), (v5 as u128));
        let v8 = if (arg3) {
            0x1::option::some<SwapEvent<T1>>(emit_swap_event<T1>(*0x2::object::uid_as_inner(&arg0.id), 0x2::tx_context::sender(arg4), v6, v5, 0x2::balance::value<T1>(&v0), v4))
        } else {
            0x1::option::none<SwapEvent<T1>>()
        };
        (0x2::coin::take<T0>(&mut arg0.token_x, v4, arg4), v8)
    }

    // decompiled from Move bytecode v6
}

