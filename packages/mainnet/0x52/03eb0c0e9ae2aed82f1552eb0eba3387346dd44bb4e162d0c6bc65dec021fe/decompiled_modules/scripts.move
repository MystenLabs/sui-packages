module 0x5203eb0c0e9ae2aed82f1552eb0eba3387346dd44bb4e162d0c6bc65dec021fe::scripts {
    struct CoinInfo<phantom T0> has store, key {
        id: 0x2::object::UID,
        whitelisted_wormhole: bool,
        bridge_limit: u64,
        bridge_fee: 0x1::fixed_point32::FixedPoint32,
        balance: 0x2::balance::Balance<T0>,
    }

    struct AdminCapability has key {
        id: 0x2::object::UID,
    }

    public entry fun bridge_wormhole<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u16, arg2: vector<u8>, arg3: u64, arg4: u32, arg5: &0x2::clock::Clock, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &mut 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::state::State, arg8: &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg9: &mut CoinInfo<T0>, arg10: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(arg9.whitelisted_wormhole, 1);
        let v0 = collect_fees<T0>(arg0, arg9, arg10);
        assert!(arg9.bridge_limit >= 0x2::coin::value<T0>(&v0), 3);
        let (v1, v2) = 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::transfer_tokens::prepare_transfer<T0>(0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::state::verified_asset<T0>(arg7), v0, arg1, arg2, arg3, arg4);
        0x2::coin::put<T0>(&mut arg9.balance, v2);
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::publish_message::publish_message(arg8, arg6, 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::transfer_tokens::transfer_tokens<T0>(arg7, v1), arg5)
    }

    public entry fun claim_fees<T0>(arg0: address, arg1: &mut CoinInfo<T0>, arg2: &mut AdminCapability, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance, 0x2::balance::value<T0>(&arg1.balance)), arg3), arg0);
    }

    fun collect_fees<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut CoinInfo<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::into_balance<T0>(arg0);
        0x2::coin::put<T0>(&mut arg1.balance, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v0, 0x1::fixed_point32::multiply_u64(0x2::balance::value<T0>(&v0), arg1.bridge_fee)), arg2));
        0x2::coin::from_balance<T0>(v0, arg2)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCapability{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCapability>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun quote_wormhole<T0>(arg0: u64, arg1: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &CoinInfo<T0>) : (u64, u64) {
        (0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::message_fee(arg1), 0x1::fixed_point32::multiply_u64(arg0, arg2.bridge_fee))
    }

    public entry fun toggle_coin<T0>(arg0: bool, arg1: u64, arg2: u64, arg3: u64, arg4: &mut CoinInfo<T0>, arg5: &mut AdminCapability, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > arg1, 2);
        arg4.bridge_limit = arg3;
        arg4.whitelisted_wormhole = arg0;
        if (arg1 != 0 && arg2 != 0) {
            arg4.bridge_fee = 0x1::fixed_point32::create_from_rational(arg1, arg2);
        };
    }

    public entry fun whitelist_coin<T0>(arg0: bool, arg1: u64, arg2: u64, arg3: u64, arg4: &mut AdminCapability, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > arg1, 2);
        let v0 = CoinInfo<T0>{
            id                   : 0x2::object::new(arg5),
            whitelisted_wormhole : arg0,
            bridge_limit         : arg3,
            bridge_fee           : 0x1::fixed_point32::create_from_rational(arg1, arg2),
            balance              : 0x2::balance::zero<T0>(),
        };
        0x2::transfer::share_object<CoinInfo<T0>>(v0);
    }

    // decompiled from Move bytecode v6
}

