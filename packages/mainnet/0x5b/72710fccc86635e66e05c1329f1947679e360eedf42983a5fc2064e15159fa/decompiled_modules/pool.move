module 0x5b72710fccc86635e66e05c1329f1947679e360eedf42983a5fc2064e15159fa::pool {
    struct Pool<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        balanceA: 0x2::balance::Balance<T0>,
        balanceB: 0x2::balance::Balance<T1>,
    }

    struct Lol has drop {
        a: u64,
        b: vector<u64>,
    }

    struct POOL has drop {
        dummy_field: bool,
    }

    public fun new<T0, T1>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Pool<T0, T1>{
            id       : 0x2::object::new(arg0),
            balanceA : 0x2::balance::zero<T0>(),
            balanceB : 0x2::balance::zero<T1>(),
        };
        0x2::transfer::share_object<Pool<T0, T1>>(v0);
    }

    public fun add_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>) {
        0x2::balance::join<T0>(&mut arg0.balanceA, 0x2::coin::into_balance<T0>(arg1));
        0x2::balance::join<T1>(&mut arg0.balanceB, 0x2::coin::into_balance<T1>(arg2));
    }

    fun init(arg0: POOL, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<POOL>(arg0, arg1);
    }

    public fun newLol(arg0: u64, arg1: vector<u64>) : Lol {
        Lol{
            a : arg0,
            b : arg1,
        }
    }

    public fun remove_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        (0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balanceA, arg1), arg3), 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.balanceB, arg2), arg3))
    }

    public fun swap_a_to_b<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = &mut arg0.balanceA;
        let v1 = &mut arg0.balanceB;
        swap_coin<T0, T1>(v0, v1, arg1, arg2)
    }

    public fun swap_b_to_a<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = &mut arg0.balanceB;
        let v1 = &mut arg0.balanceA;
        swap_coin<T1, T0>(v0, v1, arg1, arg2)
    }

    fun swap_coin<T0, T1>(arg0: &mut 0x2::balance::Balance<T0>, arg1: &mut 0x2::balance::Balance<T1>, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x2::balance::join<T0>(arg0, 0x2::coin::into_balance<T0>(arg2));
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(arg1, 0x2::coin::value<T0>(&arg2)), arg3)
    }

    // decompiled from Move bytecode v6
}

