module 0xcc8aa71adcc99cb87790b6d25383a1ce0da8ac641a57b158748c55f3273350f1::faucet {
    struct FaucetEvent has copy, drop {
        id: 0x2::object::ID,
        time: u128,
    }

    public entry fun faucetAll(arg0: &mut 0xcc8aa71adcc99cb87790b6d25383a1ce0da8ac641a57b158748c55f3273350f1::usdc::USDCSupply, arg1: &mut 0xcc8aa71adcc99cb87790b6d25383a1ce0da8ac641a57b158748c55f3273350f1::cetus::CETUSSupply, arg2: &mut 0x2::tx_context::TxContext) {
        0xcc8aa71adcc99cb87790b6d25383a1ce0da8ac641a57b158748c55f3273350f1::cetus::faucet(arg1, arg2);
        0xcc8aa71adcc99cb87790b6d25383a1ce0da8ac641a57b158748c55f3273350f1::usdc::faucet(arg0, arg2);
    }

    // decompiled from Move bytecode v6
}

