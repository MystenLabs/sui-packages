module 0x93df359be7afae4aa1c328124c3c55c9a381951459187447ec4ef9c6cc467817::payments {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Treasury<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
    }

    struct SubscriptionReceipt has store, key {
        id: 0x2::object::UID,
        user_address: address,
        plan: vector<u8>,
        amount_paid: u64,
        timestamp: u64,
    }

    struct PaymentEvent has copy, drop {
        user: address,
        plan: vector<u8>,
        amount: u64,
        receipt_id: 0x2::object::ID,
        timestamp: u64,
    }

    struct WithdrawalEvent has copy, drop {
        amount: u64,
        recipient: address,
        timestamp: u64,
    }

    public fun get_enterprise_price() : u64 {
        29990000
    }

    public fun get_premium_price() : u64 {
        9990000
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun init_treasury<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Treasury<T0>{
            id      : 0x2::object::new(arg0),
            balance : 0x2::balance::zero<T0>(),
        };
        0x2::transfer::share_object<Treasury<T0>>(v0);
    }

    public entry fun pay_enterprise<T0>(arg0: &mut Treasury<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 == 29990000, 1);
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
        let v1 = 0x2::object::new(arg3);
        let v2 = SubscriptionReceipt{
            id           : v1,
            user_address : 0x2::tx_context::sender(arg3),
            plan         : b"enterprise",
            amount_paid  : v0,
            timestamp    : 0x2::clock::timestamp_ms(arg2),
        };
        let v3 = PaymentEvent{
            user       : 0x2::tx_context::sender(arg3),
            plan       : b"enterprise",
            amount     : v0,
            receipt_id : 0x2::object::uid_to_inner(&v1),
            timestamp  : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<PaymentEvent>(v3);
        0x2::transfer::public_transfer<SubscriptionReceipt>(v2, 0x2::tx_context::sender(arg3));
    }

    public entry fun pay_premium<T0>(arg0: &mut Treasury<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 == 9990000, 1);
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
        let v1 = 0x2::object::new(arg3);
        let v2 = SubscriptionReceipt{
            id           : v1,
            user_address : 0x2::tx_context::sender(arg3),
            plan         : b"premium",
            amount_paid  : v0,
            timestamp    : 0x2::clock::timestamp_ms(arg2),
        };
        let v3 = PaymentEvent{
            user       : 0x2::tx_context::sender(arg3),
            plan       : b"premium",
            amount     : v0,
            receipt_id : 0x2::object::uid_to_inner(&v1),
            timestamp  : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<PaymentEvent>(v3);
        0x2::transfer::public_transfer<SubscriptionReceipt>(v2, 0x2::tx_context::sender(arg3));
    }

    public fun receipt_amount(arg0: &SubscriptionReceipt) : u64 {
        arg0.amount_paid
    }

    public fun receipt_plan(arg0: &SubscriptionReceipt) : &vector<u8> {
        &arg0.plan
    }

    public fun receipt_timestamp(arg0: &SubscriptionReceipt) : u64 {
        arg0.timestamp
    }

    public entry fun transfer_admin(arg0: AdminCap, arg1: address) {
        0x2::transfer::transfer<AdminCap>(arg0, arg1);
    }

    public fun treasury_balance<T0>(arg0: &Treasury<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public entry fun withdraw<T0>(arg0: &AdminCap, arg1: &mut Treasury<T0>, arg2: u64, arg3: address, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<T0>(&arg1.balance) >= arg2, 3);
        let v0 = WithdrawalEvent{
            amount    : arg2,
            recipient : arg3,
            timestamp : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<WithdrawalEvent>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance, arg2), arg5), arg3);
    }

    // decompiled from Move bytecode v6
}

