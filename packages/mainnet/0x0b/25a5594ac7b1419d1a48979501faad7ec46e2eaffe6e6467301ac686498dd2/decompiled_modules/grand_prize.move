module 0xb25a5594ac7b1419d1a48979501faad7ec46e2eaffe6e6467301ac686498dd2::grand_prize {
    struct InitEvent has copy, drop {
        admin_cap_id: 0x2::object::ID,
    }

    struct InitGrandPrizeEvent has copy, drop {
        grand_prize_id: 0x2::object::ID,
    }

    struct ClaimEvent has copy, drop {
        sender: address,
        grand_prize_id: 0x2::object::ID,
        coin_type_1: 0x1::type_name::TypeName,
        amount_1: u64,
        coin_type_2: 0x1::type_name::TypeName,
        amount_2: u64,
        coin_type_3: 0x1::type_name::TypeName,
        amount_3: u64,
        coin_type_sui: 0x1::type_name::TypeName,
        amount_sui: u64,
        claim_at: u64,
    }

    struct Winner has drop, store {
        owner: address,
        amount_t1: u64,
        amount_t2: u64,
        amount_t3: u64,
        amount_sui: u64,
    }

    struct GrandPrize<phantom T0, phantom T1, phantom T2> has store, key {
        id: 0x2::object::UID,
        balance_t1: 0x2::balance::Balance<T0>,
        balance_t2: 0x2::balance::Balance<T1>,
        balance_t3: 0x2::balance::Balance<T2>,
        balance_sui: 0x2::balance::Balance<0x2::sui::SUI>,
        winners: vector<Winner>,
    }

    entry fun claim<T0, T1, T2>(arg0: &mut GrandPrize<T0, T1, T2>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        let v1 = false;
        while (v0 < 0x1::vector::length<Winner>(&arg0.winners)) {
            if (0x1::vector::borrow<Winner>(&arg0.winners, v0).owner == 0x2::tx_context::sender(arg2)) {
                v1 = true;
                break
            };
            v0 = v0 + 1;
        };
        assert!(v1, 9223372809948889087);
        let v2 = 0x1::vector::remove<Winner>(&mut arg0.winners, v0);
        assert!(0x2::balance::value<T0>(&arg0.balance_t1) >= v2.amount_t1, 9223372835718692863);
        assert!(0x2::balance::value<T1>(&arg0.balance_t2) >= v2.amount_t2, 9223372840013660159);
        assert!(0x2::balance::value<T2>(&arg0.balance_t3) >= v2.amount_t3, 9223372844308627455);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.balance_sui) >= v2.amount_sui, 9223372848603594751);
        if (v2.amount_t1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.balance_t1, v2.amount_t1, arg2), v2.owner);
        };
        if (v2.amount_t2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(&mut arg0.balance_t2, v2.amount_t2, arg2), v2.owner);
        };
        if (v2.amount_t3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::take<T2>(&mut arg0.balance_t3, v2.amount_t3, arg2), v2.owner);
        };
        if (v2.amount_sui > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.balance_sui, v2.amount_sui, arg2), v2.owner);
        };
        let v3 = ClaimEvent{
            sender         : v2.owner,
            grand_prize_id : 0x2::object::id<GrandPrize<T0, T1, T2>>(arg0),
            coin_type_1    : 0x1::type_name::get<T0>(),
            amount_1       : v2.amount_t1,
            coin_type_2    : 0x1::type_name::get<T1>(),
            amount_2       : v2.amount_t2,
            coin_type_3    : 0x1::type_name::get<T2>(),
            amount_3       : v2.amount_t3,
            coin_type_sui  : 0x1::type_name::get<0x2::sui::SUI>(),
            amount_sui     : v2.amount_sui,
            claim_at       : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<ClaimEvent>(v3);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xb25a5594ac7b1419d1a48979501faad7ec46e2eaffe6e6467301ac686498dd2::admin::new(arg0);
        0x2::transfer::public_transfer<0xb25a5594ac7b1419d1a48979501faad7ec46e2eaffe6e6467301ac686498dd2::admin::AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = InitEvent{admin_cap_id: 0x2::object::id<0xb25a5594ac7b1419d1a48979501faad7ec46e2eaffe6e6467301ac686498dd2::admin::AdminCap>(&v0)};
        0x2::event::emit<InitEvent>(v1);
    }

    entry fun init_grandPrize<T0, T1, T2>(arg0: &0xb25a5594ac7b1419d1a48979501faad7ec46e2eaffe6e6467301ac686498dd2::admin::AdminCap, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: 0x2::coin::Coin<T2>, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: vector<address>, arg6: vector<u64>, arg7: vector<u64>, arg8: vector<u64>, arg9: vector<u64>, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<address>(&arg5) == 0x1::vector::length<u64>(&arg6), 9223372401926995967);
        assert!(0x1::vector::length<address>(&arg5) == 0x1::vector::length<u64>(&arg7), 9223372406221963263);
        assert!(0x1::vector::length<address>(&arg5) == 0x1::vector::length<u64>(&arg8), 9223372410516930559);
        assert!(0x1::vector::length<address>(&arg5) == 0x1::vector::length<u64>(&arg9), 9223372414811897855);
        let v0 = 0;
        let v1 = 0;
        let v2 = 0;
        let v3 = 0;
        let v4 = 0x1::vector::empty<Winner>();
        while (!0x1::vector::is_empty<address>(&arg5)) {
            let v5 = 0x1::vector::pop_back<u64>(&mut arg6);
            let v6 = 0x1::vector::pop_back<u64>(&mut arg7);
            let v7 = 0x1::vector::pop_back<u64>(&mut arg8);
            let v8 = 0x1::vector::pop_back<u64>(&mut arg9);
            v0 = v0 + v5;
            v1 = v1 + v6;
            v2 = v2 + v7;
            v3 = v3 + v8;
            let v9 = Winner{
                owner      : 0x1::vector::pop_back<address>(&mut arg5),
                amount_t1  : v5,
                amount_t2  : v6,
                amount_t3  : v7,
                amount_sui : v8,
            };
            0x1::vector::push_back<Winner>(&mut v4, v9);
        };
        assert!(0x2::coin::value<T0>(&arg1) >= v0, 9223372547955884031);
        assert!(0x2::coin::value<T1>(&arg2) >= v1, 9223372552250851327);
        assert!(0x2::coin::value<T2>(&arg3) >= v2, 9223372556545818623);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg4) >= v3, 9223372560840785919);
        let v10 = 0x2::coin::into_balance<T0>(arg1);
        let v11 = 0x2::coin::into_balance<T1>(arg2);
        let v12 = 0x2::coin::into_balance<T2>(arg3);
        let v13 = 0x2::coin::into_balance<0x2::sui::SUI>(arg4);
        let v14 = GrandPrize<T0, T1, T2>{
            id          : 0x2::object::new(arg10),
            balance_t1  : 0x2::balance::split<T0>(&mut v10, v0),
            balance_t2  : 0x2::balance::split<T1>(&mut v11, v1),
            balance_t3  : 0x2::balance::split<T2>(&mut v12, v2),
            balance_sui : 0x2::balance::split<0x2::sui::SUI>(&mut v13, v3),
            winners     : v4,
        };
        if (0x2::balance::value<T0>(&v10) == 0) {
            0x2::balance::destroy_zero<T0>(v10);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v10, arg10), 0x2::tx_context::sender(arg10));
        };
        if (0x2::balance::value<T1>(&v11) == 0) {
            0x2::balance::destroy_zero<T1>(v11);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v11, arg10), 0x2::tx_context::sender(arg10));
        };
        if (0x2::balance::value<T2>(&v12) == 0) {
            0x2::balance::destroy_zero<T2>(v12);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v12, arg10), 0x2::tx_context::sender(arg10));
        };
        if (0x2::balance::value<0x2::sui::SUI>(&v13) == 0) {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v13);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v13, arg10), 0x2::tx_context::sender(arg10));
        };
        0x2::transfer::public_share_object<GrandPrize<T0, T1, T2>>(v14);
        let v15 = InitGrandPrizeEvent{grand_prize_id: 0x2::object::id<GrandPrize<T0, T1, T2>>(&v14)};
        0x2::event::emit<InitGrandPrizeEvent>(v15);
    }

    // decompiled from Move bytecode v6
}

