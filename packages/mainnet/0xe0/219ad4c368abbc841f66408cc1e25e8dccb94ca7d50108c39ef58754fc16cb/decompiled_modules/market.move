module 0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::market {
    struct Market<phantom T0: drop, phantom T1: drop, phantom T2: drop> has store, key {
        id: 0x2::object::UID,
        expiry: u64,
        sy_type: 0x1::type_name::TypeName,
        pt_type: 0x1::type_name::TypeName,
        yt_type: 0x1::type_name::TypeName,
        sy_treasury: 0x2::coin::TreasuryCap<T0>,
        pt_treasury: 0x2::coin::TreasuryCap<T1>,
        yt_treasury: 0x2::coin::TreasuryCap<T2>,
    }

    struct MarketCreatedEvent has copy, drop {
        market_id: 0x2::object::ID,
        expiry: u64,
        created_by: address,
        sy_type: 0x1::type_name::TypeName,
        pt_type: 0x1::type_name::TypeName,
        yt_type: 0x1::type_name::TypeName,
    }

    public fun id<T0: drop, T1: drop, T2: drop>(arg0: &Market<T0, T1, T2>) : 0x2::object::ID {
        0x2::object::id<Market<T0, T1, T2>>(arg0)
    }

    public(friend) fun burn_pt<T0: drop, T1: drop, T2: drop>(arg0: &mut Market<T0, T1, T2>, arg1: 0x2::coin::Coin<T1>) : u64 {
        0x2::coin::burn<T1>(&mut arg0.pt_treasury, arg1)
    }

    public(friend) fun burn_sy<T0: drop, T1: drop, T2: drop>(arg0: &mut Market<T0, T1, T2>, arg1: 0x2::coin::Coin<T0>) : u64 {
        0x2::coin::burn<T0>(&mut arg0.sy_treasury, arg1)
    }

    public(friend) fun burn_yt<T0: drop, T1: drop, T2: drop>(arg0: &mut Market<T0, T1, T2>, arg1: 0x2::coin::Coin<T2>) : u64 {
        0x2::coin::burn<T2>(&mut arg0.yt_treasury, arg1)
    }

    fun create<T0: drop, T1: drop, T2: drop>(arg0: u64, arg1: 0x2::coin::TreasuryCap<T0>, arg2: 0x2::coin::TreasuryCap<T1>, arg3: 0x2::coin::TreasuryCap<T2>, arg4: &mut 0x2::tx_context::TxContext) : Market<T0, T1, T2> {
        assert!(arg0 > 0, 1900);
        let v0 = Market<T0, T1, T2>{
            id          : 0x2::object::new(arg4),
            expiry      : arg0,
            sy_type     : 0x1::type_name::with_defining_ids<T0>(),
            pt_type     : 0x1::type_name::with_defining_ids<T1>(),
            yt_type     : 0x1::type_name::with_defining_ids<T2>(),
            sy_treasury : arg1,
            pt_treasury : arg2,
            yt_treasury : arg3,
        };
        let v1 = MarketCreatedEvent{
            market_id  : 0x2::object::id<Market<T0, T1, T2>>(&v0),
            expiry     : v0.expiry,
            created_by : 0x2::tx_context::sender(arg4),
            sy_type    : v0.sy_type,
            pt_type    : v0.pt_type,
            yt_type    : v0.yt_type,
        };
        0x2::event::emit<MarketCreatedEvent>(v1);
        v0
    }

    public fun create_by_admin_cap<T0: drop, T1: drop, T2: drop>(arg0: &0xc59bf9a81ec34872a3c47e0e84a4fc65ab280f319e2df61db4f860e90b32572c::admin::AdminCap, arg1: &0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::GlobalConfig, arg2: u64, arg3: 0x2::coin::TreasuryCap<T0>, arg4: 0x2::coin::TreasuryCap<T1>, arg5: 0x2::coin::TreasuryCap<T2>, arg6: &mut 0x2::tx_context::TxContext) : Market<T0, T1, T2> {
        0xe0219ad4c368abbc841f66408cc1e25e8dccb94ca7d50108c39ef58754fc16cb::global_config::assert_current(arg1);
        create<T0, T1, T2>(arg2, arg3, arg4, arg5, arg6)
    }

    public fun expiry<T0: drop, T1: drop, T2: drop>(arg0: &Market<T0, T1, T2>) : u64 {
        arg0.expiry
    }

    public(friend) fun mint_pt<T0: drop, T1: drop, T2: drop>(arg0: &mut Market<T0, T1, T2>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(arg1 > 0, 1901);
        0x2::coin::mint<T1>(&mut arg0.pt_treasury, arg1, arg2)
    }

    public(friend) fun mint_sy<T0: drop, T1: drop, T2: drop>(arg0: &mut Market<T0, T1, T2>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg1 > 0, 1901);
        0x2::coin::mint<T0>(&mut arg0.sy_treasury, arg1, arg2)
    }

    public(friend) fun mint_yt<T0: drop, T1: drop, T2: drop>(arg0: &mut Market<T0, T1, T2>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        assert!(arg1 > 0, 1901);
        0x2::coin::mint<T2>(&mut arg0.yt_treasury, arg1, arg2)
    }

    public fun pt_total_supply<T0: drop, T1: drop, T2: drop>(arg0: &Market<T0, T1, T2>) : u64 {
        0x2::coin::total_supply<T1>(&arg0.pt_treasury)
    }

    public fun pt_treasury_id<T0: drop, T1: drop, T2: drop>(arg0: &Market<T0, T1, T2>) : 0x2::object::ID {
        0x2::object::id<0x2::coin::TreasuryCap<T1>>(&arg0.pt_treasury)
    }

    public fun pt_type_name<T0: drop, T1: drop, T2: drop>(arg0: &Market<T0, T1, T2>) : 0x1::type_name::TypeName {
        arg0.pt_type
    }

    public fun sy_total_supply<T0: drop, T1: drop, T2: drop>(arg0: &Market<T0, T1, T2>) : u64 {
        0x2::coin::total_supply<T0>(&arg0.sy_treasury)
    }

    public fun sy_treasury_id<T0: drop, T1: drop, T2: drop>(arg0: &Market<T0, T1, T2>) : 0x2::object::ID {
        0x2::object::id<0x2::coin::TreasuryCap<T0>>(&arg0.sy_treasury)
    }

    public fun sy_type_name<T0: drop, T1: drop, T2: drop>(arg0: &Market<T0, T1, T2>) : 0x1::type_name::TypeName {
        arg0.sy_type
    }

    public fun yt_total_supply<T0: drop, T1: drop, T2: drop>(arg0: &Market<T0, T1, T2>) : u64 {
        0x2::coin::total_supply<T2>(&arg0.yt_treasury)
    }

    public fun yt_treasury_id<T0: drop, T1: drop, T2: drop>(arg0: &Market<T0, T1, T2>) : 0x2::object::ID {
        0x2::object::id<0x2::coin::TreasuryCap<T2>>(&arg0.yt_treasury)
    }

    public fun yt_type_name<T0: drop, T1: drop, T2: drop>(arg0: &Market<T0, T1, T2>) : 0x1::type_name::TypeName {
        arg0.yt_type
    }

    // decompiled from Move bytecode v7
}

