module 0x5ffb509589a9c287da16b2c5f969897d4e98436a8c5252657b4f73c876b68278::fees {
    struct FeeLedger<phantom T0, phantom T1> has store {
        protocol_meme: 0x2::balance::Balance<T0>,
        creator_meme: 0x2::balance::Balance<T0>,
        protocol_quote: 0x2::balance::Balance<T1>,
        creator_quote: 0x2::balance::Balance<T1>,
        protocol_sui: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    public(friend) fun accrue<T0, T1>(arg0: &mut FeeLedger<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: 0x2::balance::Balance<T1>, arg3: 0x5ffb509589a9c287da16b2c5f969897d4e98436a8c5252657b4f73c876b68278::bps::Bps) : (u64, u64, u64, u64) {
        let v0 = 0x5ffb509589a9c287da16b2c5f969897d4e98436a8c5252657b4f73c876b68278::bps::apply_up(arg3, 0x2::balance::value<T0>(&arg1));
        let v1 = 0x5ffb509589a9c287da16b2c5f969897d4e98436a8c5252657b4f73c876b68278::bps::apply_up(arg3, 0x2::balance::value<T1>(&arg2));
        0x2::balance::join<T0>(&mut arg0.protocol_meme, 0x2::balance::split<T0>(&mut arg1, v0));
        0x2::balance::join<T0>(&mut arg0.creator_meme, arg1);
        0x2::balance::join<T1>(&mut arg0.protocol_quote, 0x2::balance::split<T1>(&mut arg2, v1));
        0x2::balance::join<T1>(&mut arg0.creator_quote, arg2);
        (v0, 0x2::balance::value<T0>(&arg1), v1, 0x2::balance::value<T1>(&arg2))
    }

    public(friend) fun accrue_protocol_fees<T0, T1>(arg0: &mut FeeLedger<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: 0x2::balance::Balance<T1>) {
        0x2::balance::join<T0>(&mut arg0.protocol_meme, arg1);
        0x2::balance::join<T1>(&mut arg0.protocol_quote, arg2);
    }

    public(friend) fun claim_creator_fees<T0, T1>(arg0: &mut FeeLedger<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(0x2::balance::value<T0>(&arg0.creator_meme) > 0 || 0x2::balance::value<T1>(&arg0.creator_quote) > 0, 20);
        (0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.creator_meme), arg1), 0x2::coin::from_balance<T1>(0x2::balance::withdraw_all<T1>(&mut arg0.creator_quote), arg1))
    }

    public(friend) fun claim_protocol_fees<T0, T1>(arg0: &mut FeeLedger<T0, T1>) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, 0x2::balance::Balance<0x2::sui::SUI>) {
        let v0 = if (0x2::balance::value<T0>(&arg0.protocol_meme) > 0) {
            true
        } else if (0x2::balance::value<T1>(&arg0.protocol_quote) > 0) {
            true
        } else {
            0x2::balance::value<0x2::sui::SUI>(&arg0.protocol_sui) > 0
        };
        assert!(v0, 20);
        (0x2::balance::withdraw_all<T0>(&mut arg0.protocol_meme), 0x2::balance::withdraw_all<T1>(&mut arg0.protocol_quote), 0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.protocol_sui))
    }

    public(friend) fun new<T0, T1>(arg0: 0x2::balance::Balance<0x2::sui::SUI>) : FeeLedger<T0, T1> {
        assert!(0x1::type_name::with_original_ids<T0>() != 0x1::type_name::with_original_ids<T1>(), 11);
        FeeLedger<T0, T1>{
            protocol_meme  : 0x2::balance::zero<T0>(),
            creator_meme   : 0x2::balance::zero<T0>(),
            protocol_quote : 0x2::balance::zero<T1>(),
            creator_quote  : 0x2::balance::zero<T1>(),
            protocol_sui   : arg0,
        }
    }

    // decompiled from Move bytecode v7
}

