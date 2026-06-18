module 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::flash {
    struct FlashReceipt<phantom T0, phantom T1> {
        pool_id: 0x2::object::ID,
        amount: u64,
        fee: u64,
    }

    public fun flash_borrow<T0, T1>(arg0: &mut 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::pool::LendingPool<T0>, arg1: &0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::ploan::GlobalConfig, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, FlashReceipt<T0, T1>) {
        0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::ploan::assert_version(arg1);
        assert!(arg2 > 0, 2);
        assert!(arg2 <= 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::pool::reserve_available<T0, T1>(arg0), 4);
        let v0 = flash_fee(arg2);
        let v1 = 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::pool::pool_id_of<T0>(arg0);
        let v2 = FlashReceipt<T0, T1>{
            pool_id : v1,
            amount  : arg2,
            fee     : v0,
        };
        0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::events::emit_flash_borrow(v1, 0x1::type_name::with_defining_ids<T1>(), arg2, v0);
        (0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::pool::flash_take<T0, T1>(arg0, arg2, arg3), v2)
    }

    public fun flash_fee(arg0: u64) : u64 {
        let v0 = 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::mul_bps(0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::from(arg0), 0);
        0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::ceil(&v0)
    }

    public fun flash_repay<T0, T1>(arg0: &mut 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::pool::LendingPool<T0>, arg1: &0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::ploan::GlobalConfig, arg2: 0x2::coin::Coin<T1>, arg3: FlashReceipt<T0, T1>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::ploan::assert_version(arg1);
        let FlashReceipt {
            pool_id : v0,
            amount  : v1,
            fee     : v2,
        } = arg3;
        assert!(v0 == 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::pool::pool_id_of<T0>(arg0), 0);
        let v3 = v1 + v2;
        assert!(0x2::coin::value<T1>(&arg2) >= v3, 1);
        0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::pool::flash_put<T0, T1>(arg0, 0x2::coin::split<T1>(&mut arg2, v3, arg4), v2);
        0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::events::emit_flash_repay(0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::pool::pool_id_of<T0>(arg0), 0x1::type_name::with_defining_ids<T1>(), v1, v2);
        arg2
    }

    public fun receipt_amount<T0, T1>(arg0: &FlashReceipt<T0, T1>) : u64 {
        arg0.amount
    }

    public fun receipt_fee<T0, T1>(arg0: &FlashReceipt<T0, T1>) : u64 {
        arg0.fee
    }

    public fun receipt_pool_id<T0, T1>(arg0: &FlashReceipt<T0, T1>) : 0x2::object::ID {
        arg0.pool_id
    }

    public fun receipt_total<T0, T1>(arg0: &FlashReceipt<T0, T1>) : u64 {
        arg0.amount + arg0.fee
    }

    // decompiled from Move bytecode v7
}

