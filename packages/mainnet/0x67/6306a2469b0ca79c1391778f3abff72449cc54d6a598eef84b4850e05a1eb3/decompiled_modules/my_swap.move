module 0x676306a2469b0ca79c1391778f3abff72449cc54d6a598eef84b4850e05a1eb3::my_swap {
    struct MY_SWAP has drop {
        dummy_field: bool,
    }

    struct Pool<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        coin_a: 0x2::balance::Balance<T0>,
        coin_b: 0x2::balance::Balance<T1>,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<MY_SWAP>, arg1: 0x2::coin::Coin<MY_SWAP>) {
        0x2::coin::burn<MY_SWAP>(arg0, arg1);
    }

    fun init(arg0: MY_SWAP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MY_SWAP>(arg0, 6, b"MY_SWAP", b"MS", b"my swap for test", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MY_SWAP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MY_SWAP>>(v0, 0x2::tx_context::sender(arg1));
        let v2 = Pool<0x2::sui::SUI, MY_SWAP>{
            id     : 0x2::object::new(arg1),
            coin_a : 0x2::balance::zero<0x2::sui::SUI>(),
            coin_b : 0x2::balance::zero<MY_SWAP>(),
        };
        0x2::transfer::share_object<Pool<0x2::sui::SUI, MY_SWAP>>(v2);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MY_SWAP>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MY_SWAP>(arg0, arg1, arg2, arg3);
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

