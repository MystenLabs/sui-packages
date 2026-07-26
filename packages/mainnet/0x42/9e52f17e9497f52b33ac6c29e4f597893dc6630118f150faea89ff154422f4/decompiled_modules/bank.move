module 0x429e52f17e9497f52b33ac6c29e4f597893dc6630118f150faea89ff154422f4::bank {
    struct BANK has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Bank has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        total_staked: u64,
        total_withdrawn: u64,
    }

    struct SuiStaked has copy, drop {
        bank_id: 0x2::object::ID,
        depositor: address,
        amount: u64,
        bank_balance: u64,
    }

    struct StakingRewardsClaimed has copy, drop {
        bank_id: 0x2::object::ID,
        admin: address,
        amount: u64,
        bank_balance: u64,
    }

    struct AdminCapCreated has copy, drop {
        parent_cap_id: 0x2::object::ID,
        new_cap_id: 0x2::object::ID,
        issuer: address,
        recipient: address,
    }

    public fun balance(arg0: &Bank) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance)
    }

    public fun create_admin_cap(arg0: &AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg2)};
        let v1 = AdminCapCreated{
            parent_cap_id : 0x2::object::id<AdminCap>(arg0),
            new_cap_id    : 0x2::object::id<AdminCap>(&v0),
            issuer        : 0x2::tx_context::sender(arg2),
            recipient     : arg1,
        };
        0x2::event::emit<AdminCapCreated>(v1);
        0x2::transfer::transfer<AdminCap>(v0, arg1);
    }

    public fun get_staking_rewards(arg0: &AdminCap, arg1: &mut Bank, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(arg2 > 0, 0);
        assert!(arg2 <= 0x2::balance::value<0x2::sui::SUI>(&arg1.balance), 1);
        arg1.total_withdrawn = arg1.total_withdrawn + arg2;
        let v0 = StakingRewardsClaimed{
            bank_id      : 0x2::object::id<Bank>(arg1),
            admin        : 0x2::tx_context::sender(arg3),
            amount       : arg2,
            bank_balance : 0x2::balance::value<0x2::sui::SUI>(&arg1.balance),
        };
        0x2::event::emit<StakingRewardsClaimed>(v0);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.balance, arg2), arg3)
    }

    fun init(arg0: BANK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
        let v1 = Bank{
            id              : 0x2::object::new(arg1),
            balance         : 0x2::balance::zero<0x2::sui::SUI>(),
            total_staked    : 0,
            total_withdrawn : 0,
        };
        0x2::transfer::share_object<Bank>(v1);
    }

    public fun stake_sui(arg0: &mut Bank, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 > 0, 0);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        arg0.total_staked = arg0.total_staked + v0;
        let v1 = SuiStaked{
            bank_id      : 0x2::object::id<Bank>(arg0),
            depositor    : 0x2::tx_context::sender(arg2),
            amount       : v0,
            bank_balance : 0x2::balance::value<0x2::sui::SUI>(&arg0.balance),
        };
        0x2::event::emit<SuiStaked>(v1);
    }

    public fun total_staked(arg0: &Bank) : u64 {
        arg0.total_staked
    }

    public fun total_withdrawn(arg0: &Bank) : u64 {
        arg0.total_withdrawn
    }

    // decompiled from Move bytecode v7
}

