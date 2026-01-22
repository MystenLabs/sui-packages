module 0x473875ed1305f8d39cbc9ae498a518450a3adc8e289bf461fd763de64dd82d14::navigator_staking {
    struct NavigatorRegistry has key {
        id: 0x2::object::UID,
        navigators: 0x2::table::Table<address, bool>,
    }

    struct NavigatorStake has key {
        id: 0x2::object::UID,
        navigator: address,
        stake: 0x2::balance::Balance<0x473875ed1305f8d39cbc9ae498a518450a3adc8e289bf461fd763de64dd82d14::shock::SHOCK>,
        staked_at: u64,
        unstake_requested_at: 0x1::option::Option<u64>,
        is_slashed: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public entry fun complete_unstake(arg0: &mut NavigatorRegistry, arg1: NavigatorStake, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let NavigatorStake {
            id                   : v0,
            navigator            : v1,
            stake                : v2,
            staked_at            : _,
            unstake_requested_at : v4,
            is_slashed           : v5,
        } = arg1;
        let v6 = v4;
        assert!(v1 == 0x2::tx_context::sender(arg3), 1);
        assert!(!v5, 2);
        assert!(0x1::option::is_some<u64>(&v6), 3);
        assert!(0x2::clock::timestamp_ms(arg2) >= 0x1::option::destroy_some<u64>(v6) + 2592000000, 4);
        0x2::table::remove<address, bool>(&mut arg0.navigators, v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x473875ed1305f8d39cbc9ae498a518450a3adc8e289bf461fd763de64dd82d14::shock::SHOCK>>(0x2::coin::from_balance<0x473875ed1305f8d39cbc9ae498a518450a3adc8e289bf461fd763de64dd82d14::shock::SHOCK>(v2, arg3), v1);
        0x2::object::delete(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = NavigatorRegistry{
            id         : 0x2::object::new(arg0),
            navigators : 0x2::table::new<address, bool>(arg0),
        };
        0x2::transfer::share_object<NavigatorRegistry>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun is_authorized(arg0: &NavigatorRegistry, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.navigators, arg1)
    }

    public entry fun request_unstake(arg0: &mut NavigatorStake, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.navigator == 0x2::tx_context::sender(arg2), 1);
        assert!(!arg0.is_slashed, 2);
        assert!(0x1::option::is_none<u64>(&arg0.unstake_requested_at), 3);
        arg0.unstake_requested_at = 0x1::option::some<u64>(0x2::clock::timestamp_ms(arg1));
    }

    public entry fun stake_navigator(arg0: &mut NavigatorRegistry, arg1: &mut 0x2::coin::Coin<0x473875ed1305f8d39cbc9ae498a518450a3adc8e289bf461fd763de64dd82d14::shock::SHOCK>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x473875ed1305f8d39cbc9ae498a518450a3adc8e289bf461fd763de64dd82d14::shock::SHOCK>(arg1) >= 1000000000000, 0);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = NavigatorStake{
            id                   : 0x2::object::new(arg3),
            navigator            : v0,
            stake                : 0x2::coin::into_balance<0x473875ed1305f8d39cbc9ae498a518450a3adc8e289bf461fd763de64dd82d14::shock::SHOCK>(0x2::coin::split<0x473875ed1305f8d39cbc9ae498a518450a3adc8e289bf461fd763de64dd82d14::shock::SHOCK>(arg1, 1000000000000, arg3)),
            staked_at            : 0x2::clock::timestamp_ms(arg2),
            unstake_requested_at : 0x1::option::none<u64>(),
            is_slashed           : false,
        };
        0x2::table::add<address, bool>(&mut arg0.navigators, v0, true);
        0x2::transfer::transfer<NavigatorStake>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

