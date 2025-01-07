module 0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::svim {
    struct SVIM has drop {
        dummy_field: bool,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct TreasuryCap<phantom T0> has store, key {
        id: 0x2::object::UID,
        total_supply: 0x2::balance::Supply<T0>,
        gons_per_fragment: u64,
        index: u64,
    }

    struct Coin<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
    }

    struct CoinMetadata<phantom T0> has store, key {
        id: 0x2::object::UID,
        decimals: u8,
        name: 0x1::string::String,
        symbol: 0x1::ascii::String,
        description: 0x1::string::String,
        icon_url: 0x1::option::Option<0x2::url::Url>,
    }

    struct CurrencyCreated<phantom T0> has copy, drop {
        decimals: u8,
    }

    struct InitEvent has copy, drop {
        sender: address,
        treasury_cap_id: 0x2::object::ID,
    }

    struct RebaseEvent has copy, drop {
        epoch_number: u64,
        rebase_amount: u64,
        index: u64,
        total_supply: u64,
        timestamp: u64,
    }

    public fun balance<T0>(arg0: &Coin<T0>) : &0x2::balance::Balance<T0> {
        &arg0.balance
    }

    public fun destroy_zero<T0>(arg0: Coin<T0>) {
        let Coin {
            id      : v0,
            balance : v1,
        } = arg0;
        0x2::object::delete(v0);
        0x2::balance::destroy_zero<T0>(v1);
    }

    public entry fun join<T0>(arg0: &mut Coin<T0>, arg1: Coin<T0>) {
        let Coin {
            id      : v0,
            balance : v1,
        } = arg1;
        0x2::object::delete(v0);
        0x2::balance::join<T0>(&mut arg0.balance, v1);
    }

    public fun split<T0>(arg0: &mut Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : Coin<T0> {
        let v0 = &mut arg0.balance;
        take<T0>(v0, arg1, arg2)
    }

    public fun value<T0>(arg0: &Coin<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun zero<T0>(arg0: &mut 0x2::tx_context::TxContext) : Coin<T0> {
        Coin<T0>{
            id      : 0x2::object::new(arg0),
            balance : 0x2::balance::zero<T0>(),
        }
    }

    public fun balance_mut<T0>(arg0: &mut Coin<T0>) : &mut 0x2::balance::Balance<T0> {
        &mut arg0.balance
    }

    public fun circulating_supply<T0>(arg0: &TreasuryCap<T0>, arg1: &0x2::balance::Balance<T0>) : u64 {
        (0x2::balance::supply_value<T0>(&arg0.total_supply) - 0x2::balance::value<T0>(arg1)) / arg0.gons_per_fragment
    }

    public fun create_currency<T0: drop>(arg0: T0, arg1: u8, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: 0x1::option::Option<0x2::url::Url>, arg6: &mut 0x2::tx_context::TxContext) : (TreasuryCap<T0>, CoinMetadata<T0>) {
        assert!(0x2::types::is_one_time_witness<T0>(&arg0), 0);
        let v0 = CurrencyCreated<T0>{decimals: arg1};
        0x2::event::emit<CurrencyCreated<T0>>(v0);
        let v1 = TreasuryCap<T0>{
            id                : 0x2::object::new(arg6),
            total_supply      : 0x2::balance::create_supply<T0>(arg0),
            gons_per_fragment : 0,
            index             : 0,
        };
        let v2 = CoinMetadata<T0>{
            id          : 0x2::object::new(arg6),
            decimals    : arg1,
            name        : 0x1::string::utf8(arg3),
            symbol      : 0x1::ascii::string(arg2),
            description : 0x1::string::utf8(arg4),
            icon_url    : arg5,
        };
        (v1, v2)
    }

    public fun from_balance<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) : Coin<T0> {
        Coin<T0>{
            id      : 0x2::object::new(arg1),
            balance : arg0,
        }
    }

    public fun get_decimals<T0>(arg0: &CoinMetadata<T0>) : u8 {
        arg0.decimals
    }

    public fun get_description<T0>(arg0: &CoinMetadata<T0>) : 0x1::string::String {
        arg0.description
    }

    public fun get_icon_url<T0>(arg0: &CoinMetadata<T0>) : 0x1::option::Option<0x2::url::Url> {
        arg0.icon_url
    }

    public fun get_name<T0>(arg0: &CoinMetadata<T0>) : 0x1::string::String {
        arg0.name
    }

    public fun get_symbol<T0>(arg0: &CoinMetadata<T0>) : 0x1::ascii::String {
        arg0.symbol
    }

    public fun gons_from_value<T0>(arg0: &TreasuryCap<T0>, arg1: u64) : u64 {
        arg0.gons_per_fragment * arg1
    }

    public fun index<T0>(arg0: &TreasuryCap<T0>) : u64 {
        arg0.index / arg0.gons_per_fragment
    }

    fun init(arg0: SVIM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = create_currency<SVIM>(arg0, 6, b"sVim", b"Staked Vim", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<CoinMetadata<SVIM>>(v1);
        0x2::transfer::public_share_object<TreasuryCap<SVIM>>(v2);
        let v3 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v3, 0x2::tx_context::sender(arg1));
        let v4 = InitEvent{
            sender          : 0x2::tx_context::sender(arg1),
            treasury_cap_id : 0x2::object::id<TreasuryCap<SVIM>>(&v2),
        };
        0x2::event::emit<InitEvent>(v4);
    }

    public(friend) fun initialize<T0>(arg0: &mut TreasuryCap<T0>) : 0x2::balance::Balance<T0> {
        assert!(arg0.gons_per_fragment == 0, 1);
        arg0.gons_per_fragment = 18446744000000000000 / 1000000000000;
        arg0.index = arg0.gons_per_fragment * 1000000;
        0x2::balance::increase_supply<T0>(&mut arg0.total_supply, 18446744000000000000)
    }

    public fun into_balance<T0>(arg0: Coin<T0>) : 0x2::balance::Balance<T0> {
        let Coin {
            id      : v0,
            balance : v1,
        } = arg0;
        0x2::object::delete(v0);
        v1
    }

    public(friend) fun rebase<T0>(arg0: u64, arg1: u64, arg2: &0x2::balance::Balance<T0>, arg3: &mut TreasuryCap<T0>, arg4: &0x2::clock::Clock) {
        let v0 = total_supply<T0>(arg3);
        let v1 = circulating_supply<T0>(arg3, arg2);
        if (arg0 == 0) {
            let v2 = RebaseEvent{
                epoch_number  : arg1,
                rebase_amount : 0,
                index         : index<T0>(arg3),
                total_supply  : v0,
                timestamp     : 0x2::clock::timestamp_ms(arg4) / 1000,
            };
            0x2::event::emit<RebaseEvent>(v2);
            return
        };
        let v3 = if (v1 > 0) {
            0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::math::safe_mul_div_u64(arg0, v0, v1)
        } else {
            arg0
        };
        let v4 = if (v0 + v3 > 4294967295000000) {
            v3 = 4294967295000000 - v0;
            4294967295000000
        } else {
            v0 + v3
        };
        arg3.gons_per_fragment = 18446744000000000000 / v4;
        let v5 = RebaseEvent{
            epoch_number  : arg1,
            rebase_amount : v3,
            index         : index<T0>(arg3),
            total_supply  : v4,
            timestamp     : 0x2::clock::timestamp_ms(arg4) / 1000,
        };
        0x2::event::emit<RebaseEvent>(v5);
    }

    public fun take<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : Coin<T0> {
        Coin<T0>{
            id      : 0x2::object::new(arg2),
            balance : 0x2::balance::split<T0>(arg0, arg1),
        }
    }

    public fun total_supply<T0>(arg0: &TreasuryCap<T0>) : u64 {
        0x2::balance::supply_value<T0>(&arg0.total_supply) / arg0.gons_per_fragment
    }

    public fun value_from_gons<T0>(arg0: &TreasuryCap<T0>, arg1: u64) : u64 {
        arg1 / arg0.gons_per_fragment
    }

    // decompiled from Move bytecode v6
}

