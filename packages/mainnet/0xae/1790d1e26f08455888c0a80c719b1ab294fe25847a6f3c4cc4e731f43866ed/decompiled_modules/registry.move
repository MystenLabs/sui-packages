module 0xae1790d1e26f08455888c0a80c719b1ab294fe25847a6f3c4cc4e731f43866ed::registry {
    struct REGISTRY has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Registry has key {
        id: 0x2::object::UID,
        supported_coins: vector<0x1::type_name::TypeName>,
        base_fee_rate: u64,
        platform_fee_rate: u64,
        creator_fee_rate: u64,
        ref_fee_rate: u64,
        resolver_collateral: u64,
        resolver_fee: u64,
        next_market_number: u64,
        markets: 0x2::bag::Bag,
    }

    public fun add_coin_type<T0>(arg0: &mut Registry, arg1: &AdminCap) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (!0x1::vector::contains<0x1::type_name::TypeName>(&arg0.supported_coins, &v0)) {
            0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg0.supported_coins, v0);
        };
    }

    public(friend) fun add_market(arg0: &mut Registry, arg1: u64, arg2: 0x2::object::ID) {
        assert!(!0x2::bag::contains<u64>(&arg0.markets, arg1), 2);
        0x2::bag::add<u64, 0x2::object::ID>(&mut arg0.markets, arg1, arg2);
    }

    public(friend) fun base_fee_rate(arg0: &Registry) : u64 {
        arg0.base_fee_rate
    }

    public(friend) fun creator_fee_rate(arg0: &Registry) : u64 {
        arg0.creator_fee_rate
    }

    public fun get_market_id(arg0: &Registry, arg1: u64) : 0x2::object::ID {
        assert!(0x2::bag::contains<u64>(&arg0.markets, arg1), 3);
        *0x2::bag::borrow<u64, 0x2::object::ID>(&arg0.markets, arg1)
    }

    public(friend) fun get_market_number(arg0: &mut Registry) : u64 {
        arg0.next_market_number = arg0.next_market_number + 1;
        arg0.next_market_number
    }

    fun init(arg0: REGISTRY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry{
            id                  : 0x2::object::new(arg1),
            supported_coins     : 0x1::vector::empty<0x1::type_name::TypeName>(),
            base_fee_rate       : 10000,
            platform_fee_rate   : 600,
            creator_fee_rate    : 250,
            ref_fee_rate        : 150,
            resolver_collateral : 750,
            resolver_fee        : 50,
            next_market_number  : 0,
            markets             : 0x2::bag::new(arg1),
        };
        assert!(v0.platform_fee_rate + v0.creator_fee_rate + v0.ref_fee_rate == 1000, 1);
        0x2::transfer::share_object<Registry>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v1, 0x2::tx_context::sender(arg1));
    }

    public(friend) fun platform_fee_rate(arg0: &Registry) : u64 {
        arg0.platform_fee_rate
    }

    public(friend) fun ref_fee_rate(arg0: &Registry) : u64 {
        arg0.ref_fee_rate
    }

    public(friend) fun resolver_collateral(arg0: &Registry) : u64 {
        arg0.resolver_collateral
    }

    public(friend) fun resolver_fee(arg0: &Registry) : u64 {
        arg0.resolver_fee
    }

    public fun set_base_fee_rate(arg0: &mut Registry, arg1: u64, arg2: &AdminCap) {
        assert!(arg1 <= 50000, 0);
        arg0.base_fee_rate = arg1;
    }

    public fun set_fee_rate(arg0: &mut Registry, arg1: u64, arg2: u64, arg3: u64, arg4: &AdminCap) {
        assert!(arg1 + arg2 + arg3 == 1000, 1);
        arg0.platform_fee_rate = arg1;
        arg0.creator_fee_rate = arg2;
        arg0.ref_fee_rate = arg3;
    }

    public fun set_resolver_collateral(arg0: &mut Registry, arg1: u64, arg2: &AdminCap) {
        arg0.resolver_collateral = arg1;
    }

    public fun set_resolver_fee(arg0: &mut Registry, arg1: u64, arg2: &AdminCap) {
        arg0.resolver_fee = arg1;
    }

    public(friend) fun supported_coins(arg0: &Registry) : vector<0x1::type_name::TypeName> {
        arg0.supported_coins
    }

    // decompiled from Move bytecode v6
}

