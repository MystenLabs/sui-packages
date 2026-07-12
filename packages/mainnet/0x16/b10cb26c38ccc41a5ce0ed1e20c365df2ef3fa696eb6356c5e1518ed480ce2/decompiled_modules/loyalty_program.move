module 0x16b10cb26c38ccc41a5ce0ed1e20c365df2ef3fa696eb6356c5e1518ed480ce2::loyalty_program {
    struct LoyaltyProgram has key {
        id: 0x2::object::UID,
        admin: address,
        points_per_purchase: u64,
        points_for_free_coffee: u64,
        referral_bonus: u64,
        total_customers: u64,
        total_purchases: u64,
    }

    struct CustomerProfile has key {
        id: 0x2::object::UID,
        zklogin_address: address,
        referral_code: 0x1::string::String,
        referred_by: 0x1::option::Option<address>,
        total_xp: u64,
        level: u64,
        total_purchases: u64,
        created_at: u64,
    }

    struct RewardNFT has store, key {
        id: 0x2::object::UID,
        customer: address,
        shop: address,
        level_reached: u64,
        timestamp: u64,
    }

    struct CustomerShopAccount has store, key {
        id: 0x2::object::UID,
        customer: address,
        shop: address,
        points: u64,
        purchases: u64,
        last_purchase_timestamp: u64,
        created_at: u64,
    }

    struct Purchase has store, key {
        id: 0x2::object::UID,
        customer: address,
        coffee_shop: address,
        points_earned: u64,
        timestamp: u64,
    }

    struct CustomerRegistered has copy, drop {
        customer_address: address,
        referral_code: 0x1::string::String,
        referred_by: 0x1::option::Option<address>,
        timestamp: u64,
    }

    struct LevelUpEvent has copy, drop {
        customer: address,
        shop: address,
        new_level: u64,
        nft_id: address,
        timestamp: u64,
    }

    struct PurchaseRecorded has copy, drop {
        customer: address,
        shop: address,
        points_earned: u64,
        total_points_at_shop: u64,
        timestamp: u64,
    }

    struct PurchaseRequestEvent has copy, drop {
        customer: address,
        shop: address,
        timestamp: u64,
    }

    struct CustomerShopAccountCreated has copy, drop {
        customer: address,
        shop: address,
        timestamp: u64,
    }

    struct RewardRedeemed has copy, drop {
        customer: address,
        points_spent: u64,
        remaining_points: u64,
        timestamp: u64,
    }

    public entry fun apply_referral_bonus(arg0: &mut CustomerShopAccount, arg1: &mut CustomerShopAccount, arg2: &LoyaltyProgram, arg3: &mut 0x2::tx_context::TxContext) {
        arg0.points = arg0.points + arg2.referral_bonus;
        arg1.points = arg1.points + arg2.referral_bonus;
    }

    public fun calculate_level(arg0: u64) : u64 {
        if (arg0 >= 5000) {
            7
        } else if (arg0 >= 2000) {
            6
        } else if (arg0 >= 1000) {
            5
        } else if (arg0 >= 500) {
            4
        } else if (arg0 >= 250) {
            3
        } else if (arg0 >= 100) {
            2
        } else {
            1
        }
    }

    public entry fun create_shop_account(arg0: &CustomerProfile, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 == arg0.zklogin_address, 2);
        let v2 = CustomerShopAccount{
            id                      : 0x2::object::new(arg3),
            customer                : v0,
            shop                    : arg1,
            points                  : 0,
            purchases               : 0,
            last_purchase_timestamp : 0,
            created_at              : v1,
        };
        let v3 = CustomerShopAccountCreated{
            customer  : v0,
            shop      : arg1,
            timestamp : v1,
        };
        0x2::event::emit<CustomerShopAccountCreated>(v3);
        0x2::transfer::transfer<CustomerShopAccount>(v2, v0);
    }

    fun generate_referral_code(arg0: address) : 0x1::string::String {
        let v0 = 0x2::bcs::to_bytes<address>(&arg0);
        let v1 = b"0123456789abcdef";
        let v2 = 0x1::vector::empty<u8>();
        let v3 = 0;
        while (v3 < 6 && v3 < 0x1::vector::length<u8>(&v0)) {
            let v4 = *0x1::vector::borrow<u8>(&v0, v3);
            0x1::vector::push_back<u8>(&mut v2, *0x1::vector::borrow<u8>(&v1, ((v4 >> 4) as u64)));
            0x1::vector::push_back<u8>(&mut v2, *0x1::vector::borrow<u8>(&v1, ((v4 & 15) as u64)));
            v3 = v3 + 1;
        };
        0x1::string::utf8(v2)
    }

    public fun get_account_customer(arg0: &CustomerShopAccount) : address {
        arg0.customer
    }

    public fun get_account_points(arg0: &CustomerShopAccount) : u64 {
        arg0.points
    }

    public fun get_account_purchases(arg0: &CustomerShopAccount) : u64 {
        arg0.purchases
    }

    public fun get_account_shop(arg0: &CustomerShopAccount) : address {
        arg0.shop
    }

    public fun get_customer_address(arg0: &CustomerProfile) : address {
        arg0.zklogin_address
    }

    public fun get_last_purchase_time(arg0: &CustomerShopAccount) : u64 {
        arg0.last_purchase_timestamp
    }

    public fun get_program_stats(arg0: &LoyaltyProgram) : (u64, u64, u64) {
        (arg0.total_customers, arg0.total_purchases, arg0.points_per_purchase)
    }

    public fun get_referral_code(arg0: &CustomerProfile) : 0x1::string::String {
        arg0.referral_code
    }

    public fun get_total_purchases(arg0: &CustomerProfile) : u64 {
        arg0.total_purchases
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = LoyaltyProgram{
            id                     : 0x2::object::new(arg0),
            admin                  : 0x2::tx_context::sender(arg0),
            points_per_purchase    : 10,
            points_for_free_coffee : 100,
            referral_bonus         : 20,
            total_customers        : 0,
            total_purchases        : 0,
        };
        0x2::transfer::share_object<LoyaltyProgram>(v0);
    }

    public(friend) fun migration_mint_profile(arg0: &mut LoyaltyProgram, arg1: address, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = CustomerProfile{
            id              : 0x2::object::new(arg7),
            zklogin_address : arg1,
            referral_code   : 0x1::string::utf8(arg2),
            referred_by     : 0x1::option::none<address>(),
            total_xp        : arg3,
            level           : arg4,
            total_purchases : arg5,
            created_at      : arg6,
        };
        arg0.total_customers = arg0.total_customers + 1;
        0x2::transfer::transfer<CustomerProfile>(v0, arg1);
    }

    public(friend) fun migration_mint_reward_nft(arg0: address, arg1: address, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = RewardNFT{
            id            : 0x2::object::new(arg4),
            customer      : arg0,
            shop          : arg1,
            level_reached : arg2,
            timestamp     : arg3,
        };
        0x2::transfer::transfer<RewardNFT>(v0, arg0);
    }

    public(friend) fun migration_mint_shop_account(arg0: address, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = CustomerShopAccount{
            id                      : 0x2::object::new(arg6),
            customer                : arg0,
            shop                    : arg1,
            points                  : arg2,
            purchases               : arg3,
            last_purchase_timestamp : arg4,
            created_at              : arg5,
        };
        0x2::transfer::transfer<CustomerShopAccount>(v0, arg0);
    }

    public entry fun record_batch_purchases(arg0: &mut CustomerShopAccount, arg1: &mut CustomerProfile, arg2: &mut 0x16b10cb26c38ccc41a5ce0ed1e20c365df2ef3fa696eb6356c5e1518ed480ce2::coffee_shop_registry::CoffeeShop, arg3: &mut LoyaltyProgram, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg5);
        assert!(arg4 > 0 && arg4 <= 5, 10);
        0x16b10cb26c38ccc41a5ce0ed1e20c365df2ef3fa696eb6356c5e1518ed480ce2::coffee_shop_registry::verify_shop_ready(arg2);
        let v1 = 0x16b10cb26c38ccc41a5ce0ed1e20c365df2ef3fa696eb6356c5e1518ed480ce2::coffee_shop_registry::get_shop_owner(arg2);
        assert!(0x2::tx_context::sender(arg6) == arg0.customer, 2);
        assert!(arg0.shop == v1, 2);
        assert!(arg1.zklogin_address == arg0.customer, 2);
        if (arg0.last_purchase_timestamp > 0) {
            assert!(v0 >= arg0.last_purchase_timestamp + 300000, 4);
        };
        let v2 = arg3.points_per_purchase;
        let v3 = v2 * 0x16b10cb26c38ccc41a5ce0ed1e20c365df2ef3fa696eb6356c5e1518ed480ce2::coffee_shop_registry::get_shop_multiplier(arg2) / 100;
        let v4 = 0;
        while (v4 < arg4) {
            arg0.points = arg0.points + v3;
            arg0.purchases = arg0.purchases + 1;
            arg1.total_xp = arg1.total_xp + v2;
            arg1.total_purchases = arg1.total_purchases + 1;
            let v5 = calculate_level(arg1.total_xp);
            if (v5 > arg1.level) {
                arg1.level = v5;
                let v6 = 0x2::object::new(arg6);
                let v7 = RewardNFT{
                    id            : v6,
                    customer      : arg0.customer,
                    shop          : v1,
                    level_reached : v5,
                    timestamp     : v0,
                };
                let v8 = LevelUpEvent{
                    customer  : arg0.customer,
                    shop      : v1,
                    new_level : v5,
                    nft_id    : 0x2::object::uid_to_address(&v6),
                    timestamp : v0,
                };
                0x2::event::emit<LevelUpEvent>(v8);
                0x2::transfer::transfer<RewardNFT>(v7, arg0.customer);
            };
            v4 = v4 + 1;
        };
        arg0.last_purchase_timestamp = v0;
        arg3.total_purchases = arg3.total_purchases + arg4;
        let v9 = 0;
        while (v9 < arg4) {
            0x16b10cb26c38ccc41a5ce0ed1e20c365df2ef3fa696eb6356c5e1518ed480ce2::coffee_shop_registry::increment_shop_purchases(arg2);
            v9 = v9 + 1;
        };
        let v10 = v3 * arg4;
        let v11 = Purchase{
            id            : 0x2::object::new(arg6),
            customer      : arg0.customer,
            coffee_shop   : v1,
            points_earned : v10,
            timestamp     : v0,
        };
        let v12 = PurchaseRecorded{
            customer             : arg0.customer,
            shop                 : v1,
            points_earned        : v10,
            total_points_at_shop : arg0.points,
            timestamp            : v0,
        };
        0x2::event::emit<PurchaseRecorded>(v12);
        0x2::transfer::transfer<Purchase>(v11, arg0.customer);
    }

    public entry fun record_purchase(arg0: &mut CustomerShopAccount, arg1: &mut CustomerProfile, arg2: &mut 0x16b10cb26c38ccc41a5ce0ed1e20c365df2ef3fa696eb6356c5e1518ed480ce2::coffee_shop_registry::CoffeeShop, arg3: &mut LoyaltyProgram, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg4);
        0x16b10cb26c38ccc41a5ce0ed1e20c365df2ef3fa696eb6356c5e1518ed480ce2::coffee_shop_registry::verify_shop_ready(arg2);
        let v1 = 0x16b10cb26c38ccc41a5ce0ed1e20c365df2ef3fa696eb6356c5e1518ed480ce2::coffee_shop_registry::get_shop_owner(arg2);
        assert!(0x2::tx_context::sender(arg5) == arg0.customer, 2);
        assert!(arg0.shop == v1, 2);
        assert!(arg1.zklogin_address == arg0.customer, 2);
        if (arg0.last_purchase_timestamp > 0) {
            assert!(v0 >= arg0.last_purchase_timestamp + 300000, 4);
        };
        let v2 = arg3.points_per_purchase;
        let v3 = v2 * 0x16b10cb26c38ccc41a5ce0ed1e20c365df2ef3fa696eb6356c5e1518ed480ce2::coffee_shop_registry::get_shop_multiplier(arg2) / 100;
        arg0.points = arg0.points + v3;
        arg0.purchases = arg0.purchases + 1;
        arg0.last_purchase_timestamp = v0;
        arg1.total_xp = arg1.total_xp + v2;
        arg1.total_purchases = arg1.total_purchases + 1;
        arg3.total_purchases = arg3.total_purchases + 1;
        0x16b10cb26c38ccc41a5ce0ed1e20c365df2ef3fa696eb6356c5e1518ed480ce2::coffee_shop_registry::increment_shop_purchases(arg2);
        let v4 = Purchase{
            id            : 0x2::object::new(arg5),
            customer      : arg0.customer,
            coffee_shop   : v1,
            points_earned : v3,
            timestamp     : v0,
        };
        let v5 = PurchaseRecorded{
            customer             : arg0.customer,
            shop                 : v1,
            points_earned        : v3,
            total_points_at_shop : arg0.points,
            timestamp            : v0,
        };
        0x2::event::emit<PurchaseRecorded>(v5);
        0x2::transfer::transfer<Purchase>(v4, arg0.customer);
        let v6 = calculate_level(arg1.total_xp);
        if (v6 > arg1.level) {
            arg1.level = v6;
            let v7 = 0x2::object::new(arg5);
            let v8 = RewardNFT{
                id            : v7,
                customer      : arg0.customer,
                shop          : v1,
                level_reached : v6,
                timestamp     : v0,
            };
            let v9 = LevelUpEvent{
                customer  : arg0.customer,
                shop      : v1,
                new_level : v6,
                nft_id    : 0x2::object::uid_to_address(&v7),
                timestamp : v0,
            };
            0x2::event::emit<LevelUpEvent>(v9);
            0x2::transfer::transfer<RewardNFT>(v8, arg0.customer);
        };
    }

    public entry fun redeem_reward(arg0: &mut CustomerShopAccount, arg1: &0x16b10cb26c38ccc41a5ce0ed1e20c365df2ef3fa696eb6356c5e1518ed480ce2::coffee_shop_registry::CoffeeShop, arg2: &LoyaltyProgram, arg3: u64, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg6) == arg0.customer, 2);
        assert!(arg0.shop == 0x16b10cb26c38ccc41a5ce0ed1e20c365df2ef3fa696eb6356c5e1518ed480ce2::coffee_shop_registry::get_shop_owner(arg1), 2);
        assert!(0x16b10cb26c38ccc41a5ce0ed1e20c365df2ef3fa696eb6356c5e1518ed480ce2::coffee_shop_registry::is_valid_reward(arg1, arg3, 0x1::string::utf8(arg4)), 11);
        assert!(arg0.points >= arg3, 0);
        assert!(arg3 > 0, 1);
        arg0.points = arg0.points - arg3;
        let v0 = RewardRedeemed{
            customer         : arg0.customer,
            points_spent     : arg3,
            remaining_points : arg0.points,
            timestamp        : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<RewardRedeemed>(v0);
        0x16b10cb26c38ccc41a5ce0ed1e20c365df2ef3fa696eb6356c5e1518ed480ce2::voucher_system::mint_voucher(arg0.customer, arg0.shop, arg4, arg3, arg5, arg6);
    }

    public entry fun redeem_reward_nft(arg0: RewardNFT, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let RewardNFT {
            id            : v0,
            customer      : v1,
            shop          : v2,
            level_reached : _,
            timestamp     : _,
        } = arg0;
        0x2::object::delete(v0);
        0x16b10cb26c38ccc41a5ce0ed1e20c365df2ef3fa696eb6356c5e1518ed480ce2::voucher_system::mint_voucher_internal(v1, v2, b"free_coffee", 0, arg1, arg2);
    }

    public entry fun register_customer(arg0: &mut LoyaltyProgram, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        let v2 = if (0x1::vector::length<u8>(&arg1) > 0) {
            0x1::option::some<address>(@0x0)
        } else {
            0x1::option::none<address>()
        };
        let v3 = CustomerProfile{
            id              : 0x2::object::new(arg3),
            zklogin_address : v0,
            referral_code   : generate_referral_code(v0),
            referred_by     : v2,
            total_xp        : 0,
            level           : 1,
            total_purchases : 0,
            created_at      : v1,
        };
        arg0.total_customers = arg0.total_customers + 1;
        let v4 = CustomerRegistered{
            customer_address : v0,
            referral_code    : v3.referral_code,
            referred_by      : v3.referred_by,
            timestamp        : v1,
        };
        0x2::event::emit<CustomerRegistered>(v4);
        0x2::transfer::transfer<CustomerProfile>(v3, v0);
    }

    public entry fun request_stamp(arg0: &CustomerShopAccount, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::clock::timestamp_ms(arg1);
        assert!(v0 == arg0.customer, 2);
        if (arg0.last_purchase_timestamp > 0) {
            assert!(v1 >= arg0.last_purchase_timestamp + 300000, 4);
        };
        let v2 = PurchaseRequestEvent{
            customer  : v0,
            shop      : arg0.shop,
            timestamp : v1,
        };
        0x2::event::emit<PurchaseRequestEvent>(v2);
    }

    public entry fun update_points_for_free_coffee(arg0: &mut LoyaltyProgram, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 2);
        arg0.points_for_free_coffee = arg1;
    }

    public entry fun update_points_per_purchase(arg0: &mut LoyaltyProgram, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 2);
        arg0.points_per_purchase = arg1;
    }

    // decompiled from Move bytecode v6
}

