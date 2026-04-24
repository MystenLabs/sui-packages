module 0xb715bdeb40dac0119c31629f795b978b0aa40ecad425a00a0af886a5526ce380::token_registry {
    struct CreatorCap has store, key {
        id: 0x2::object::UID,
        token_id: 0x2::object::ID,
    }

    struct Token has key {
        id: 0x2::object::UID,
        name: vector<u8>,
        symbol: vector<u8>,
        decimals: u8,
        icon_url: vector<u8>,
        creator: address,
        total_supply: u64,
        is_active: bool,
        balances: 0x2::table::Table<address, u64>,
    }

    struct RedemptionVault<phantom T0> has key {
        id: 0x2::object::UID,
        token_id: 0x2::object::ID,
        reserve: 0x2::balance::Balance<T0>,
        rate_numerator: u64,
        rate_denominator: u64,
        opens_at: u64,
        closes_at: u64,
    }

    struct TokenCreated has copy, drop {
        token_id: 0x2::object::ID,
        name: vector<u8>,
        symbol: vector<u8>,
        decimals: u8,
        creator: address,
    }

    struct Minted has copy, drop {
        token_id: 0x2::object::ID,
        recipient: address,
        amount: u64,
        new_total_supply: u64,
    }

    struct Transferred has copy, drop {
        token_id: 0x2::object::ID,
        from: address,
        to: address,
        amount: u64,
    }

    struct Burned has copy, drop {
        token_id: 0x2::object::ID,
        from: address,
        amount: u64,
        new_total_supply: u64,
    }

    struct RedemptionOpened<phantom T0> has copy, drop {
        token_id: 0x2::object::ID,
        reserve_amount: u64,
        rate_numerator: u64,
        rate_denominator: u64,
        opens_at: u64,
        closes_at: u64,
    }

    struct Redeemed<phantom T0> has copy, drop {
        token_id: 0x2::object::ID,
        holder: address,
        token_amount: u64,
        reserve_amount: u64,
    }

    struct RedemptionClosed<phantom T0> has copy, drop {
        token_id: 0x2::object::ID,
        remaining_reserve: u64,
        burned_supply: u64,
    }

    public fun transfer(arg0: &mut Token, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.is_active, 2);
        assert!(arg2 > 0, 5);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = get_balance_internal(arg0, v0);
        assert!(v1 >= arg2, 1);
        set_balance_internal(arg0, v0, v1 - arg2);
        let v2 = get_balance_internal(arg0, arg1) + arg2;
        set_balance_internal(arg0, arg1, v2);
        let v3 = Transferred{
            token_id : 0x2::object::id<Token>(arg0),
            from     : v0,
            to       : arg1,
            amount   : arg2,
        };
        0x2::event::emit<Transferred>(v3);
    }

    public fun burn(arg0: &mut Token, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 5);
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = get_balance_internal(arg0, v0);
        assert!(v1 >= arg1, 1);
        set_balance_internal(arg0, v0, v1 - arg1);
        arg0.total_supply = arg0.total_supply - arg1;
        let v2 = Burned{
            token_id         : 0x2::object::id<Token>(arg0),
            from             : v0,
            amount           : arg1,
            new_total_supply : arg0.total_supply,
        };
        0x2::event::emit<Burned>(v2);
    }

    public fun burn_from(arg0: &CreatorCap, arg1: &mut Token, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.token_id == 0x2::object::id<Token>(arg1), 0);
        assert!(arg3 > 0, 5);
        let v0 = get_balance_internal(arg1, arg2);
        assert!(v0 >= arg3, 1);
        set_balance_internal(arg1, arg2, v0 - arg3);
        arg1.total_supply = arg1.total_supply - arg3;
        let v1 = Burned{
            token_id         : 0x2::object::id<Token>(arg1),
            from             : arg2,
            amount           : arg3,
            new_total_supply : arg1.total_supply,
        };
        0x2::event::emit<Burned>(v1);
    }

    public fun close_redemption<T0>(arg0: &CreatorCap, arg1: &mut Token, arg2: RedemptionVault<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.token_id == 0x2::object::id<Token>(arg1), 0);
        assert!(arg2.token_id == 0x2::object::id<Token>(arg1), 0);
        assert!(0x2::clock::timestamp_ms(arg3) >= arg2.closes_at, 6);
        let RedemptionVault {
            id               : v0,
            token_id         : _,
            reserve          : v2,
            rate_numerator   : _,
            rate_denominator : _,
            opens_at         : _,
            closes_at        : _,
        } = arg2;
        let v7 = v2;
        arg1.is_active = false;
        let v8 = RedemptionClosed<T0>{
            token_id          : 0x2::object::id<Token>(arg1),
            remaining_reserve : 0x2::balance::value<T0>(&v7),
            burned_supply     : arg1.total_supply,
        };
        0x2::event::emit<RedemptionClosed<T0>>(v8);
        0x2::object::delete(v0);
        0x2::coin::from_balance<T0>(v7, arg4)
    }

    public fun create_token(arg0: vector<u8>, arg1: vector<u8>, arg2: u8, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) : CreatorCap {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::object::new(arg4);
        let v2 = 0x2::object::uid_to_inner(&v1);
        let v3 = Token{
            id           : v1,
            name         : arg0,
            symbol       : arg1,
            decimals     : arg2,
            icon_url     : arg3,
            creator      : v0,
            total_supply : 0,
            is_active    : true,
            balances     : 0x2::table::new<address, u64>(arg4),
        };
        let v4 = TokenCreated{
            token_id : v2,
            name     : v3.name,
            symbol   : v3.symbol,
            decimals : arg2,
            creator  : v0,
        };
        0x2::event::emit<TokenCreated>(v4);
        0x2::transfer::share_object<Token>(v3);
        CreatorCap{
            id       : 0x2::object::new(arg4),
            token_id : v2,
        }
    }

    public fun get_balance(arg0: &Token, arg1: address) : u64 {
        get_balance_internal(arg0, arg1)
    }

    fun get_balance_internal(arg0: &Token, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.balances, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.balances, arg1)
        } else {
            0
        }
    }

    public fun get_metadata(arg0: &Token) : (vector<u8>, vector<u8>, u8, vector<u8>) {
        (arg0.name, arg0.symbol, arg0.decimals, arg0.icon_url)
    }

    public fun get_redemption_info<T0>(arg0: &RedemptionVault<T0>) : (u64, u64, u64, u64, u64) {
        (0x2::balance::value<T0>(&arg0.reserve), arg0.rate_numerator, arg0.rate_denominator, arg0.opens_at, arg0.closes_at)
    }

    public fun get_total_supply(arg0: &Token) : u64 {
        arg0.total_supply
    }

    public fun is_active(arg0: &Token) : bool {
        arg0.is_active
    }

    public fun mint(arg0: &CreatorCap, arg1: &mut Token, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.token_id == 0x2::object::id<Token>(arg1), 0);
        assert!(arg1.is_active, 2);
        assert!(arg3 > 0, 5);
        let v0 = get_balance_internal(arg1, arg2) + arg3;
        set_balance_internal(arg1, arg2, v0);
        arg1.total_supply = arg1.total_supply + arg3;
        let v1 = Minted{
            token_id         : 0x2::object::id<Token>(arg1),
            recipient        : arg2,
            amount           : arg3,
            new_total_supply : arg1.total_supply,
        };
        0x2::event::emit<Minted>(v1);
    }

    public fun open_redemption<T0>(arg0: &CreatorCap, arg1: &Token, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.token_id == 0x2::object::id<Token>(arg1), 0);
        assert!(arg4 > 0, 5);
        assert!(arg6 > arg5, 3);
        let v0 = 0x2::object::id<Token>(arg1);
        let v1 = RedemptionVault<T0>{
            id               : 0x2::object::new(arg7),
            token_id         : v0,
            reserve          : 0x2::coin::into_balance<T0>(arg2),
            rate_numerator   : arg3,
            rate_denominator : arg4,
            opens_at         : arg5,
            closes_at        : arg6,
        };
        let v2 = RedemptionOpened<T0>{
            token_id         : v0,
            reserve_amount   : 0x2::coin::value<T0>(&arg2),
            rate_numerator   : arg3,
            rate_denominator : arg4,
            opens_at         : arg5,
            closes_at        : arg6,
        };
        0x2::event::emit<RedemptionOpened<T0>>(v2);
        0x2::transfer::share_object<RedemptionVault<T0>>(v1);
    }

    public fun redeem<T0>(arg0: &mut Token, arg1: &mut RedemptionVault<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg1.token_id == 0x2::object::id<Token>(arg0), 0);
        assert!(arg2 > 0, 5);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(v0 >= arg1.opens_at && v0 < arg1.closes_at, 3);
        let v1 = 0x2::tx_context::sender(arg4);
        let v2 = get_balance_internal(arg0, v1);
        assert!(v2 >= arg2, 1);
        let v3 = (((arg2 as u128) * (arg1.rate_numerator as u128) / (arg1.rate_denominator as u128)) as u64);
        assert!(0x2::balance::value<T0>(&arg1.reserve) >= v3, 4);
        set_balance_internal(arg0, v1, v2 - arg2);
        arg0.total_supply = arg0.total_supply - arg2;
        let v4 = Redeemed<T0>{
            token_id       : 0x2::object::id<Token>(arg0),
            holder         : v1,
            token_amount   : arg2,
            reserve_amount : v3,
        };
        0x2::event::emit<Redeemed<T0>>(v4);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.reserve, v3), arg4)
    }

    fun set_balance_internal(arg0: &mut Token, arg1: address, arg2: u64) {
        if (0x2::table::contains<address, u64>(&arg0.balances, arg1)) {
            *0x2::table::borrow_mut<address, u64>(&mut arg0.balances, arg1) = arg2;
        } else if (arg2 > 0) {
            0x2::table::add<address, u64>(&mut arg0.balances, arg1, arg2);
        };
    }

    // decompiled from Move bytecode v6
}

