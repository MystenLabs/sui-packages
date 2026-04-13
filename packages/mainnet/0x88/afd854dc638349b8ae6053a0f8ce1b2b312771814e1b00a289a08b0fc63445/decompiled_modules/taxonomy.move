module 0x88afd854dc638349b8ae6053a0f8ce1b2b312771814e1b00a289a08b0fc63445::taxonomy {
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

    fun build_payload(arg0: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0;
        while (v1 < arg0) {
            0x1::vector::push_back<u8>(&mut v0, 0);
            v1 = v1 + 1;
        };
        v0
    }

    public fun create_and_share_shared(arg0: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<SharedTestObject>(create_shared_object(arg0));
    }

    public fun create_and_transfer_owned(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = create_owned(arg0);
        0x2::transfer::transfer<OwnedTestObject>(v0, 0x2::tx_context::sender(arg0));
    }

    fun create_owned(arg0: &mut 0x2::tx_context::TxContext) : OwnedTestObject {
        OwnedTestObject{
            id      : 0x2::object::new(arg0),
            value   : 0,
            balance : 0x2::balance::zero<0x2::sui::SUI>(),
            payload : 0x1::vector::empty<u8>(),
        }
    }

    fun create_owned_with_payload(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) : OwnedTestObject {
        OwnedTestObject{
            id      : 0x2::object::new(arg1),
            value   : 0,
            balance : 0x2::balance::zero<0x2::sui::SUI>(),
            payload : build_payload(arg0),
        }
    }

    fun create_shared_object(arg0: &mut 0x2::tx_context::TxContext) : SharedTestObject {
        SharedTestObject{
            id      : 0x2::object::new(arg0),
            value   : 0,
            balance : 0x2::balance::zero<0x2::sui::SUI>(),
            payload : 0x1::vector::empty<u8>(),
        }
    }

    fun create_shared_with_payload(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) : SharedTestObject {
        SharedTestObject{
            id      : 0x2::object::new(arg1),
            value   : 0,
            balance : 0x2::balance::zero<0x2::sui::SUI>(),
            payload : build_payload(arg0),
        }
    }

    fun deposit_and_rebuild_owned(arg0: OwnedTestObject, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) : OwnedTestObject {
        let OwnedTestObject {
            id      : v0,
            value   : v1,
            balance : v2,
            payload : v3,
        } = arg0;
        let v4 = v2;
        0x2::object::delete(v0);
        0x2::balance::join<0x2::sui::SUI>(&mut v4, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        OwnedTestObject{
            id      : 0x2::object::new(arg2),
            value   : v1,
            balance : v4,
            payload : v3,
        }
    }

    fun destroy_owned(arg0: OwnedTestObject) {
        let OwnedTestObject {
            id      : v0,
            value   : _,
            balance : v2,
            payload : _,
        } = arg0;
        0x2::object::delete(v0);
        0x2::balance::destroy_zero<0x2::sui::SUI>(v2);
    }

    public fun multi_balance_owned_10(arg0: OwnedTestObject, arg1: OwnedTestObject, arg2: OwnedTestObject, arg3: OwnedTestObject, arg4: OwnedTestObject, arg5: OwnedTestObject, arg6: OwnedTestObject, arg7: OwnedTestObject, arg8: OwnedTestObject, arg9: OwnedTestObject, arg10: 0x2::coin::Coin<0x2::sui::SUI>, arg11: 0x2::coin::Coin<0x2::sui::SUI>, arg12: 0x2::coin::Coin<0x2::sui::SUI>, arg13: 0x2::coin::Coin<0x2::sui::SUI>, arg14: 0x2::coin::Coin<0x2::sui::SUI>, arg15: 0x2::coin::Coin<0x2::sui::SUI>, arg16: 0x2::coin::Coin<0x2::sui::SUI>, arg17: 0x2::coin::Coin<0x2::sui::SUI>, arg18: 0x2::coin::Coin<0x2::sui::SUI>, arg19: 0x2::coin::Coin<0x2::sui::SUI>, arg20: bool, arg21: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg21);
        let v1 = deposit_and_rebuild_owned(arg0, arg10, arg21);
        let v2 = deposit_and_rebuild_owned(arg1, arg11, arg21);
        let v3 = deposit_and_rebuild_owned(arg2, arg12, arg21);
        let v4 = deposit_and_rebuild_owned(arg3, arg13, arg21);
        let v5 = deposit_and_rebuild_owned(arg4, arg14, arg21);
        let v6 = deposit_and_rebuild_owned(arg5, arg15, arg21);
        let v7 = deposit_and_rebuild_owned(arg6, arg16, arg21);
        let v8 = deposit_and_rebuild_owned(arg7, arg17, arg21);
        let v9 = deposit_and_rebuild_owned(arg8, arg18, arg21);
        0x2::transfer::transfer<OwnedTestObject>(v1, v0);
        0x2::transfer::transfer<OwnedTestObject>(v2, v0);
        0x2::transfer::transfer<OwnedTestObject>(v3, v0);
        0x2::transfer::transfer<OwnedTestObject>(v4, v0);
        0x2::transfer::transfer<OwnedTestObject>(v5, v0);
        0x2::transfer::transfer<OwnedTestObject>(v6, v0);
        0x2::transfer::transfer<OwnedTestObject>(v7, v0);
        0x2::transfer::transfer<OwnedTestObject>(v8, v0);
        0x2::transfer::transfer<OwnedTestObject>(v9, v0);
        0x2::transfer::transfer<OwnedTestObject>(deposit_and_rebuild_owned(arg9, arg19, arg21), v0);
        assert!(!arg20, 102);
    }

    public fun multi_balance_owned_2(arg0: OwnedTestObject, arg1: OwnedTestObject, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = deposit_and_rebuild_owned(arg0, arg2, arg5);
        0x2::transfer::transfer<OwnedTestObject>(v1, v0);
        0x2::transfer::transfer<OwnedTestObject>(deposit_and_rebuild_owned(arg1, arg3, arg5), v0);
        assert!(!arg4, 102);
    }

    public fun multi_balance_owned_5(arg0: OwnedTestObject, arg1: OwnedTestObject, arg2: OwnedTestObject, arg3: OwnedTestObject, arg4: OwnedTestObject, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: 0x2::coin::Coin<0x2::sui::SUI>, arg9: 0x2::coin::Coin<0x2::sui::SUI>, arg10: bool, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg11);
        let v1 = deposit_and_rebuild_owned(arg0, arg5, arg11);
        let v2 = deposit_and_rebuild_owned(arg1, arg6, arg11);
        let v3 = deposit_and_rebuild_owned(arg2, arg7, arg11);
        let v4 = deposit_and_rebuild_owned(arg3, arg8, arg11);
        0x2::transfer::transfer<OwnedTestObject>(v1, v0);
        0x2::transfer::transfer<OwnedTestObject>(v2, v0);
        0x2::transfer::transfer<OwnedTestObject>(v3, v0);
        0x2::transfer::transfer<OwnedTestObject>(v4, v0);
        0x2::transfer::transfer<OwnedTestObject>(deposit_and_rebuild_owned(arg4, arg9, arg11), v0);
        assert!(!arg10, 102);
    }

    public fun multi_balance_shared_10(arg0: &mut SharedTestObject, arg1: &mut SharedTestObject, arg2: &mut SharedTestObject, arg3: &mut SharedTestObject, arg4: &mut SharedTestObject, arg5: &mut SharedTestObject, arg6: &mut SharedTestObject, arg7: &mut SharedTestObject, arg8: &mut SharedTestObject, arg9: &mut SharedTestObject, arg10: 0x2::coin::Coin<0x2::sui::SUI>, arg11: 0x2::coin::Coin<0x2::sui::SUI>, arg12: 0x2::coin::Coin<0x2::sui::SUI>, arg13: 0x2::coin::Coin<0x2::sui::SUI>, arg14: 0x2::coin::Coin<0x2::sui::SUI>, arg15: 0x2::coin::Coin<0x2::sui::SUI>, arg16: 0x2::coin::Coin<0x2::sui::SUI>, arg17: 0x2::coin::Coin<0x2::sui::SUI>, arg18: 0x2::coin::Coin<0x2::sui::SUI>, arg19: 0x2::coin::Coin<0x2::sui::SUI>, arg20: bool) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg10));
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg11));
        0x2::balance::join<0x2::sui::SUI>(&mut arg2.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg12));
        0x2::balance::join<0x2::sui::SUI>(&mut arg3.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg13));
        0x2::balance::join<0x2::sui::SUI>(&mut arg4.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg14));
        0x2::balance::join<0x2::sui::SUI>(&mut arg5.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg15));
        0x2::balance::join<0x2::sui::SUI>(&mut arg6.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg16));
        0x2::balance::join<0x2::sui::SUI>(&mut arg7.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg17));
        0x2::balance::join<0x2::sui::SUI>(&mut arg8.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg18));
        0x2::balance::join<0x2::sui::SUI>(&mut arg9.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg19));
        assert!(!arg20, 102);
    }

    public fun multi_balance_shared_2(arg0: &mut SharedTestObject, arg1: &mut SharedTestObject, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: bool) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg3));
        assert!(!arg4, 102);
    }

    public fun multi_balance_shared_5(arg0: &mut SharedTestObject, arg1: &mut SharedTestObject, arg2: &mut SharedTestObject, arg3: &mut SharedTestObject, arg4: &mut SharedTestObject, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: 0x2::coin::Coin<0x2::sui::SUI>, arg9: 0x2::coin::Coin<0x2::sui::SUI>, arg10: bool) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg5));
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg6));
        0x2::balance::join<0x2::sui::SUI>(&mut arg2.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg7));
        0x2::balance::join<0x2::sui::SUI>(&mut arg3.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg8));
        0x2::balance::join<0x2::sui::SUI>(&mut arg4.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg9));
        assert!(!arg10, 102);
    }

    public fun multi_payload_owned_10(arg0: u64, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = create_owned_with_payload(arg0, arg2);
        let v2 = create_owned_with_payload(arg0, arg2);
        let v3 = create_owned_with_payload(arg0, arg2);
        let v4 = create_owned_with_payload(arg0, arg2);
        let v5 = create_owned_with_payload(arg0, arg2);
        let v6 = create_owned_with_payload(arg0, arg2);
        let v7 = create_owned_with_payload(arg0, arg2);
        let v8 = create_owned_with_payload(arg0, arg2);
        let v9 = create_owned_with_payload(arg0, arg2);
        0x2::transfer::transfer<OwnedTestObject>(v1, v0);
        0x2::transfer::transfer<OwnedTestObject>(v2, v0);
        0x2::transfer::transfer<OwnedTestObject>(v3, v0);
        0x2::transfer::transfer<OwnedTestObject>(v4, v0);
        0x2::transfer::transfer<OwnedTestObject>(v5, v0);
        0x2::transfer::transfer<OwnedTestObject>(v6, v0);
        0x2::transfer::transfer<OwnedTestObject>(v7, v0);
        0x2::transfer::transfer<OwnedTestObject>(v8, v0);
        0x2::transfer::transfer<OwnedTestObject>(v9, v0);
        0x2::transfer::transfer<OwnedTestObject>(create_owned_with_payload(arg0, arg2), v0);
        assert!(!arg1, 102);
    }

    public fun multi_payload_owned_2(arg0: u64, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = create_owned_with_payload(arg0, arg2);
        0x2::transfer::transfer<OwnedTestObject>(v1, v0);
        0x2::transfer::transfer<OwnedTestObject>(create_owned_with_payload(arg0, arg2), v0);
        assert!(!arg1, 102);
    }

    public fun multi_payload_owned_5(arg0: u64, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = create_owned_with_payload(arg0, arg2);
        let v2 = create_owned_with_payload(arg0, arg2);
        let v3 = create_owned_with_payload(arg0, arg2);
        let v4 = create_owned_with_payload(arg0, arg2);
        0x2::transfer::transfer<OwnedTestObject>(v1, v0);
        0x2::transfer::transfer<OwnedTestObject>(v2, v0);
        0x2::transfer::transfer<OwnedTestObject>(v3, v0);
        0x2::transfer::transfer<OwnedTestObject>(v4, v0);
        0x2::transfer::transfer<OwnedTestObject>(create_owned_with_payload(arg0, arg2), v0);
        assert!(!arg1, 102);
    }

    public fun multi_payload_shared_10(arg0: u64, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = create_shared_with_payload(arg0, arg2);
        let v1 = create_shared_with_payload(arg0, arg2);
        let v2 = create_shared_with_payload(arg0, arg2);
        let v3 = create_shared_with_payload(arg0, arg2);
        let v4 = create_shared_with_payload(arg0, arg2);
        let v5 = create_shared_with_payload(arg0, arg2);
        let v6 = create_shared_with_payload(arg0, arg2);
        let v7 = create_shared_with_payload(arg0, arg2);
        let v8 = create_shared_with_payload(arg0, arg2);
        0x2::transfer::share_object<SharedTestObject>(v0);
        0x2::transfer::share_object<SharedTestObject>(v1);
        0x2::transfer::share_object<SharedTestObject>(v2);
        0x2::transfer::share_object<SharedTestObject>(v3);
        0x2::transfer::share_object<SharedTestObject>(v4);
        0x2::transfer::share_object<SharedTestObject>(v5);
        0x2::transfer::share_object<SharedTestObject>(v6);
        0x2::transfer::share_object<SharedTestObject>(v7);
        0x2::transfer::share_object<SharedTestObject>(v8);
        0x2::transfer::share_object<SharedTestObject>(create_shared_with_payload(arg0, arg2));
        assert!(!arg1, 102);
    }

    public fun multi_payload_shared_2(arg0: u64, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = create_shared_with_payload(arg0, arg2);
        0x2::transfer::share_object<SharedTestObject>(v0);
        0x2::transfer::share_object<SharedTestObject>(create_shared_with_payload(arg0, arg2));
        assert!(!arg1, 102);
    }

    public fun multi_payload_shared_5(arg0: u64, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = create_shared_with_payload(arg0, arg2);
        let v1 = create_shared_with_payload(arg0, arg2);
        let v2 = create_shared_with_payload(arg0, arg2);
        let v3 = create_shared_with_payload(arg0, arg2);
        0x2::transfer::share_object<SharedTestObject>(v0);
        0x2::transfer::share_object<SharedTestObject>(v1);
        0x2::transfer::share_object<SharedTestObject>(v2);
        0x2::transfer::share_object<SharedTestObject>(v3);
        0x2::transfer::share_object<SharedTestObject>(create_shared_with_payload(arg0, arg2));
        assert!(!arg1, 102);
    }

    public fun multi_rebate_owned_10(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = create_owned(arg0);
        let v1 = create_owned(arg0);
        let v2 = create_owned(arg0);
        let v3 = create_owned(arg0);
        let v4 = create_owned(arg0);
        let v5 = create_owned(arg0);
        let v6 = create_owned(arg0);
        let v7 = create_owned(arg0);
        let v8 = create_owned(arg0);
        destroy_owned(v0);
        destroy_owned(v1);
        destroy_owned(v2);
        destroy_owned(v3);
        destroy_owned(v4);
        destroy_owned(v5);
        destroy_owned(v6);
        destroy_owned(v7);
        destroy_owned(v8);
        destroy_owned(create_owned(arg0));
        abort 999
    }

    public fun multi_rebate_owned_2(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = create_owned(arg0);
        destroy_owned(v0);
        destroy_owned(create_owned(arg0));
        abort 999
    }

    public fun multi_rebate_owned_5(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = create_owned(arg0);
        let v1 = create_owned(arg0);
        let v2 = create_owned(arg0);
        let v3 = create_owned(arg0);
        destroy_owned(v0);
        destroy_owned(v1);
        destroy_owned(v2);
        destroy_owned(v3);
        destroy_owned(create_owned(arg0));
        abort 999
    }

    public fun multi_rebate_shared_10(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = create_shared_object(arg0);
        let v1 = create_shared_object(arg0);
        let v2 = create_shared_object(arg0);
        let v3 = create_shared_object(arg0);
        let v4 = create_shared_object(arg0);
        let v5 = create_shared_object(arg0);
        let v6 = create_shared_object(arg0);
        let v7 = create_shared_object(arg0);
        let v8 = create_shared_object(arg0);
        0x2::transfer::share_object<SharedTestObject>(v0);
        0x2::transfer::share_object<SharedTestObject>(v1);
        0x2::transfer::share_object<SharedTestObject>(v2);
        0x2::transfer::share_object<SharedTestObject>(v3);
        0x2::transfer::share_object<SharedTestObject>(v4);
        0x2::transfer::share_object<SharedTestObject>(v5);
        0x2::transfer::share_object<SharedTestObject>(v6);
        0x2::transfer::share_object<SharedTestObject>(v7);
        0x2::transfer::share_object<SharedTestObject>(v8);
        0x2::transfer::share_object<SharedTestObject>(create_shared_object(arg0));
        abort 999
    }

    public fun multi_rebate_shared_2(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = create_shared_object(arg0);
        0x2::transfer::share_object<SharedTestObject>(v0);
        0x2::transfer::share_object<SharedTestObject>(create_shared_object(arg0));
        abort 999
    }

    public fun multi_rebate_shared_5(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = create_shared_object(arg0);
        let v1 = create_shared_object(arg0);
        let v2 = create_shared_object(arg0);
        let v3 = create_shared_object(arg0);
        0x2::transfer::share_object<SharedTestObject>(v0);
        0x2::transfer::share_object<SharedTestObject>(v1);
        0x2::transfer::share_object<SharedTestObject>(v2);
        0x2::transfer::share_object<SharedTestObject>(v3);
        0x2::transfer::share_object<SharedTestObject>(create_shared_object(arg0));
        abort 999
    }

    public fun multi_rollback_owned_10(arg0: bool, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = create_owned(arg1);
        let v2 = create_owned(arg1);
        let v3 = create_owned(arg1);
        let v4 = create_owned(arg1);
        let v5 = create_owned(arg1);
        let v6 = create_owned(arg1);
        let v7 = create_owned(arg1);
        let v8 = create_owned(arg1);
        let v9 = create_owned(arg1);
        0x2::transfer::transfer<OwnedTestObject>(v1, v0);
        0x2::transfer::transfer<OwnedTestObject>(v2, v0);
        0x2::transfer::transfer<OwnedTestObject>(v3, v0);
        0x2::transfer::transfer<OwnedTestObject>(v4, v0);
        0x2::transfer::transfer<OwnedTestObject>(v5, v0);
        0x2::transfer::transfer<OwnedTestObject>(v6, v0);
        0x2::transfer::transfer<OwnedTestObject>(v7, v0);
        0x2::transfer::transfer<OwnedTestObject>(v8, v0);
        0x2::transfer::transfer<OwnedTestObject>(v9, v0);
        0x2::transfer::transfer<OwnedTestObject>(create_owned(arg1), v0);
        assert!(!arg0, 102);
    }

    public fun multi_rollback_owned_2(arg0: bool, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = create_owned(arg1);
        0x2::transfer::transfer<OwnedTestObject>(v1, v0);
        0x2::transfer::transfer<OwnedTestObject>(create_owned(arg1), v0);
        assert!(!arg0, 102);
    }

    public fun multi_rollback_owned_5(arg0: bool, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = create_owned(arg1);
        let v2 = create_owned(arg1);
        let v3 = create_owned(arg1);
        let v4 = create_owned(arg1);
        0x2::transfer::transfer<OwnedTestObject>(v1, v0);
        0x2::transfer::transfer<OwnedTestObject>(v2, v0);
        0x2::transfer::transfer<OwnedTestObject>(v3, v0);
        0x2::transfer::transfer<OwnedTestObject>(v4, v0);
        0x2::transfer::transfer<OwnedTestObject>(create_owned(arg1), v0);
        assert!(!arg0, 102);
    }

    public fun multi_rollback_shared_10(arg0: bool, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = create_shared_object(arg1);
        let v1 = create_shared_object(arg1);
        let v2 = create_shared_object(arg1);
        let v3 = create_shared_object(arg1);
        let v4 = create_shared_object(arg1);
        let v5 = create_shared_object(arg1);
        let v6 = create_shared_object(arg1);
        let v7 = create_shared_object(arg1);
        let v8 = create_shared_object(arg1);
        0x2::transfer::share_object<SharedTestObject>(v0);
        0x2::transfer::share_object<SharedTestObject>(v1);
        0x2::transfer::share_object<SharedTestObject>(v2);
        0x2::transfer::share_object<SharedTestObject>(v3);
        0x2::transfer::share_object<SharedTestObject>(v4);
        0x2::transfer::share_object<SharedTestObject>(v5);
        0x2::transfer::share_object<SharedTestObject>(v6);
        0x2::transfer::share_object<SharedTestObject>(v7);
        0x2::transfer::share_object<SharedTestObject>(v8);
        0x2::transfer::share_object<SharedTestObject>(create_shared_object(arg1));
        assert!(!arg0, 102);
    }

    public fun multi_rollback_shared_2(arg0: bool, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = create_shared_object(arg1);
        0x2::transfer::share_object<SharedTestObject>(v0);
        0x2::transfer::share_object<SharedTestObject>(create_shared_object(arg1));
        assert!(!arg0, 102);
    }

    public fun multi_rollback_shared_5(arg0: bool, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = create_shared_object(arg1);
        let v1 = create_shared_object(arg1);
        let v2 = create_shared_object(arg1);
        let v3 = create_shared_object(arg1);
        0x2::transfer::share_object<SharedTestObject>(v0);
        0x2::transfer::share_object<SharedTestObject>(v1);
        0x2::transfer::share_object<SharedTestObject>(v2);
        0x2::transfer::share_object<SharedTestObject>(v3);
        0x2::transfer::share_object<SharedTestObject>(create_shared_object(arg1));
        assert!(!arg0, 102);
    }

    // decompiled from Move bytecode v6
}

