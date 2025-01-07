module 0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::stake {
    struct StakePool has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::kart::KART>,
        time_ks: 0x2::table::Table<address, u64>,
        time_kc: 0x2::table::Table<address, u64>,
        time_kb: 0x2::table::Table<address, u64>,
        deposit_ks: 0x2::table::Table<address, 0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::kartscription::KartScription>,
        deposit_kc: 0x2::table::Table<address, 0x2::balance::Balance<0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::kart::KART>>,
        deposit_kb: 0x2::table::Table<address, 0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::kartbox::KartBox>,
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

    public entry fun claim_reward_kb(arg0: &mut StakePool, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<address, u64>(&arg0.time_kb, v0), 1);
        assert!(0x2::clock::timestamp_ms(arg1) - *0x2::table::borrow<address, u64>(&arg0.time_kb, v0) > 86400000, 2);
        do_claim_reward_kb(arg0, arg1, arg2);
    }

    public entry fun claim_reward_kc(arg0: &mut StakePool, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<address, u64>(&arg0.time_kc, v0), 1);
        assert!(0x2::clock::timestamp_ms(arg1) - *0x2::table::borrow<address, u64>(&arg0.time_kc, v0) > 86400000, 2);
        do_claim_reward_kc(arg0, arg1, arg2);
    }

    public entry fun claim_reward_ks(arg0: &mut StakePool, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<address, u64>(&arg0.time_ks, v0), 1);
        assert!(0x2::clock::timestamp_ms(arg1) - *0x2::table::borrow<address, u64>(&arg0.time_ks, v0) > 86400000, 2);
        do_claim_reward_ks(arg0, arg1, arg2);
    }

    public entry fun deposit_kb(arg0: 0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::kartbox::KartBox, arg1: &mut StakePool, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        do_deposit_kb(arg0, arg1, arg2, arg3);
    }

    public entry fun deposit_kc(arg0: 0x2::coin::Coin<0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::kart::KART>, arg1: &mut StakePool, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        do_deposit_kc(arg0, arg1, arg2, arg3);
    }

    public entry fun deposit_ks(arg0: 0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::kartscription::KartScription, arg1: &mut StakePool, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        do_deposit_ks(arg0, arg1, arg2, arg3);
    }

    public fun deposit_value_kb(arg0: &StakePool, arg1: address) : u64 {
        assert!(0x2::table::contains<address, u64>(&arg0.time_kb, arg1), 1);
        0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::kartbox::current_value(0x2::table::borrow<address, 0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::kartbox::KartBox>(&arg0.deposit_kb, arg1))
    }

    public fun deposit_value_kc(arg0: &StakePool, arg1: address) : u64 {
        assert!(0x2::table::contains<address, u64>(&arg0.time_kc, arg1), 1);
        0x2::balance::value<0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::kart::KART>(0x2::table::borrow<address, 0x2::balance::Balance<0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::kart::KART>>(&arg0.deposit_kc, arg1))
    }

    public fun deposit_value_ks(arg0: &StakePool, arg1: address) : u64 {
        assert!(0x2::table::contains<address, u64>(&arg0.time_ks, arg1), 1);
        0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::kartscription::kart_value(0x2::table::borrow<address, 0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::kartscription::KartScription>(&arg0.deposit_ks, arg1))
    }

    fun do_claim_reward_kb(arg0: &mut StakePool, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<address, u64>(&arg0.time_kb, v0), 1);
        let v1 = 0x2::clock::timestamp_ms(arg1);
        0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::kartbox::inject_kartcoin_to_kartbox(0x2::table::borrow_mut<address, 0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::kartbox::KartBox>(&mut arg0.deposit_kb, v0), 0x2::coin::take<0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::kart::KART>(&mut arg0.balance, (((deposit_value_kb(arg0, v0) as u128) * ((v1 - *0x2::table::borrow<address, u64>(&arg0.time_kb, v0)) as u128) * 350 / 31536000000 * 10000) as u64), arg2));
        *0x2::table::borrow_mut<address, u64>(&mut arg0.time_kb, v0) = v1;
    }

    fun do_claim_reward_kc(arg0: &mut StakePool, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<address, u64>(&arg0.time_kc, v0), 1);
        let v1 = 0x2::clock::timestamp_ms(arg1);
        0x2::coin::put<0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::kart::KART>(0x2::table::borrow_mut<address, 0x2::balance::Balance<0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::kart::KART>>(&mut arg0.deposit_kc, v0), 0x2::coin::take<0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::kart::KART>(&mut arg0.balance, (((deposit_value_kc(arg0, v0) as u128) * ((v1 - *0x2::table::borrow<address, u64>(&arg0.time_kc, v0)) as u128) * 350 / 31536000000 * 10000) as u64), arg2));
        *0x2::table::borrow_mut<address, u64>(&mut arg0.time_kc, v0) = v1;
    }

    fun do_claim_reward_ks(arg0: &mut StakePool, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<address, u64>(&arg0.time_ks, v0), 1);
        let v1 = 0x2::clock::timestamp_ms(arg1);
        0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::kartscription::inject_kart(0x2::table::borrow_mut<address, 0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::kartscription::KartScription>(&mut arg0.deposit_ks, v0), 0x2::coin::take<0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::kart::KART>(&mut arg0.balance, (((deposit_value_ks(arg0, v0) as u128) * ((v1 - *0x2::table::borrow<address, u64>(&arg0.time_ks, v0)) as u128) * 400 / 31536000000 * 10000) as u64), arg2));
        *0x2::table::borrow_mut<address, u64>(&mut arg0.time_ks, v0) = v1;
    }

    public fun do_deposit_kb(arg0: 0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::kartbox::KartBox, arg1: &mut StakePool, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = DepositEvent{
            amount : 0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::kartbox::current_value(&arg0),
            sender : v0,
            type   : 0x1::string::utf8(b"KartBox"),
        };
        0x2::event::emit<DepositEvent>(v1);
        if (0x2::table::contains<address, u64>(&arg1.time_kb, v0)) {
            do_claim_reward_kb(arg1, arg2, arg3);
            0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::kartbox::do_merge(0x2::table::borrow_mut<address, 0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::kartbox::KartBox>(&mut arg1.deposit_kb, v0), arg0);
        } else {
            0x2::table::add<address, u64>(&mut arg1.time_kb, v0, 0x2::clock::timestamp_ms(arg2));
            0x2::table::add<address, 0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::kartbox::KartBox>(&mut arg1.deposit_kb, v0, arg0);
        };
    }

    public fun do_deposit_kc(arg0: 0x2::coin::Coin<0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::kart::KART>, arg1: &mut StakePool, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = DepositEvent{
            amount : 0x2::coin::value<0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::kart::KART>(&arg0),
            sender : v0,
            type   : 0x1::string::utf8(b"KartCoin"),
        };
        0x2::event::emit<DepositEvent>(v1);
        if (0x2::table::contains<address, u64>(&arg1.time_kc, v0)) {
            do_claim_reward_kc(arg1, arg2, arg3);
            0x2::coin::put<0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::kart::KART>(0x2::table::borrow_mut<address, 0x2::balance::Balance<0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::kart::KART>>(&mut arg1.deposit_kc, v0), arg0);
        } else {
            0x2::table::add<address, u64>(&mut arg1.time_kc, v0, 0x2::clock::timestamp_ms(arg2));
            0x2::table::add<address, 0x2::balance::Balance<0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::kart::KART>>(&mut arg1.deposit_kc, v0, 0x2::coin::into_balance<0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::kart::KART>(arg0));
        };
    }

    public fun do_deposit_ks(arg0: 0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::kartscription::KartScription, arg1: &mut StakePool, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = DepositEvent{
            amount : 0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::kartscription::kart_value(&arg0),
            sender : v0,
            type   : 0x1::string::utf8(b"KartScription"),
        };
        0x2::event::emit<DepositEvent>(v1);
        if (0x2::table::contains<address, u64>(&arg1.time_ks, v0)) {
            do_claim_reward_ks(arg1, arg2, arg3);
            0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::kartscription::do_merge(0x2::table::borrow_mut<address, 0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::kartscription::KartScription>(&mut arg1.deposit_ks, v0), arg0, arg3);
        } else {
            0x2::table::add<address, u64>(&mut arg1.time_ks, v0, 0x2::clock::timestamp_ms(arg2));
            0x2::table::add<address, 0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::kartscription::KartScription>(&mut arg1.deposit_ks, v0, arg0);
        };
    }

    public fun do_pay_w_kartcoin(arg0: &mut 0x2::coin::Coin<0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::kart::KART>, arg1: u64, arg2: &mut StakePool, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::put<0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::kart::KART>(&mut arg2.balance, 0x2::coin::split<0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::kart::KART>(arg0, arg1, arg3));
        let v0 = PayEvent{
            amount : arg1,
            sender : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<PayEvent>(v0);
    }

    public fun do_pay_w_kartscription(arg0: &mut 0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::kartscription::KartScription, arg1: u64, arg2: &mut StakePool, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::put<0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::kart::KART>(&mut arg2.balance, 0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::kartscription::pay(arg0, arg1, arg3));
        let v0 = PayEvent{
            amount : arg1,
            sender : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<PayEvent>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = StakePool{
            id         : 0x2::object::new(arg0),
            balance    : 0x2::balance::zero<0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::kart::KART>(),
            time_ks    : 0x2::table::new<address, u64>(arg0),
            time_kc    : 0x2::table::new<address, u64>(arg0),
            time_kb    : 0x2::table::new<address, u64>(arg0),
            deposit_ks : 0x2::table::new<address, 0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::kartscription::KartScription>(arg0),
            deposit_kc : 0x2::table::new<address, 0x2::balance::Balance<0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::kart::KART>>(arg0),
            deposit_kb : 0x2::table::new<address, 0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::kartbox::KartBox>(arg0),
        };
        0x2::transfer::share_object<StakePool>(v0);
    }

    public entry fun pay_w_kartcoin(arg0: &mut 0x2::coin::Coin<0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::kart::KART>, arg1: u64, arg2: &mut StakePool, arg3: &mut 0x2::tx_context::TxContext) {
        do_pay_w_kartcoin(arg0, arg1, arg2, arg3);
    }

    public entry fun pay_w_kartscription(arg0: &mut 0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::kartscription::KartScription, arg1: u64, arg2: &mut StakePool, arg3: &mut 0x2::tx_context::TxContext) {
        do_pay_w_kartscription(arg0, arg1, arg2, arg3);
    }

    public entry fun withdraw_kb(arg0: &mut StakePool, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        claim_reward_kb(arg0, arg1, arg2);
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::table::remove<address, 0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::kartbox::KartBox>(&mut arg0.deposit_kb, v0);
        0x2::table::remove<address, u64>(&mut arg0.time_kb, v0);
        let v2 = WithdrawEvent{
            amount : 0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::kartbox::current_value(&v1),
            sender : v0,
        };
        0x2::event::emit<WithdrawEvent>(v2);
        0x2::transfer::public_transfer<0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::kartbox::KartBox>(v1, v0);
    }

    public entry fun withdraw_kc(arg0: &mut StakePool, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        claim_reward_kc(arg0, arg1, arg2);
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::coin::from_balance<0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::kart::KART>(0x2::table::remove<address, 0x2::balance::Balance<0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::kart::KART>>(&mut arg0.deposit_kc, v0), arg2);
        0x2::table::remove<address, u64>(&mut arg0.time_kc, v0);
        let v2 = WithdrawEvent{
            amount : 0x2::coin::value<0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::kart::KART>(&v1),
            sender : v0,
        };
        0x2::event::emit<WithdrawEvent>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::kart::KART>>(v1, v0);
    }

    public entry fun withdraw_ks(arg0: &mut StakePool, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        claim_reward_ks(arg0, arg1, arg2);
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::table::remove<address, 0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::kartscription::KartScription>(&mut arg0.deposit_ks, v0);
        0x2::table::remove<address, u64>(&mut arg0.time_ks, v0);
        let v2 = WithdrawEvent{
            amount : 0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::kartscription::kart_value(&v1),
            sender : v0,
        };
        0x2::event::emit<WithdrawEvent>(v2);
        0x2::transfer::public_transfer<0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::kartscription::KartScription>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

