module 0x9ac73ab78e0de036ce6a216809db4df808b76d6b10f1e8647d4329ece441165a::vakinha {
    struct USDC has drop {
        dummy_field: bool,
    }

    struct Campaign has key {
        id: 0x2::object::UID,
        title: 0x1::string::String,
        description: 0x1::string::String,
        contact: 0x1::string::String,
        author: address,
        goal: u64,
        balance: 0x2::balance::Balance<USDC>,
        is_open: bool,
        created_at: u64,
    }

    struct DonationReceipt has store, key {
        id: 0x2::object::UID,
        campaign_id: 0x2::object::ID,
        donor: address,
        amount: u64,
        timestamp: u64,
    }

    public fun create_campaign(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 > 0, 1);
        let v0 = Campaign{
            id          : 0x2::object::new(arg5),
            title       : arg0,
            description : arg1,
            contact     : arg2,
            author      : 0x2::tx_context::sender(arg5),
            goal        : arg3,
            balance     : 0x2::balance::zero<USDC>(),
            is_open     : true,
            created_at  : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::transfer::share_object<Campaign>(v0);
    }

    public fun donate(arg0: &mut Campaign, arg1: 0x2::coin::Coin<USDC>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : DonationReceipt {
        assert!(arg0.is_open, 2);
        let v0 = 0x2::coin::value<USDC>(&arg1);
        assert!(v0 > 0, 4);
        0x2::balance::join<USDC>(&mut arg0.balance, 0x2::coin::into_balance<USDC>(arg1));
        let v1 = DonationReceipt{
            id          : 0x2::object::new(arg3),
            campaign_id : 0x2::object::id<Campaign>(arg0),
            donor       : 0x2::tx_context::sender(arg3),
            amount      : v0,
            timestamp   : 0x2::clock::timestamp_ms(arg2),
        };
        if (0x2::balance::value<USDC>(&arg0.balance) >= arg0.goal) {
            arg0.is_open = false;
        };
        v1
    }

    entry fun donate_and_keep_receipt(arg0: &mut Campaign, arg1: 0x2::coin::Coin<USDC>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = donate(arg0, arg1, arg2, arg3);
        0x2::transfer::transfer<DonationReceipt>(v0, 0x2::tx_context::sender(arg3));
    }

    public fun get_author(arg0: &Campaign) : address {
        arg0.author
    }

    public fun get_balance(arg0: &Campaign) : u64 {
        0x2::balance::value<USDC>(&arg0.balance)
    }

    public fun get_goal(arg0: &Campaign) : u64 {
        arg0.goal
    }

    public fun get_progress_percentage(arg0: &Campaign) : u64 {
        if (arg0.goal == 0) {
            return 0
        };
        0x2::balance::value<USDC>(&arg0.balance) * 100 / arg0.goal
    }

    public fun is_open(arg0: &Campaign) : bool {
        arg0.is_open
    }

    public fun micro_to_usdc(arg0: u64) : u64 {
        arg0 / 1000000
    }

    public fun usdc_to_micro(arg0: u64) : u64 {
        arg0 * 1000000
    }

    public fun withdraw(arg0: &mut Campaign, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.author, 3);
        assert!(!arg0.is_open, 2);
        assert!(0x2::balance::value<USDC>(&arg0.balance) >= arg0.goal, 5);
        0x2::transfer::public_transfer<0x2::coin::Coin<USDC>>(0x2::coin::from_balance<USDC>(0x2::balance::withdraw_all<USDC>(&mut arg0.balance), arg1), arg0.author);
    }

    // decompiled from Move bytecode v6
}

