module 0xce42a683a94fc4fd1f0be5cdd2459acd82535c7800b4847a9cc4965cfcb5182d::platform {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
        admin: address,
    }

    struct ModeratorRegistry has key {
        id: 0x2::object::UID,
        moderators: 0x2::table::Table<address, bool>,
    }

    struct PlatformTreasury has key {
        id: 0x2::object::UID,
        bal: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct PlatformConfig has key {
        id: 0x2::object::UID,
        admin: address,
        tip_fee_bps: u64,
        sales_fee_bps: u64,
        token_platform_fee_bps: u64,
        token_creator_fee_bps: u64,
        handle_claim_fee_micro: u64,
        paused: bool,
    }

    struct ModeratorAdded has copy, drop {
        moderator: address,
    }

    struct ModeratorRemoved has copy, drop {
        moderator: address,
    }

    entry fun add_moderator(arg0: &PlatformConfig, arg1: &AdminCap, arg2: &mut ModeratorRegistry, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg4);
        if (0x2::table::contains<address, bool>(&arg2.moderators, arg3)) {
            *0x2::table::borrow_mut<address, bool>(&mut arg2.moderators, arg3) = true;
        } else {
            0x2::table::add<address, bool>(&mut arg2.moderators, arg3, true);
        };
        let v0 = ModeratorAdded{moderator: arg3};
        0x2::event::emit<ModeratorAdded>(v0);
    }

    fun assert_admin(arg0: &PlatformConfig, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 1);
    }

    public fun deposit_usde(arg0: &mut PlatformTreasury, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.bal, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    public fun handle_claim_fee_micro(arg0: &PlatformConfig) : u64 {
        arg0.handle_claim_fee_micro
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = AdminCap{
            id    : 0x2::object::new(arg0),
            admin : v0,
        };
        let v2 = PlatformConfig{
            id                     : 0x2::object::new(arg0),
            admin                  : v0,
            tip_fee_bps            : 200,
            sales_fee_bps          : 500,
            token_platform_fee_bps : 200,
            token_creator_fee_bps  : 300,
            handle_claim_fee_micro : 1000000,
            paused                 : false,
        };
        let v3 = PlatformTreasury{
            id  : 0x2::object::new(arg0),
            bal : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        let v4 = ModeratorRegistry{
            id         : 0x2::object::new(arg0),
            moderators : 0x2::table::new<address, bool>(arg0),
        };
        0x2::transfer::share_object<PlatformConfig>(v2);
        0x2::transfer::share_object<PlatformTreasury>(v3);
        0x2::transfer::share_object<ModeratorRegistry>(v4);
        0x2::transfer::transfer<AdminCap>(v1, v0);
    }

    public fun is_moderator(arg0: &AdminCap, arg1: &ModeratorRegistry, arg2: address) : bool {
        if (arg0.admin == arg2) {
            return true
        };
        0x2::table::contains<address, bool>(&arg1.moderators, arg2) && *0x2::table::borrow<address, bool>(&arg1.moderators, arg2)
    }

    public fun is_paused(arg0: &PlatformConfig) : bool {
        arg0.paused
    }

    entry fun remove_moderator(arg0: &PlatformConfig, arg1: &AdminCap, arg2: &mut ModeratorRegistry, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg4);
        if (0x2::table::contains<address, bool>(&arg2.moderators, arg3)) {
            0x2::table::remove<address, bool>(&mut arg2.moderators, arg3);
            let v0 = ModeratorRemoved{moderator: arg3};
            0x2::event::emit<ModeratorRemoved>(v0);
        };
    }

    public fun sales_fee_bps(arg0: &PlatformConfig) : u64 {
        arg0.sales_fee_bps
    }

    entry fun set_paused(arg0: &mut PlatformConfig, arg1: &AdminCap, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg3);
        arg0.paused = arg2;
    }

    public fun tip_fee_bps(arg0: &PlatformConfig) : u64 {
        arg0.tip_fee_bps
    }

    public fun token_creator_fee_bps(arg0: &PlatformConfig) : u64 {
        arg0.token_creator_fee_bps
    }

    public fun token_platform_fee_bps(arg0: &PlatformConfig) : u64 {
        arg0.token_platform_fee_bps
    }

    entry fun withdraw_treasury(arg0: &PlatformConfig, arg1: &AdminCap, arg2: &mut PlatformTreasury, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg2.bal, arg3), arg4), arg0.admin);
    }

    // decompiled from Move bytecode v6
}

