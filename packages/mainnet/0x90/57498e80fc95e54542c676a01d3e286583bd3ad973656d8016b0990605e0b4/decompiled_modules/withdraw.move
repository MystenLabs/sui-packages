module 0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::withdraw {
    struct WithdrawEvent has copy, drop {
        redeemer: address,
        market: 0x1::type_name::TypeName,
        obligation: 0x2::object::ID,
        withdraw_asset: 0x1::type_name::TypeName,
        withdraw_amount: u64,
        burn_asset: 0x1::type_name::TypeName,
        burn_amount: u64,
        time: u64,
    }

    public fun withdraw<T0, T1>(arg0: &mut 0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::market::Market<T0>, arg1: &0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::obligation::ObligationOwnerCap, arg2: &0xc17d1d88270b8fabfc423a8000c21a8d265b356b83bc2df9418c55560803ad3a::coin_decimals_registry::CoinDecimalsRegistry, arg3: u64, arg4: &0xcd9847dcdef37af236b3c6e3fe953a886e53daff970697c4db4414c15723f9f3::x_oracle::XOracle, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::market::ensure_version_matches<T0>(arg0);
        let v0 = 0x2::clock::timestamp_ms(arg5) / 1000;
        let (v1, v2) = 0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::market::handle_withdraw<T0, T1>(arg0, 0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::obligation::id(arg1), arg3, arg2, arg4, arg5, v0, arg6);
        let v3 = v1;
        let v4 = WithdrawEvent{
            redeemer        : 0x2::tx_context::sender(arg6),
            market          : 0x1::type_name::get<T0>(),
            obligation      : 0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::obligation::id(arg1),
            withdraw_asset  : 0x1::type_name::get<T1>(),
            withdraw_amount : 0x2::coin::value<T1>(&v3),
            burn_asset      : 0x1::type_name::get<0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::ctoken::CToken<T0, T1>>(),
            burn_amount     : v2,
            time            : v0,
        };
        0x2::event::emit<WithdrawEvent>(v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v3, 0x2::tx_context::sender(arg6));
    }

    // decompiled from Move bytecode v6
}

