module 0x9cab3a40743b2ee7d6aedb268135fda191d94b14c90a9201d5a713c085b216c4::stream_pay {
    struct Stream has key {
        id: 0x2::object::UID,
        payer: address,
        payee: address,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        start_time: u64,
        duration: u64,
        total_amount: u64,
        claimed_amount: u64,
        last_claim_time: u64,
    }

    struct StreamCreated has copy, drop {
        id: 0x2::object::ID,
        payer: address,
        payee: address,
        amount: u64,
        duration: u64,
    }

    struct FundsClaimed has copy, drop {
        stream_id: 0x2::object::ID,
        amount: u64,
    }

    struct StreamCancelled has copy, drop {
        stream_id: 0x2::object::ID,
        refund_amount: u64,
    }

    public fun calculate_vested_amount(arg0: &Stream, arg1: u64) : u64 {
        if (arg1 <= arg0.start_time) {
            return 0
        };
        let v0 = arg1 - arg0.start_time;
        if (v0 >= arg0.duration) {
            return arg0.total_amount
        };
        (((arg0.total_amount as u128) * (v0 as u128) / (arg0.duration as u128)) as u64)
    }

    public fun cancel_stream(arg0: Stream, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let Stream {
            id              : v0,
            payer           : v1,
            payee           : v2,
            balance         : v3,
            start_time      : v4,
            duration        : v5,
            total_amount    : v6,
            claimed_amount  : v7,
            last_claim_time : _,
        } = arg0;
        let v9 = v3;
        let v10 = v0;
        assert!(0x2::tx_context::sender(arg2) == v1, 3);
        let v11 = 0x2::clock::timestamp_ms(arg1);
        let v12 = if (v11 >= v4 + v5) {
            v6
        } else {
            (((v6 as u128) * ((v11 - v4) as u128) / (v5 as u128)) as u64)
        };
        let v13 = v12 - v7;
        if (v13 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut v9, v13, arg2), v2);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v9, arg2), v1);
        let v14 = StreamCancelled{
            stream_id     : 0x2::object::uid_to_inner(&v10),
            refund_amount : 0x2::balance::value<0x2::sui::SUI>(&v9),
        };
        0x2::event::emit<StreamCancelled>(v14);
        0x2::object::delete(v10);
    }

    public fun claim(arg0: &mut Stream, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(0x2::tx_context::sender(arg2) == arg0.payee, 2);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = calculate_vested_amount(arg0, v0) - arg0.claimed_amount;
        assert!(v1 > 0, 1);
        arg0.claimed_amount = arg0.claimed_amount + v1;
        arg0.last_claim_time = v0;
        let v2 = FundsClaimed{
            stream_id : 0x2::object::uid_to_inner(&arg0.id),
            amount    : v1,
        };
        0x2::event::emit<FundsClaimed>(v2);
        0x2::coin::take<0x2::sui::SUI>(&mut arg0.balance, v1, arg2)
    }

    public fun create_stream(arg0: address, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        let v2 = Stream{
            id              : 0x2::object::new(arg4),
            payer           : 0x2::tx_context::sender(arg4),
            payee           : arg0,
            balance         : 0x2::coin::into_balance<0x2::sui::SUI>(arg1),
            start_time      : v1,
            duration        : arg2,
            total_amount    : v0,
            claimed_amount  : 0,
            last_claim_time : v1,
        };
        let v3 = StreamCreated{
            id       : 0x2::object::uid_to_inner(&v2.id),
            payer    : v2.payer,
            payee    : arg0,
            amount   : v0,
            duration : arg2,
        };
        0x2::event::emit<StreamCreated>(v3);
        0x2::transfer::share_object<Stream>(v2);
    }

    // decompiled from Move bytecode v6
}

