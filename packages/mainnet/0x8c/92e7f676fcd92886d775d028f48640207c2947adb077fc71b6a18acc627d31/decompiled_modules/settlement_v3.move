module 0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::settlement_v3 {
    struct RepaymentProof<phantom T0> {
        debt: u64,
        repaid: u64,
    }

    struct ConversionReceipt<phantom T0> {
        debt_repaid: u64,
        base_profit: u64,
    }

    struct FinalSettlementV3<phantom T0> has copy, drop {
        sender: address,
        debt_repaid: u64,
        base_profit: u64,
        sui_payout: u64,
        converted_to_sui: bool,
    }

    fun consume_repayment<T0>(arg0: RepaymentProof<T0>) : u64 {
        let RepaymentProof {
            debt   : v0,
            repaid : v1,
        } = arg0;
        assert!(v0 > 0 && v1 == v0, 700);
        v0
    }

    public(friend) fun new_repayment_proof<T0>(arg0: u64, arg1: u64) : RepaymentProof<T0> {
        RepaymentProof<T0>{
            debt   : arg0,
            repaid : arg1,
        }
    }

    public fun prepare_sui_conversion_v3<T0>(arg0: RepaymentProof<T0>, arg1: 0x2::balance::Balance<T0>, arg2: u64) : (0x2::balance::Balance<T0>, ConversionReceipt<T0>) {
        let v0 = 0x2::balance::value<T0>(&arg1);
        assert!(v0 > 0, 701);
        assert!(arg2 > 0 && v0 >= arg2, 702);
        let v1 = ConversionReceipt<T0>{
            debt_repaid : consume_repayment<T0>(arg0),
            base_profit : v0,
        };
        (arg1, v1)
    }

    public fun settle_base_v3<T0>(arg0: RepaymentProof<T0>, arg1: 0x2::balance::Balance<T0>, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<T0>(&arg1);
        assert!(v0 > 0, 701);
        assert!(arg2 > 0 && v0 >= arg2, 702);
        let v1 = FinalSettlementV3<T0>{
            sender           : 0x2::tx_context::sender(arg3),
            debt_repaid      : consume_repayment<T0>(arg0),
            base_profit      : v0,
            sui_payout       : 0,
            converted_to_sui : false,
        };
        0x2::event::emit<FinalSettlementV3<T0>>(v1);
        0x2::balance::send_funds<T0>(arg1, @0xa40759d45016da48ec08b52907582e69d9c0de9c1ce719331a409e6e15533292);
    }

    public fun settle_converted_sui_v3<T0>(arg0: ConversionReceipt<T0>, arg1: 0x2::balance::Balance<0x2::sui::SUI>, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        let ConversionReceipt {
            debt_repaid : v0,
            base_profit : v1,
        } = arg0;
        let v2 = 0x2::balance::value<0x2::sui::SUI>(&arg1);
        assert!(v2 > 0, 701);
        assert!(arg2 > 0 && v2 >= arg2, 703);
        let v3 = FinalSettlementV3<T0>{
            sender           : 0x2::tx_context::sender(arg3),
            debt_repaid      : v0,
            base_profit      : v1,
            sui_payout       : v2,
            converted_to_sui : true,
        };
        0x2::event::emit<FinalSettlementV3<T0>>(v3);
        0x2::balance::send_funds<0x2::sui::SUI>(arg1, @0xa40759d45016da48ec08b52907582e69d9c0de9c1ce719331a409e6e15533292);
    }

    // decompiled from Move bytecode v7
}

