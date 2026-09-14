module 0x44a18be0f62cb053258fc2df59069f2e5c74e5c7d0a075c191ba3b0412475fc8::bonding_curve {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Pool<phantom T0> has store, key {
        id: 0x2::object::UID,
        creator: address,
        name: 0x1::string::String,
        symbol: 0x1::string::String,
        icon_url: 0x1::string::String,
        description: 0x1::string::String,
        sui_reserve: 0x2::balance::Balance<0x2::sui::SUI>,
        token_reserve: 0x2::balance::Balance<T0>,
        creator_fee_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        platform_fee_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        virtual_sui: u64,
        graduation_threshold: u64,
        graduated: bool,
        total_volume_sui: u64,
    }

    struct PoolCreated has copy, drop {
        pool_id: address,
        creator: address,
        name: 0x1::string::String,
        symbol: 0x1::string::String,
        virtual_sui: u64,
        graduation_threshold: u64,
        initial_token_supply: u64,
    }

    struct TradeExecuted has copy, drop {
        pool_id: address,
        trader: address,
        is_buy: bool,
        sui_amount: u64,
        token_amount: u64,
        fee_amount: u64,
        creator_fee: u64,
        new_sui_reserve: u64,
        new_token_reserve: u64,
    }

    struct FeesClaimed has copy, drop {
        pool_id: address,
        recipient: address,
        amount: u64,
        is_creator: bool,
    }

    struct Graduated has copy, drop {
        pool_id: address,
        final_sui_reserve: u64,
    }

    struct GraduationExtracted has copy, drop {
        pool_id: address,
        sui_amount: u64,
        token_amount: u64,
    }

    public fun buy<T0>(arg0: &mut Pool<T0>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(!arg0.graduated, 3);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 > 0, 5);
        let v1 = mul_div(v0, 100, 10000);
        let v2 = mul_div(v1, 6000, 10000);
        let v3 = arg0.virtual_sui + 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve);
        let v4 = 0x2::balance::value<T0>(&arg0.token_reserve);
        let v5 = (((v3 as u128) * (v4 as u128) / ((v3 + v0 - v1) as u128)) as u64);
        let v6 = v4 - v5;
        assert!(v6 >= arg2, 4);
        let v7 = 0x2::coin::into_balance<0x2::sui::SUI>(arg1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.creator_fee_balance, 0x2::balance::split<0x2::sui::SUI>(&mut v7, v2));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.platform_fee_balance, 0x2::balance::split<0x2::sui::SUI>(&mut v7, v1 - v2));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_reserve, v7);
        arg0.total_volume_sui = arg0.total_volume_sui + v0;
        let v8 = 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve);
        maybe_graduate<T0>(arg0, v8);
        let v9 = TradeExecuted{
            pool_id           : 0x2::object::uid_to_address(&arg0.id),
            trader            : 0x2::tx_context::sender(arg3),
            is_buy            : true,
            sui_amount        : v0,
            token_amount      : v6,
            fee_amount        : v1,
            creator_fee       : v2,
            new_sui_reserve   : v8,
            new_token_reserve : v5,
        };
        0x2::event::emit<TradeExecuted>(v9);
        0x2::coin::take<T0>(&mut arg0.token_reserve, v6, arg3)
    }

    public fun claim_creator_fees<T0>(arg0: &mut Pool<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(0x2::tx_context::sender(arg1) == arg0.creator, 0);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.creator_fee_balance);
        assert!(v0 > 0, 2);
        let v1 = FeesClaimed{
            pool_id    : 0x2::object::uid_to_address(&arg0.id),
            recipient  : arg0.creator,
            amount     : v0,
            is_creator : true,
        };
        0x2::event::emit<FeesClaimed>(v1);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.creator_fee_balance, v0), arg1)
    }

    public fun claim_platform_fees<T0>(arg0: &mut Pool<T0>, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.platform_fee_balance);
        assert!(v0 > 0, 2);
        let v1 = FeesClaimed{
            pool_id    : 0x2::object::uid_to_address(&arg0.id),
            recipient  : 0x2::tx_context::sender(arg2),
            amount     : v0,
            is_creator : false,
        };
        0x2::event::emit<FeesClaimed>(v1);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.platform_fee_balance, v0), arg2)
    }

    public fun create_pool<T0>(arg0: 0x2::coin::TreasuryCap<T0>, arg1: &0x2::coin::CoinMetadata<T0>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) : Pool<T0> {
        let v0 = 0x2::coin::get_icon_url<T0>(arg1);
        let v1 = if (0x1::option::is_some<0x2::url::Url>(&v0)) {
            let v2 = 0x1::option::destroy_some<0x2::url::Url>(0x2::coin::get_icon_url<T0>(arg1));
            0x1::string::from_ascii(0x2::url::inner_url(&v2))
        } else {
            0x1::string::utf8(b"")
        };
        let v3 = Pool<T0>{
            id                   : 0x2::object::new(arg6),
            creator              : 0x2::tx_context::sender(arg6),
            name                 : 0x2::coin::get_name<T0>(arg1),
            symbol               : 0x1::string::from_ascii(0x2::coin::get_symbol<T0>(arg1)),
            icon_url             : v1,
            description          : arg5,
            sui_reserve          : 0x2::balance::zero<0x2::sui::SUI>(),
            token_reserve        : 0x2::coin::into_balance<T0>(arg2),
            creator_fee_balance  : 0x2::balance::zero<0x2::sui::SUI>(),
            platform_fee_balance : 0x2::balance::zero<0x2::sui::SUI>(),
            virtual_sui          : arg3,
            graduation_threshold : arg4,
            graduated            : false,
            total_volume_sui     : 0,
        };
        let v4 = PoolCreated{
            pool_id              : 0x2::object::uid_to_address(&v3.id),
            creator              : v3.creator,
            name                 : v3.name,
            symbol               : v3.symbol,
            virtual_sui          : arg3,
            graduation_threshold : arg4,
            initial_token_supply : 0x2::coin::value<T0>(&arg2),
        };
        0x2::event::emit<PoolCreated>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<T0>>(arg0);
        v3
    }

    public fun creator_fees_available<T0>(arg0: &Pool<T0>) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.creator_fee_balance)
    }

    public fun extract_for_graduation<T0>(arg0: &mut Pool<T0>, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<T0>) {
        assert!(arg0.graduated, 6);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve);
        let v1 = 0x2::balance::value<T0>(&arg0.token_reserve);
        let v2 = GraduationExtracted{
            pool_id      : 0x2::object::uid_to_address(&arg0.id),
            sui_amount   : v0,
            token_amount : v1,
        };
        0x2::event::emit<GraduationExtracted>(v2);
        (0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_reserve, v0), arg2), 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.token_reserve, v1), arg2))
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun is_graduated<T0>(arg0: &Pool<T0>) : bool {
        arg0.graduated
    }

    fun maybe_graduate<T0>(arg0: &mut Pool<T0>, arg1: u64) {
        if (!arg0.graduated && arg1 >= arg0.graduation_threshold) {
            arg0.graduated = true;
            let v0 = Graduated{
                pool_id           : 0x2::object::uid_to_address(&arg0.id),
                final_sui_reserve : arg1,
            };
            0x2::event::emit<Graduated>(v0);
        };
    }

    fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    public fun quote_buy<T0>(arg0: &Pool<T0>, arg1: u64) : u64 {
        let v0 = arg0.virtual_sui + 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve);
        let v1 = 0x2::balance::value<T0>(&arg0.token_reserve);
        v1 - (((v0 as u128) * (v1 as u128) / ((v0 + arg1 - mul_div(arg1, 100, 10000)) as u128)) as u64)
    }

    public fun reserves<T0>(arg0: &Pool<T0>) : (u64, u64, u64) {
        (arg0.virtual_sui, 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve), 0x2::balance::value<T0>(&arg0.token_reserve))
    }

    public fun sell<T0>(arg0: &mut Pool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(!arg0.graduated, 3);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 5);
        let v1 = arg0.virtual_sui + 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve);
        let v2 = 0x2::balance::value<T0>(&arg0.token_reserve);
        let v3 = v1 - (((v1 as u128) * (v2 as u128) / ((v2 + v0) as u128)) as u64);
        let v4 = 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve);
        let v5 = if (v3 > v4) {
            v4
        } else {
            v3
        };
        let v6 = mul_div(v5, 100, 10000);
        let v7 = mul_div(v6, 6000, 10000);
        let v8 = v5 - v6;
        assert!(v8 >= arg2, 4);
        0x2::balance::join<T0>(&mut arg0.token_reserve, 0x2::coin::into_balance<T0>(arg1));
        let v9 = 0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_reserve, v5);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.creator_fee_balance, 0x2::balance::split<0x2::sui::SUI>(&mut v9, v7));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.platform_fee_balance, 0x2::balance::split<0x2::sui::SUI>(&mut v9, v6 - v7));
        arg0.total_volume_sui = arg0.total_volume_sui + v5;
        let v10 = TradeExecuted{
            pool_id           : 0x2::object::uid_to_address(&arg0.id),
            trader            : 0x2::tx_context::sender(arg3),
            is_buy            : false,
            sui_amount        : v8,
            token_amount      : v0,
            fee_amount        : v6,
            creator_fee       : v7,
            new_sui_reserve   : 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve),
            new_token_reserve : 0x2::balance::value<T0>(&arg0.token_reserve),
        };
        0x2::event::emit<TradeExecuted>(v10);
        0x2::coin::from_balance<0x2::sui::SUI>(v9, arg3)
    }

    // decompiled from Move bytecode v7
}

