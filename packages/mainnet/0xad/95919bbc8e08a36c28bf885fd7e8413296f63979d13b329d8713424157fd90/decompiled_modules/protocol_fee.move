module 0xad95919bbc8e08a36c28bf885fd7e8413296f63979d13b329d8713424157fd90::protocol_fee {
    struct ProtocolTreasury has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        total_collected: u64,
        intent_count: u64,
        admin: address,
        fee_per_intent: u64,
    }

    struct FeePaid has copy, drop {
        treasury: 0x2::object::ID,
        payer: address,
        amount: u64,
        intent_type: vector<u8>,
        intent_number: u64,
    }

    struct FeeWithdrawn has copy, drop {
        treasury: 0x2::object::ID,
        admin: address,
        amount: u64,
    }

    struct FeeUpdated has copy, drop {
        treasury: 0x2::object::ID,
        admin: address,
        old_fee: u64,
        new_fee: u64,
    }

    struct AdminTransferred has copy, drop {
        treasury: 0x2::object::ID,
        old_admin: address,
        new_admin: address,
    }

    public fun balance(arg0: &ProtocolTreasury) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance)
    }

    public fun admin(arg0: &ProtocolTreasury) : address {
        arg0.admin
    }

    public fun fee_per_intent(arg0: &ProtocolTreasury) : u64 {
        arg0.fee_per_intent
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ProtocolTreasury{
            id              : 0x2::object::new(arg0),
            balance         : 0x2::balance::zero<0x2::sui::SUI>(),
            total_collected : 0,
            intent_count    : 0,
            admin           : 0x2::tx_context::sender(arg0),
            fee_per_intent  : 5000000,
        };
        0x2::transfer::share_object<ProtocolTreasury>(v0);
    }

    public fun intent_count(arg0: &ProtocolTreasury) : u64 {
        arg0.intent_count
    }

    public fun pay_fee(arg0: &mut ProtocolTreasury, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.fee_per_intent;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= v0, 0);
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::split<0x2::sui::SUI>(&mut arg1, v0, arg3));
        arg0.total_collected = arg0.total_collected + v0;
        arg0.intent_count = arg0.intent_count + 1;
        let v1 = FeePaid{
            treasury      : 0x2::object::id<ProtocolTreasury>(arg0),
            payer         : 0x2::tx_context::sender(arg3),
            amount        : v0,
            intent_type   : arg2,
            intent_number : arg0.intent_count,
        };
        0x2::event::emit<FeePaid>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, 0x2::tx_context::sender(arg3));
    }

    public fun set_fee(arg0: &mut ProtocolTreasury, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.admin, 1);
        assert!(arg1 > 0, 2);
        arg0.fee_per_intent = arg1;
        let v1 = FeeUpdated{
            treasury : 0x2::object::id<ProtocolTreasury>(arg0),
            admin    : v0,
            old_fee  : arg0.fee_per_intent,
            new_fee  : arg1,
        };
        0x2::event::emit<FeeUpdated>(v1);
    }

    public fun total_collected(arg0: &ProtocolTreasury) : u64 {
        arg0.total_collected
    }

    public fun transfer_admin(arg0: &mut ProtocolTreasury, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 1);
        arg0.admin = arg1;
        let v0 = AdminTransferred{
            treasury  : 0x2::object::id<ProtocolTreasury>(arg0),
            old_admin : arg0.admin,
            new_admin : arg1,
        };
        0x2::event::emit<AdminTransferred>(v0);
    }

    public fun withdraw_all(arg0: &mut ProtocolTreasury, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(v0 == arg0.admin, 1);
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&arg0.balance);
        assert!(v1 > 0, 0);
        let v2 = FeeWithdrawn{
            treasury : 0x2::object::id<ProtocolTreasury>(arg0),
            admin    : v0,
            amount   : v1,
        };
        0x2::event::emit<FeeWithdrawn>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.balance, v1, arg1), v0);
    }

    // decompiled from Move bytecode v6
}

