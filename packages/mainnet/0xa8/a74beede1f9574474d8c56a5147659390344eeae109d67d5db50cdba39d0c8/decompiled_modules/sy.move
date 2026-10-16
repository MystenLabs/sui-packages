module 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::sy {
    struct SyState has store, key {
        id: 0x2::object::UID,
        sy_info: 0x2::vec_map::VecMap<0x1::type_name::TypeName, SyInfo>,
    }

    struct SyInfo has copy, drop, store {
        underlying_type: 0x1::type_name::TypeName,
        sign_type: 0x1::type_name::TypeName,
        market_id: 0x1::option::Option<0x2::object::ID>,
        vault_id: 0x1::option::Option<0x2::object::ID>,
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

    struct SyStateCreatedEvent has copy, drop {
        sy_state_id: 0x2::object::ID,
    }

    struct SyMintRequestedEvent has copy, drop {
        market_id: 0x2::object::ID,
        sy_amount: u64,
        underlying_amount: u64,
    }

    struct SyBurnRequestedEvent has copy, drop {
        market_id: 0x2::object::ID,
        sy_amount: u64,
        underlying_amount: u64,
    }

    struct SyBurnCancelledEvent has copy, drop {
        market_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        sy_amount: u64,
    }

    struct EscrowedSyBurnedEvent has copy, drop {
        market_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        sy_amount: u64,
        sy_type: 0x1::type_name::TypeName,
        underlying_type: 0x1::type_name::TypeName,
    }

    struct SyUnregisteredEvent has copy, drop {
        sy_type: 0x1::type_name::TypeName,
    }

    struct SyMarketVaultBoundEvent has copy, drop {
        sy_type: 0x1::type_name::TypeName,
        underlying_type: 0x1::type_name::TypeName,
        sign_type: 0x1::type_name::TypeName,
        market_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
    }

    fun assert_binding_available(arg0: &SyState, arg1: 0x1::type_name::TypeName, arg2: 0x2::object::ID, arg3: 0x2::object::ID) {
        let v0 = 0x2::vec_map::keys<0x1::type_name::TypeName, SyInfo>(&arg0.sy_info);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::type_name::TypeName>(&v0)) {
            let v2 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v0, v1);
            if (v2 != arg1) {
                let v3 = 0x2::vec_map::get<0x1::type_name::TypeName, SyInfo>(&arg0.sy_info, &v2);
                if (0x1::option::is_some<0x2::object::ID>(&v3.market_id)) {
                    assert!(*0x1::option::borrow<0x2::object::ID>(&v3.market_id) != arg2, 613);
                };
                if (0x1::option::is_some<0x2::object::ID>(&v3.vault_id)) {
                    assert!(*0x1::option::borrow<0x2::object::ID>(&v3.vault_id) != arg3, 613);
                };
            };
            v1 = v1 + 1;
        };
    }

    fun assert_registered_route<T0: drop, T1: drop, T2: drop>(arg0: &SyState, arg1: 0x2::object::ID, arg2: 0x2::object::ID) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::vec_map::contains<0x1::type_name::TypeName, SyInfo>(&arg0.sy_info, &v0), 606);
        let v1 = 0x2::vec_map::get<0x1::type_name::TypeName, SyInfo>(&arg0.sy_info, &v0);
        assert!(v1.underlying_type == 0x1::type_name::with_defining_ids<T1>(), 609);
        assert!(v1.sign_type == 0x1::type_name::with_defining_ids<T2>(), 605);
        assert!(0x1::option::is_some<0x2::object::ID>(&v1.market_id) && 0x1::option::is_some<0x2::object::ID>(&v1.vault_id), 612);
        assert!(*0x1::option::borrow<0x2::object::ID>(&v1.market_id) == arg1, 607);
        assert!(*0x1::option::borrow<0x2::object::ID>(&v1.vault_id) == arg2, 610);
    }

    public fun bind_market_vault<T0: drop, T1: drop, T2: drop>(arg0: &mut SyState, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg2: T2, arg3: 0x2::object::ID, arg4: 0x2::object::ID) {
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::package_version::assert_current(arg1);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = 0x1::type_name::with_defining_ids<T1>();
        let v2 = 0x1::type_name::with_defining_ids<T2>();
        assert!(0x2::vec_map::contains<0x1::type_name::TypeName, SyInfo>(&arg0.sy_info, &v0), 606);
        assert_binding_available(arg0, v0, arg3, arg4);
        let v3 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, SyInfo>(&mut arg0.sy_info, &v0);
        assert!(v3.underlying_type == v1, 609);
        assert!(v3.sign_type == v2, 605);
        assert!(0x1::option::is_none<0x2::object::ID>(&v3.market_id) && 0x1::option::is_none<0x2::object::ID>(&v3.vault_id), 611);
        0x1::option::fill<0x2::object::ID>(&mut v3.market_id, arg3);
        0x1::option::fill<0x2::object::ID>(&mut v3.vault_id, arg4);
        let v4 = SyMarketVaultBoundEvent{
            sy_type         : v0,
            underlying_type : v1,
            sign_type       : v2,
            market_id       : arg3,
            vault_id        : arg4,
        };
        0x2::event::emit<SyMarketVaultBoundEvent>(v4);
    }

    public fun burn_escrowed_sy_market_state<T0: drop, T1: drop, T2: drop, T3: drop, T4: drop>(arg0: 0x2::coin::Coin<T0>, arg1: T4, arg2: &SyState, arg3: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg4: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T2, T3>, arg5: 0x2::object::ID) : u64 {
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::package_version::assert_target_active(arg3, b"market", 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T2, T3>(arg4), 608);
        assert_registered_route<T0, T1, T4>(arg2, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T2, T3>(arg4), arg5);
        let v0 = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::burn_sy<T0, T2, T3>(arg4, arg0);
        assert!(v0 > 0, 602);
        let v1 = EscrowedSyBurnedEvent{
            market_id       : 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T2, T3>(arg4),
            vault_id        : arg5,
            sy_amount       : v0,
            sy_type         : 0x1::type_name::with_defining_ids<T0>(),
            underlying_type : 0x1::type_name::with_defining_ids<T1>(),
        };
        0x2::event::emit<EscrowedSyBurnedEvent>(v1);
        v0
    }

    public fun burn_sy_exact_in_market_state<T0: drop, T1: drop, T2: drop>(arg0: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg2: 0x9b071eaad9d3d764cbae7ca6473ac0f2dcc1f7c5f8076851fa46f1aafe0c3f67::price_info::PriceInfo<T0>, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock) : BurnSyRequest<T0> {
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::package_version::assert_target_active(arg1, b"market", 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg0), 608);
        let v0 = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::burn_sy<T0, T1, T2>(arg0, arg3);
        assert!(v0 > 0, 602);
        let v1 = sy_to_underlying_amount(v0, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::consume_price_info<T0, T1, T2>(arg0, arg1, arg2, arg4));
        assert!(v1 > 0, 602);
        let v2 = SyBurnRequestedEvent{
            market_id         : 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg0),
            sy_amount         : v0,
            underlying_amount : v1,
        };
        0x2::event::emit<SyBurnRequestedEvent>(v2);
        BurnSyRequest<T0>{
            market_id : 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg0),
            sy_amount : v0,
            amount    : v1,
        }
    }

    public fun cancel_burn_request_market_state<T0: drop, T1: drop, T2: drop, T3: drop, T4: drop>(arg0: BurnSyRequest<T0>, arg1: T4, arg2: &SyState, arg3: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg4: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T2, T3>, arg5: 0x2::object::ID, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::package_version::assert_target_active(arg3, b"market", 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T2, T3>(arg4), 608);
        assert_registered_route<T0, T1, T4>(arg2, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T2, T3>(arg4), arg5);
        let BurnSyRequest {
            market_id : v0,
            sy_amount : v1,
            amount    : _,
        } = arg0;
        assert!(v0 == 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T2, T3>(arg4), 607);
        let v3 = SyBurnCancelledEvent{
            market_id : v0,
            vault_id  : arg5,
            sy_amount : v1,
        };
        0x2::event::emit<SyBurnCancelledEvent>(v3);
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::mint_sy<T0, T2, T3>(arg4, v1, arg6)
    }

    public fun destroy_burn_request<T0: drop, T1: drop, T2: drop>(arg0: BurnSyRequest<T0>, arg1: T2, arg2: &SyState, arg3: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg4: 0x2::object::ID, arg5: 0x2::object::ID) : u64 {
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::package_version::assert_current(arg3);
        assert_registered_route<T0, T1, T2>(arg2, arg4, arg5);
        let BurnSyRequest {
            market_id : v0,
            sy_amount : _,
            amount    : v2,
        } = arg0;
        assert!(v0 == arg4, 607);
        v2
    }

    public fun destroy_mint_request<T0: drop, T1: drop, T2: drop>(arg0: MintSyRequest<T0>, arg1: T2, arg2: &SyState, arg3: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg4: 0x2::object::ID, arg5: 0x2::object::ID) : u64 {
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::package_version::assert_current(arg3);
        assert_registered_route<T0, T1, T2>(arg2, arg4, arg5);
        let MintSyRequest {
            market_id : v0,
            sy_amount : _,
            amount    : v2,
        } = arg0;
        assert!(v0 == arg4, 607);
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
        let v1 = SyStateCreatedEvent{sy_state_id: 0x2::object::id<SyState>(&v0)};
        0x2::event::emit<SyStateCreatedEvent>(v1);
        0x2::transfer::share_object<SyState>(v0);
    }

    public fun market_underlying_type<T0: drop>(arg0: &SyState, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg2: 0x2::object::ID) : 0x1::type_name::TypeName {
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::package_version::assert_current(arg1);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::vec_map::contains<0x1::type_name::TypeName, SyInfo>(&arg0.sy_info, &v0), 606);
        let v1 = 0x2::vec_map::get<0x1::type_name::TypeName, SyInfo>(&arg0.sy_info, &v0);
        assert!(0x1::option::is_some<0x2::object::ID>(&v1.market_id), 612);
        assert!(*0x1::option::borrow<0x2::object::ID>(&v1.market_id) == arg2, 607);
        v1.underlying_type
    }

    public fun mint_sy_exact_in_market_state<T0: drop, T1: drop, T2: drop>(arg0: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg2: 0x9b071eaad9d3d764cbae7ca6473ac0f2dcc1f7c5f8076851fa46f1aafe0c3f67::price_info::PriceInfo<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, MintSyRequest<T0>) {
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::package_version::assert_target_active(arg1, b"market", 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg0), 608);
        assert!(arg3 > 0, 602);
        let v0 = underlying_to_sy_amount(arg3, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::consume_price_info<T0, T1, T2>(arg0, arg1, arg2, arg4));
        assert!(v0 > 0, 602);
        let v1 = MintSyRequest<T0>{
            market_id : 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg0),
            sy_amount : v0,
            amount    : arg3,
        };
        let v2 = SyMintRequestedEvent{
            market_id         : 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg0),
            sy_amount         : v0,
            underlying_amount : arg3,
        };
        0x2::event::emit<SyMintRequestedEvent>(v2);
        (0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::mint_sy<T0, T1, T2>(arg0, v0, arg5), v1)
    }

    public fun register_new_sy<T0: drop, T1: drop, T2: drop>(arg0: &mut SyState, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg2: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::admin::AdminCap, arg3: &mut 0x2::tx_context::TxContext) {
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::package_version::assert_current(arg1);
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        let v2 = 0x1::type_name::with_defining_ids<T2>();
        if (0x2::vec_map::contains<0x1::type_name::TypeName, SyInfo>(&arg0.sy_info, &v0)) {
            abort 601
        };
        let v3 = SyInfo{
            underlying_type : v1,
            sign_type       : v2,
            market_id       : 0x1::option::none<0x2::object::ID>(),
            vault_id        : 0x1::option::none<0x2::object::ID>(),
        };
        0x2::vec_map::insert<0x1::type_name::TypeName, SyInfo>(&mut arg0.sy_info, v0, v3);
        let v4 = SyRegisteredEvent{
            sy_type         : v0,
            underlying_type : v1,
            sign_type       : v2,
        };
        0x2::event::emit<SyRegisteredEvent>(v4);
    }

    fun sy_to_underlying_amount(arg0: u64, arg1: u128) : u64 {
        assert!(arg1 > 0, 604);
        (0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::full_math_u128::mul_div_floor((arg0 as u128), arg1, 18446744073709551616) as u64)
    }

    fun underlying_to_sy_amount(arg0: u64, arg1: u128) : u64 {
        assert!(arg1 > 0, 604);
        (0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::full_math_u128::mul_div_floor((arg0 as u128), 18446744073709551616, arg1) as u64)
    }

    public fun unregister_sy<T0: drop>(arg0: &mut SyState, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg2: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::admin::AdminCap, arg3: &mut 0x2::tx_context::TxContext) {
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::package_version::assert_current(arg1);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::vec_map::contains<0x1::type_name::TypeName, SyInfo>(&arg0.sy_info, &v0), 606);
        let v1 = 0x2::vec_map::get<0x1::type_name::TypeName, SyInfo>(&arg0.sy_info, &v0);
        assert!(0x1::option::is_none<0x2::object::ID>(&v1.market_id) && 0x1::option::is_none<0x2::object::ID>(&v1.vault_id), 611);
        let (_, _) = 0x2::vec_map::remove<0x1::type_name::TypeName, SyInfo>(&mut arg0.sy_info, &v0);
        let v4 = SyUnregisteredEvent{sy_type: v0};
        0x2::event::emit<SyUnregisteredEvent>(v4);
    }

    // decompiled from Move bytecode v7
}

