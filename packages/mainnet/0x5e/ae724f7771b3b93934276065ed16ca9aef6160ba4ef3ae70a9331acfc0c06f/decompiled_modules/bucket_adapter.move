module 0x5eae724f7771b3b93934276065ed16ca9aef6160ba4ef3ae70a9331acfc0c06f::bucket_adapter {
    public entry fun despoit_buck<T0>(arg0: &0x2::coin::Coin<T0>, arg1: &mut 0x2::tx_context::TxContext) {
    }

    public entry fun stake_sbuck<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::Fountain<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<T0, T1>>(0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::stake<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(arg2), arg3, arg4), 0x2::tx_context::sender(arg4));
    }

    // decompiled from Move bytecode v6
}

