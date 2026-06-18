module 0x6c93873fda254e9dc724f10b41d770430c5bc3aa49e16694d2af752d55605d72::sy {
    struct SyState has store, key {
        id: 0x2::object::UID,
        sy_info: 0x2::vec_map::VecMap<0x1::type_name::TypeName, SyInfo>,
    }

    struct SyInfo has copy, drop, store {
        underlying_type: 0x1::type_name::TypeName,
        sign_type: 0x1::type_name::TypeName,
    }

    struct MintSyRequest<phantom T0: drop> {
        market_id: 0x2::object::ID,
        sy_amount: u64,
        amount: u64,
    }

    struct BurnSyRequest<phantom T0: drop> {
        market_id: 0x2::object::ID,
        sy_amount: u64,
        amount: u64,
    }

    struct SyRegisteredEvent has copy, drop {
        sy_type: 0x1::type_name::TypeName,
        underlying_type: 0x1::type_name::TypeName,
        sign_type: 0x1::type_name::TypeName,
    }

    struct SyUnregisteredEvent has copy, drop {
        sy_type: 0x1::type_name::TypeName,
    }

    fun assert_registered_sign<T0: drop, T1: drop>(arg0: &SyState) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::vec_map::contains<0x1::type_name::TypeName, SyInfo>(&arg0.sy_info, &v0), 606);
        assert!(0x2::vec_map::get<0x1::type_name::TypeName, SyInfo>(&arg0.sy_info, &v0).sign_type == 0x1::type_name::with_defining_ids<T1>(), 605);
    }

    public fun burn_escrowed_sy<T0: drop, T1: drop, T2: drop, T3: drop>(arg0: 0x2::coin::Coin<T0>, arg1: T3, arg2: &SyState, arg3: &0x6c93873fda254e9dc724f10b41d770430c5bc3aa49e16694d2af752d55605d72::global_config::GlobalConfig, arg4: &mut 0x6c93873fda254e9dc724f10b41d770430c5bc3aa49e16694d2af752d55605d72::market::Market<T0, T1, T2>) : u64 {
        0x6c93873fda254e9dc724f10b41d770430c5bc3aa49e16694d2af752d55605d72::global_config::assert_current(arg3);
        assert_registered_sign<T0, T3>(arg2);
        0x6c93873fda254e9dc724f10b41d770430c5bc3aa49e16694d2af752d55605d72::market::burn_sy<T0, T1, T2>(arg4, arg0)
    }

    public fun burn_sy_exact_in<T0: drop, T1: drop, T2: drop>(arg0: &mut 0x6c93873fda254e9dc724f10b41d770430c5bc3aa49e16694d2af752d55605d72::market::Market<T0, T1, T2>, arg1: &0x6c93873fda254e9dc724f10b41d770430c5bc3aa49e16694d2af752d55605d72::global_config::GlobalConfig, arg2: 0x6c93873fda254e9dc724f10b41d770430c5bc3aa49e16694d2af752d55605d72::price_info::PriceInfo<T0>, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock) : BurnSyRequest<T0> {
        0x6c93873fda254e9dc724f10b41d770430c5bc3aa49e16694d2af752d55605d72::global_config::assert_current(arg1);
        let v0 = 0x6c93873fda254e9dc724f10b41d770430c5bc3aa49e16694d2af752d55605d72::market::burn_sy<T0, T1, T2>(arg0, arg3);
        assert!(v0 > 0, 602);
        let v1 = sy_to_underlying_amount(v0, 0x6c93873fda254e9dc724f10b41d770430c5bc3aa49e16694d2af752d55605d72::price_info::consume<T0>(arg2, 0x6c93873fda254e9dc724f10b41d770430c5bc3aa49e16694d2af752d55605d72::market::id<T0, T1, T2>(arg0), arg4));
        assert!(v1 > 0, 602);
        BurnSyRequest<T0>{
            market_id : 0x6c93873fda254e9dc724f10b41d770430c5bc3aa49e16694d2af752d55605d72::market::id<T0, T1, T2>(arg0),
            sy_amount : v0,
            amount    : v1,
        }
    }

    public fun cancel_burn_request<T0: drop, T1: drop, T2: drop, T3: drop>(arg0: BurnSyRequest<T0>, arg1: T3, arg2: &mut SyState, arg3: &0x6c93873fda254e9dc724f10b41d770430c5bc3aa49e16694d2af752d55605d72::global_config::GlobalConfig, arg4: &mut 0x6c93873fda254e9dc724f10b41d770430c5bc3aa49e16694d2af752d55605d72::market::Market<T0, T1, T2>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x6c93873fda254e9dc724f10b41d770430c5bc3aa49e16694d2af752d55605d72::global_config::assert_current(arg3);
        assert_registered_sign<T0, T3>(arg2);
        let BurnSyRequest {
            market_id : v0,
            sy_amount : v1,
            amount    : _,
        } = arg0;
        assert!(v0 == 0x6c93873fda254e9dc724f10b41d770430c5bc3aa49e16694d2af752d55605d72::market::id<T0, T1, T2>(arg4), 607);
        0x6c93873fda254e9dc724f10b41d770430c5bc3aa49e16694d2af752d55605d72::market::mint_sy<T0, T1, T2>(arg4, v1, arg5)
    }

    public fun destroy_burn_request<T0: drop, T1: drop>(arg0: BurnSyRequest<T0>, arg1: T1, arg2: &mut SyState, arg3: &0x6c93873fda254e9dc724f10b41d770430c5bc3aa49e16694d2af752d55605d72::global_config::GlobalConfig) : u64 {
        0x6c93873fda254e9dc724f10b41d770430c5bc3aa49e16694d2af752d55605d72::global_config::assert_current(arg3);
        assert_registered_sign<T0, T1>(arg2);
        let BurnSyRequest {
            market_id : _,
            sy_amount : _,
            amount    : v2,
        } = arg0;
        v2
    }

    public fun destroy_mint_request<T0: drop, T1: drop>(arg0: MintSyRequest<T0>, arg1: T1, arg2: &mut SyState, arg3: &0x6c93873fda254e9dc724f10b41d770430c5bc3aa49e16694d2af752d55605d72::global_config::GlobalConfig) : u64 {
        0x6c93873fda254e9dc724f10b41d770430c5bc3aa49e16694d2af752d55605d72::global_config::assert_current(arg3);
        assert_registered_sign<T0, T1>(arg2);
        let MintSyRequest {
            market_id : _,
            sy_amount : _,
            amount    : v2,
        } = arg0;
        v2
    }

    public fun get_burn_request_amount<T0: drop>(arg0: &BurnSyRequest<T0>) : u64 {
        arg0.amount
    }

    public fun get_burn_request_market_id<T0: drop>(arg0: &BurnSyRequest<T0>) : 0x2::object::ID {
        arg0.market_id
    }

    public fun get_burn_request_sy_amount<T0: drop>(arg0: &BurnSyRequest<T0>) : u64 {
        arg0.sy_amount
    }

    public fun get_mint_request_amount<T0: drop>(arg0: &MintSyRequest<T0>) : u64 {
        arg0.amount
    }

    public fun get_mint_request_market_id<T0: drop>(arg0: &MintSyRequest<T0>) : 0x2::object::ID {
        arg0.market_id
    }

    public fun get_mint_request_sy_amount<T0: drop>(arg0: &MintSyRequest<T0>) : u64 {
        arg0.sy_amount
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SyState{
            id      : 0x2::object::new(arg0),
            sy_info : 0x2::vec_map::empty<0x1::type_name::TypeName, SyInfo>(),
        };
        0x2::transfer::share_object<SyState>(v0);
    }

    public fun mint_sy_exact_in<T0: drop, T1: drop, T2: drop>(arg0: &mut 0x6c93873fda254e9dc724f10b41d770430c5bc3aa49e16694d2af752d55605d72::market::Market<T0, T1, T2>, arg1: &0x6c93873fda254e9dc724f10b41d770430c5bc3aa49e16694d2af752d55605d72::global_config::GlobalConfig, arg2: 0x6c93873fda254e9dc724f10b41d770430c5bc3aa49e16694d2af752d55605d72::price_info::PriceInfo<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, MintSyRequest<T0>) {
        0x6c93873fda254e9dc724f10b41d770430c5bc3aa49e16694d2af752d55605d72::global_config::assert_current(arg1);
        assert!(arg3 > 0, 602);
        let v0 = underlying_to_sy_amount(arg3, 0x6c93873fda254e9dc724f10b41d770430c5bc3aa49e16694d2af752d55605d72::price_info::consume<T0>(arg2, 0x6c93873fda254e9dc724f10b41d770430c5bc3aa49e16694d2af752d55605d72::market::id<T0, T1, T2>(arg0), arg4));
        assert!(v0 > 0, 602);
        let v1 = MintSyRequest<T0>{
            market_id : 0x6c93873fda254e9dc724f10b41d770430c5bc3aa49e16694d2af752d55605d72::market::id<T0, T1, T2>(arg0),
            sy_amount : v0,
            amount    : arg3,
        };
        (0x6c93873fda254e9dc724f10b41d770430c5bc3aa49e16694d2af752d55605d72::market::mint_sy<T0, T1, T2>(arg0, v0, arg5), v1)
    }

    public fun register_new_sy<T0: drop, T1: drop, T2: drop>(arg0: &mut SyState, arg1: &0x6c93873fda254e9dc724f10b41d770430c5bc3aa49e16694d2af752d55605d72::global_config::GlobalConfig, arg2: &0x6c93873fda254e9dc724f10b41d770430c5bc3aa49e16694d2af752d55605d72::admin::AdminCap, arg3: &mut 0x2::tx_context::TxContext) {
        0x6c93873fda254e9dc724f10b41d770430c5bc3aa49e16694d2af752d55605d72::global_config::assert_current(arg1);
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        let v2 = 0x1::type_name::with_defining_ids<T2>();
        if (0x2::vec_map::contains<0x1::type_name::TypeName, SyInfo>(&arg0.sy_info, &v0)) {
            abort 601
        };
        let v3 = SyInfo{
            underlying_type : v1,
            sign_type       : v2,
        };
        0x2::vec_map::insert<0x1::type_name::TypeName, SyInfo>(&mut arg0.sy_info, v0, v3);
        let v4 = SyRegisteredEvent{
            sy_type         : v0,
            underlying_type : v1,
            sign_type       : v2,
        };
        0x2::event::emit<SyRegisteredEvent>(v4);
    }

    public(friend) fun sy_to_underlying_amount(arg0: u64, arg1: u128) : u64 {
        assert!(arg1 > 0, 604);
        (0x6c93873fda254e9dc724f10b41d770430c5bc3aa49e16694d2af752d55605d72::full_math_u128::mul_div_floor((arg0 as u128), arg1, 18446744073709551616) as u64)
    }

    public(friend) fun underlying_to_sy_amount(arg0: u64, arg1: u128) : u64 {
        assert!(arg1 > 0, 604);
        (0x6c93873fda254e9dc724f10b41d770430c5bc3aa49e16694d2af752d55605d72::full_math_u128::mul_div_floor((arg0 as u128), 18446744073709551616, arg1) as u64)
    }

    public fun unregister_sy<T0: drop>(arg0: &mut SyState, arg1: &0x6c93873fda254e9dc724f10b41d770430c5bc3aa49e16694d2af752d55605d72::global_config::GlobalConfig, arg2: &0x6c93873fda254e9dc724f10b41d770430c5bc3aa49e16694d2af752d55605d72::admin::AdminCap, arg3: &mut 0x2::tx_context::TxContext) {
        0x6c93873fda254e9dc724f10b41d770430c5bc3aa49e16694d2af752d55605d72::global_config::assert_current(arg1);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::vec_map::contains<0x1::type_name::TypeName, SyInfo>(&arg0.sy_info, &v0), 606);
        let (_, _) = 0x2::vec_map::remove<0x1::type_name::TypeName, SyInfo>(&mut arg0.sy_info, &v0);
        let v3 = SyUnregisteredEvent{sy_type: v0};
        0x2::event::emit<SyUnregisteredEvent>(v3);
    }

    // decompiled from Move bytecode v7
}

