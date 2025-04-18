module 0x6442744050c8d69f7fded77cab7796072ef87153cf3993c2d698de43a123729c::sale {
    struct AdminCapability has store, key {
        id: 0x2::object::UID,
    }

    struct GlobalConfig<phantom T0> has store, key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<T0>,
    }

    struct RewardPool<phantom T0> has store, key {
        id: 0x2::object::UID,
        owner: address,
        admin_public_key: vector<u8>,
        reward_pool: 0x2::balance::Balance<T0>,
        total_reward_claimed: u64,
        reward_per_address: 0x2::table::Table<address, u64>,
    }

    struct SaleConfig<phantom T0> has store, key {
        id: 0x2::object::UID,
        sale_type: u8,
        owner: address,
        price: u64,
        is_enabled: bool,
        is_burn_half: bool,
    }

    struct BuyEvent has copy, drop {
        buyer: address,
        amount: u64,
        sale_type: u8,
    }

    struct ClaimEvent has copy, drop {
        claimer: address,
        amount: u64,
        total_amount: u64,
    }

    struct SALE has drop {
        dummy_field: bool,
    }

    public entry fun adjust_sale_config<T0>(arg0: &mut SaleConfig<T0>, arg1: u64, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 1);
        assert!(arg1 > 0, 2);
        arg0.price = arg1;
        arg0.is_enabled = arg2;
    }

    public entry fun buy<T0>(arg0: &SaleConfig<T0>, arg1: &mut GlobalConfig<T0>, arg2: u64, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.is_enabled, 3);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = arg0.price * arg2;
        let v2 = 0x2::coin::into_balance<T0>(arg3);
        assert!(0x2::balance::value<T0>(&v2) >= v1, 5);
        if (!arg0.is_burn_half) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v2, v1), arg4), arg0.owner);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v2, v1 / 2), arg4), arg0.owner);
            0x2::coin::burn<T0>(&mut arg1.treasury_cap, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v2, v1 / 2), arg4));
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v2, arg4), v0);
        let v3 = BuyEvent{
            buyer     : v0,
            amount    : arg2,
            sale_type : arg0.sale_type,
        };
        0x2::event::emit<BuyEvent>(v3);
    }

    public entry fun deposit_reward<T0>(arg0: &mut RewardPool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<T0>(&mut arg0.reward_pool, 0x2::coin::into_balance<T0>(arg1));
    }

    fun init(arg0: SALE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCapability{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCapability>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun initialize_global_config<T0>(arg0: &AdminCapability, arg1: 0x2::coin::TreasuryCap<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = GlobalConfig<T0>{
            id           : 0x2::object::new(arg2),
            treasury_cap : arg1,
        };
        0x2::transfer::share_object<GlobalConfig<T0>>(v0);
    }

    public entry fun initialize_reward_pool<T0>(arg0: &AdminCapability, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = RewardPool<T0>{
            id                   : 0x2::object::new(arg2),
            owner                : 0x2::tx_context::sender(arg2),
            admin_public_key     : arg1,
            reward_pool          : 0x2::balance::zero<T0>(),
            total_reward_claimed : 0,
            reward_per_address   : 0x2::table::new<address, u64>(arg2),
        };
        0x2::transfer::share_object<RewardPool<T0>>(v0);
    }

    public entry fun initialize_sale_config<T0>(arg0: &AdminCapability, arg1: u8, arg2: u64, arg3: bool, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 2);
        let v0 = SaleConfig<T0>{
            id           : 0x2::object::new(arg5),
            sale_type    : arg1,
            owner        : 0x2::tx_context::sender(arg5),
            price        : arg2,
            is_enabled   : arg3,
            is_burn_half : arg4,
        };
        0x2::transfer::share_object<SaleConfig<T0>>(v0);
    }

    public entry fun redeem_global_config<T0>(arg0: &AdminCapability, arg1: GlobalConfig<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let GlobalConfig {
            id           : v0,
            treasury_cap : v1,
        } = arg1;
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T0>>(v1, 0x2::tx_context::sender(arg2));
        0x2::object::delete(v0);
    }

    public entry fun redeem_reward<T0>(arg0: &mut RewardPool<T0>, arg1: u64, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x2::bls12381::bls12381_min_pk_verify(&arg3, &arg0.admin_public_key, &arg2) == true, 4);
        let v1 = 0x1::u64::to_string(arg1);
        0x1::string::append(&mut v1, 0x2::address::to_string(v0));
        assert!(0x1::string::utf8(arg2) == v1, 6);
        if (0x2::table::contains<address, u64>(&arg0.reward_per_address, v0)) {
            let v2 = 0x2::table::borrow_mut<address, u64>(&mut arg0.reward_per_address, v0);
            assert!(*v2 < arg1, 7);
            let v3 = arg1 - *v2;
            *v2 = arg1;
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.reward_pool, v3), arg4), v0);
            arg0.total_reward_claimed = arg0.total_reward_claimed + v3;
            let v4 = ClaimEvent{
                claimer      : v0,
                amount       : v3,
                total_amount : arg1,
            };
            0x2::event::emit<ClaimEvent>(v4);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.reward_pool, arg1), arg4), v0);
            0x2::table::add<address, u64>(&mut arg0.reward_per_address, v0, arg1);
            arg0.total_reward_claimed = arg0.total_reward_claimed + arg1;
            let v5 = ClaimEvent{
                claimer      : v0,
                amount       : arg1,
                total_amount : arg1,
            };
            0x2::event::emit<ClaimEvent>(v5);
        };
    }

    public entry fun withdraw_reward<T0>(arg0: &AdminCapability, arg1: &mut RewardPool<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.reward_pool, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

