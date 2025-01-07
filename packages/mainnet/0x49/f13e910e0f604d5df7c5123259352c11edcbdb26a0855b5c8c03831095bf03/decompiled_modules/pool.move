module 0x49f13e910e0f604d5df7c5123259352c11edcbdb26a0855b5c8c03831095bf03::pool {
    struct POOL has drop {
        dummy_field: bool,
    }

    struct PoolKey has copy, drop, store {
        dummy_field: bool,
    }

    struct AdminCap<phantom T0> has store, key {
        id: 0x2::object::UID,
    }

    struct DaoFeePool<phantom T0> has store, key {
        id: 0x2::object::UID,
        fee_bps: u16,
        fee_recipient: address,
    }

    public fun new<T0>(arg0: 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T0>, arg1: u16, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : (DaoFeePool<T0>, AdminCap<T0>) {
        let v0 = DaoFeePool<T0>{
            id            : 0x2::object::new(arg3),
            fee_bps       : arg1,
            fee_recipient : arg2,
        };
        0x49f13e910e0f604d5df7c5123259352c11edcbdb26a0855b5c8c03831095bf03::events::emit_created_pool_event(0x2::object::uid_to_inner(&v0.id), 0x2::object::id<0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T0>>(&arg0), arg1, arg2);
        let v1 = PoolKey{dummy_field: false};
        0x2::dynamic_object_field::add<PoolKey, 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T0>>(&mut v0.id, v1, arg0);
        let v2 = AdminCap<T0>{id: 0x2::object::new(arg3)};
        (v0, v2)
    }

    public(friend) fun borrow_mut_pool<T0>(arg0: &mut DaoFeePool<T0>) : &mut 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T0> {
        let v0 = PoolKey{dummy_field: false};
        0x2::dynamic_object_field::borrow_mut<PoolKey, 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T0>>(&mut arg0.id, v0)
    }

    public(friend) fun borrow_pool<T0>(arg0: &DaoFeePool<T0>) : &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T0> {
        let v0 = PoolKey{dummy_field: false};
        0x2::dynamic_object_field::borrow<PoolKey, 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T0>>(&arg0.id, v0)
    }

    public(friend) fun calculate_dao_fee<T0, T1>(arg0: &DaoFeePool<T0>, arg1: &0x2::coin::Coin<T1>) : u64 {
        (((0x2::coin::value<T1>(arg1) as u128) * (arg0.fee_bps as u128) / 10000) as u64)
    }

    public(friend) fun collect_dao_fee<T0, T1>(arg0: &DaoFeePool<T0>, arg1: &mut 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = calculate_dao_fee<T0, T1>(arg0, arg1);
        if (v0 != 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(arg1, v0, arg2), arg0.fee_recipient);
        };
    }

    public fun fee_bps<T0>(arg0: &DaoFeePool<T0>) : u16 {
        arg0.fee_bps
    }

    public fun fee_recipient<T0>(arg0: &DaoFeePool<T0>) : address {
        arg0.fee_recipient
    }

    fun init(arg0: POOL, arg1: &mut 0x2::tx_context::TxContext) {
        0x49f13e910e0f604d5df7c5123259352c11edcbdb26a0855b5c8c03831095bf03::version::init_package_version<POOL>(&arg0, arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<POOL>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public fun share<T0>(arg0: DaoFeePool<T0>) {
        0x2::transfer::public_share_object<DaoFeePool<T0>>(arg0);
    }

    public fun update_fee_bps<T0>(arg0: &AdminCap<T0>, arg1: &mut DaoFeePool<T0>, arg2: u16) {
        0x49f13e910e0f604d5df7c5123259352c11edcbdb26a0855b5c8c03831095bf03::events::emit_updated_fee_bps_event(0x2::object::uid_to_inner(&arg1.id), arg1.fee_bps, arg2);
        arg1.fee_bps = arg2;
    }

    public fun update_fee_recipient<T0>(arg0: &AdminCap<T0>, arg1: &mut DaoFeePool<T0>, arg2: address) {
        0x49f13e910e0f604d5df7c5123259352c11edcbdb26a0855b5c8c03831095bf03::events::emit_updated_fee_recipient_event(0x2::object::uid_to_inner(&arg1.id), arg1.fee_recipient, arg2);
        arg1.fee_recipient = arg2;
    }

    // decompiled from Move bytecode v6
}

