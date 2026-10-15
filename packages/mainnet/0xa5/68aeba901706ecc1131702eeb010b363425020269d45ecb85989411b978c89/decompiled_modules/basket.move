module 0xa568aeba901706ecc1131702eeb010b363425020269d45ecb85989411b978c89::basket {
    struct Config has key {
        id: 0x2::object::UID,
        fee_bps: u64,
        fee_to: address,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Basket has key {
        id: 0x2::object::UID,
        creator: address,
        name: 0x1::string::String,
        fee_bps: u64,
        assets: vector<0x1::type_name::TypeName>,
        balances: 0x2::bag::Bag,
        total: u64,
        locked: bool,
    }

    struct Share has store, key {
        id: 0x2::object::UID,
        basket: 0x2::object::ID,
        amount: u64,
    }

    struct Draft {
        creator: address,
        name: 0x1::string::String,
        fee_bps: u64,
        assets: vector<0x1::type_name::TypeName>,
        balances: 0x2::bag::Bag,
    }

    struct MintTicket {
        basket: 0x2::object::ID,
        shares: u64,
        paid: vector<0x1::type_name::TypeName>,
    }

    struct RedeemTicket {
        basket: 0x2::object::ID,
        shares: u64,
        total_before: u64,
        taken: vector<0x1::type_name::TypeName>,
    }

    struct BasketCreated has copy, drop {
        basket: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
        assets: vector<0x1::type_name::TypeName>,
        fee_bps: u64,
        shares: u64,
    }

    struct Minted has copy, drop {
        basket: 0x2::object::ID,
        who: address,
        shares: u64,
        to_creator: u64,
        to_viper: u64,
        total: u64,
    }

    struct Redeemed has copy, drop {
        basket: 0x2::object::ID,
        who: address,
        shares: u64,
        to_creator: u64,
        to_viper: u64,
        total: u64,
    }

    struct FeeChanged has copy, drop {
        fee_bps: u64,
        fee_to: address,
    }

    public fun join(arg0: &mut Share, arg1: Share) {
        let Share {
            id     : v0,
            basket : v1,
            amount : v2,
        } = arg1;
        assert!(v1 == arg0.basket, 8);
        0x2::object::delete(v0);
        arg0.amount = arg0.amount + v2;
    }

    public fun split(arg0: &mut Share, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : Share {
        assert!(arg1 > 0 && arg1 <= arg0.amount, 11);
        arg0.amount = arg0.amount - arg1;
        Share{
            id     : 0x2::object::new(arg2),
            basket : arg0.basket,
            amount : arg1,
        }
    }

    public fun value(arg0: &Share) : u64 {
        arg0.amount
    }

    public fun assets(arg0: &Basket) : vector<0x1::type_name::TypeName> {
        arg0.assets
    }

    public fun balance_of<T0>(arg0: &Basket) : u64 {
        let v0 = 0x1::type_name::with_original_ids<T0>();
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v0)) {
            return 0
        };
        0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.balances, v0))
    }

    public fun basket_id(arg0: &Share) : 0x2::object::ID {
        arg0.basket
    }

    public fun begin_mint(arg0: &mut Basket, arg1: u64) : MintTicket {
        assert!(!arg0.locked, 13);
        assert!(arg1 > 0, 16);
        arg0.locked = true;
        MintTicket{
            basket : 0x2::object::id<Basket>(arg0),
            shares : arg1,
            paid   : 0x1::vector::empty<0x1::type_name::TypeName>(),
        }
    }

    public fun begin_redeem(arg0: &mut Basket, arg1: &Config, arg2: Share, arg3: &mut 0x2::tx_context::TxContext) : RedeemTicket {
        assert!(!arg0.locked, 13);
        let Share {
            id     : v0,
            basket : v1,
            amount : v2,
        } = arg2;
        0x2::object::delete(v0);
        assert!(v1 == 0x2::object::id<Basket>(arg0), 8);
        assert!(v2 > 0, 16);
        let (v3, v4) = pay_fees(arg0, arg1, v2, arg3);
        let v5 = v2 - v3 - v4;
        arg0.total = arg0.total - v5;
        arg0.locked = true;
        let v6 = Redeemed{
            basket     : v1,
            who        : 0x2::tx_context::sender(arg3),
            shares     : v5,
            to_creator : v3,
            to_viper   : v4,
            total      : arg0.total,
        };
        0x2::event::emit<Redeemed>(v6);
        RedeemTicket{
            basket       : v1,
            shares       : v5,
            total_before : arg0.total,
            taken        : 0x1::vector::empty<0x1::type_name::TypeName>(),
        }
    }

    fun ceil_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = (arg2 as u128);
        ((((arg0 as u128) * (arg1 as u128) + v0 - 1) / v0) as u64)
    }

    public fun config_fee(arg0: &Config) : (u64, address) {
        (arg0.fee_bps, arg0.fee_to)
    }

    public fun creator(arg0: &Basket) : address {
        arg0.creator
    }

    public fun destroy_zero(arg0: Share) {
        let Share {
            id     : v0,
            basket : _,
            amount : v2,
        } = arg0;
        assert!(v2 == 0, 4);
        0x2::object::delete(v0);
    }

    public fun draft_add<T0>(arg0: &mut Draft, arg1: 0x2::coin::Coin<T0>) {
        let v0 = 0x1::type_name::with_original_ids<T0>();
        assert!(!0x1::vector::contains<0x1::type_name::TypeName>(&arg0.assets, &v0), 3);
        assert!(0x1::vector::length<0x1::type_name::TypeName>(&arg0.assets) < 8, 2);
        assert!(0x2::coin::value<T0>(&arg1) > 0, 4);
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg0.assets, v0);
        0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0, 0x2::coin::into_balance<T0>(arg1));
    }

    public fun fee_bps(arg0: &Basket) : u64 {
        arg0.fee_bps
    }

    public fun finish_draft(arg0: Draft, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : Share {
        let Draft {
            creator  : v0,
            name     : v1,
            fee_bps  : v2,
            assets   : v3,
            balances : v4,
        } = arg0;
        let v5 = v3;
        assert!(0x1::vector::length<0x1::type_name::TypeName>(&v5) >= 2, 1);
        assert!(arg1 > 1000, 7);
        let v6 = Basket{
            id       : 0x2::object::new(arg2),
            creator  : v0,
            name     : v1,
            fee_bps  : v2,
            assets   : v5,
            balances : v4,
            total    : arg1,
            locked   : false,
        };
        let v7 = 0x2::object::id<Basket>(&v6);
        let v8 = BasketCreated{
            basket  : v7,
            creator : v0,
            name    : v6.name,
            assets  : v6.assets,
            fee_bps : v2,
            shares  : arg1,
        };
        0x2::event::emit<BasketCreated>(v8);
        0x2::transfer::share_object<Basket>(v6);
        Share{
            id     : 0x2::object::new(arg2),
            basket : v7,
            amount : arg1 - 1000,
        }
    }

    public fun finish_mint(arg0: &mut Basket, arg1: &Config, arg2: MintTicket, arg3: &mut 0x2::tx_context::TxContext) : Share {
        let MintTicket {
            basket : v0,
            shares : v1,
            paid   : v2,
        } = arg2;
        let v3 = v2;
        assert!(v0 == 0x2::object::id<Basket>(arg0), 8);
        assert!(0x1::vector::length<0x1::type_name::TypeName>(&v3) == 0x1::vector::length<0x1::type_name::TypeName>(&arg0.assets), 12);
        arg0.total = arg0.total + v1;
        arg0.locked = false;
        let (v4, v5) = pay_fees(arg0, arg1, v1, arg3);
        let v6 = Minted{
            basket     : v0,
            who        : 0x2::tx_context::sender(arg3),
            shares     : v1,
            to_creator : v4,
            to_viper   : v5,
            total      : arg0.total,
        };
        0x2::event::emit<Minted>(v6);
        Share{
            id     : 0x2::object::new(arg3),
            basket : v0,
            amount : v1 - v4 - v5,
        }
    }

    public fun finish_redeem(arg0: &mut Basket, arg1: RedeemTicket) {
        let RedeemTicket {
            basket       : v0,
            shares       : _,
            total_before : _,
            taken        : v3,
        } = arg1;
        let v4 = v3;
        assert!(v0 == 0x2::object::id<Basket>(arg0), 8);
        assert!(0x1::vector::length<0x1::type_name::TypeName>(&v4) == 0x1::vector::length<0x1::type_name::TypeName>(&arg0.assets), 15);
        arg0.locked = false;
    }

    fun floor_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Config{
            id      : 0x2::object::new(arg0),
            fee_bps : 30,
            fee_to  : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<Config>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun is_locked(arg0: &Basket) : bool {
        arg0.locked
    }

    public fun mint_cost<T0>(arg0: &Basket, arg1: u64) : u64 {
        ceil_div(balance_of<T0>(arg0), arg1, arg0.total)
    }

    public fun mint_deposit<T0>(arg0: &mut Basket, arg1: &mut MintTicket, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg1.basket == 0x2::object::id<Basket>(arg0), 8);
        let v0 = 0x1::type_name::with_original_ids<T0>();
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&arg0.assets, &v0), 9);
        assert!(!0x1::vector::contains<0x1::type_name::TypeName>(&arg1.paid, &v0), 10);
        let v1 = ceil_div(balance_of<T0>(arg0), arg1.shares, arg0.total);
        assert!(0x2::coin::value<T0>(&arg2) >= v1, 11);
        0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0), 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg2, v1, arg3)));
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg1.paid, v0);
        arg2
    }

    fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    public fun name(arg0: &Basket) : 0x1::string::String {
        arg0.name
    }

    public fun new_draft(arg0: vector<u8>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : Draft {
        assert!(arg1 <= 100, 5);
        let v0 = 0x1::string::utf8(arg0);
        assert!(0x1::string::length(&v0) <= 40, 6);
        Draft{
            creator  : 0x2::tx_context::sender(arg2),
            name     : v0,
            fee_bps  : arg1,
            assets   : 0x1::vector::empty<0x1::type_name::TypeName>(),
            balances : 0x2::bag::new(arg2),
        }
    }

    fun pay_fees(arg0: &Basket, arg1: &Config, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        let v0 = mul_div(arg2, arg0.fee_bps, 10000);
        let v1 = mul_div(arg2, arg1.fee_bps, 10000);
        let v2 = 0x2::object::id<Basket>(arg0);
        if (v0 > 0) {
            let v3 = Share{
                id     : 0x2::object::new(arg3),
                basket : v2,
                amount : v0,
            };
            0x2::transfer::public_transfer<Share>(v3, arg0.creator);
        };
        if (v1 > 0) {
            let v4 = Share{
                id     : 0x2::object::new(arg3),
                basket : v2,
                amount : v1,
            };
            0x2::transfer::public_transfer<Share>(v4, arg1.fee_to);
        };
        (v0, v1)
    }

    public fun redeem_take<T0>(arg0: &mut Basket, arg1: &mut RedeemTicket, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg1.basket == 0x2::object::id<Basket>(arg0), 8);
        let v0 = 0x1::type_name::with_original_ids<T0>();
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&arg0.assets, &v0), 9);
        assert!(!0x1::vector::contains<0x1::type_name::TypeName>(&arg1.taken, &v0), 14);
        let v1 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0);
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg1.taken, v0);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v1, floor_div(0x2::balance::value<T0>(v1), arg1.shares, arg1.total_before)), arg2)
    }

    public fun redeem_value<T0>(arg0: &Basket, arg1: u64) : u64 {
        floor_div(balance_of<T0>(arg0), arg1, arg0.total)
    }

    public fun set_fee(arg0: &AdminCap, arg1: &mut Config, arg2: u64, arg3: address) {
        assert!(arg2 <= 100, 5);
        arg1.fee_bps = arg2;
        arg1.fee_to = arg3;
        let v0 = FeeChanged{
            fee_bps : arg2,
            fee_to  : arg3,
        };
        0x2::event::emit<FeeChanged>(v0);
    }

    public fun total(arg0: &Basket) : u64 {
        arg0.total
    }

    // decompiled from Move bytecode v7
}

