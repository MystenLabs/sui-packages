module 0xfbfcfbc08e019628c5c302a8a40d1bef7a2882b21ef1c44ce16cc9b3765dc43b::wrapper {
    struct DEXStorage has store, key {
        id: 0x2::object::UID,
        dummy: u64,
    }

    struct LPCoin<phantom T0, phantom T1, phantom T2> has drop {
        dummy_field: bool,
    }

    public entry fun call_remove_liquidity<T0, T1, T2>(arg0: &mut DEXStorage, arg1: vector<0x2::coin::Coin<LPCoin<T0, T1, T2>>>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x2::coin::Coin<LPCoin<T0, T1, T2>>>(&arg1)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<LPCoin<T0, T1, T2>>>(0x1::vector::pop_back<0x2::coin::Coin<LPCoin<T0, T1, T2>>>(&mut arg1), 0x2::tx_context::sender(arg2));
            v0 = v0 + 1;
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<LPCoin<T0, T1, T2>>>(arg1);
    }

    public entry fun call_swap_x<T0, T1>(arg0: &mut DEXStorage, arg1: &0x2::clock::Clock, arg2: vector<0x2::coin::Coin<T0>>, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x2::coin::Coin<T0>>(&arg2)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg2), 0x2::tx_context::sender(arg6));
            v0 = v0 + 1;
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<T0>>(arg2);
    }

    public entry fun call_swap_y<T0, T1>(arg0: &mut DEXStorage, arg1: &0x2::clock::Clock, arg2: vector<0x2::coin::Coin<T1>>, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x2::coin::Coin<T1>>(&arg2)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x1::vector::pop_back<0x2::coin::Coin<T1>>(&mut arg2), 0x2::tx_context::sender(arg6));
            v0 = v0 + 1;
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<T1>>(arg2);
    }

    public entry fun call_xy<T0, T1, T2>(arg0: &mut DEXStorage, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
    }

    public entry fun create_storage(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = DEXStorage{
            id    : 0x2::object::new(arg0),
            dummy : 0,
        };
        0x2::transfer::share_object<DEXStorage>(v0);
    }

    // decompiled from Move bytecode v7
}

