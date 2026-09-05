module 0x903c36e90b707ac367b430c05f684ed62180664b8324a375159a8129d1ab23a3::wrapper {
    struct DEXStorage has store, key {
        id: 0x2::object::UID,
        dummy: u64,
    }

    struct LPCoin<phantom T0, phantom T1, phantom T2> has drop {
        dummy_field: bool,
    }

    struct RealDEXStorage has store, key {
        id: 0x2::object::UID,
        pools: 0x2::object::UID,
        fee_to: address,
    }

    public entry fun call_live_xy<T0, T1, T2>(arg0: &mut 0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::core::DEXStorage, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::core::xy<T0, T1, T2>(arg0, arg1, arg2, arg3);
        let v2 = 0x2::tx_context::sender(arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v0, v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v1, v2);
    }

    public entry fun call_real_xy<T0, T1, T2>(arg0: &mut RealDEXStorage, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
    }

    public entry fun call_remove_liquidity<T0, T1, T2>(arg0: &mut DEXStorage, arg1: vector<0x2::coin::Coin<LPCoin<T0, T1, T2>>>, arg2: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun call_swap_x<T0, T1>(arg0: &mut DEXStorage, arg1: &0x2::clock::Clock, arg2: vector<0x2::coin::Coin<T0>>, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun call_swap_y<T0, T1>(arg0: &mut DEXStorage, arg1: &0x2::clock::Clock, arg2: vector<0x2::coin::Coin<T1>>, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun call_xy<T0, T1, T2>(arg0: &mut DEXStorage, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
    }

    public entry fun create_real_storage(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = RealDEXStorage{
            id     : 0x2::object::new(arg0),
            pools  : 0x2::object::new(arg0),
            fee_to : @0x0,
        };
        0x2::transfer::share_object<RealDEXStorage>(v0);
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

