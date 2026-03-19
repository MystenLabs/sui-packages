module 0x7ce60dbd92810f03514a3c11ceb34f8db547f40e01a5724bc5624deef0df17d6::taxonomy {
    struct OwnedTestObject has store, key {
        id: 0x2::object::UID,
        value: u64,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        payload: vector<u8>,
    }

    struct SharedTestObject has key {
        id: 0x2::object::UID,
        value: u64,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        payload: vector<u8>,
    }

    public fun create_owned_test_object(arg0: &mut 0x2::tx_context::TxContext) : OwnedTestObject {
        OwnedTestObject{
            id      : 0x2::object::new(arg0),
            value   : 0,
            balance : 0x2::balance::zero<0x2::sui::SUI>(),
            payload : 0x1::vector::empty<u8>(),
        }
    }

    public fun create_owned_test_object_with_payload(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) : OwnedTestObject {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0;
        while (v1 < arg0) {
            0x1::vector::push_back<u8>(&mut v0, 0);
            v1 = v1 + 1;
        };
        OwnedTestObject{
            id      : 0x2::object::new(arg1),
            value   : 0,
            balance : 0x2::balance::zero<0x2::sui::SUI>(),
            payload : v0,
        }
    }

    public fun create_shared_test_object(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SharedTestObject{
            id      : 0x2::object::new(arg0),
            value   : 0,
            balance : 0x2::balance::zero<0x2::sui::SUI>(),
            payload : 0x1::vector::empty<u8>(),
        };
        0x2::transfer::share_object<SharedTestObject>(v0);
    }

    public fun create_shared_test_object_with_payload(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) : SharedTestObject {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0;
        while (v1 < arg0) {
            0x1::vector::push_back<u8>(&mut v0, 0);
            v1 = v1 + 1;
        };
        SharedTestObject{
            id      : 0x2::object::new(arg1),
            value   : 0,
            balance : 0x2::balance::zero<0x2::sui::SUI>(),
            payload : v0,
        }
    }

    public fun destroy_owned_object(arg0: OwnedTestObject) {
        let OwnedTestObject {
            id      : v0,
            value   : _,
            balance : v2,
            payload : _,
        } = arg0;
        0x2::object::delete(v0);
        0x2::balance::destroy_zero<0x2::sui::SUI>(v2);
    }

    fun heavy_computation(arg0: u64) : u64 {
        let v0 = arg0;
        let v1 = 0;
        while (v1 < 200) {
            v0 = v0 + v1 * 2;
            v1 = v1 + 1;
        };
        v0
    }

    fun light_computation(arg0: u64) : u64 {
        let v0 = arg0;
        let v1 = 0;
        while (v1 < 10) {
            v0 = v0 + v1 * 2;
            v1 = v1 + 1;
        };
        v0
    }

    fun medium_computation(arg0: u64) : u64 {
        let v0 = arg0;
        let v1 = 0;
        while (v1 < 50) {
            v0 = v0 + v1 * 2;
            v1 = v1 + 1;
        };
        v0
    }

    public fun payload_create_destroy_owned(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) {
        destroy_owned_object(create_owned_test_object_with_payload(arg0, arg1));
    }

    public fun payload_create_owned(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = create_owned_test_object_with_payload(arg0, arg1);
        0x2::transfer::transfer<OwnedTestObject>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun payload_create_shared(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<SharedTestObject>(create_shared_test_object_with_payload(arg0, arg1));
    }

    public fun test_balance_owned(arg0: OwnedTestObject, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        let OwnedTestObject {
            id      : v0,
            value   : v1,
            balance : v2,
            payload : v3,
        } = arg0;
        let v4 = v2;
        0x2::object::delete(v0);
        0x2::balance::join<0x2::sui::SUI>(&mut v4, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        assert!(!arg2, 102);
        let v5 = OwnedTestObject{
            id      : 0x2::object::new(arg3),
            value   : v1,
            balance : v4,
            payload : v3,
        };
        0x2::transfer::transfer<OwnedTestObject>(v5, 0x2::tx_context::sender(arg3));
    }

    public fun test_balance_shared(arg0: &mut SharedTestObject, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: bool) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        assert!(!arg2, 102);
    }

    public fun test_division_by_zero_owned(arg0: u64, arg1: u64) : u64 {
        arg0 / arg1
    }

    public fun test_division_by_zero_shared(arg0: u64, arg1: u64) : u64 {
        arg0 / arg1
    }

    public fun test_overflow_owned(arg0: u64, arg1: u64) : u64 {
        arg0 + arg1
    }

    public fun test_overflow_shared(arg0: u64, arg1: u64) : u64 {
        arg0 + arg1
    }

    public fun test_owned_deep_abort(arg0: u64) {
        heavy_computation(arg0);
        assert!(arg0 >= 100, 100);
    }

    public fun test_owned_early_abort(arg0: u64) {
        assert!(arg0 >= 100, 100);
    }

    public fun test_owned_medium_abort(arg0: u64) {
        medium_computation(arg0);
        assert!(arg0 >= 100, 100);
    }

    public fun test_owned_object_creation(arg0: bool, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = OwnedTestObject{
            id      : 0x2::object::new(arg1),
            value   : 100,
            balance : 0x2::balance::zero<0x2::sui::SUI>(),
            payload : 0x1::vector::empty<u8>(),
        };
        0x2::transfer::transfer<OwnedTestObject>(v0, 0x2::tx_context::sender(arg1));
        assert!(!arg0, 102);
    }

    public fun test_owned_object_modify(arg0: OwnedTestObject, arg1: u64, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        let OwnedTestObject {
            id      : v0,
            value   : _,
            balance : v2,
            payload : v3,
        } = arg0;
        0x2::object::delete(v0);
        let v4 = OwnedTestObject{
            id      : 0x2::object::new(arg3),
            value   : arg1,
            balance : v2,
            payload : v3,
        };
        0x2::transfer::transfer<OwnedTestObject>(v4, 0x2::tx_context::sender(arg3));
        assert!(!arg2, 102);
    }

    public fun test_owned_shallow_abort(arg0: u64) {
        light_computation(arg0);
        assert!(arg0 >= 100, 100);
    }

    public fun test_rebate_abort_owned(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = create_owned_test_object(arg0);
        heavy_computation(v0.value);
        abort 999
    }

    public fun test_rebate_destroy_then_abort_owned(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = create_owned_test_object(arg0);
        heavy_computation(v0.value);
        destroy_owned_object(v0);
        abort 999
    }

    public fun test_rebate_success_owned(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = create_owned_test_object(arg0);
        heavy_computation(v0.value);
        destroy_owned_object(v0);
    }

    public fun test_rollback_deep_owned(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = create_owned_test_object(arg0);
        let v1 = create_owned_test_object(arg0);
        let v2 = create_owned_test_object(arg0);
        let v3 = create_owned_test_object(arg0);
        let v4 = create_owned_test_object(arg0);
        let v5 = create_owned_test_object(arg0);
        let v6 = create_owned_test_object(arg0);
        let v7 = create_owned_test_object(arg0);
        let v8 = create_owned_test_object(arg0);
        let v9 = create_owned_test_object(arg0);
        0x2::transfer::transfer<OwnedTestObject>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::transfer<OwnedTestObject>(v1, 0x2::tx_context::sender(arg0));
        0x2::transfer::transfer<OwnedTestObject>(v2, 0x2::tx_context::sender(arg0));
        0x2::transfer::transfer<OwnedTestObject>(v3, 0x2::tx_context::sender(arg0));
        0x2::transfer::transfer<OwnedTestObject>(v4, 0x2::tx_context::sender(arg0));
        0x2::transfer::transfer<OwnedTestObject>(v5, 0x2::tx_context::sender(arg0));
        0x2::transfer::transfer<OwnedTestObject>(v6, 0x2::tx_context::sender(arg0));
        0x2::transfer::transfer<OwnedTestObject>(v7, 0x2::tx_context::sender(arg0));
        0x2::transfer::transfer<OwnedTestObject>(v8, 0x2::tx_context::sender(arg0));
        0x2::transfer::transfer<OwnedTestObject>(v9, 0x2::tx_context::sender(arg0));
        abort 102
    }

    public fun test_rollback_medium_owned(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = create_owned_test_object(arg0);
        let v1 = create_owned_test_object(arg0);
        let v2 = create_owned_test_object(arg0);
        let v3 = create_owned_test_object(arg0);
        let v4 = create_owned_test_object(arg0);
        0x2::transfer::transfer<OwnedTestObject>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::transfer<OwnedTestObject>(v1, 0x2::tx_context::sender(arg0));
        0x2::transfer::transfer<OwnedTestObject>(v2, 0x2::tx_context::sender(arg0));
        0x2::transfer::transfer<OwnedTestObject>(v3, 0x2::tx_context::sender(arg0));
        0x2::transfer::transfer<OwnedTestObject>(v4, 0x2::tx_context::sender(arg0));
        abort 102
    }

    public fun test_rollback_shallow_owned(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = create_owned_test_object(arg0);
        0x2::transfer::transfer<OwnedTestObject>(v0, 0x2::tx_context::sender(arg0));
        abort 102
    }

    public fun test_shared_deep_abort(arg0: u64) {
        heavy_computation(arg0);
        assert!(arg0 >= 100, 100);
    }

    public fun test_shared_early_abort(arg0: u64) {
        assert!(arg0 >= 100, 100);
    }

    public fun test_shared_medium_abort(arg0: u64) {
        medium_computation(arg0);
        assert!(arg0 >= 100, 100);
    }

    public fun test_shared_object_creation(arg0: bool, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = SharedTestObject{
            id      : 0x2::object::new(arg1),
            value   : 100,
            balance : 0x2::balance::zero<0x2::sui::SUI>(),
            payload : 0x1::vector::empty<u8>(),
        };
        0x2::transfer::share_object<SharedTestObject>(v0);
        assert!(!arg0, 102);
    }

    public fun test_shared_object_modify(arg0: &mut SharedTestObject, arg1: u64, arg2: bool) {
        arg0.value = arg1;
        assert!(!arg2, 102);
    }

    public fun test_shared_shallow_abort(arg0: u64) {
        light_computation(arg0);
        assert!(arg0 >= 100, 100);
    }

    public fun test_vector_oob_owned(arg0: u64) : u64 {
        let v0 = vector[10, 20, 30];
        *0x1::vector::borrow<u64>(&v0, arg0)
    }

    public fun test_vector_oob_shared(arg0: u64) : u64 {
        let v0 = vector[10, 20, 30];
        *0x1::vector::borrow<u64>(&v0, arg0)
    }

    // decompiled from Move bytecode v6
}

