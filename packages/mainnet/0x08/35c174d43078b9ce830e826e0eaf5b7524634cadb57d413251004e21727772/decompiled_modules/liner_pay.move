module 0x835c174d43078b9ce830e826e0eaf5b7524634cadb57d413251004e21727772::liner_pay {
    struct Payer has store, key {
        id: 0x2::object::UID,
        p_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        p_debt: 0x2::balance::Balance<0x2::sui::SUI>,
        owner: address,
        stream_ids: 0x2::vec_set::VecSet<vector<u8>>,
        p_last_settlement_time: u64,
        p_total_paid_amount_per: u64,
    }

    struct Reciver has store, key {
        id: 0x2::object::UID,
        payer: address,
        recipient: address,
        r_amount_per: u64,
        r_last_settlement_time: u64,
    }

    struct StreamInfo has drop {
        payer: address,
        reciver: address,
        amount_per_sec: u64,
    }

    public entry fun createAndDeposit(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Payer{
            id                      : 0x2::object::new(arg1),
            p_balance               : 0x2::coin::into_balance<0x2::sui::SUI>(arg0),
            p_debt                  : 0x2::balance::zero<0x2::sui::SUI>(),
            owner                   : 0x2::tx_context::sender(arg1),
            stream_ids              : 0x2::vec_set::empty<vector<u8>>(),
            p_last_settlement_time  : 0,
            p_total_paid_amount_per : 0,
        };
        0x2::transfer::share_object<Payer>(v0);
    }

    public entry fun createStream(arg0: &mut Payer, arg1: address, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg4), 5);
        assert!(arg2 > 0, 2);
        let v0 = getStreamId(arg0.owner, arg1, arg2);
        let v1 = !0x2::vec_set::is_empty<vector<u8>>(&arg0.stream_ids) && 0x2::vec_set::contains<vector<u8>>(&arg0.stream_ids, &v0);
        assert!(!v1, 1);
        0x2::vec_set::insert<vector<u8>>(&mut arg0.stream_ids, v0);
        let v2 = Reciver{
            id                     : 0x2::object::new(arg4),
            payer                  : arg0.owner,
            recipient              : arg1,
            r_amount_per           : arg2,
            r_last_settlement_time : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::transfer::transfer<Reciver>(v2, arg1);
        settlement(arg0, arg3);
        arg0.p_total_paid_amount_per = arg0.p_total_paid_amount_per + arg2;
    }

    public entry fun getPayerBalance(arg0: &Payer, arg1: &0x2::clock::Clock) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.p_balance) - (0x2::clock::timestamp_ms(arg1) - arg0.p_last_settlement_time) * arg0.p_total_paid_amount_per
    }

    fun getStreamId(arg0: address, arg1: address, arg2: u64) : vector<u8> {
        let v0 = StreamInfo{
            payer          : arg0,
            reciver        : arg1,
            amount_per_sec : arg2,
        };
        let v1 = 0x2::bcs::to_bytes<StreamInfo>(&v0);
        0x2::hash::keccak256(&v1)
    }

    fun settlement(arg0: &mut Payer, arg1: &0x2::clock::Clock) : u64 {
        let v0 = (0x2::clock::timestamp_ms(arg1) - arg0.p_last_settlement_time) * arg0.p_total_paid_amount_per;
        if (0x2::balance::value<0x2::sui::SUI>(&arg0.p_balance) >= v0) {
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.p_debt, 0x2::balance::split<0x2::sui::SUI>(&mut arg0.p_balance, v0));
            arg0.p_last_settlement_time = 0x2::clock::timestamp_ms(arg1);
        } else {
            arg0.p_last_settlement_time = arg0.p_last_settlement_time + 0x2::balance::value<0x2::sui::SUI>(&arg0.p_balance) / arg0.p_total_paid_amount_per;
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.p_debt, 0x2::balance::split<0x2::sui::SUI>(&mut arg0.p_balance, 0x2::balance::value<0x2::sui::SUI>(&arg0.p_balance) - 0x2::balance::value<0x2::sui::SUI>(&arg0.p_balance) % arg0.p_total_paid_amount_per));
        };
        arg0.p_last_settlement_time
    }

    public entry fun withdraw(arg0: &mut Payer, arg1: &mut Reciver, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = getStreamId(arg0.owner, arg1.recipient, arg2);
        assert!(0x2::vec_set::contains<vector<u8>>(&arg0.stream_ids, &v0), 3);
        let v1 = settlement(arg0, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.p_debt, (v1 - arg1.r_last_settlement_time) * arg1.r_amount_per), arg4), arg1.recipient);
        arg1.r_last_settlement_time = v1;
    }

    public entry fun withdrawPayer(arg0: &mut Payer, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg3), 5);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.p_balance) >= arg1, 4);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.p_balance) >= (0x2::clock::timestamp_ms(arg2) - arg0.p_last_settlement_time) * arg0.p_total_paid_amount_per, 4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.p_balance, arg1), arg3), arg0.owner);
    }

    public entry fun withdrawPayerAll(arg0: &mut Payer, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 5);
        let v0 = 0x2::clock::timestamp_ms(arg1) - arg0.p_last_settlement_time;
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.p_balance) >= v0 * arg0.p_total_paid_amount_per, 4);
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&arg0.p_balance) - v0 * arg0.p_total_paid_amount_per;
        withdrawPayer(arg0, v1, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

