module 0x16b10cb26c38ccc41a5ce0ed1e20c365df2ef3fa696eb6356c5e1518ed480ce2::coffee_shop_registry {
    struct RewardTier has copy, drop, store {
        points_cost: u64,
        reward_type: 0x1::string::String,
    }

    struct CoffeeShop has key {
        id: 0x2::object::UID,
        owner: address,
        name: 0x1::string::String,
        description: 0x1::string::String,
        location: 0x1::string::String,
        image_url: 0x1::string::String,
        verified: bool,
        active: bool,
        total_purchases: u64,
        points_multiplier: u64,
        reward_tiers: vector<RewardTier>,
        registered_at: u64,
    }

    struct ShopRegistry has key {
        id: 0x2::object::UID,
        admin: address,
        total_shops: u64,
        verification_required: bool,
    }

    struct ShopCapability has store, key {
        id: 0x2::object::UID,
        shop_id: 0x2::object::ID,
        shop_name: 0x1::string::String,
    }

    struct ShopRegistered has copy, drop {
        shop_id: 0x2::object::ID,
        owner: address,
        name: 0x1::string::String,
        location: 0x1::string::String,
        timestamp: u64,
    }

    struct ShopVerified has copy, drop {
        shop_id: 0x2::object::ID,
        name: 0x1::string::String,
        timestamp: u64,
    }

    struct ShopProfileUpdated has copy, drop {
        shop_id: 0x2::object::ID,
        name: 0x1::string::String,
        timestamp: u64,
    }

    struct ShopStatusChanged has copy, drop {
        shop_id: 0x2::object::ID,
        active: bool,
        timestamp: u64,
    }

    public fun get_shop_info(arg0: &CoffeeShop) : (0x1::string::String, 0x1::string::String, 0x1::string::String, 0x1::string::String, bool, bool, u64) {
        (arg0.name, arg0.description, arg0.location, arg0.image_url, arg0.verified, arg0.active, arg0.total_purchases)
    }

    public fun get_shop_multiplier(arg0: &CoffeeShop) : u64 {
        arg0.points_multiplier
    }

    public fun get_shop_name(arg0: &CoffeeShop) : 0x1::string::String {
        arg0.name
    }

    public fun get_shop_owner(arg0: &CoffeeShop) : address {
        arg0.owner
    }

    public(friend) fun increment_shop_purchases(arg0: &mut CoffeeShop) {
        arg0.total_purchases = arg0.total_purchases + 1;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ShopRegistry{
            id                    : 0x2::object::new(arg0),
            admin                 : 0x2::tx_context::sender(arg0),
            total_shops           : 0,
            verification_required : false,
        };
        0x2::transfer::share_object<ShopRegistry>(v0);
    }

    public fun is_shop_active(arg0: &CoffeeShop) : bool {
        arg0.active
    }

    public fun is_shop_verified(arg0: &CoffeeShop) : bool {
        arg0.verified
    }

    public fun is_valid_reward(arg0: &CoffeeShop, arg1: u64, arg2: 0x1::string::String) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<RewardTier>(&arg0.reward_tiers)) {
            let v1 = 0x1::vector::borrow<RewardTier>(&arg0.reward_tiers, v0);
            if (v1.points_cost == arg1 && v1.reward_type == arg2) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public(friend) fun migration_mint_shop(arg0: &mut ShopRegistry, arg1: address, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: bool, arg7: bool, arg8: u64, arg9: u64, arg10: vector<u64>, arg11: vector<vector<u8>>, arg12: u64, arg13: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u64>(&arg10) == 0x1::vector::length<vector<u8>>(&arg11), 5);
        let v0 = 0x1::string::utf8(arg2);
        let v1 = 0x1::vector::empty<RewardTier>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<u64>(&arg10)) {
            let v3 = RewardTier{
                points_cost : *0x1::vector::borrow<u64>(&arg10, v2),
                reward_type : 0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(&arg11, v2)),
            };
            0x1::vector::push_back<RewardTier>(&mut v1, v3);
            v2 = v2 + 1;
        };
        let v4 = CoffeeShop{
            id                : 0x2::object::new(arg13),
            owner             : arg1,
            name              : v0,
            description       : 0x1::string::utf8(arg3),
            location          : 0x1::string::utf8(arg4),
            image_url         : 0x1::string::utf8(arg5),
            verified          : arg6,
            active            : arg7,
            total_purchases   : arg8,
            points_multiplier : arg9,
            reward_tiers      : v1,
            registered_at     : arg12,
        };
        let v5 = 0x2::object::id<CoffeeShop>(&v4);
        let v6 = ShopCapability{
            id        : 0x2::object::new(arg13),
            shop_id   : v5,
            shop_name : v0,
        };
        arg0.total_shops = arg0.total_shops + 1;
        let v7 = ShopRegistered{
            shop_id   : v5,
            owner     : arg1,
            name      : v0,
            location  : 0x1::string::utf8(arg4),
            timestamp : arg12,
        };
        0x2::event::emit<ShopRegistered>(v7);
        0x2::transfer::share_object<CoffeeShop>(v4);
        0x2::transfer::transfer<ShopCapability>(v6, arg1);
    }

    public entry fun register_shop(arg0: &mut ShopRegistry, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::clock::timestamp_ms(arg5);
        let v2 = 0x1::string::utf8(arg1);
        let v3 = 0x1::vector::empty<RewardTier>();
        let v4 = RewardTier{
            points_cost : 100,
            reward_type : 0x1::string::utf8(b"free_coffee"),
        };
        0x1::vector::push_back<RewardTier>(&mut v3, v4);
        let v5 = CoffeeShop{
            id                : 0x2::object::new(arg6),
            owner             : v0,
            name              : v2,
            description       : 0x1::string::utf8(arg2),
            location          : 0x1::string::utf8(arg3),
            image_url         : 0x1::string::utf8(arg4),
            verified          : !arg0.verification_required,
            active            : true,
            total_purchases   : 0,
            points_multiplier : 100,
            reward_tiers      : v3,
            registered_at     : v1,
        };
        let v6 = 0x2::object::id<CoffeeShop>(&v5);
        let v7 = ShopCapability{
            id        : 0x2::object::new(arg6),
            shop_id   : v6,
            shop_name : v2,
        };
        arg0.total_shops = arg0.total_shops + 1;
        let v8 = ShopRegistered{
            shop_id   : v6,
            owner     : v0,
            name      : v2,
            location  : 0x1::string::utf8(arg3),
            timestamp : v1,
        };
        0x2::event::emit<ShopRegistered>(v8);
        0x2::transfer::share_object<CoffeeShop>(v5);
        0x2::transfer::transfer<ShopCapability>(v7, v0);
    }

    public fun reward_tier_count(arg0: &CoffeeShop) : u64 {
        0x1::vector::length<RewardTier>(&arg0.reward_tiers)
    }

    public entry fun set_points_multiplier(arg0: &mut CoffeeShop, arg1: &ShopRegistry, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg1.admin, 0);
        arg0.points_multiplier = arg2;
    }

    public entry fun set_reward_tiers(arg0: &mut CoffeeShop, arg1: &ShopCapability, arg2: vector<u64>, arg3: vector<vector<u8>>, arg4: &0x2::tx_context::TxContext) {
        assert!(arg1.shop_id == 0x2::object::id<CoffeeShop>(arg0), 4);
        assert!(0x2::tx_context::sender(arg4) == arg0.owner, 3);
        let v0 = 0x1::vector::length<u64>(&arg2);
        assert!(v0 == 0x1::vector::length<vector<u8>>(&arg3), 5);
        let v1 = 0x1::vector::empty<RewardTier>();
        let v2 = 0;
        while (v2 < v0) {
            let v3 = RewardTier{
                points_cost : *0x1::vector::borrow<u64>(&arg2, v2),
                reward_type : 0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(&arg3, v2)),
            };
            0x1::vector::push_back<RewardTier>(&mut v1, v3);
            v2 = v2 + 1;
        };
        arg0.reward_tiers = v1;
    }

    public entry fun set_shop_active(arg0: &mut CoffeeShop, arg1: &ShopCapability, arg2: bool, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(arg1.shop_id == 0x2::object::id<CoffeeShop>(arg0), 4);
        assert!(0x2::tx_context::sender(arg4) == arg0.owner, 3);
        arg0.active = arg2;
        let v0 = ShopStatusChanged{
            shop_id   : 0x2::object::id<CoffeeShop>(arg0),
            active    : arg2,
            timestamp : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<ShopStatusChanged>(v0);
    }

    public entry fun update_shop_profile(arg0: &mut CoffeeShop, arg1: &ShopCapability, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        assert!(arg1.shop_id == 0x2::object::id<CoffeeShop>(arg0), 4);
        assert!(0x2::tx_context::sender(arg7) == arg0.owner, 3);
        arg0.name = 0x1::string::utf8(arg2);
        arg0.description = 0x1::string::utf8(arg3);
        arg0.location = 0x1::string::utf8(arg4);
        arg0.image_url = 0x1::string::utf8(arg5);
        let v0 = ShopProfileUpdated{
            shop_id   : 0x2::object::id<CoffeeShop>(arg0),
            name      : arg0.name,
            timestamp : 0x2::clock::timestamp_ms(arg6),
        };
        0x2::event::emit<ShopProfileUpdated>(v0);
    }

    public entry fun verify_shop(arg0: &mut CoffeeShop, arg1: &ShopRegistry, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg1.admin, 0);
        arg0.verified = true;
        let v0 = ShopVerified{
            shop_id   : 0x2::object::id<CoffeeShop>(arg0),
            name      : arg0.name,
            timestamp : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<ShopVerified>(v0);
    }

    public fun verify_shop_ready(arg0: &CoffeeShop) {
        assert!(arg0.verified, 1);
        assert!(arg0.active, 2);
    }

    // decompiled from Move bytecode v6
}

