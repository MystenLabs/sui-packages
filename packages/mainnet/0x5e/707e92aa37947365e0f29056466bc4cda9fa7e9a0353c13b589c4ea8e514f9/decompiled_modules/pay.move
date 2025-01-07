module 0x5e707e92aa37947365e0f29056466bc4cda9fa7e9a0353c13b589c4ea8e514f9::pay {
    struct PAY has drop {
        dummy_field: bool,
    }

    struct CoinReceived has copy, drop {
        ref: 0x1::string::String,
        system: 0x1::string::String,
        coin: 0x1::ascii::String,
        amount: u64,
    }

    struct KNSVoucherReceived has copy, drop {
        ref: 0x1::string::String,
        system: 0x1::string::String,
    }

    public entry fun knsVoucher(arg0: 0x5e707e92aa37947365e0f29056466bc4cda9fa7e9a0353c13b589c4ea8e514f9::kns_voucher::KNSVoucher, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        0x5e707e92aa37947365e0f29056466bc4cda9fa7e9a0353c13b589c4ea8e514f9::kns_voucher::burn(arg0, arg3);
        let v0 = KNSVoucherReceived{
            ref    : arg1,
            system : arg2,
        };
        0x2::event::emit<KNSVoucherReceived>(v0);
    }

    public entry fun payCoin<T0>(arg0: 0x2::coin::Coin<T0>, arg1: 0x1::string::String, arg2: 0x1::string::String) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, @0x4c9fac90ac064bd6f8528ebcabab233131332ef47cb276d1cd2178af4fa044c6);
        let v0 = CoinReceived{
            ref    : arg1,
            system : arg2,
            coin   : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            amount : 0x2::coin::value<T0>(&arg0),
        };
        0x2::event::emit<CoinReceived>(v0);
    }

    // decompiled from Move bytecode v6
}

