module 0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::settlement_v4 {
    struct RepaymentProof<phantom T0> {
        source_id: u8,
        evidence_kind: u8,
        debt: u64,
        debt_known: bool,
        repaid: u64,
    }

    struct DecisionV1<phantom T0> has copy, drop {
        sender: address,
        source_id: u8,
        evidence_kind: u8,
        debt: u64,
        debt_known: bool,
        repaid: u64,
        base_profit: u64,
        min_base_profit: u64,
        deadline_ms: u64,
        settled_at_ms: u64,
    }

    fun consume_repayment<T0>(arg0: RepaymentProof<T0>) : (u8, u8, u64, bool, u64) {
        let RepaymentProof {
            source_id     : v0,
            evidence_kind : v1,
            debt          : v2,
            debt_known    : v3,
            repaid        : v4,
        } = arg0;
        assert!(v1 == expected_evidence(v0), 801);
        assert!(v4 > 0, 802);
        if (v1 == 1) {
            assert!(v3, 802);
        };
        if (v3) {
            assert!(v2 > 0 && v4 == v2, 802);
        } else {
            assert!(v1 == 2 && v2 == 0, 802);
        };
        (v0, v1, v2, v3, v4)
    }

    fun expected_evidence(arg0: u8) : u8 {
        if (arg0 == 1 || arg0 == 2) {
            2
        } else {
            assert!(arg0 >= 3 && arg0 <= 16, 800);
            1
        }
    }

    public(friend) fun new_repayment_proof<T0>(arg0: u8, arg1: u8, arg2: u64, arg3: bool, arg4: u64) : RepaymentProof<T0> {
        RepaymentProof<T0>{
            source_id     : arg0,
            evidence_kind : arg1,
            debt          : arg2,
            debt_known    : arg3,
            repaid        : arg4,
        }
    }

    public(friend) fun protocol_validated() : u8 {
        2
    }

    public(friend) fun receipt_view() : u8 {
        1
    }

    public fun settle_base_v4<T0>(arg0: RepaymentProof<T0>, arg1: 0x2::balance::Balance<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: u64, arg5: &0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = 0x2::balance::value<T0>(&arg1);
        validate_settlement_at(v0, arg4, v1, arg2);
        let (v2, v3, v4, v5, v6) = consume_repayment<T0>(arg0);
        let v7 = DecisionV1<T0>{
            sender          : 0x2::tx_context::sender(arg5),
            source_id       : v2,
            evidence_kind   : v3,
            debt            : v4,
            debt_known      : v5,
            repaid          : v6,
            base_profit     : v1,
            min_base_profit : arg2,
            deadline_ms     : arg4,
            settled_at_ms   : v0,
        };
        0x2::event::emit<DecisionV1<T0>>(v7);
        0x2::balance::send_funds<T0>(arg1, @0xa10aecd2e9e45698e8c36ccaf3c4ea51cdda87f3c098a71d1e77be3351000498);
    }

    public(friend) fun source_bluefin_a() : u8 {
        5
    }

    public(friend) fun source_bluefin_b() : u8 {
        6
    }

    public(friend) fun source_cetus_a() : u8 {
        3
    }

    public(friend) fun source_cetus_b() : u8 {
        4
    }

    public(friend) fun source_cetus_dlmm_a() : u8 {
        11
    }

    public(friend) fun source_cetus_dlmm_b() : u8 {
        12
    }

    public(friend) fun source_deepbook_base() : u8 {
        1
    }

    public(friend) fun source_deepbook_quote() : u8 {
        2
    }

    public(friend) fun source_kriya_loan_x() : u8 {
        15
    }

    public(friend) fun source_kriya_loan_y() : u8 {
        16
    }

    public(friend) fun source_magma_a() : u8 {
        7
    }

    public(friend) fun source_magma_b() : u8 {
        8
    }

    public(friend) fun source_momentum_loan_x() : u8 {
        13
    }

    public(friend) fun source_momentum_loan_y() : u8 {
        14
    }

    public(friend) fun source_turbos_a() : u8 {
        9
    }

    public(friend) fun source_turbos_b() : u8 {
        10
    }

    fun validate_settlement_at(arg0: u64, arg1: u64, arg2: u64, arg3: u64) {
        assert!(arg1 > 0, 805);
        assert!(arg0 <= arg1, 806);
        assert!(arg2 > 0, 803);
        assert!(arg3 > 0 && arg2 >= arg3, 804);
    }

    // decompiled from Move bytecode v7
}

