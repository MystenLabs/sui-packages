module 0x231a2983731507b3e74677607e1e4f0483290a8363f1975103a15bf8dac7d5c8::oksol {
    struct BuyEvent has copy, drop {
        buyer: address,
        sui_in_mist: u64,
        token_out_raw: u64,
    }

    struct SellEvent has copy, drop {
        seller: address,
        token_in_raw: u64,
        sui_out_mist: u64,
    }

    struct AdminWithdrawEvent has copy, drop {
        admin: address,
        amount_mist: u64,
    }

    struct OKSOL has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Vault has store, key {
        id: 0x2::object::UID,
        admin_addr: address,
        oksol_cap: 0x2::coin::TreasuryCap<OKSOL>,
        oksol_inventory: 0x2::coin::Coin<OKSOL>,
        sui_pool: 0x2::coin::Coin<0x2::sui::SUI>,
        paused: bool,
        rate_num: u64,
        rate_den: u64,
        min_reserve_mist: u64,
        max_pool_mist: u64,
    }

    public entry fun buy(arg0: &mut Vault, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 1);
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        0x2::coin::join<0x2::sui::SUI>(&mut arg0.sui_pool, arg1);
        sweep_above_max(arg0, arg2);
        let v2 = (((v1 as u128) * (arg0.rate_num as u128) / (arg0.rate_den as u128)) as u64);
        assert!(0x2::coin::value<OKSOL>(&arg0.oksol_inventory) >= v2, 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<OKSOL>>(0x2::coin::split<OKSOL>(&mut arg0.oksol_inventory, v2, arg2), v0);
        let v3 = BuyEvent{
            buyer         : v0,
            sui_in_mist   : v1,
            token_out_raw : v2,
        };
        0x2::event::emit<BuyEvent>(v3);
    }

    public entry fun deposit_sui(arg0: &AdminCap, arg1: &mut Vault, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::join<0x2::sui::SUI>(&mut arg1.sui_pool, arg2);
        sweep_above_max(arg1, arg3);
    }

    public fun get_admin(arg0: &Vault) : address {
        arg0.admin_addr
    }

    public fun get_inventory(arg0: &Vault) : u64 {
        0x2::coin::value<OKSOL>(&arg0.oksol_inventory)
    }

    public fun get_max_pool_mist(arg0: &Vault) : u64 {
        arg0.max_pool_mist
    }

    public fun get_min_reserve_mist(arg0: &Vault) : u64 {
        arg0.min_reserve_mist
    }

    public fun get_pool_sui(arg0: &Vault) : u64 {
        0x2::coin::value<0x2::sui::SUI>(&arg0.sui_pool)
    }

    public fun get_rate(arg0: &Vault) : (u64, u64) {
        (arg0.rate_num, arg0.rate_den)
    }

    fun init(arg0: OKSOL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<OKSOL>(arg0, 9, b"OKSOL", b"OKSOL", b"OKSOL OTC Token (fixed supply v2.2)", 0x1::option::none<0x2::url::Url>(), arg1);
        let v3 = v1;
        let v4 = AdminCap{id: 0x2::object::new(arg1)};
        let v5 = Vault{
            id               : 0x2::object::new(arg1),
            admin_addr       : v0,
            oksol_cap        : v3,
            oksol_inventory  : 0x2::coin::mint<OKSOL>(&mut v3, 3650000000000000000, arg1),
            sui_pool         : 0x2::coin::zero<0x2::sui::SUI>(arg1),
            paused           : false,
            rate_num         : 365,
            rate_den         : 100,
            min_reserve_mist : 100000000,
            max_pool_mist    : 100000000000,
        };
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<OKSOL>>(v2, v0);
        0x2::transfer::public_transfer<AdminCap>(v4, v0);
        0x2::transfer::share_object<Vault>(v5);
    }

    public entry fun sell(arg0: &mut Vault, arg1: 0x2::coin::Coin<OKSOL>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 1);
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::coin::value<OKSOL>(&arg1);
        let v2 = (((v1 as u128) * (arg0.rate_den as u128) / (arg0.rate_num as u128)) as u64);
        let v3 = 0x2::coin::value<0x2::sui::SUI>(&arg0.sui_pool);
        assert!(v3 >= v2, 4);
        assert!((v3 as u128) - (v2 as u128) >= (arg0.min_reserve_mist as u128), 5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg0.sui_pool, v2, arg2), v0);
        let v4 = SellEvent{
            seller       : v0,
            token_in_raw : v1,
            sui_out_mist : v2,
        };
        0x2::event::emit<SellEvent>(v4);
        0x2::coin::join<OKSOL>(&mut arg0.oksol_inventory, arg1);
    }

    public entry fun set_max_pool_mist(arg0: &AdminCap, arg1: &mut Vault, arg2: u64) {
        arg1.max_pool_mist = arg2;
    }

    public entry fun set_min_reserve_mist(arg0: &AdminCap, arg1: &mut Vault, arg2: u64) {
        arg1.min_reserve_mist = arg2;
    }

    public entry fun set_paused(arg0: &AdminCap, arg1: &mut Vault, arg2: bool) {
        arg1.paused = arg2;
    }

    public entry fun set_rate(arg0: &AdminCap, arg1: &mut Vault, arg2: u64, arg3: u64) {
        assert!(arg2 > 0 && arg3 > 0, 2);
        arg1.rate_num = arg2;
        arg1.rate_den = arg3;
    }

    fun sweep_above_max(arg0: &mut Vault, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0.sui_pool);
        if (v0 > arg0.max_pool_mist) {
            let v1 = v0 - arg0.max_pool_mist;
            let v2 = AdminWithdrawEvent{
                admin       : arg0.admin_addr,
                amount_mist : v1,
            };
            0x2::event::emit<AdminWithdrawEvent>(v2);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg0.sui_pool, v1, arg1), arg0.admin_addr);
        };
    }

    public entry fun withdraw_excess_sui(arg0: &AdminCap, arg1: &mut Vault, arg2: &mut 0x2::tx_context::TxContext) {
        sweep_above_max(arg1, arg2);
    }

    public entry fun withdraw_sui_unsafe(arg0: &AdminCap, arg1: &mut Vault, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1.sui_pool) >= arg2, 4);
        let v0 = AdminWithdrawEvent{
            admin       : arg1.admin_addr,
            amount_mist : arg2,
        };
        0x2::event::emit<AdminWithdrawEvent>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1.sui_pool, arg2, arg3), arg1.admin_addr);
    }

    // decompiled from Move bytecode v7
}

