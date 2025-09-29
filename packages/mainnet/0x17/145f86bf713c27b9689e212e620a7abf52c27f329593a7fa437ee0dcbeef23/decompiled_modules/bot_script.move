module 0x79b4d9b6b564e324ff1c6f928d586196aef423da1c2b6e37aea39c7407c281dc::bot_script {
    public fun change_funder<T0: store + key>(arg0: &0x2::package::Publisher, arg1: &mut 0x79b4d9b6b564e324ff1c6f928d586196aef423da1c2b6e37aea39c7407c281dc::bot::Bot<T0>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x79b4d9b6b564e324ff1c6f928d586196aef423da1c2b6e37aea39c7407c281dc::bot::change_funder<T0>(arg0, arg1, arg2);
    }

    public fun change_operator<T0: store + key>(arg0: &0x2::package::Publisher, arg1: &mut 0x79b4d9b6b564e324ff1c6f928d586196aef423da1c2b6e37aea39c7407c281dc::bot::Bot<T0>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x79b4d9b6b564e324ff1c6f928d586196aef423da1c2b6e37aea39c7407c281dc::bot::change_operator<T0>(arg0, arg1, arg2);
    }

    public fun create_bot<T0: store + key>(arg0: &0x2::package::Publisher, arg1: address, arg2: address, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 != @0x0 && arg2 != @0x0, 13906834234472923135);
        assert!(arg1 != arg2, 13906834238767890431);
        0x2::transfer::public_share_object<0x79b4d9b6b564e324ff1c6f928d586196aef423da1c2b6e37aea39c7407c281dc::bot::Bot<T0>>(0x79b4d9b6b564e324ff1c6f928d586196aef423da1c2b6e37aea39c7407c281dc::bot::create_bot<T0>(arg0, arg1, arg2, arg3, arg4));
    }

    public fun deposit<T0: store + key, T1>(arg0: &mut 0x79b4d9b6b564e324ff1c6f928d586196aef423da1c2b6e37aea39c7407c281dc::bot::Bot<T0>, arg1: 0x2::coin::Coin<T1>) {
        0x79b4d9b6b564e324ff1c6f928d586196aef423da1c2b6e37aea39c7407c281dc::bot::deposit<T0, T1>(arg0, 0x2::coin::into_balance<T1>(arg1));
    }

    public fun stop_bot<T0: store + key>(arg0: &mut 0x79b4d9b6b564e324ff1c6f928d586196aef423da1c2b6e37aea39c7407c281dc::bot::Bot<T0>, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        0x79b4d9b6b564e324ff1c6f928d586196aef423da1c2b6e37aea39c7407c281dc::bot::only_funder<T0>(arg0, 0x2::tx_context::sender(arg2));
        0x79b4d9b6b564e324ff1c6f928d586196aef423da1c2b6e37aea39c7407c281dc::bot::stop_bot<T0>(arg0, arg1);
    }

    public fun withdraw<T0: store + key, T1>(arg0: &mut 0x79b4d9b6b564e324ff1c6f928d586196aef423da1c2b6e37aea39c7407c281dc::bot::Bot<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        0x79b4d9b6b564e324ff1c6f928d586196aef423da1c2b6e37aea39c7407c281dc::bot::only_funder<T0>(arg0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x79b4d9b6b564e324ff1c6f928d586196aef423da1c2b6e37aea39c7407c281dc::bot::withdraw<T0, T1>(arg0), arg1), 0x2::tx_context::sender(arg1));
    }

    public fun deposit2<T0: store + key, T1, T2>(arg0: &mut 0x79b4d9b6b564e324ff1c6f928d586196aef423da1c2b6e37aea39c7407c281dc::bot::Bot<T0>, arg1: 0x2::coin::Coin<T1>, arg2: 0x2::coin::Coin<T2>) {
        0x79b4d9b6b564e324ff1c6f928d586196aef423da1c2b6e37aea39c7407c281dc::bot::deposit<T0, T1>(arg0, 0x2::coin::into_balance<T1>(arg1));
        0x79b4d9b6b564e324ff1c6f928d586196aef423da1c2b6e37aea39c7407c281dc::bot::deposit<T0, T2>(arg0, 0x2::coin::into_balance<T2>(arg2));
    }

    public fun init_cex_deposit<T0: store + key, T1, T2>(arg0: &mut 0x79b4d9b6b564e324ff1c6f928d586196aef423da1c2b6e37aea39c7407c281dc::bot::Bot<T0>, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x79b4d9b6b564e324ff1c6f928d586196aef423da1c2b6e37aea39c7407c281dc::bot::only_operator<T0>(arg0, 0x2::tx_context::sender(arg3));
        assert!(!0x79b4d9b6b564e324ff1c6f928d586196aef423da1c2b6e37aea39c7407c281dc::bot::stopped<T0>(arg0), 13906834380501811199);
        let (v0, v1) = 0x79b4d9b6b564e324ff1c6f928d586196aef423da1c2b6e37aea39c7407c281dc::bot::check_out<T0, T1, T2>(arg0, arg1, arg2);
        if (arg1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v0, arg3), 0x79b4d9b6b564e324ff1c6f928d586196aef423da1c2b6e37aea39c7407c281dc::bot::cex_deposit_address<T0>(arg0));
        } else {
            0x2::balance::destroy_zero<T1>(v0);
        };
        if (arg2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v1, arg3), 0x79b4d9b6b564e324ff1c6f928d586196aef423da1c2b6e37aea39c7407c281dc::bot::cex_deposit_address<T0>(arg0));
        } else {
            0x2::balance::destroy_zero<T2>(v1);
        };
    }

    // decompiled from Move bytecode v6
}

