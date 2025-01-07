module 0xdbfda156b7365bd0129ea18a5747a7f29ba0373b308e85920316a02fea64b1bf::stake {
    struct StakePool has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0xdbfda156b7365bd0129ea18a5747a7f29ba0373b308e85920316a02fea64b1bf::mrc::MRC>,
        time_mrcs: 0x2::table::Table<address, u64>,
        time_mrc: 0x2::table::Table<address, u64>,
        time_mrcb: 0x2::table::Table<address, u64>,
        deposit_mrcs: 0x2::table::Table<address, 0xdbfda156b7365bd0129ea18a5747a7f29ba0373b308e85920316a02fea64b1bf::mrcscription::MrcScription>,
        deposit_mrc: 0x2::table::Table<address, 0x2::balance::Balance<0xdbfda156b7365bd0129ea18a5747a7f29ba0373b308e85920316a02fea64b1bf::mrc::MRC>>,
        deposit_mrcb: 0x2::table::Table<address, 0xdbfda156b7365bd0129ea18a5747a7f29ba0373b308e85920316a02fea64b1bf::mrcbox::MrcBox>,
    }

    struct DepositEvent has copy, drop {
        amount: u64,
        sender: address,
        type: 0x1::string::String,
    }

    struct WithdrawEvent has copy, drop {
        amount: u64,
        sender: address,
    }

    struct PayEvent has copy, drop {
        amount: u64,
        sender: address,
    }

    public entry fun claim_reward_mrc(arg0: &mut StakePool, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<address, u64>(&arg0.time_mrc, v0), 1);
        assert!(0x2::clock::timestamp_ms(arg1) - *0x2::table::borrow<address, u64>(&arg0.time_mrc, v0) > 86400000, 2);
        do_claim_reward_mrc(arg0, arg1, arg2);
    }

    public entry fun claim_reward_mrcb(arg0: &mut StakePool, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<address, u64>(&arg0.time_mrcb, v0), 1);
        assert!(0x2::clock::timestamp_ms(arg1) - *0x2::table::borrow<address, u64>(&arg0.time_mrcb, v0) > 86400000, 2);
        do_claim_reward_mrcb(arg0, arg1, arg2);
    }

    public entry fun claim_reward_mrcs(arg0: &mut StakePool, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<address, u64>(&arg0.time_mrcs, v0), 1);
        assert!(0x2::clock::timestamp_ms(arg1) - *0x2::table::borrow<address, u64>(&arg0.time_mrcs, v0) > 86400000, 2);
        do_claim_reward_mrcs(arg0, arg1, arg2);
    }

    public entry fun deposit_mrc(arg0: 0x2::coin::Coin<0xdbfda156b7365bd0129ea18a5747a7f29ba0373b308e85920316a02fea64b1bf::mrc::MRC>, arg1: &mut StakePool, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        do_deposit_mrc(arg0, arg1, arg2, arg3);
    }

    public entry fun deposit_mrcb(arg0: 0xdbfda156b7365bd0129ea18a5747a7f29ba0373b308e85920316a02fea64b1bf::mrcbox::MrcBox, arg1: &mut StakePool, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        do_deposit_mrcb(arg0, arg1, arg2, arg3);
    }

    public entry fun deposit_mrcs(arg0: 0xdbfda156b7365bd0129ea18a5747a7f29ba0373b308e85920316a02fea64b1bf::mrcscription::MrcScription, arg1: &mut StakePool, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        do_deposit_mrcs(arg0, arg1, arg2, arg3);
    }

    public fun deposit_value_mrc(arg0: &StakePool, arg1: address) : u64 {
        assert!(0x2::table::contains<address, u64>(&arg0.time_mrc, arg1), 1);
        0x2::balance::value<0xdbfda156b7365bd0129ea18a5747a7f29ba0373b308e85920316a02fea64b1bf::mrc::MRC>(0x2::table::borrow<address, 0x2::balance::Balance<0xdbfda156b7365bd0129ea18a5747a7f29ba0373b308e85920316a02fea64b1bf::mrc::MRC>>(&arg0.deposit_mrc, arg1))
    }

    public fun deposit_value_mrcb(arg0: &StakePool, arg1: address) : u64 {
        assert!(0x2::table::contains<address, u64>(&arg0.time_mrcb, arg1), 1);
        0xdbfda156b7365bd0129ea18a5747a7f29ba0373b308e85920316a02fea64b1bf::mrcbox::current_value(0x2::table::borrow<address, 0xdbfda156b7365bd0129ea18a5747a7f29ba0373b308e85920316a02fea64b1bf::mrcbox::MrcBox>(&arg0.deposit_mrcb, arg1))
    }

    public fun deposit_value_mrcs(arg0: &StakePool, arg1: address) : u64 {
        assert!(0x2::table::contains<address, u64>(&arg0.time_mrcs, arg1), 1);
        0xdbfda156b7365bd0129ea18a5747a7f29ba0373b308e85920316a02fea64b1bf::mrcscription::mrc_value(0x2::table::borrow<address, 0xdbfda156b7365bd0129ea18a5747a7f29ba0373b308e85920316a02fea64b1bf::mrcscription::MrcScription>(&arg0.deposit_mrcs, arg1))
    }

    fun do_claim_reward_mrc(arg0: &mut StakePool, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<address, u64>(&arg0.time_mrc, v0), 1);
        let v1 = 0x2::clock::timestamp_ms(arg1);
        0x2::coin::put<0xdbfda156b7365bd0129ea18a5747a7f29ba0373b308e85920316a02fea64b1bf::mrc::MRC>(0x2::table::borrow_mut<address, 0x2::balance::Balance<0xdbfda156b7365bd0129ea18a5747a7f29ba0373b308e85920316a02fea64b1bf::mrc::MRC>>(&mut arg0.deposit_mrc, v0), 0x2::coin::take<0xdbfda156b7365bd0129ea18a5747a7f29ba0373b308e85920316a02fea64b1bf::mrc::MRC>(&mut arg0.balance, (((deposit_value_mrc(arg0, v0) as u128) * ((v1 - *0x2::table::borrow<address, u64>(&arg0.time_mrc, v0)) as u128) * 350 / 31536000000 * 10000) as u64), arg2));
        *0x2::table::borrow_mut<address, u64>(&mut arg0.time_mrc, v0) = v1;
    }

    fun do_claim_reward_mrcb(arg0: &mut StakePool, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<address, u64>(&arg0.time_mrcb, v0), 1);
        let v1 = 0x2::clock::timestamp_ms(arg1);
        0xdbfda156b7365bd0129ea18a5747a7f29ba0373b308e85920316a02fea64b1bf::mrcbox::inject_mrccoin_to_mrcbox(0x2::table::borrow_mut<address, 0xdbfda156b7365bd0129ea18a5747a7f29ba0373b308e85920316a02fea64b1bf::mrcbox::MrcBox>(&mut arg0.deposit_mrcb, v0), 0x2::coin::take<0xdbfda156b7365bd0129ea18a5747a7f29ba0373b308e85920316a02fea64b1bf::mrc::MRC>(&mut arg0.balance, (((deposit_value_mrcb(arg0, v0) as u128) * ((v1 - *0x2::table::borrow<address, u64>(&arg0.time_mrcb, v0)) as u128) * 350 / 31536000000 * 10000) as u64), arg2));
        *0x2::table::borrow_mut<address, u64>(&mut arg0.time_mrcb, v0) = v1;
    }

    fun do_claim_reward_mrcs(arg0: &mut StakePool, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<address, u64>(&arg0.time_mrcs, v0), 1);
        let v1 = 0x2::clock::timestamp_ms(arg1);
        0xdbfda156b7365bd0129ea18a5747a7f29ba0373b308e85920316a02fea64b1bf::mrcscription::inject_mrc(0x2::table::borrow_mut<address, 0xdbfda156b7365bd0129ea18a5747a7f29ba0373b308e85920316a02fea64b1bf::mrcscription::MrcScription>(&mut arg0.deposit_mrcs, v0), 0x2::coin::take<0xdbfda156b7365bd0129ea18a5747a7f29ba0373b308e85920316a02fea64b1bf::mrc::MRC>(&mut arg0.balance, (((deposit_value_mrcs(arg0, v0) as u128) * ((v1 - *0x2::table::borrow<address, u64>(&arg0.time_mrcs, v0)) as u128) * 400 / 31536000000 * 10000) as u64), arg2));
        *0x2::table::borrow_mut<address, u64>(&mut arg0.time_mrcs, v0) = v1;
    }

    public fun do_deposit_mrc(arg0: 0x2::coin::Coin<0xdbfda156b7365bd0129ea18a5747a7f29ba0373b308e85920316a02fea64b1bf::mrc::MRC>, arg1: &mut StakePool, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = DepositEvent{
            amount : 0x2::coin::value<0xdbfda156b7365bd0129ea18a5747a7f29ba0373b308e85920316a02fea64b1bf::mrc::MRC>(&arg0),
            sender : v0,
            type   : 0x1::string::utf8(b"MrcCoin"),
        };
        0x2::event::emit<DepositEvent>(v1);
        if (0x2::table::contains<address, u64>(&arg1.time_mrc, v0)) {
            do_claim_reward_mrc(arg1, arg2, arg3);
            0x2::coin::put<0xdbfda156b7365bd0129ea18a5747a7f29ba0373b308e85920316a02fea64b1bf::mrc::MRC>(0x2::table::borrow_mut<address, 0x2::balance::Balance<0xdbfda156b7365bd0129ea18a5747a7f29ba0373b308e85920316a02fea64b1bf::mrc::MRC>>(&mut arg1.deposit_mrc, v0), arg0);
        } else {
            0x2::table::add<address, u64>(&mut arg1.time_mrc, v0, 0x2::clock::timestamp_ms(arg2));
            0x2::table::add<address, 0x2::balance::Balance<0xdbfda156b7365bd0129ea18a5747a7f29ba0373b308e85920316a02fea64b1bf::mrc::MRC>>(&mut arg1.deposit_mrc, v0, 0x2::coin::into_balance<0xdbfda156b7365bd0129ea18a5747a7f29ba0373b308e85920316a02fea64b1bf::mrc::MRC>(arg0));
        };
    }

    public fun do_deposit_mrcb(arg0: 0xdbfda156b7365bd0129ea18a5747a7f29ba0373b308e85920316a02fea64b1bf::mrcbox::MrcBox, arg1: &mut StakePool, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = DepositEvent{
            amount : 0xdbfda156b7365bd0129ea18a5747a7f29ba0373b308e85920316a02fea64b1bf::mrcbox::current_value(&arg0),
            sender : v0,
            type   : 0x1::string::utf8(b"MrcBox"),
        };
        0x2::event::emit<DepositEvent>(v1);
        if (0x2::table::contains<address, u64>(&arg1.time_mrcb, v0)) {
            do_claim_reward_mrcb(arg1, arg2, arg3);
            0xdbfda156b7365bd0129ea18a5747a7f29ba0373b308e85920316a02fea64b1bf::mrcbox::do_merge(0x2::table::borrow_mut<address, 0xdbfda156b7365bd0129ea18a5747a7f29ba0373b308e85920316a02fea64b1bf::mrcbox::MrcBox>(&mut arg1.deposit_mrcb, v0), arg0);
        } else {
            0x2::table::add<address, u64>(&mut arg1.time_mrcb, v0, 0x2::clock::timestamp_ms(arg2));
            0x2::table::add<address, 0xdbfda156b7365bd0129ea18a5747a7f29ba0373b308e85920316a02fea64b1bf::mrcbox::MrcBox>(&mut arg1.deposit_mrcb, v0, arg0);
        };
    }

    public fun do_deposit_mrcs(arg0: 0xdbfda156b7365bd0129ea18a5747a7f29ba0373b308e85920316a02fea64b1bf::mrcscription::MrcScription, arg1: &mut StakePool, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = DepositEvent{
            amount : 0xdbfda156b7365bd0129ea18a5747a7f29ba0373b308e85920316a02fea64b1bf::mrcscription::mrc_value(&arg0),
            sender : v0,
            type   : 0x1::string::utf8(b"MrcScription"),
        };
        0x2::event::emit<DepositEvent>(v1);
        if (0x2::table::contains<address, u64>(&arg1.time_mrcs, v0)) {
            do_claim_reward_mrcs(arg1, arg2, arg3);
            0xdbfda156b7365bd0129ea18a5747a7f29ba0373b308e85920316a02fea64b1bf::mrcscription::do_merge(0x2::table::borrow_mut<address, 0xdbfda156b7365bd0129ea18a5747a7f29ba0373b308e85920316a02fea64b1bf::mrcscription::MrcScription>(&mut arg1.deposit_mrcs, v0), arg0, arg3);
        } else {
            0x2::table::add<address, u64>(&mut arg1.time_mrcs, v0, 0x2::clock::timestamp_ms(arg2));
            0x2::table::add<address, 0xdbfda156b7365bd0129ea18a5747a7f29ba0373b308e85920316a02fea64b1bf::mrcscription::MrcScription>(&mut arg1.deposit_mrcs, v0, arg0);
        };
    }

    public fun do_pay_w_mrccoin(arg0: &mut 0x2::coin::Coin<0xdbfda156b7365bd0129ea18a5747a7f29ba0373b308e85920316a02fea64b1bf::mrc::MRC>, arg1: u64, arg2: &mut StakePool, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::put<0xdbfda156b7365bd0129ea18a5747a7f29ba0373b308e85920316a02fea64b1bf::mrc::MRC>(&mut arg2.balance, 0x2::coin::split<0xdbfda156b7365bd0129ea18a5747a7f29ba0373b308e85920316a02fea64b1bf::mrc::MRC>(arg0, arg1, arg3));
        let v0 = PayEvent{
            amount : arg1,
            sender : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<PayEvent>(v0);
    }

    public fun do_pay_w_mrcscription(arg0: &mut 0xdbfda156b7365bd0129ea18a5747a7f29ba0373b308e85920316a02fea64b1bf::mrcscription::MrcScription, arg1: u64, arg2: &mut StakePool, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::put<0xdbfda156b7365bd0129ea18a5747a7f29ba0373b308e85920316a02fea64b1bf::mrc::MRC>(&mut arg2.balance, 0xdbfda156b7365bd0129ea18a5747a7f29ba0373b308e85920316a02fea64b1bf::mrcscription::pay(arg0, arg1, arg3));
        let v0 = PayEvent{
            amount : arg1,
            sender : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<PayEvent>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = StakePool{
            id           : 0x2::object::new(arg0),
            balance      : 0x2::balance::zero<0xdbfda156b7365bd0129ea18a5747a7f29ba0373b308e85920316a02fea64b1bf::mrc::MRC>(),
            time_mrcs    : 0x2::table::new<address, u64>(arg0),
            time_mrc     : 0x2::table::new<address, u64>(arg0),
            time_mrcb    : 0x2::table::new<address, u64>(arg0),
            deposit_mrcs : 0x2::table::new<address, 0xdbfda156b7365bd0129ea18a5747a7f29ba0373b308e85920316a02fea64b1bf::mrcscription::MrcScription>(arg0),
            deposit_mrc  : 0x2::table::new<address, 0x2::balance::Balance<0xdbfda156b7365bd0129ea18a5747a7f29ba0373b308e85920316a02fea64b1bf::mrc::MRC>>(arg0),
            deposit_mrcb : 0x2::table::new<address, 0xdbfda156b7365bd0129ea18a5747a7f29ba0373b308e85920316a02fea64b1bf::mrcbox::MrcBox>(arg0),
        };
        0x2::transfer::share_object<StakePool>(v0);
    }

    public fun last_time_mrc(arg0: &StakePool, arg1: address) : u64 {
        assert!(0x2::table::contains<address, u64>(&arg0.time_mrc, arg1), 1);
        *0x2::table::borrow<address, u64>(&arg0.time_mrc, arg1)
    }

    public fun last_time_mrcb(arg0: &StakePool, arg1: address) : u64 {
        assert!(0x2::table::contains<address, u64>(&arg0.time_mrcb, arg1), 1);
        *0x2::table::borrow<address, u64>(&arg0.time_mrcb, arg1)
    }

    public fun last_time_mrcs(arg0: &StakePool, arg1: address) : u64 {
        assert!(0x2::table::contains<address, u64>(&arg0.time_mrcs, arg1), 1);
        *0x2::table::borrow<address, u64>(&arg0.time_mrcs, arg1)
    }

    public entry fun pay_w_mrccoin(arg0: &mut 0x2::coin::Coin<0xdbfda156b7365bd0129ea18a5747a7f29ba0373b308e85920316a02fea64b1bf::mrc::MRC>, arg1: u64, arg2: &mut StakePool, arg3: &mut 0x2::tx_context::TxContext) {
        do_pay_w_mrccoin(arg0, arg1, arg2, arg3);
    }

    public entry fun pay_w_mrcscription(arg0: &mut 0xdbfda156b7365bd0129ea18a5747a7f29ba0373b308e85920316a02fea64b1bf::mrcscription::MrcScription, arg1: u64, arg2: &mut StakePool, arg3: &mut 0x2::tx_context::TxContext) {
        do_pay_w_mrcscription(arg0, arg1, arg2, arg3);
    }

    public entry fun withdraw_mrc(arg0: &mut StakePool, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        claim_reward_mrc(arg0, arg1, arg2);
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::coin::from_balance<0xdbfda156b7365bd0129ea18a5747a7f29ba0373b308e85920316a02fea64b1bf::mrc::MRC>(0x2::table::remove<address, 0x2::balance::Balance<0xdbfda156b7365bd0129ea18a5747a7f29ba0373b308e85920316a02fea64b1bf::mrc::MRC>>(&mut arg0.deposit_mrc, v0), arg2);
        0x2::table::remove<address, u64>(&mut arg0.time_mrc, v0);
        let v2 = WithdrawEvent{
            amount : 0x2::coin::value<0xdbfda156b7365bd0129ea18a5747a7f29ba0373b308e85920316a02fea64b1bf::mrc::MRC>(&v1),
            sender : v0,
        };
        0x2::event::emit<WithdrawEvent>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdbfda156b7365bd0129ea18a5747a7f29ba0373b308e85920316a02fea64b1bf::mrc::MRC>>(v1, v0);
    }

    public entry fun withdraw_mrcb(arg0: &mut StakePool, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        claim_reward_mrcb(arg0, arg1, arg2);
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::table::remove<address, 0xdbfda156b7365bd0129ea18a5747a7f29ba0373b308e85920316a02fea64b1bf::mrcbox::MrcBox>(&mut arg0.deposit_mrcb, v0);
        0x2::table::remove<address, u64>(&mut arg0.time_mrcb, v0);
        let v2 = WithdrawEvent{
            amount : 0xdbfda156b7365bd0129ea18a5747a7f29ba0373b308e85920316a02fea64b1bf::mrcbox::current_value(&v1),
            sender : v0,
        };
        0x2::event::emit<WithdrawEvent>(v2);
        0x2::transfer::public_transfer<0xdbfda156b7365bd0129ea18a5747a7f29ba0373b308e85920316a02fea64b1bf::mrcbox::MrcBox>(v1, v0);
    }

    public entry fun withdraw_mrcs(arg0: &mut StakePool, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        claim_reward_mrcs(arg0, arg1, arg2);
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::table::remove<address, 0xdbfda156b7365bd0129ea18a5747a7f29ba0373b308e85920316a02fea64b1bf::mrcscription::MrcScription>(&mut arg0.deposit_mrcs, v0);
        0x2::table::remove<address, u64>(&mut arg0.time_mrcs, v0);
        let v2 = WithdrawEvent{
            amount : 0xdbfda156b7365bd0129ea18a5747a7f29ba0373b308e85920316a02fea64b1bf::mrcscription::mrc_value(&v1),
            sender : v0,
        };
        0x2::event::emit<WithdrawEvent>(v2);
        0x2::transfer::public_transfer<0xdbfda156b7365bd0129ea18a5747a7f29ba0373b308e85920316a02fea64b1bf::mrcscription::MrcScription>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

