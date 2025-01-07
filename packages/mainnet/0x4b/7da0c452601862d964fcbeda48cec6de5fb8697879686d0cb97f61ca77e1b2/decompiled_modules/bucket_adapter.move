module 0x4b7da0c452601862d964fcbeda48cec6de5fb8697879686d0cb97f61ca77e1b2::bucket_adapter {
    public entry fun despoit_buck<T0>(arg0: &mut 0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::Flask<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK>>(0x2::coin::from_balance<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK>(0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::deposit<T0>(arg0, arg1), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun stake_sbuck<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::Fountain<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<T0, T1>>(0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::stake<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(arg2), arg3, arg4), 0x2::tx_context::sender(arg4));
    }

    // decompiled from Move bytecode v6
}

