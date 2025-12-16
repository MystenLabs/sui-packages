module 0x51caf411cb8556b67bfc5e6076fd36d129b23c41e929354e7f25c40625bd334a::subscription {
    struct SUBSCRIPTION has drop {
        dummy_field: bool,
    }

    struct Treasury has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<SUBSCRIPTION>,
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

    public fun get_enterprise_price() : u64 {
        29990000
    }

    public fun get_premium_price() : u64 {
        9990000
    }

    fun init(arg0: SUBSCRIPTION, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUBSCRIPTION>(arg0, 6, b"USDC", b"USD Coin (Testnet)", b"Test USDC for subscription payments on Sui testnet", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<SUBSCRIPTION>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUBSCRIPTION>>(v1);
        let v2 = Treasury{
            id      : 0x2::object::new(arg1),
            balance : 0x2::balance::zero<SUBSCRIPTION>(),
        };
        0x2::transfer::share_object<Treasury>(v2);
    }

    public fun mint_test_usdc(arg0: &mut 0x2::coin::TreasuryCap<SUBSCRIPTION>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SUBSCRIPTION>>(0x2::coin::mint<SUBSCRIPTION>(arg0, arg1, arg3), arg2);
    }

    public fun pay_enterprise(arg0: &mut Treasury, arg1: 0x2::coin::Coin<SUBSCRIPTION>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<SUBSCRIPTION>(&arg1);
        assert!(v0 == 29990000, 1);
        0x2::balance::join<SUBSCRIPTION>(&mut arg0.balance, 0x2::coin::into_balance<SUBSCRIPTION>(arg1));
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

    public fun pay_premium(arg0: &mut Treasury, arg1: 0x2::coin::Coin<SUBSCRIPTION>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<SUBSCRIPTION>(&arg1);
        assert!(v0 == 9990000, 1);
        0x2::balance::join<SUBSCRIPTION>(&mut arg0.balance, 0x2::coin::into_balance<SUBSCRIPTION>(arg1));
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

    // decompiled from Move bytecode v6
}

