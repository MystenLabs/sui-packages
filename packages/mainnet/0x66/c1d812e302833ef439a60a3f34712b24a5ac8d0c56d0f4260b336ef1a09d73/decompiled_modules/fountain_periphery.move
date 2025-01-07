module 0x66c1d812e302833ef439a60a3f34712b24a5ac8d0c56d0f4260b336ef1a09d73::fountain_periphery {
    public entry fun airdrop<T0, T1>(arg0: &mut 0x66c1d812e302833ef439a60a3f34712b24a5ac8d0c56d0f4260b336ef1a09d73::fountain_core::Fountain<T0, T1>, arg1: 0x2::coin::Coin<T1>) {
        0x66c1d812e302833ef439a60a3f34712b24a5ac8d0c56d0f4260b336ef1a09d73::fountain_core::airdrop<T0, T1>(arg0, 0x2::coin::into_balance<T1>(arg1));
    }

    public entry fun claim<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0x66c1d812e302833ef439a60a3f34712b24a5ac8d0c56d0f4260b336ef1a09d73::fountain_core::Fountain<T0, T1>, arg2: &mut 0x66c1d812e302833ef439a60a3f34712b24a5ac8d0c56d0f4260b336ef1a09d73::fountain_core::StakeProof<T0, T1>, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x66c1d812e302833ef439a60a3f34712b24a5ac8d0c56d0f4260b336ef1a09d73::fountain_core::claim<T0, T1>(arg0, arg1, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun stake<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0x66c1d812e302833ef439a60a3f34712b24a5ac8d0c56d0f4260b336ef1a09d73::fountain_core::Fountain<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x66c1d812e302833ef439a60a3f34712b24a5ac8d0c56d0f4260b336ef1a09d73::fountain_core::StakeProof<T0, T1>>(0x66c1d812e302833ef439a60a3f34712b24a5ac8d0c56d0f4260b336ef1a09d73::fountain_core::stake<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(arg2), arg3, arg4), 0x2::tx_context::sender(arg4));
    }

    public entry fun supply<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0x66c1d812e302833ef439a60a3f34712b24a5ac8d0c56d0f4260b336ef1a09d73::fountain_core::Fountain<T0, T1>, arg2: 0x2::coin::Coin<T1>) {
        0x66c1d812e302833ef439a60a3f34712b24a5ac8d0c56d0f4260b336ef1a09d73::fountain_core::supply<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T1>(arg2));
    }

    public entry fun unstake<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0x66c1d812e302833ef439a60a3f34712b24a5ac8d0c56d0f4260b336ef1a09d73::fountain_core::Fountain<T0, T1>, arg2: 0x66c1d812e302833ef439a60a3f34712b24a5ac8d0c56d0f4260b336ef1a09d73::fountain_core::StakeProof<T0, T1>, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x66c1d812e302833ef439a60a3f34712b24a5ac8d0c56d0f4260b336ef1a09d73::fountain_core::unstake<T0, T1>(arg0, arg1, arg2);
        let v2 = 0x2::tx_context::sender(arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v0, arg3), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v1, arg3), v2);
    }

    public entry fun create_fountain<T0, T1>(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_share_object<0x66c1d812e302833ef439a60a3f34712b24a5ac8d0c56d0f4260b336ef1a09d73::fountain_core::Fountain<T0, T1>>(0x66c1d812e302833ef439a60a3f34712b24a5ac8d0c56d0f4260b336ef1a09d73::fountain_core::new_fountain<T0, T1>(arg0, arg1, arg2, arg3, arg4));
    }

    // decompiled from Move bytecode v6
}

