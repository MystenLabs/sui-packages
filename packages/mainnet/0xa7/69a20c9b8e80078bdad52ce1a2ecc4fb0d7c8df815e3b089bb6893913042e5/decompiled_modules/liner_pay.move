module 0xa769a20c9b8e80078bdad52ce1a2ecc4fb0d7c8df815e3b089bb6893913042e5::liner_pay {
    struct PayerPool has store, key {
        id: 0x2::object::UID,
        p_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        p_debt: 0x2::balance::Balance<0x2::sui::SUI>,
        owner: address,
        stream_ids: 0x2::vec_set::VecSet<vector<u8>>,
        p_last_settlement_time: u64,
        p_total_paid_amount_per: u64,
    }

    struct ReciverCard has store, key {
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

    struct CreatePayerPool has copy, drop {
        pool_id: 0x2::object::ID,
        owner: address,
    }

    struct StreamAction has copy, drop {
        stream_id: vector<u8>,
        action_type: 0x1::string::String,
        payer: address,
        p_total_paid_amount_per: u64,
        p_last_settlement_time: u64,
        recipient: address,
        r_amount_per: u64,
        r_last_settlement_time: u64,
    }

    struct WithdrawAction has copy, drop {
        stream_id: vector<u8>,
        action_type: 0x1::string::String,
        from: address,
        to: address,
        amount: u64,
        owe: bool,
    }

    public entry fun cancelStream(arg0: &mut PayerPool, arg1: address, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg5), 5);
        let v0 = getStreamId(arg0.owner, arg1, arg2);
        assert!(0x2::vec_set::contains<vector<u8>>(&arg0.stream_ids, &v0), 3);
        let (v1, _) = settlement(arg0, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.p_debt, (v1 - arg3) * arg2), arg5), arg1);
        0x2::vec_set::remove<vector<u8>>(&mut arg0.stream_ids, &v0);
        arg0.p_total_paid_amount_per = arg0.p_total_paid_amount_per - arg2;
        let v3 = StreamAction{
            stream_id               : v0,
            action_type             : 0x1::string::utf8(b"cancle stream"),
            payer                   : arg0.owner,
            p_total_paid_amount_per : arg0.p_total_paid_amount_per,
            p_last_settlement_time  : arg0.p_last_settlement_time,
            recipient               : arg1,
            r_amount_per            : arg2,
            r_last_settlement_time  : arg3,
        };
        0x2::event::emit<StreamAction>(v3);
    }

    public fun createAndDeposit(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) : address {
        let v0 = PayerPool{
            id                      : 0x2::object::new(arg1),
            p_balance               : 0x2::coin::into_balance<0x2::sui::SUI>(arg0),
            p_debt                  : 0x2::balance::zero<0x2::sui::SUI>(),
            owner                   : 0x2::tx_context::sender(arg1),
            stream_ids              : 0x2::vec_set::empty<vector<u8>>(),
            p_last_settlement_time  : 0,
            p_total_paid_amount_per : 0,
        };
        let v1 = CreatePayerPool{
            pool_id : 0x2::object::uid_to_inner(&v0.id),
            owner   : v0.owner,
        };
        0x2::event::emit<CreatePayerPool>(v1);
        0x2::transfer::share_object<PayerPool>(v0);
        0x2::object::uid_to_address(&v0.id)
    }

    public entry fun createPayPoolAndStream(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: vector<address>, arg2: vector<u64>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<address>(&arg1) == 0x1::vector::length<u64>(&arg2), 0);
        let v0 = PayerPool{
            id                      : 0x2::object::new(arg4),
            p_balance               : 0x2::coin::into_balance<0x2::sui::SUI>(arg0),
            p_debt                  : 0x2::balance::zero<0x2::sui::SUI>(),
            owner                   : 0x2::tx_context::sender(arg4),
            stream_ids              : 0x2::vec_set::empty<vector<u8>>(),
            p_last_settlement_time  : 0,
            p_total_paid_amount_per : 0,
        };
        let v1 = CreatePayerPool{
            pool_id : 0x2::object::uid_to_inner(&v0.id),
            owner   : v0.owner,
        };
        0x2::event::emit<CreatePayerPool>(v1);
        let v2 = 0;
        while (v2 < 0x1::vector::length<address>(&arg1)) {
            let v3 = &mut v0;
            createStream(v3, *0x1::vector::borrow<address>(&arg1, v2), *0x1::vector::borrow<u64>(&arg2, v2), arg3, arg4);
            v2 = v2 + 1;
        };
        0x2::transfer::share_object<PayerPool>(v0);
    }

    public fun createStream(arg0: &mut PayerPool, arg1: address, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : address {
        assert!(arg0.owner == 0x2::tx_context::sender(arg4), 5);
        assert!(arg2 > 0, 2);
        let v0 = getStreamId(arg0.owner, arg1, arg2);
        let v1 = !0x2::vec_set::is_empty<vector<u8>>(&arg0.stream_ids) && 0x2::vec_set::contains<vector<u8>>(&arg0.stream_ids, &v0);
        assert!(!v1, 1);
        0x2::vec_set::insert<vector<u8>>(&mut arg0.stream_ids, v0);
        let v2 = 0x2::clock::timestamp_ms(arg3) / 1000;
        let v3 = ReciverCard{
            id                     : 0x2::object::new(arg4),
            payer                  : arg0.owner,
            recipient              : arg1,
            r_amount_per           : arg2,
            r_last_settlement_time : v2,
        };
        0x2::transfer::transfer<ReciverCard>(v3, arg1);
        let (_, _) = settlement(arg0, arg3);
        arg0.p_total_paid_amount_per = arg0.p_total_paid_amount_per + arg2;
        let v6 = StreamAction{
            stream_id               : v0,
            action_type             : 0x1::string::utf8(b"create stream"),
            payer                   : arg0.owner,
            p_total_paid_amount_per : arg0.p_total_paid_amount_per,
            p_last_settlement_time  : arg0.p_last_settlement_time,
            recipient               : arg1,
            r_amount_per            : arg2,
            r_last_settlement_time  : v2,
        };
        0x2::event::emit<StreamAction>(v6);
        0x2::object::uid_to_address(&v3.id)
    }

    public entry fun getPayerBalance(arg0: &PayerPool, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.p_balance);
        let v1 = (0x2::clock::timestamp_ms(arg1) / 1000 - arg0.p_last_settlement_time) * arg0.p_total_paid_amount_per;
        if (v0 >= v1) {
            v0 - v1
        } else {
            0
        }
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

    fun settlement(arg0: &mut PayerPool, arg1: &0x2::clock::Clock) : (u64, bool) {
        let v0 = (0x2::clock::timestamp_ms(arg1) / 1000 - arg0.p_last_settlement_time) * arg0.p_total_paid_amount_per;
        let v1 = false;
        if (0x2::balance::value<0x2::sui::SUI>(&arg0.p_balance) >= v0) {
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.p_debt, 0x2::balance::split<0x2::sui::SUI>(&mut arg0.p_balance, v0));
            arg0.p_last_settlement_time = 0x2::clock::timestamp_ms(arg1) / 1000;
        } else {
            arg0.p_last_settlement_time = arg0.p_last_settlement_time + 0x2::balance::value<0x2::sui::SUI>(&arg0.p_balance) / arg0.p_total_paid_amount_per;
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.p_debt, 0x2::balance::split<0x2::sui::SUI>(&mut arg0.p_balance, 0x2::balance::value<0x2::sui::SUI>(&arg0.p_balance) - 0x2::balance::value<0x2::sui::SUI>(&arg0.p_balance) % arg0.p_total_paid_amount_per));
            v1 = true;
        };
        (arg0.p_last_settlement_time, v1)
    }

    public entry fun withdraw(arg0: &mut PayerPool, arg1: &mut ReciverCard, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = getStreamId(arg0.owner, arg1.recipient, arg2);
        assert!(0x2::vec_set::contains<vector<u8>>(&arg0.stream_ids, &v0), 3);
        let (v1, v2) = settlement(arg0, arg3);
        let v3 = (v1 - arg1.r_last_settlement_time) * arg1.r_amount_per;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.p_debt, v3), arg4), arg1.recipient);
        arg1.r_last_settlement_time = v1;
        let v4 = WithdrawAction{
            stream_id   : v0,
            action_type : 0x1::string::utf8(b"reciver withdraw"),
            from        : arg0.owner,
            to          : arg1.recipient,
            amount      : v3,
            owe         : v2,
        };
        0x2::event::emit<WithdrawAction>(v4);
    }

    public entry fun withdrawPayer(arg0: &mut PayerPool, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg3), 5);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.p_balance) >= arg1, 4);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.p_balance) >= (0x2::clock::timestamp_ms(arg2) / 1000 - arg0.p_last_settlement_time) * arg0.p_total_paid_amount_per, 4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.p_balance, arg1), arg3), arg0.owner);
        let v0 = WithdrawAction{
            stream_id   : 0x1::vector::empty<u8>(),
            action_type : 0x1::string::utf8(b"payer withdraw"),
            from        : 0x2::object::uid_to_address(&arg0.id),
            to          : arg0.owner,
            amount      : arg1,
            owe         : false,
        };
        0x2::event::emit<WithdrawAction>(v0);
    }

    public entry fun withdrawPayerAll(arg0: &mut PayerPool, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 5);
        let v0 = 0x2::clock::timestamp_ms(arg1) / 1000 - arg0.p_last_settlement_time;
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.p_balance) >= v0 * arg0.p_total_paid_amount_per, 4);
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&arg0.p_balance) - v0 * arg0.p_total_paid_amount_per;
        withdrawPayer(arg0, v1, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

