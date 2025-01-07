module 0xdbd3a1ed33f3b3f9370bb8fe6b05718f3eb1c841d52bbf6f3b9318b7f4db0651::umi_aggregator {
    struct SwapBeginEvent has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct SwapEndEvent has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    public fun swap_begin<T0>(arg0: vector<0x2::coin::Coin<T0>>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = SwapBeginEvent{
            coin_type : 0x1::type_name::get<T0>(),
            amount    : arg1,
        };
        0x2::event::emit<SwapBeginEvent>(v0);
        0xdbd3a1ed33f3b3f9370bb8fe6b05718f3eb1c841d52bbf6f3b9318b7f4db0651::utils::maybe_split_coins_and_transfer_rest<T0>(arg0, arg1, arg2, arg3)
    }

    public fun swap_end<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64) {
        let v0 = SwapEndEvent{
            coin_type : 0x1::type_name::get<T0>(),
            amount    : arg1,
        };
        0x2::event::emit<SwapEndEvent>(v0);
        0xdbd3a1ed33f3b3f9370bb8fe6b05718f3eb1c841d52bbf6f3b9318b7f4db0651::utils::check_amount_sufficient<T0>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

