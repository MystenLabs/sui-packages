module 0xb3c504291fc97836d545061c105511a05ea129fb385c6ee8483fc4fff611e236::blastfun_router {
    struct BuyEvent<phantom T0, phantom T1> has copy, drop {
        recipient: address,
        amount_in: u64,
        amount_out: u64,
    }

    struct SellEvent<phantom T0, phantom T1> has copy, drop {
        recipient: address,
        amount_in: u64,
        amount_out: u64,
    }

    public entry fun buy_exact_in<T0, T1>(arg0: &0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_allowed_versions::MemezAV, arg1: &mut 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fun::MemezFun<0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_pump::Pump, T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: 0x1::option::Option<address>, arg4: 0x1::option::Option<vector<u8>>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_pump::pump<T0, T1>(arg1, arg2, arg3, arg4, arg5, 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_allowed_versions::get_allowed_versions(arg0), arg6);
        0xb3c504291fc97836d545061c105511a05ea129fb385c6ee8483fc4fff611e236::utils::send_coin<T0>(v0, 0x2::tx_context::sender(arg6));
        let v1 = BuyEvent<T0, T1>{
            recipient  : 0x2::tx_context::sender(arg6),
            amount_in  : 0x2::coin::value<T1>(&arg2),
            amount_out : 0x2::coin::value<T0>(&v0),
        };
        0x2::event::emit<BuyEvent<T0, T1>>(v1);
    }

    public entry fun sell_exact_in<T0, T1>(arg0: &0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_allowed_versions::MemezAV, arg1: &mut 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fun::MemezFun<0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_pump::Pump, T0, T1>, arg2: &mut 0xa204bd0d48d49fc7b8b05c8ef3f3ae63d1b22d157526a88b91391b41e6053157::ipx_coin_standard::IPXTreasuryStandard, arg3: 0x2::coin::Coin<T0>, arg4: 0x1::option::Option<address>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_pump::dump<T0, T1>(arg1, arg2, arg3, arg4, arg5, 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_allowed_versions::get_allowed_versions(arg0), arg6);
        0xb3c504291fc97836d545061c105511a05ea129fb385c6ee8483fc4fff611e236::utils::send_coin<T1>(v0, 0x2::tx_context::sender(arg6));
        let v1 = SellEvent<T0, T1>{
            recipient  : 0x2::tx_context::sender(arg6),
            amount_in  : 0x2::coin::value<T0>(&arg3),
            amount_out : 0x2::coin::value<T1>(&v0),
        };
        0x2::event::emit<SellEvent<T0, T1>>(v1);
    }

    // decompiled from Move bytecode v6
}

