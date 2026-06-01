module 0x888f919f64154138f6e21a2341515f68d472be54c45eb9c70e628cfb5458958a::suirobo_factory {
    struct Marketplace has key {
        id: 0x2::object::UID,
        treasury: 0x2::balance::Balance<0x2::sui::SUI>,
        platform_fee_percent: u8,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Skill has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        blob_id: 0x1::string::String,
        version: 0x1::string::String,
        creator: address,
        price: u64,
    }

    struct SkillReceipt has store, key {
        id: 0x2::object::UID,
        skill_id: 0x2::object::ID,
    }

    struct SkillPublished has copy, drop {
        skill_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
        price: u64,
        blob_id: 0x1::string::String,
    }

    struct SkillPurchased has copy, drop {
        skill_id: 0x2::object::ID,
        buyer: address,
        price: u64,
        creator_revenue: u64,
        platform_revenue: u64,
    }

    struct ExecutionFeePaid has copy, drop {
        payer: address,
        total_fee: u64,
        platform_share: u64,
        creator_reward: u64,
        rewarded_creator: address,
        num_creators: u64,
    }

    public fun buy_skill(arg0: &mut Marketplace, arg1: &Skill, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v0 >= arg1.price, 0);
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = v0 * (arg0.platform_fee_percent as u64) / 100;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.treasury, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, v2, arg3)));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, arg1.creator);
        let v3 = SkillReceipt{
            id       : 0x2::object::new(arg3),
            skill_id : 0x2::object::id<Skill>(arg1),
        };
        0x2::transfer::public_transfer<SkillReceipt>(v3, v1);
        let v4 = SkillPurchased{
            skill_id         : 0x2::object::id<Skill>(arg1),
            buyer            : v1,
            price            : arg1.price,
            creator_revenue  : v0 - v2,
            platform_revenue : v2,
        };
        0x2::event::emit<SkillPurchased>(v4);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = Marketplace{
            id                   : 0x2::object::new(arg0),
            treasury             : 0x2::balance::zero<0x2::sui::SUI>(),
            platform_fee_percent : 20,
        };
        0x2::transfer::share_object<Marketplace>(v1);
    }

    entry fun pay_execution_fee(arg0: &mut Marketplace, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: vector<address>, arg3: &0x2::random::Random, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) == 50000000, 2);
        if (0x1::vector::is_empty<address>(&arg2)) {
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.treasury, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
            let v0 = ExecutionFeePaid{
                payer            : 0x2::tx_context::sender(arg4),
                total_fee        : 50000000,
                platform_share   : 50000000,
                creator_reward   : 0,
                rewarded_creator : @0x0,
                num_creators     : 0,
            };
            0x2::event::emit<ExecutionFeePaid>(v0);
        } else {
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.treasury, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, 25000000, arg4)));
            let v1 = 0x2::random::new_generator(arg3, arg4);
            let v2 = 0x1::vector::length<address>(&arg2);
            let v3 = *0x1::vector::borrow<address>(&arg2, 0x2::random::generate_u64_in_range(&mut v1, 0, (v2 as u64) - 1));
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, v3);
            let v4 = ExecutionFeePaid{
                payer            : 0x2::tx_context::sender(arg4),
                total_fee        : 50000000,
                platform_share   : 25000000,
                creator_reward   : 25000000,
                rewarded_creator : v3,
                num_creators     : v2,
            };
            0x2::event::emit<ExecutionFeePaid>(v4);
        };
    }

    public fun publish_skill(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg5);
        let v1 = 0x2::tx_context::sender(arg5);
        let v2 = Skill{
            id          : v0,
            name        : arg0,
            description : arg1,
            blob_id     : arg2,
            version     : arg3,
            creator     : v1,
            price       : arg4,
        };
        let v3 = SkillPublished{
            skill_id : 0x2::object::uid_to_inner(&v0),
            creator  : v1,
            name     : arg0,
            price    : arg4,
            blob_id  : arg2,
        };
        0x2::event::emit<SkillPublished>(v3);
        0x2::transfer::share_object<Skill>(v2);
    }

    public fun update_platform_fee(arg0: &AdminCap, arg1: &mut Marketplace, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 <= 100, 1);
        arg1.platform_fee_percent = arg2;
    }

    public fun withdraw_treasury(arg0: &AdminCap, arg1: &mut Marketplace, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.treasury, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v7
}

