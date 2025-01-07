module 0xd92c26d471209672daaec06466ff3488da211260ea4eb472da79f5e81d112287::swap {
    struct Bank<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        a: 0x2::balance::Balance<T0>,
        b: 0x2::balance::Balance<T1>,
        lp: 0x2::balance::Supply<LPCoin<T0, T1>>,
        fee: u64,
        scaler: u64,
    }

    struct LPCoin<phantom T0, phantom T1> has drop {
        dummy_field: bool,
    }

    public fun a_to_b<T0, T1>(arg0: &mut Bank<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<T0>(&arg0.a);
        let v1 = 0x2::balance::value<T1>(&arg0.b);
        let v2 = 0x2::coin::value<T0>(&arg1);
        0x2::balance::join<T0>(&mut arg0.a, 0x2::coin::into_balance<T0>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.b, v1 - v0 * v1 / (v0 + v2 - v2 * arg0.fee / arg0.scaler)), arg2), 0x2::tx_context::sender(arg2));
    }

    public fun add<T0, T1>(arg0: &mut Bank<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        let v1 = 0x2::coin::value<T1>(&arg2);
        assert!(get_bank_price<T0, T1>(arg0) == get_price<T0, T1>(arg0, v0, v1), 1);
        0x2::balance::join<T0>(&mut arg0.a, 0x2::coin::into_balance<T0>(arg1));
        0x2::balance::join<T1>(&mut arg0.b, 0x2::coin::into_balance<T1>(arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<LPCoin<T0, T1>>>(0x2::coin::from_balance<LPCoin<T0, T1>>(0x2::balance::increase_supply<LPCoin<T0, T1>>(&mut arg0.lp, 0x1::u64::sqrt(v0 * v1)), arg3), 0x2::tx_context::sender(arg3));
    }

    public fun add_bank<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = LPCoin<T0, T1>{dummy_field: false};
        let v1 = Bank<T0, T1>{
            id     : 0x2::object::new(arg4),
            a      : 0x2::coin::into_balance<T0>(arg0),
            b      : 0x2::coin::into_balance<T1>(arg1),
            lp     : 0x2::balance::create_supply<LPCoin<T0, T1>>(v0),
            fee    : arg2,
            scaler : arg3,
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<LPCoin<T0, T1>>>(0x2::coin::from_balance<LPCoin<T0, T1>>(0x2::balance::increase_supply<LPCoin<T0, T1>>(&mut v1.lp, 0x1::u64::sqrt(0x2::coin::value<T0>(&arg0) * 0x2::coin::value<T1>(&arg1))), arg4), 0x2::tx_context::sender(arg4));
        0x2::transfer::share_object<Bank<T0, T1>>(v1);
    }

    public fun b_to_a<T0, T1>(arg0: &mut Bank<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<T0>(&arg0.a);
        let v1 = 0x2::balance::value<T1>(&arg0.b);
        let v2 = 0x2::coin::value<T1>(&arg1);
        0x2::balance::join<T1>(&mut arg0.b, 0x2::coin::into_balance<T1>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.a, v0 - v0 * v1 / (v1 + v2 - v2 * arg0.fee / arg0.scaler)), arg2), 0x2::tx_context::sender(arg2));
    }

    public fun get_bank_price<T0, T1>(arg0: &Bank<T0, T1>) : u64 {
        arg0.scaler * 0x2::balance::value<T0>(&arg0.a) / 0x2::balance::value<T1>(&arg0.b)
    }

    public fun get_price<T0, T1>(arg0: &Bank<T0, T1>, arg1: u64, arg2: u64) : u64 {
        arg0.scaler * arg1 / arg2
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public fun remove<T0, T1>(arg0: &mut Bank<T0, T1>, arg1: 0x2::coin::Coin<LPCoin<T0, T1>>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::decrease_supply<LPCoin<T0, T1>>(&mut arg0.lp, 0x2::coin::into_balance<LPCoin<T0, T1>>(arg1));
        let v0 = arg0.scaler * 0x2::coin::value<LPCoin<T0, T1>>(&arg1) / 0x2::balance::supply_value<LPCoin<T0, T1>>(&arg0.lp);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.a, 0x2::balance::value<T0>(&arg0.a) * v0 / arg0.scaler), arg2), 0x2::tx_context::sender(arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.b, 0x2::balance::value<T1>(&arg0.b) * v0 / arg0.scaler), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

