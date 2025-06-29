module 0x4a8f619840119cd81a12bbfa9d2060cf9c2d781d7759cff86001474d76f84651::presale {
    struct PresaleConfig has key {
        id: 0x2::object::UID,
        admin: address,
        is_active: bool,
        total_tokens_for_sale: u64,
        tokens_sold: u64,
        sui_collected: 0x2::balance::Balance<0x2::sui::SUI>,
        gfs_treasury: 0x2::balance::Balance<0x4a8f619840119cd81a12bbfa9d2060cf9c2d781d7759cff86001474d76f84651::gfs_governance::GFS_GOVERNANCE>,
        start_time: u64,
        end_time: u64,
    }

    struct PresaleCap has key {
        id: 0x2::object::UID,
    }

    struct TokensPurchased has copy, drop {
        buyer: address,
        sui_amount: u64,
        gfs_amount: u64,
        timestamp: u64,
    }

    struct PresaleInitialized has copy, drop {
        admin: address,
        total_tokens: u64,
        start_time: u64,
        end_time: u64,
    }

    public entry fun buy_tokens(arg0: &mut PresaleConfig, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(arg0.is_active, 1);
        assert!(v0 >= arg0.start_time, 1);
        assert!(v0 <= arg0.end_time, 5);
        assert!(v2 >= 200000000, 2);
        assert!(v2 <= 100000000000, 2);
        let v3 = calculate_gfs_amount(v2);
        assert!(0x2::balance::value<0x4a8f619840119cd81a12bbfa9d2060cf9c2d781d7759cff86001474d76f84651::gfs_governance::GFS_GOVERNANCE>(&arg0.gfs_treasury) >= v3, 3);
        arg0.tokens_sold = arg0.tokens_sold + v3;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_collected, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x4a8f619840119cd81a12bbfa9d2060cf9c2d781d7759cff86001474d76f84651::gfs_governance::GFS_GOVERNANCE>>(0x2::coin::take<0x4a8f619840119cd81a12bbfa9d2060cf9c2d781d7759cff86001474d76f84651::gfs_governance::GFS_GOVERNANCE>(&mut arg0.gfs_treasury, v3, arg3), v1);
        let v4 = TokensPurchased{
            buyer      : v1,
            sui_amount : v2,
            gfs_amount : v3,
            timestamp  : v0,
        };
        0x2::event::emit<TokensPurchased>(v4);
    }

    fun calculate_gfs_amount(arg0: u64) : u64 {
        arg0 * 550
    }

    public fun calculate_gfs_for_sui(arg0: u64) : u64 {
        calculate_gfs_amount(arg0)
    }

    public fun get_presale_info(arg0: &PresaleConfig) : (bool, u64, u64, u64, u64) {
        (arg0.is_active, arg0.total_tokens_for_sale, arg0.tokens_sold, 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_collected), 0x2::balance::value<0x4a8f619840119cd81a12bbfa9d2060cf9c2d781d7759cff86001474d76f84651::gfs_governance::GFS_GOVERNANCE>(&arg0.gfs_treasury))
    }

    public entry fun initialize_presale(arg0: &mut 0x4a8f619840119cd81a12bbfa9d2060cf9c2d781d7759cff86001474d76f84651::gfs_governance::GovernanceRegistry, arg1: u64, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = PresaleConfig{
            id                    : 0x2::object::new(arg5),
            admin                 : v0,
            is_active             : true,
            total_tokens_for_sale : arg1,
            tokens_sold           : 0,
            sui_collected         : 0x2::balance::zero<0x2::sui::SUI>(),
            gfs_treasury          : 0x2::coin::into_balance<0x4a8f619840119cd81a12bbfa9d2060cf9c2d781d7759cff86001474d76f84651::gfs_governance::GFS_GOVERNANCE>(0x4a8f619840119cd81a12bbfa9d2060cf9c2d781d7759cff86001474d76f84651::gfs_governance::mint_tokens_for_presale(arg0, arg1, arg5)),
            start_time            : arg2,
            end_time              : arg3,
        };
        let v2 = PresaleCap{id: 0x2::object::new(arg5)};
        let v3 = PresaleInitialized{
            admin        : v0,
            total_tokens : arg1,
            start_time   : arg2,
            end_time     : arg3,
        };
        0x2::event::emit<PresaleInitialized>(v3);
        0x2::transfer::share_object<PresaleConfig>(v1);
        0x2::transfer::transfer<PresaleCap>(v2, v0);
    }

    public entry fun toggle_presale(arg0: &mut PresaleConfig, arg1: &PresaleCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg2), 4);
        arg0.is_active = !arg0.is_active;
    }

    public entry fun withdraw_sui(arg0: &mut PresaleConfig, arg1: &PresaleCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg2), 4);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_collected);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.sui_collected, v0, arg2), 0x2::tx_context::sender(arg2));
        };
    }

    // decompiled from Move bytecode v6
}

