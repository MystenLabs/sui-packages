module 0xf7837365ab32d2d9256ffd807232c618e07afe6a8896dbfb7c3e3f365853c22a::Treasury {
    struct Treasury has store, key {
        id: 0x2::object::UID,
        funds: 0x2::balance::Balance<0xf7837365ab32d2d9256ffd807232c618e07afe6a8896dbfb7c3e3f365853c22a::HetraCoin::HETRACOIN>,
        admin: address,
        in_execution: bool,
    }

    struct DepositEvent has copy, drop {
        sender: address,
        amount: u64,
        timestamp: u64,
    }

    struct WithdrawalEvent has copy, drop {
        recipient: address,
        amount: u64,
        timestamp: u64,
    }

    struct WithdrawalRequest has store, key {
        id: 0x2::object::UID,
        amount: u64,
        recipient: address,
        expiration_epoch: u64,
    }

    struct WithdrawalRequestedEvent has copy, drop {
        amount: u64,
        recipient: address,
        expiration_epoch: u64,
    }

    public fun create_treasury(arg0: address, arg1: &mut 0x2::tx_context::TxContext) : Treasury {
        Treasury{
            id           : 0x2::object::new(arg1),
            funds        : 0x2::balance::zero<0xf7837365ab32d2d9256ffd807232c618e07afe6a8896dbfb7c3e3f365853c22a::HetraCoin::HETRACOIN>(),
            admin        : arg0,
            in_execution : false,
        }
    }

    public entry fun deposit(arg0: &mut Treasury, arg1: 0x2::coin::Coin<0xf7837365ab32d2d9256ffd807232c618e07afe6a8896dbfb7c3e3f365853c22a::HetraCoin::HETRACOIN>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.in_execution, 3);
        arg0.in_execution = true;
        0x2::balance::join<0xf7837365ab32d2d9256ffd807232c618e07afe6a8896dbfb7c3e3f365853c22a::HetraCoin::HETRACOIN>(&mut arg0.funds, 0x2::coin::into_balance<0xf7837365ab32d2d9256ffd807232c618e07afe6a8896dbfb7c3e3f365853c22a::HetraCoin::HETRACOIN>(arg1));
        let v0 = DepositEvent{
            sender    : 0x2::tx_context::sender(arg2),
            amount    : 0x2::coin::value<0xf7837365ab32d2d9256ffd807232c618e07afe6a8896dbfb7c3e3f365853c22a::HetraCoin::HETRACOIN>(&arg1),
            timestamp : 0x2::tx_context::epoch(arg2),
        };
        0x2::event::emit<DepositEvent>(v0);
        arg0.in_execution = false;
    }

    public entry fun execute_withdrawal(arg0: &mut Treasury, arg1: WithdrawalRequest, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::epoch(arg2) >= arg1.expiration_epoch, 4);
        withdraw(arg0, arg1.amount, arg2);
        let WithdrawalRequest {
            id               : v0,
            amount           : _,
            recipient        : _,
            expiration_epoch : _,
        } = arg1;
        0x2::object::delete(v0);
    }

    public fun get_balance(arg0: &Treasury) : u64 {
        0x2::balance::value<0xf7837365ab32d2d9256ffd807232c618e07afe6a8896dbfb7c3e3f365853c22a::HetraCoin::HETRACOIN>(&arg0.funds)
    }

    public entry fun request_withdrawal(arg0: &mut Treasury, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 1);
        let v0 = 0x2::tx_context::epoch(arg3) + 60;
        let v1 = WithdrawalRequest{
            id               : 0x2::object::new(arg3),
            amount           : arg1,
            recipient        : arg2,
            expiration_epoch : v0,
        };
        0x2::transfer::transfer<WithdrawalRequest>(v1, 0x2::tx_context::sender(arg3));
        let v2 = WithdrawalRequestedEvent{
            amount           : arg1,
            recipient        : arg2,
            expiration_epoch : v0,
        };
        0x2::event::emit<WithdrawalRequestedEvent>(v2);
    }

    public entry fun withdraw(arg0: &mut Treasury, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.in_execution, 3);
        arg0.in_execution = true;
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.admin, 1);
        assert!(0x2::balance::value<0xf7837365ab32d2d9256ffd807232c618e07afe6a8896dbfb7c3e3f365853c22a::HetraCoin::HETRACOIN>(&arg0.funds) >= arg1, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xf7837365ab32d2d9256ffd807232c618e07afe6a8896dbfb7c3e3f365853c22a::HetraCoin::HETRACOIN>>(0x2::coin::from_balance<0xf7837365ab32d2d9256ffd807232c618e07afe6a8896dbfb7c3e3f365853c22a::HetraCoin::HETRACOIN>(0x2::balance::split<0xf7837365ab32d2d9256ffd807232c618e07afe6a8896dbfb7c3e3f365853c22a::HetraCoin::HETRACOIN>(&mut arg0.funds, arg1), arg2), v0);
        let v1 = WithdrawalEvent{
            recipient : v0,
            amount    : arg1,
            timestamp : 0x2::tx_context::epoch(arg2),
        };
        0x2::event::emit<WithdrawalEvent>(v1);
        arg0.in_execution = false;
    }

    // decompiled from Move bytecode v6
}

