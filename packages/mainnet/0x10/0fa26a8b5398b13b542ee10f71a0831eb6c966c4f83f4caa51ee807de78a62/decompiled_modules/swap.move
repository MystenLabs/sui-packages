module 0x100fa26a8b5398b13b542ee10f71a0831eb6c966c4f83f4caa51ee807de78a62::swap {
    struct SWAP has drop {
        dummy_field: bool,
    }

    struct Capacity has store, key {
        id: 0x2::object::UID,
    }

    struct Pool<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        coin_a: 0x2::balance::Balance<T0>,
        coin_b: 0x2::balance::Balance<T1>,
    }

    public entry fun Add<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<T0>(&mut arg0.coin_a, 0x2::coin::into_balance<T0>(arg1));
        0x2::balance::join<T1>(&mut arg0.coin_b, 0x2::coin::into_balance<T1>(arg2));
    }

    fun init(arg0: SWAP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWAP>(arg0, 6, b"SWAP", b"SWAP", b"my swap", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SWAP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWAP>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<SWAP>>(0x2::coin::mint<SWAP>(&mut v2, 10000000, arg1), 0x2::tx_context::sender(arg1));
        let v3 = Capacity{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<Capacity>(v3, 0x2::tx_context::sender(arg1));
        let v4 = Pool<0x2::sui::SUI, SWAP>{
            id     : 0x2::object::new(arg1),
            coin_a : 0x2::balance::zero<0x2::sui::SUI>(),
            coin_b : 0x2::balance::zero<SWAP>(),
        };
        0x2::transfer::share_object<Pool<0x2::sui::SUI, SWAP>>(v4);
    }

    public entry fun send<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.coin_a, arg1), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun swap_a_to_b<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<T0>(&mut arg0.coin_a, 0x2::balance::split<T0>(0x2::coin::balance_mut<T0>(arg1), arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.coin_b, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun swap_b_to_a<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x2::coin::Coin<T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<T1>(&mut arg0.coin_b, 0x2::balance::split<T1>(0x2::coin::balance_mut<T1>(arg1), arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.coin_a, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

