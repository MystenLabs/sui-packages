module 0xbd2b9b587e174bdd38451a67c9231df514a71b47ee1e4e02f21b7b24d2866018::sale {
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
        total_reward_claimed: u64,
        reward_per_address: 0x2::table::Table<address, u64>,
    }

    struct SaleConfigLand<phantom T0> has store, key {
        id: 0x2::object::UID,
        sale_infos: 0x2::table::Table<u64, SaleInfoLand>,
        owner: address,
    }

    struct SaleInfoLand has store {
        sale_id: u64,
        sale_type: u8,
        price: u64,
        is_enabled: bool,
    }

    struct SaleConfigMiner<phantom T0> has store, key {
        id: 0x2::object::UID,
        sale_infos: 0x2::table::Table<u64, SaleInfoMiner>,
        owner: address,
    }

    struct SaleInfoMiner has store {
        sale_id: u64,
        sale_type: u8,
        price: u64,
        is_enabled: bool,
    }

    struct BuyEvent has copy, drop {
        buyer: address,
        amount: u64,
        sale_id: u64,
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

    public entry fun add_sale_land_config<T0>(arg0: &AdminCapability, arg1: &mut SaleConfigLand<T0>, arg2: u64, arg3: u8, arg4: u64, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) {
        0x2::tx_context::sender(arg6);
        assert!(arg4 > 0, 2);
        let v0 = SaleInfoLand{
            sale_id    : arg2,
            sale_type  : arg3,
            price      : arg4,
            is_enabled : arg5,
        };
        0x2::table::add<u64, SaleInfoLand>(&mut arg1.sale_infos, arg2, v0);
    }

    public entry fun add_sale_miner_config<T0>(arg0: &AdminCapability, arg1: &mut SaleConfigMiner<T0>, arg2: u64, arg3: u8, arg4: u64, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) {
        0x2::tx_context::sender(arg6);
        assert!(arg4 > 0, 2);
        let v0 = SaleInfoMiner{
            sale_id    : arg2,
            sale_type  : arg3,
            price      : arg4,
            is_enabled : arg5,
        };
        0x2::table::add<u64, SaleInfoMiner>(&mut arg1.sale_infos, arg2, v0);
    }

    public entry fun adjust_sale_land_config<T0>(arg0: &AdminCapability, arg1: &mut SaleConfigLand<T0>, arg2: u64, arg3: u64, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) {
        0x2::tx_context::sender(arg5);
        assert!(arg3 > 0, 2);
        let v0 = 0x2::table::borrow_mut<u64, SaleInfoLand>(&mut arg1.sale_infos, arg2);
        v0.price = arg3;
        v0.is_enabled = arg4;
    }

    public entry fun adjust_sale_miner_config<T0>(arg0: &AdminCapability, arg1: &mut SaleConfigMiner<T0>, arg2: u64, arg3: u8, arg4: u64, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) {
        0x2::tx_context::sender(arg6);
        assert!(arg4 > 0, 2);
        let v0 = 0x2::table::borrow_mut<u64, SaleInfoMiner>(&mut arg1.sale_infos, arg2);
        v0.price = arg4;
        v0.is_enabled = arg5;
    }

    public entry fun buy_land<T0>(arg0: &SaleConfigLand<T0>, arg1: u64, arg2: u64, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::table::borrow<u64, SaleInfoLand>(&arg0.sale_infos, arg1);
        assert!(v0.is_enabled, 3);
        let v1 = 0x2::tx_context::sender(arg4);
        let v2 = v0.price * arg2;
        let v3 = 0x2::coin::into_balance<T0>(arg3);
        assert!(0x2::balance::value<T0>(&v3) >= v2, 5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v3, v2), arg4), arg0.owner);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v3, arg4), v1);
        let v4 = BuyEvent{
            buyer     : v1,
            amount    : arg2,
            sale_id   : v0.sale_id,
            sale_type : v0.sale_type,
        };
        0x2::event::emit<BuyEvent>(v4);
    }

    public entry fun buy_miner<T0>(arg0: &SaleConfigMiner<T0>, arg1: &mut GlobalConfig<T0>, arg2: u64, arg3: u64, arg4: 0x2::coin::Coin<T0>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::table::borrow<u64, SaleInfoMiner>(&arg0.sale_infos, arg2);
        assert!(v0.is_enabled, 3);
        let v1 = 0x2::tx_context::sender(arg5);
        let v2 = v0.price * arg3;
        let v3 = 0x2::coin::into_balance<T0>(arg4);
        assert!(0x2::balance::value<T0>(&v3) >= v2, 5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v3, v2 / 2), arg5), arg0.owner);
        0x2::coin::burn<T0>(&mut arg1.treasury_cap, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v3, v2 / 2), arg5));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v3, arg5), v1);
        let v4 = BuyEvent{
            buyer     : v1,
            amount    : arg3,
            sale_id   : v0.sale_id,
            sale_type : v0.sale_type,
        };
        0x2::event::emit<BuyEvent>(v4);
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
            total_reward_claimed : 0,
            reward_per_address   : 0x2::table::new<address, u64>(arg2),
        };
        0x2::transfer::share_object<RewardPool<T0>>(v0);
    }

    public entry fun initialize_sale_land_config<T0>(arg0: &AdminCapability, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = SaleConfigLand<T0>{
            id         : 0x2::object::new(arg1),
            sale_infos : 0x2::table::new<u64, SaleInfoLand>(arg1),
            owner      : 0x2::tx_context::sender(arg1),
        };
        0x2::transfer::share_object<SaleConfigLand<T0>>(v0);
    }

    public entry fun initialize_sale_miner_config<T0>(arg0: &AdminCapability, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = SaleConfigMiner<T0>{
            id         : 0x2::object::new(arg1),
            sale_infos : 0x2::table::new<u64, SaleInfoMiner>(arg1),
            owner      : 0x2::tx_context::sender(arg1),
        };
        0x2::transfer::share_object<SaleConfigMiner<T0>>(v0);
    }

    public entry fun redeem_global_config<T0>(arg0: &AdminCapability, arg1: GlobalConfig<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let GlobalConfig {
            id           : v0,
            treasury_cap : v1,
        } = arg1;
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T0>>(v1, 0x2::tx_context::sender(arg2));
        0x2::object::delete(v0);
    }

    public entry fun redeem_reward<T0>(arg0: &mut RewardPool<T0>, arg1: &mut GlobalConfig<T0>, arg2: u64, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(0x2::bls12381::bls12381_min_pk_verify(&arg4, &arg0.admin_public_key, &arg3) == true, 4);
        let v1 = 0x1::u64::to_string(arg2);
        0x1::string::append(&mut v1, 0x2::address::to_string(v0));
        assert!(0x1::string::utf8(arg3) == v1, 6);
        if (0x2::table::contains<address, u64>(&arg0.reward_per_address, v0)) {
            let v2 = 0x2::table::borrow_mut<address, u64>(&mut arg0.reward_per_address, v0);
            assert!(*v2 < arg2, 7);
            let v3 = arg2 - *v2;
            *v2 = arg2;
            0x2::coin::mint_and_transfer<T0>(&mut arg1.treasury_cap, v3, v0, arg5);
            arg0.total_reward_claimed = arg0.total_reward_claimed + v3;
            let v4 = ClaimEvent{
                claimer      : v0,
                amount       : v3,
                total_amount : arg2,
            };
            0x2::event::emit<ClaimEvent>(v4);
        } else {
            0x2::coin::mint_and_transfer<T0>(&mut arg1.treasury_cap, arg2, v0, arg5);
            0x2::table::add<address, u64>(&mut arg0.reward_per_address, v0, arg2);
            arg0.total_reward_claimed = arg0.total_reward_claimed + arg2;
            let v5 = ClaimEvent{
                claimer      : v0,
                amount       : arg2,
                total_amount : arg2,
            };
            0x2::event::emit<ClaimEvent>(v5);
        };
    }

    // decompiled from Move bytecode v6
}

