module 0xae5e376b646e4d095b99e2eeaa222e40d5a6c26250419f00c4fc613a9cfb2e18::trading {
    struct BidCommission<phantom T0> has store {
        cut: 0x2::balance::Balance<T0>,
        beneficiary: address,
    }

    struct AskCommission has drop, store {
        cut: u64,
        beneficiary: address,
    }

    public fun ask_commission_amount(arg0: &AskCommission) : u64 {
        arg0.cut
    }

    public fun ask_commission_beneficiary(arg0: &AskCommission) : address {
        arg0.beneficiary
    }

    public fun bid_commission_amount<T0>(arg0: &BidCommission<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.cut)
    }

    public fun bid_commission_beneficiary<T0>(arg0: &BidCommission<T0>) : address {
        arg0.beneficiary
    }

    public fun destroy_bid_commission<T0>(arg0: BidCommission<T0>) : (0x2::balance::Balance<T0>, address) {
        let BidCommission {
            cut         : v0,
            beneficiary : v1,
        } = arg0;
        (v0, v1)
    }

    public fun new_ask_commission(arg0: address, arg1: u64) : AskCommission {
        AskCommission{
            cut         : arg1,
            beneficiary : arg0,
        }
    }

    public fun new_bid_commission<T0>(arg0: address, arg1: 0x2::balance::Balance<T0>) : BidCommission<T0> {
        BidCommission<T0>{
            cut         : arg1,
            beneficiary : arg0,
        }
    }

    public fun transfer_ask_commission<T0>(arg0: &mut 0x1::option::Option<AskCommission>, arg1: &mut 0x2::balance::Balance<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x1::option::is_some<AskCommission>(arg0)) {
            let AskCommission {
                cut         : v0,
                beneficiary : v1,
            } = 0x1::option::extract<AskCommission>(arg0);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(arg1, v0, arg2), v1);
        };
    }

    public fun transfer_bid_commission<T0>(arg0: &mut 0x1::option::Option<BidCommission<T0>>, arg1: &mut 0x2::tx_context::TxContext) {
        if (0x1::option::is_some<BidCommission<T0>>(arg0)) {
            let BidCommission {
                cut         : v0,
                beneficiary : v1,
            } = 0x1::option::extract<BidCommission<T0>>(arg0);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v0, arg1), v1);
        };
    }

    // decompiled from Move bytecode v6
}

