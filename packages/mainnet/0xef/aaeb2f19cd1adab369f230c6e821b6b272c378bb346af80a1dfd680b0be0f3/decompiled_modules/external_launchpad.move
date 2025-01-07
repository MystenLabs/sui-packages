module 0xefaaeb2f19cd1adab369f230c6e821b6b272c378bb346af80a1dfd680b0be0f3::external_launchpad {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct LaunchpadConfig has store {
        refundable_started_at_ms: u64,
        refundable_ended_at_ms: u64,
        whitelist: 0x2::table::Table<address, u64>,
    }

    struct Launchpad has store, key {
        id: 0x2::object::UID,
        claimable: bool,
        xflx_ratio: u64,
        list_launchpad: vector<LaunchpadConfig>,
        balance: 0x2::balance::Balance<0x6dae8ca14311574fdfe555524ea48558e3d1360d1607d1c7f98af867e3b7976c::flx::FLX>,
        treasury: address,
    }

    struct Refund has copy, drop {
        launchpad_index: u64,
        amount: u64,
        sender: address,
    }

    struct Claim has copy, drop {
        launchpad_index: u64,
        amount: u64,
        sender: address,
    }

    public entry fun add_launchpad(arg0: &AdminCap, arg1: &mut Launchpad, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0x2::clock::timestamp_ms(arg4) && arg3 > arg2, 7);
        let v0 = LaunchpadConfig{
            refundable_started_at_ms : arg2,
            refundable_ended_at_ms   : arg3,
            whitelist                : 0x2::table::new<address, u64>(arg5),
        };
        0x1::vector::push_back<LaunchpadConfig>(&mut arg1.list_launchpad, v0);
    }

    public fun available(arg0: &0x2::table::Table<address, u64>, arg1: address) : u64 {
        *0x2::table::borrow<address, u64>(arg0, arg1)
    }

    public entry fun claim(arg0: &mut Launchpad, arg1: u64, arg2: &mut 0x65ed6d4e666fcbc1afcd9d4b1d6d4af7def3eeeeaa663f5bebae8101112290f6::xflx::TreasuryManagement, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.claimable, 8);
        perform(arg0, arg1, false, arg2, arg3);
    }

    public entry fun deposit_as_admin(arg0: &AdminCap, arg1: &mut Launchpad, arg2: 0x2::coin::Coin<0x6dae8ca14311574fdfe555524ea48558e3d1360d1607d1c7f98af867e3b7976c::flx::FLX>) {
        0x2::balance::join<0x6dae8ca14311574fdfe555524ea48558e3d1360d1607d1c7f98af867e3b7976c::flx::FLX>(&mut arg1.balance, 0x2::coin::into_balance<0x6dae8ca14311574fdfe555524ea48558e3d1360d1607d1c7f98af867e3b7976c::flx::FLX>(arg2));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = Launchpad{
            id             : 0x2::object::new(arg0),
            claimable      : false,
            xflx_ratio     : 6500,
            list_launchpad : 0x1::vector::empty<LaunchpadConfig>(),
            balance        : 0x2::balance::zero<0x6dae8ca14311574fdfe555524ea48558e3d1360d1607d1c7f98af867e3b7976c::flx::FLX>(),
            treasury       : @0x80ef0d4bf7b5c5e7989d907c5ed4437af83bb8d665f864a21a3ffed7619986a9,
        };
        0x2::transfer::share_object<Launchpad>(v1);
    }

    public fun is_whitelisted(arg0: &0x2::table::Table<address, u64>, arg1: address) : bool {
        0x2::table::contains<address, u64>(arg0, arg1)
    }

    fun perform(arg0: &mut Launchpad, arg1: u64, arg2: bool, arg3: &mut 0x65ed6d4e666fcbc1afcd9d4b1d6d4af7def3eeeeaa663f5bebae8101112290f6::xflx::TreasuryManagement, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = &mut 0x1::vector::borrow_mut<LaunchpadConfig>(&mut arg0.list_launchpad, arg1).whitelist;
        assert!(is_whitelisted(v1, v0), 5);
        assert!(available(v1, v0) > 0, 6);
        assert!(0x2::balance::value<0x6dae8ca14311574fdfe555524ea48558e3d1360d1607d1c7f98af867e3b7976c::flx::FLX>(&arg0.balance) >= available(v1, v0), 3);
        let v2 = 0x2::table::borrow_mut<address, u64>(v1, v0);
        let v3 = 0x2::balance::split<0x6dae8ca14311574fdfe555524ea48558e3d1360d1607d1c7f98af867e3b7976c::flx::FLX>(&mut arg0.balance, *v2);
        *v2 = 0;
        if (arg2) {
            let v4 = Refund{
                launchpad_index : arg1,
                amount          : 0x2::balance::value<0x6dae8ca14311574fdfe555524ea48558e3d1360d1607d1c7f98af867e3b7976c::flx::FLX>(&v3),
                sender          : v0,
            };
            0x2::event::emit<Refund>(v4);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x6dae8ca14311574fdfe555524ea48558e3d1360d1607d1c7f98af867e3b7976c::flx::FLX>>(0x2::coin::from_balance<0x6dae8ca14311574fdfe555524ea48558e3d1360d1607d1c7f98af867e3b7976c::flx::FLX>(v3, arg4), arg0.treasury);
        } else {
            let v5 = Claim{
                launchpad_index : arg1,
                amount          : 0x2::balance::value<0x6dae8ca14311574fdfe555524ea48558e3d1360d1607d1c7f98af867e3b7976c::flx::FLX>(&v3),
                sender          : v0,
            };
            0x2::event::emit<Claim>(v5);
            0x65ed6d4e666fcbc1afcd9d4b1d6d4af7def3eeeeaa663f5bebae8101112290f6::xflx::mint_and_transfer(arg3, 0x2::coin::from_balance<0x6dae8ca14311574fdfe555524ea48558e3d1360d1607d1c7f98af867e3b7976c::flx::FLX>(0x2::balance::split<0x6dae8ca14311574fdfe555524ea48558e3d1360d1607d1c7f98af867e3b7976c::flx::FLX>(&mut v3, 0xefaaeb2f19cd1adab369f230c6e821b6b272c378bb346af80a1dfd680b0be0f3::u64::mul_div(0x2::balance::value<0x6dae8ca14311574fdfe555524ea48558e3d1360d1607d1c7f98af867e3b7976c::flx::FLX>(&v3), arg0.xflx_ratio, 10000)), arg4), v0, arg4);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x6dae8ca14311574fdfe555524ea48558e3d1360d1607d1c7f98af867e3b7976c::flx::FLX>>(0x2::coin::from_balance<0x6dae8ca14311574fdfe555524ea48558e3d1360d1607d1c7f98af867e3b7976c::flx::FLX>(v3, arg4), v0);
        };
    }

    public entry fun refund(arg0: &mut Launchpad, arg1: u64, arg2: &mut 0x65ed6d4e666fcbc1afcd9d4b1d6d4af7def3eeeeaa663f5bebae8101112290f6::xflx::TreasuryManagement, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg3) >= 0x1::vector::borrow<LaunchpadConfig>(&arg0.list_launchpad, arg1).refundable_started_at_ms, 1);
        assert!(0x2::clock::timestamp_ms(arg3) < 0x1::vector::borrow<LaunchpadConfig>(&arg0.list_launchpad, arg1).refundable_ended_at_ms, 2);
        perform(arg0, arg1, true, arg2, arg4);
    }

    public entry fun remove_whitelist(arg0: &AdminCap, arg1: &mut Launchpad, arg2: u64, arg3: vector<address>) {
        let v0 = 0;
        let v1 = 0x1::vector::borrow_mut<LaunchpadConfig>(&mut arg1.list_launchpad, arg2);
        while (v0 < 0x1::vector::length<address>(&arg3)) {
            let v2 = *0x1::vector::borrow<address>(&arg3, v0);
            assert!(is_whitelisted(&v1.whitelist, v2), 5);
            0x2::table::remove<address, u64>(&mut v1.whitelist, v2);
            v0 = v0 + 1;
        };
    }

    public entry fun set_claimable(arg0: &AdminCap, arg1: &mut Launchpad, arg2: bool) {
        arg1.claimable = arg2;
    }

    public entry fun set_whitelist(arg0: &AdminCap, arg1: &mut Launchpad, arg2: u64, arg3: vector<address>, arg4: vector<u64>) {
        assert!(0x1::vector::length<address>(&arg3) == 0x1::vector::length<u64>(&arg4), 0);
        let v0 = 0;
        let v1 = 0x1::vector::borrow_mut<LaunchpadConfig>(&mut arg1.list_launchpad, arg2);
        while (v0 < 0x1::vector::length<address>(&arg3)) {
            let v2 = *0x1::vector::borrow<address>(&arg3, v0);
            assert!(!is_whitelisted(&v1.whitelist, v2), 4);
            0x2::table::add<address, u64>(&mut v1.whitelist, v2, *0x1::vector::borrow<u64>(&arg4, v0));
            v0 = v0 + 1;
        };
    }

    public entry fun update_refundable_end_time(arg0: &AdminCap, arg1: &mut Launchpad, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock) {
        assert!(arg3 > 0x2::clock::timestamp_ms(arg4) && arg3 > 0x1::vector::borrow<LaunchpadConfig>(&arg1.list_launchpad, arg2).refundable_started_at_ms, 7);
        0x1::vector::borrow_mut<LaunchpadConfig>(&mut arg1.list_launchpad, arg2).refundable_ended_at_ms = arg3;
    }

    public entry fun update_refundable_start_time(arg0: &AdminCap, arg1: &mut Launchpad, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock) {
        assert!(arg3 > 0x2::clock::timestamp_ms(arg4), 7);
        0x1::vector::borrow_mut<LaunchpadConfig>(&mut arg1.list_launchpad, arg2).refundable_started_at_ms = arg3;
    }

    public entry fun withdraw_as_admin(arg0: &AdminCap, arg1: &mut Launchpad, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0x6dae8ca14311574fdfe555524ea48558e3d1360d1607d1c7f98af867e3b7976c::flx::FLX>(&arg1.balance) >= arg2, 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x6dae8ca14311574fdfe555524ea48558e3d1360d1607d1c7f98af867e3b7976c::flx::FLX>>(0x2::coin::from_balance<0x6dae8ca14311574fdfe555524ea48558e3d1360d1607d1c7f98af867e3b7976c::flx::FLX>(0x2::balance::split<0x6dae8ca14311574fdfe555524ea48558e3d1360d1607d1c7f98af867e3b7976c::flx::FLX>(&mut arg1.balance, arg2), arg4), arg3);
    }

    // decompiled from Move bytecode v6
}

