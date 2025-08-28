module 0x6db8e8f4cefe53236afab262a32b544b1169909bd889b7476dad33a90589b1b3::bot_script {
    public fun change_funder<T0: store + key>(arg0: &0x2::package::Publisher, arg1: &mut 0x6db8e8f4cefe53236afab262a32b544b1169909bd889b7476dad33a90589b1b3::bot::Bot<T0>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x6db8e8f4cefe53236afab262a32b544b1169909bd889b7476dad33a90589b1b3::bot::change_funder<T0>(arg0, arg1, arg2);
    }

    public fun change_operator<T0: store + key>(arg0: &0x2::package::Publisher, arg1: &mut 0x6db8e8f4cefe53236afab262a32b544b1169909bd889b7476dad33a90589b1b3::bot::Bot<T0>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x6db8e8f4cefe53236afab262a32b544b1169909bd889b7476dad33a90589b1b3::bot::change_operator<T0>(arg0, arg1, arg2);
    }

    public fun create_bot<T0: store + key>(arg0: &0x2::package::Publisher, arg1: address, arg2: address, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 != @0x0 && arg2 != @0x0, 13906834234472923135);
        assert!(arg1 != arg2, 13906834238767890431);
        0x2::transfer::public_share_object<0x6db8e8f4cefe53236afab262a32b544b1169909bd889b7476dad33a90589b1b3::bot::Bot<T0>>(0x6db8e8f4cefe53236afab262a32b544b1169909bd889b7476dad33a90589b1b3::bot::create_bot<T0>(arg0, arg1, arg2, arg3, arg4));
    }

    public fun deposit<T0: store + key, T1>(arg0: &mut 0x6db8e8f4cefe53236afab262a32b544b1169909bd889b7476dad33a90589b1b3::bot::Bot<T0>, arg1: 0x2::coin::Coin<T1>) {
        0x6db8e8f4cefe53236afab262a32b544b1169909bd889b7476dad33a90589b1b3::bot::deposit<T0, T1>(arg0, 0x2::coin::into_balance<T1>(arg1));
    }

    public fun withdraw<T0: store + key, T1>(arg0: &mut 0x6db8e8f4cefe53236afab262a32b544b1169909bd889b7476dad33a90589b1b3::bot::Bot<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        0x6db8e8f4cefe53236afab262a32b544b1169909bd889b7476dad33a90589b1b3::bot::only_funder<T0>(arg0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x6db8e8f4cefe53236afab262a32b544b1169909bd889b7476dad33a90589b1b3::bot::withdraw<T0, T1>(arg0), arg1), 0x2::tx_context::sender(arg1));
    }

    public fun deposit2<T0: store + key, T1, T2>(arg0: &mut 0x6db8e8f4cefe53236afab262a32b544b1169909bd889b7476dad33a90589b1b3::bot::Bot<T0>, arg1: 0x2::coin::Coin<T1>, arg2: 0x2::coin::Coin<T2>) {
        0x6db8e8f4cefe53236afab262a32b544b1169909bd889b7476dad33a90589b1b3::bot::deposit<T0, T1>(arg0, 0x2::coin::into_balance<T1>(arg1));
        0x6db8e8f4cefe53236afab262a32b544b1169909bd889b7476dad33a90589b1b3::bot::deposit<T0, T2>(arg0, 0x2::coin::into_balance<T2>(arg2));
    }

    public fun init_cex_deposit<T0: store + key, T1, T2>(arg0: &mut 0x6db8e8f4cefe53236afab262a32b544b1169909bd889b7476dad33a90589b1b3::bot::Bot<T0>, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x6db8e8f4cefe53236afab262a32b544b1169909bd889b7476dad33a90589b1b3::bot::only_operator<T0>(arg0, 0x2::tx_context::sender(arg3));
        let (v0, v1) = 0x6db8e8f4cefe53236afab262a32b544b1169909bd889b7476dad33a90589b1b3::bot::check_out<T0, T1, T2>(arg0, arg1, arg2);
        if (arg1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v0, arg3), 0x6db8e8f4cefe53236afab262a32b544b1169909bd889b7476dad33a90589b1b3::bot::cex_deposit_address<T0>(arg0));
        } else {
            0x2::balance::destroy_zero<T1>(v0);
        };
        if (arg2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v1, arg3), 0x6db8e8f4cefe53236afab262a32b544b1169909bd889b7476dad33a90589b1b3::bot::cex_deposit_address<T0>(arg0));
        } else {
            0x2::balance::destroy_zero<T2>(v1);
        };
    }

    // decompiled from Move bytecode v6
}

