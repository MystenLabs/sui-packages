module 0xce68e3d147e729716ff9617530dbdd19d82d2bc20819549f6eefa1bd1f06687b::navigator_staking {
    struct Registry has key {
        id: 0x2::object::UID,
        navigators: 0x2::table::Table<address, NavigatorInfo>,
        admin: address,
    }

    struct NavigatorInfo has drop, store {
        staked_amount: u64,
        staked_at: u64,
        cooldown_started: u64,
        is_cooling_down: bool,
    }

    struct NavigatorStake has key {
        id: 0x2::object::UID,
        navigator: address,
        staked_at: u64,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry{
            id         : 0x2::object::new(arg0),
            navigators : 0x2::table::new<address, NavigatorInfo>(arg0),
            admin      : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<Registry>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun is_navigator(arg0: &Registry, arg1: address) : bool {
        0x2::table::contains<address, NavigatorInfo>(&arg0.navigators, arg1)
    }

    public entry fun stake(arg0: &mut Registry, arg1: 0x2::coin::Coin<0xce68e3d147e729716ff9617530dbdd19d82d2bc20819549f6eefa1bd1f06687b::shock::SHOCK>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(!0x2::table::contains<address, NavigatorInfo>(&arg0.navigators, v0), 2);
        assert!(0x2::coin::value<0xce68e3d147e729716ff9617530dbdd19d82d2bc20819549f6eefa1bd1f06687b::shock::SHOCK>(&arg1) >= 1000000000000, 5);
        if (0x2::coin::value<0xce68e3d147e729716ff9617530dbdd19d82d2bc20819549f6eefa1bd1f06687b::shock::SHOCK>(&arg1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xce68e3d147e729716ff9617530dbdd19d82d2bc20819549f6eefa1bd1f06687b::shock::SHOCK>>(arg1, v0);
        } else {
            0x2::coin::destroy_zero<0xce68e3d147e729716ff9617530dbdd19d82d2bc20819549f6eefa1bd1f06687b::shock::SHOCK>(arg1);
        };
        let v1 = 0x2::clock::timestamp_ms(arg2);
        let v2 = NavigatorInfo{
            staked_amount    : 1000000000000,
            staked_at        : v1,
            cooldown_started : 0,
            is_cooling_down  : false,
        };
        0x2::table::add<address, NavigatorInfo>(&mut arg0.navigators, v0, v2);
        let v3 = NavigatorStake{
            id        : 0x2::object::new(arg3),
            navigator : v0,
            staked_at : v1,
        };
        0x2::transfer::transfer<NavigatorStake>(v3, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xce68e3d147e729716ff9617530dbdd19d82d2bc20819549f6eefa1bd1f06687b::shock::SHOCK>>(0x2::coin::split<0xce68e3d147e729716ff9617530dbdd19d82d2bc20819549f6eefa1bd1f06687b::shock::SHOCK>(&mut arg1, 1000000000000, arg3), v0);
    }

    public entry fun start_cooldown(arg0: &mut Registry, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<address, NavigatorInfo>(&arg0.navigators, v0), 3);
        let v1 = 0x2::table::borrow_mut<address, NavigatorInfo>(&mut arg0.navigators, v0);
        v1.is_cooling_down = true;
        v1.cooldown_started = 0x2::clock::timestamp_ms(arg1);
    }

    public entry fun unstake(arg0: &mut Registry, arg1: 0x2::coin::Coin<0xce68e3d147e729716ff9617530dbdd19d82d2bc20819549f6eefa1bd1f06687b::shock::SHOCK>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::table::contains<address, NavigatorInfo>(&arg0.navigators, v0), 3);
        let v1 = 0x2::table::remove<address, NavigatorInfo>(&mut arg0.navigators, v0);
        assert!(v1.is_cooling_down, 4);
        assert!(0x2::clock::timestamp_ms(arg2) - v1.cooldown_started >= 2592000000, 4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xce68e3d147e729716ff9617530dbdd19d82d2bc20819549f6eefa1bd1f06687b::shock::SHOCK>>(arg1, v0);
    }

    // decompiled from Move bytecode v6
}

