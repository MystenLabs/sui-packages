module 0xc13b4af41b57a80410a30c802f9b772f41c220382e5cb8fa48011085d91e9184::templates {
    struct Registry has key {
        id: 0x2::object::UID,
        version: u64,
        fee_bps: u64,
        revenue: 0x2::balance::Balance<0x2::sui::SUI>,
        burn_pot: 0x2::balance::Balance<0x2::sui::SUI>,
        ept_type: 0x1::option::Option<0x1::type_name::TypeName>,
        pool_id: 0x1::option::Option<0x2::object::ID>,
        sold: u64,
        volume: u64,
        burned: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Template has key {
        id: 0x2::object::UID,
        template_id: 0x1::string::String,
        digest: 0x1::string::String,
        author: address,
        price: u64,
        for_sale: bool,
        sold: u64,
        revenue: u64,
    }

    struct AuthorCap has store, key {
        id: 0x2::object::UID,
        template: 0x2::object::ID,
    }

    struct License has key {
        id: 0x2::object::UID,
        template: 0x2::object::ID,
        template_id: 0x1::string::String,
        buyer: address,
        paid: u64,
        at_ms: u64,
    }

    struct TemplateListed has copy, drop {
        template: 0x2::object::ID,
        template_id: 0x1::string::String,
        author: address,
        price: u64,
    }

    struct PriceChanged has copy, drop {
        template: 0x2::object::ID,
        old_price: u64,
        new_price: u64,
        for_sale: bool,
    }

    struct AuthorChanged has copy, drop {
        template: 0x2::object::ID,
        old_author: address,
        new_author: address,
    }

    struct TemplateSold has copy, drop {
        template: 0x2::object::ID,
        template_id: 0x1::string::String,
        buyer: address,
        author: address,
        price: u64,
        to_author: u64,
        to_protocol: u64,
        to_burn: u64,
        license: 0x2::object::ID,
    }

    struct EptBurned has copy, drop {
        sui_spent: u64,
        ept_burned: u64,
        caller: address,
    }

    struct FeeChanged has copy, drop {
        old_bps: u64,
        new_bps: u64,
    }

    struct BurnConfigSet has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        pool: 0x2::object::ID,
    }

    struct RevenueWithdrawn has copy, drop {
        amount: u64,
        to: address,
    }

    public fun author(arg0: &Template) : address {
        arg0.author
    }

    public fun author_cap_template(arg0: &AuthorCap) : 0x2::object::ID {
        arg0.template
    }

    public fun burn_configured(arg0: &Registry) : bool {
        0x1::option::is_some<0x1::type_name::TypeName>(&arg0.ept_type)
    }

    public fun burn_license(arg0: License) {
        let License {
            id          : v0,
            template    : _,
            template_id : _,
            buyer       : _,
            paid        : _,
            at_ms       : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun burn_pot_value(arg0: &Registry) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.burn_pot)
    }

    public fun burn_share_bps() : u64 {
        5000
    }

    public fun buy_template(arg0: &mut Registry, arg1: &mut Template, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: 0x1::string::String, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 0);
        assert!(arg1.for_sale && arg1.price > 0, 1);
        assert!(arg1.price <= arg3, 13);
        assert!(arg1.digest == arg4, 15);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= arg1.price, 2);
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(v0 != arg1.author, 6);
        let v1 = arg1.price;
        let v2 = 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, v1, arg6));
        if (0x2::coin::value<0x2::sui::SUI>(&arg2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, v0);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg2);
        };
        let v3 = v1 * arg0.fee_bps / 10000;
        let v4 = v3 * (10000 - 5000) / 10000;
        let v5 = v3 - v4;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.burn_pot, 0x2::balance::split<0x2::sui::SUI>(&mut v2, v5));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.revenue, 0x2::balance::split<0x2::sui::SUI>(&mut v2, v4));
        let v6 = 0x2::balance::value<0x2::sui::SUI>(&v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v2, arg6), arg1.author);
        let v7 = License{
            id          : 0x2::object::new(arg6),
            template    : 0x2::object::id<Template>(arg1),
            template_id : arg1.template_id,
            buyer       : v0,
            paid        : v1,
            at_ms       : 0x2::clock::timestamp_ms(arg5),
        };
        arg1.sold = arg1.sold + 1;
        arg1.revenue = arg1.revenue + v6;
        arg0.sold = arg0.sold + 1;
        arg0.volume = arg0.volume + v1;
        let v8 = TemplateSold{
            template    : 0x2::object::id<Template>(arg1),
            template_id : arg1.template_id,
            buyer       : v0,
            author      : arg1.author,
            price       : v1,
            to_author   : v6,
            to_protocol : v4,
            to_burn     : v5,
            license     : 0x2::object::id<License>(&v7),
        };
        0x2::event::emit<TemplateSold>(v8);
        0x2::transfer::transfer<License>(v7, v0);
    }

    public fun digest(arg0: &Template) : 0x1::string::String {
        arg0.digest
    }

    public fun fee_bps(arg0: &Registry) : u64 {
        arg0.fee_bps
    }

    public fun fee_bps_max() : u64 {
        300
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry{
            id       : 0x2::object::new(arg0),
            version  : 1,
            fee_bps  : 300,
            revenue  : 0x2::balance::zero<0x2::sui::SUI>(),
            burn_pot : 0x2::balance::zero<0x2::sui::SUI>(),
            ept_type : 0x1::option::none<0x1::type_name::TypeName>(),
            pool_id  : 0x1::option::none<0x2::object::ID>(),
            sold     : 0,
            volume   : 0,
            burned   : 0,
        };
        0x2::transfer::share_object<Registry>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun is_for_sale(arg0: &Template) : bool {
        arg0.for_sale
    }

    public fun license_buyer(arg0: &License) : address {
        arg0.buyer
    }

    public fun license_paid(arg0: &License) : u64 {
        arg0.paid
    }

    public fun license_template(arg0: &License) : 0x2::object::ID {
        arg0.template
    }

    public fun license_template_id(arg0: &License) : 0x1::string::String {
        arg0.template_id
    }

    public fun list_template(arg0: &Registry, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : AuthorCap {
        assert!(arg0.version == 1, 0);
        assert!(arg3 > 0, 5);
        assert!(arg3 <= 1000000000000000, 17);
        assert!(0x1::string::length(&arg1) > 0, 12);
        assert!(0x1::string::length(&arg1) <= 64, 16);
        assert!(0x1::string::length(&arg2) == 64, 15);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = Template{
            id          : 0x2::object::new(arg4),
            template_id : arg1,
            digest      : arg2,
            author      : v0,
            price       : arg3,
            for_sale    : true,
            sold        : 0,
            revenue     : 0,
        };
        let v2 = 0x2::object::id<Template>(&v1);
        let v3 = AuthorCap{
            id       : 0x2::object::new(arg4),
            template : v2,
        };
        let v4 = TemplateListed{
            template    : v2,
            template_id : v1.template_id,
            author      : v0,
            price       : arg3,
        };
        0x2::event::emit<TemplateListed>(v4);
        0x2::transfer::share_object<Template>(v1);
        v3
    }

    public fun migrate(arg0: &AdminCap, arg1: &mut Registry) {
        assert!(arg1.version < 1, 19);
        arg1.version = 1;
    }

    public fun price(arg0: &Template) : u64 {
        arg0.price
    }

    public fun quote(arg0: &Registry, arg1: u64) : (u64, u64, u64) {
        assert!(arg1 <= 1000000000000000, 17);
        let v0 = arg1 * arg0.fee_bps / 10000;
        let v1 = v0 * (10000 - 5000) / 10000;
        (arg1 - v0, v1, v0 - v1)
    }

    public fun revenue_value(arg0: &Registry) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.revenue)
    }

    public fun set_author(arg0: &AuthorCap, arg1: &mut Template, arg2: address) {
        assert!(arg0.template == 0x2::object::id<Template>(arg1), 4);
        assert!(arg2 != @0x0, 18);
        arg1.author = arg2;
        let v0 = AuthorChanged{
            template   : 0x2::object::id<Template>(arg1),
            old_author : arg1.author,
            new_author : arg2,
        };
        0x2::event::emit<AuthorChanged>(v0);
    }

    public fun set_burn_config<T0>(arg0: &AdminCap, arg1: &mut Registry, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>) {
        assert!(arg1.version == 1, 0);
        assert!(0x1::option::is_none<0x1::type_name::TypeName>(&arg1.ept_type) && 0x1::option::is_none<0x2::object::ID>(&arg1.pool_id), 14);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>>(arg2);
        arg1.ept_type = 0x1::option::some<0x1::type_name::TypeName>(v0);
        arg1.pool_id = 0x1::option::some<0x2::object::ID>(v1);
        let v2 = BurnConfigSet{
            coin_type : v0,
            pool      : v1,
        };
        0x2::event::emit<BurnConfigSet>(v2);
    }

    public fun set_fee(arg0: &AdminCap, arg1: &mut Registry, arg2: u64) {
        assert!(arg1.version == 1, 0);
        assert!(arg2 <= 300, 3);
        arg1.fee_bps = arg2;
        let v0 = FeeChanged{
            old_bps : arg1.fee_bps,
            new_bps : arg2,
        };
        0x2::event::emit<FeeChanged>(v0);
    }

    public fun set_price(arg0: &AuthorCap, arg1: &mut Template, arg2: u64, arg3: bool) {
        assert!(arg0.template == 0x2::object::id<Template>(arg1), 4);
        assert!(!arg3 || arg2 > 0, 5);
        assert!(arg2 <= 1000000000000000, 17);
        arg1.price = arg2;
        arg1.for_sale = arg3;
        let v0 = PriceChanged{
            template  : 0x2::object::id<Template>(arg1),
            old_price : arg1.price,
            new_price : arg2,
            for_sale  : arg3,
        };
        0x2::event::emit<PriceChanged>(v0);
    }

    public fun sold(arg0: &Template) : u64 {
        arg0.sold
    }

    public fun swap_and_burn<T0>(arg0: &mut Registry, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 0);
        assert!(0x1::option::is_some<0x1::type_name::TypeName>(&arg0.ept_type) && 0x1::option::is_some<0x2::object::ID>(&arg0.pool_id), 11);
        assert!(0x1::type_name::with_defining_ids<T0>() == *0x1::option::borrow<0x1::type_name::TypeName>(&arg0.ept_type), 9);
        assert!(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>>(arg2) == *0x1::option::borrow<0x2::object::ID>(&arg0.pool_id), 8);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.burn_pot);
        assert!(v0 > 0, 7);
        let v1 = if (arg3 == 0 || arg3 > v0) {
            v0
        } else {
            arg3
        };
        let v2 = (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, 0x2::sui::SUI>(arg2) as u256);
        let v3 = ((v1 as u256) * ((1000000 - 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::fee_rate<T0, 0x2::sui::SUI>(arg2)) as u256) / (1000000 as u256) << 128) / v2 * v2;
        assert!(v3 > 0, 10);
        let v4 = ((v3 * ((10000 - 200) as u256) / (10000 as u256)) as u64);
        let v5 = if (arg4 > v4) {
            arg4
        } else {
            v4
        };
        let (v6, v7, v8) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, 0x2::sui::SUI>(arg1, arg2, false, true, v1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_sqrt_price() - 1, arg5);
        let v9 = v8;
        let v10 = v6;
        0x2::balance::destroy_zero<0x2::sui::SUI>(v7);
        let v11 = 0x2::balance::value<T0>(&v10);
        assert!(v11 >= v5, 10);
        let v12 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, 0x2::sui::SUI>(&v9);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, 0x2::sui::SUI>(arg1, arg2, 0x2::balance::zero<T0>(), 0x2::balance::split<0x2::sui::SUI>(&mut arg0.burn_pot, v12), v9);
        arg0.burned = arg0.burned + v11;
        let v13 = EptBurned{
            sui_spent  : v12,
            ept_burned : v11,
            caller     : 0x2::tx_context::sender(arg6),
        };
        0x2::event::emit<EptBurned>(v13);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v10, arg6), @0x0);
    }

    public fun template_id(arg0: &Template) : 0x1::string::String {
        arg0.template_id
    }

    public fun total_burned(arg0: &Registry) : u64 {
        arg0.burned
    }

    public fun total_sold(arg0: &Registry) : u64 {
        arg0.sold
    }

    public fun total_volume(arg0: &Registry) : u64 {
        arg0.volume
    }

    public fun version(arg0: &Registry) : u64 {
        arg0.version
    }

    public fun withdraw_revenue(arg0: &AdminCap, arg1: &mut Registry, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(arg1.version == 1, 0);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg1.revenue);
        let v1 = RevenueWithdrawn{
            amount : v0,
            to     : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<RevenueWithdrawn>(v1);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.revenue, v0), arg2)
    }

    // decompiled from Move bytecode v7
}

