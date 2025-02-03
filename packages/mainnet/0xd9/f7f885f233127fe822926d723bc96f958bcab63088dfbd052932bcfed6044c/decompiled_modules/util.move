module 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::util {
    public fun split_and_give_back(arg0: 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription {
        if (0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::amount(&arg0) == arg1) {
            arg0
        } else {
            0x2::transfer::public_transfer<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(arg0, 0x2::tx_context::sender(arg2));
            0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::do_split(&mut arg0, arg1, arg2)
        }
    }

    public fun split_and_return_remain(arg0: 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription, 0x1::option::Option<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>) {
        if (0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::amount(&arg0) == arg1) {
            (arg0, 0x1::option::none<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>())
        } else {
            (0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::do_split(&mut arg0, arg1, arg2), 0x1::option::some<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(arg0))
        }
    }

    public fun split_coin_and_give_back<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        if (0x2::coin::value<T0>(&arg0) == arg1) {
            arg0
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg2));
            0x2::coin::split<T0>(&mut arg0, arg1, arg2)
        }
    }

    // decompiled from Move bytecode v6
}

