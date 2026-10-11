module 0xc53561ba91fcfb7a6914ccbc4ac394986430516117dd2532854fa0e84688c616::payout {
    public fun assert_min_and_pay<T0>(arg0: &0xc53561ba91fcfb7a6914ccbc4ac394986430516117dd2532854fa0e84688c616::owner::OwnerCap, arg1: 0x2::balance::Balance<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<T0>(&arg1);
        assert!(v0 >= arg2, 0xc53561ba91fcfb7a6914ccbc4ac394986430516117dd2532854fa0e84688c616::errors::min_profit());
        let v1 = 0xc53561ba91fcfb7a6914ccbc4ac394986430516117dd2532854fa0e84688c616::owner::recipient(arg0);
        0xc53561ba91fcfb7a6914ccbc4ac394986430516117dd2532854fa0e84688c616::owner::emit_payout(b"Balance", v0, v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg1, arg3), v1);
    }

    public fun assert_min_and_pay_coin<T0>(arg0: &0xc53561ba91fcfb7a6914ccbc4ac394986430516117dd2532854fa0e84688c616::owner::OwnerCap, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 >= arg2, 0xc53561ba91fcfb7a6914ccbc4ac394986430516117dd2532854fa0e84688c616::errors::min_profit());
        let v1 = 0xc53561ba91fcfb7a6914ccbc4ac394986430516117dd2532854fa0e84688c616::owner::recipient(arg0);
        0xc53561ba91fcfb7a6914ccbc4ac394986430516117dd2532854fa0e84688c616::owner::emit_payout(b"Coin", v0, v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, v1);
    }

    public fun assert_min_and_pay_sender<T0>(arg0: 0x2::balance::Balance<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<T0>(&arg0);
        assert!(v0 >= arg1, 0xc53561ba91fcfb7a6914ccbc4ac394986430516117dd2532854fa0e84688c616::errors::min_profit());
        let v1 = 0x2::tx_context::sender(arg2);
        0xc53561ba91fcfb7a6914ccbc4ac394986430516117dd2532854fa0e84688c616::owner::emit_payout(b"Balance", v0, v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg2), v1);
    }

    public fun destroy_zero_balance<T0>(arg0: 0x2::balance::Balance<T0>) {
        0x2::balance::destroy_zero<T0>(arg0);
    }

    // decompiled from Move bytecode v7
}

