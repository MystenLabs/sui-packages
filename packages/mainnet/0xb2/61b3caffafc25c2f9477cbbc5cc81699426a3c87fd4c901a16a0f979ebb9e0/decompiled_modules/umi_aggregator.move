module 0xb261b3caffafc25c2f9477cbbc5cc81699426a3c87fd4c901a16a0f979ebb9e0::umi_aggregator {
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
        0xb261b3caffafc25c2f9477cbbc5cc81699426a3c87fd4c901a16a0f979ebb9e0::utils::maybe_split_coins_and_transfer_rest<T0>(arg0, arg1, arg2, arg3)
    }

    public fun swap_end<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64) {
        let v0 = SwapEndEvent{
            coin_type : 0x1::type_name::get<T0>(),
            amount    : 0x2::coin::value<T0>(arg0),
        };
        0x2::event::emit<SwapEndEvent>(v0);
        0xb261b3caffafc25c2f9477cbbc5cc81699426a3c87fd4c901a16a0f979ebb9e0::utils::check_amount_sufficient<T0>(arg0, arg1);
    }

    public fun take_fee_for_partner<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &0xb261b3caffafc25c2f9477cbbc5cc81699426a3c87fd4c901a16a0f979ebb9e0::admin_cap::PartnerPolicy, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (_, v1, v2, v3, v4) = 0xb261b3caffafc25c2f9477cbbc5cc81699426a3c87fd4c901a16a0f979ebb9e0::admin_cap::get_partner_info(arg1);
        let v5 = 0x2::coin::value<T0>(&arg0) * v3 / 10000;
        let v6 = v5 * v4 / 10000;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0, v6, arg2), v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0, v5 - v6, arg2), v2);
        arg0
    }

    // decompiled from Move bytecode v6
}

