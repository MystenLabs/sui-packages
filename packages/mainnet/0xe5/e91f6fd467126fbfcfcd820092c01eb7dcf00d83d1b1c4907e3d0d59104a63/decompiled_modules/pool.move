module 0xe5e91f6fd467126fbfcfcd820092c01eb7dcf00d83d1b1c4907e3d0d59104a63::pool {
    struct LP_TOKEN has drop, store {
        dummy_field: bool,
    }

    struct Pool has key {
        id: 0x2::object::UID,
        squidsquids_reserve: 0x2::balance::Balance<0xe5e91f6fd467126fbfcfcd820092c01eb7dcf00d83d1b1c4907e3d0d59104a63::squidsquids::SQUIDSQUIDS>,
        sui_reserve: 0x2::balance::Balance<0x2::sui::SUI>,
        lp_supply: 0x2::balance::Supply<LP_TOKEN>,
    }

    public entry fun add_liquidity(arg0: &mut Pool, arg1: 0x2::coin::Coin<0xe5e91f6fd467126fbfcfcd820092c01eb7dcf00d83d1b1c4907e3d0d59104a63::squidsquids::SQUIDSQUIDS>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::coin::value<0xe5e91f6fd467126fbfcfcd820092c01eb7dcf00d83d1b1c4907e3d0d59104a63::squidsquids::SQUIDSQUIDS>(&arg1);
        let v2 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v1 > 0 && v2 > 0, 1);
        let v3 = 0x2::balance::supply_value<LP_TOKEN>(&arg0.lp_supply);
        let v4 = if (v3 == 0) {
            (((v2 as u128) * (v1 as u128)) as u64)
        } else {
            let v5 = (((v2 as u128) * (v3 as u128) / (0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve) as u128)) as u64);
            let v6 = (((v1 as u128) * (v3 as u128) / (0x2::balance::value<0xe5e91f6fd467126fbfcfcd820092c01eb7dcf00d83d1b1c4907e3d0d59104a63::squidsquids::SQUIDSQUIDS>(&arg0.squidsquids_reserve) as u128)) as u64);
            if (v5 < v6) {
                v5
            } else {
                v6
            }
        };
        0x2::balance::join<0xe5e91f6fd467126fbfcfcd820092c01eb7dcf00d83d1b1c4907e3d0d59104a63::squidsquids::SQUIDSQUIDS>(&mut arg0.squidsquids_reserve, 0x2::coin::into_balance<0xe5e91f6fd467126fbfcfcd820092c01eb7dcf00d83d1b1c4907e3d0d59104a63::squidsquids::SQUIDSQUIDS>(arg1));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_reserve, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        0xe5e91f6fd467126fbfcfcd820092c01eb7dcf00d83d1b1c4907e3d0d59104a63::events::emit_liquidity_event(0x2::object::uid_to_inner(&arg0.id), v0, v1, v2, 0x2::tx_context::epoch(arg3));
        0x2::transfer::public_transfer<0x2::coin::Coin<LP_TOKEN>>(0x2::coin::from_balance<LP_TOKEN>(0x2::balance::increase_supply<LP_TOKEN>(&mut arg0.lp_supply, v4), arg3), v0);
    }

    fun calculate_price_impact(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (1000000 as u128) / (arg1 as u128)) as u64)
    }

    public entry fun create_pool(arg0: 0x2::coin::Coin<0xe5e91f6fd467126fbfcfcd820092c01eb7dcf00d83d1b1c4907e3d0d59104a63::squidsquids::SQUIDSQUIDS>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::object::new(arg2);
        let v2 = 0x2::coin::value<0xe5e91f6fd467126fbfcfcd820092c01eb7dcf00d83d1b1c4907e3d0d59104a63::squidsquids::SQUIDSQUIDS>(&arg0);
        let v3 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v2 > 1000 && v3 > 1000, 5);
        let v4 = LP_TOKEN{dummy_field: false};
        let v5 = Pool{
            id                  : v1,
            squidsquids_reserve : 0x2::coin::into_balance<0xe5e91f6fd467126fbfcfcd820092c01eb7dcf00d83d1b1c4907e3d0d59104a63::squidsquids::SQUIDSQUIDS>(arg0),
            sui_reserve         : 0x2::coin::into_balance<0x2::sui::SUI>(arg1),
            lp_supply           : 0x2::balance::create_supply<LP_TOKEN>(v4),
        };
        0xe5e91f6fd467126fbfcfcd820092c01eb7dcf00d83d1b1c4907e3d0d59104a63::events::emit_liquidity_event(0x2::object::uid_to_inner(&v1), v0, v2, v3, 0x2::tx_context::epoch(arg2));
        0x2::transfer::share_object<Pool>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<LP_TOKEN>>(0x2::coin::from_balance<LP_TOKEN>(0x2::balance::increase_supply<LP_TOKEN>(&mut v5.lp_supply, (((v3 as u128) * (v2 as u128)) as u64)), arg2), v0);
    }

    public entry fun remove_liquidity(arg0: &mut Pool, arg1: 0x2::coin::Coin<LP_TOKEN>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::coin::value<LP_TOKEN>(&arg1);
        assert!(v1 > 0, 1);
        let v2 = 0x2::balance::supply_value<LP_TOKEN>(&arg0.lp_supply);
        let v3 = (((v1 as u128) * (0x2::balance::value<0xe5e91f6fd467126fbfcfcd820092c01eb7dcf00d83d1b1c4907e3d0d59104a63::squidsquids::SQUIDSQUIDS>(&arg0.squidsquids_reserve) as u128) / (v2 as u128)) as u64);
        let v4 = (((v1 as u128) * (0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve) as u128) / (v2 as u128)) as u64);
        let v5 = v3 * 3 / 100;
        0x2::balance::decrease_supply<LP_TOKEN>(&mut arg0.lp_supply, 0x2::coin::into_balance<LP_TOKEN>(arg1));
        let v6 = 0x2::coin::take<0xe5e91f6fd467126fbfcfcd820092c01eb7dcf00d83d1b1c4907e3d0d59104a63::squidsquids::SQUIDSQUIDS>(&mut arg0.squidsquids_reserve, v3, arg2);
        0xe5e91f6fd467126fbfcfcd820092c01eb7dcf00d83d1b1c4907e3d0d59104a63::events::emit_remove_liquidity_event(0x2::object::uid_to_inner(&arg0.id), v0, v3 - v5, v4, 0x2::tx_context::epoch(arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<0xe5e91f6fd467126fbfcfcd820092c01eb7dcf00d83d1b1c4907e3d0d59104a63::squidsquids::SQUIDSQUIDS>>(0x2::coin::split<0xe5e91f6fd467126fbfcfcd820092c01eb7dcf00d83d1b1c4907e3d0d59104a63::squidsquids::SQUIDSQUIDS>(&mut v6, v5, arg2), @0xd3182da9d0fd0466f8aac23aaf22636ab388542952a9274dd30e12778e3f6764);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xe5e91f6fd467126fbfcfcd820092c01eb7dcf00d83d1b1c4907e3d0d59104a63::squidsquids::SQUIDSQUIDS>>(v6, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.sui_reserve, v4, arg2), v0);
    }

    public entry fun swap_squidsquids_to_sui(arg0: &mut Pool, arg1: 0x2::coin::Coin<0xe5e91f6fd467126fbfcfcd820092c01eb7dcf00d83d1b1c4907e3d0d59104a63::squidsquids::SQUIDSQUIDS>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::coin::value<0xe5e91f6fd467126fbfcfcd820092c01eb7dcf00d83d1b1c4907e3d0d59104a63::squidsquids::SQUIDSQUIDS>(&arg1);
        assert!(v1 > 0, 1);
        let v2 = v1 * 3 / 100;
        let v3 = v1 - v2;
        let v4 = 0x2::balance::value<0xe5e91f6fd467126fbfcfcd820092c01eb7dcf00d83d1b1c4907e3d0d59104a63::squidsquids::SQUIDSQUIDS>(&arg0.squidsquids_reserve);
        let v5 = calculate_price_impact(v3, v4);
        assert!(v5 <= 10 * 1000000 / 100, 3);
        let v6 = (v3 as u128) * 997;
        let v7 = ((v6 * (0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve) as u128) / ((v4 as u128) * 1000 + v6)) as u64);
        assert!(v7 >= arg2, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xe5e91f6fd467126fbfcfcd820092c01eb7dcf00d83d1b1c4907e3d0d59104a63::squidsquids::SQUIDSQUIDS>>(0x2::coin::split<0xe5e91f6fd467126fbfcfcd820092c01eb7dcf00d83d1b1c4907e3d0d59104a63::squidsquids::SQUIDSQUIDS>(&mut arg1, v2, arg3), @0xd3182da9d0fd0466f8aac23aaf22636ab388542952a9274dd30e12778e3f6764);
        0x2::balance::join<0xe5e91f6fd467126fbfcfcd820092c01eb7dcf00d83d1b1c4907e3d0d59104a63::squidsquids::SQUIDSQUIDS>(&mut arg0.squidsquids_reserve, 0x2::coin::into_balance<0xe5e91f6fd467126fbfcfcd820092c01eb7dcf00d83d1b1c4907e3d0d59104a63::squidsquids::SQUIDSQUIDS>(arg1));
        0xe5e91f6fd467126fbfcfcd820092c01eb7dcf00d83d1b1c4907e3d0d59104a63::events::emit_swap_event(0x2::object::uid_to_inner(&arg0.id), v0, v3, v7, false, v5, 0x2::tx_context::epoch(arg3));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.sui_reserve, v7, arg3), v0);
    }

    public entry fun swap_sui_to_squidsquids(arg0: &mut Pool, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v1 > 0, 1);
        let v2 = 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve);
        let v3 = calculate_price_impact(v1, v2);
        assert!(v3 <= 10 * 1000000 / 100, 3);
        let v4 = (v1 as u128) * 997;
        let v5 = ((v4 * (0x2::balance::value<0xe5e91f6fd467126fbfcfcd820092c01eb7dcf00d83d1b1c4907e3d0d59104a63::squidsquids::SQUIDSQUIDS>(&arg0.squidsquids_reserve) as u128) / ((v2 as u128) * 1000 + v4)) as u64);
        assert!(v5 >= arg2, 2);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_reserve, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v6 = 0x2::coin::take<0xe5e91f6fd467126fbfcfcd820092c01eb7dcf00d83d1b1c4907e3d0d59104a63::squidsquids::SQUIDSQUIDS>(&mut arg0.squidsquids_reserve, v5, arg3);
        let v7 = v5 * 3 / 100;
        0xe5e91f6fd467126fbfcfcd820092c01eb7dcf00d83d1b1c4907e3d0d59104a63::events::emit_swap_event(0x2::object::uid_to_inner(&arg0.id), v0, v1, v5 - v7, true, v3, 0x2::tx_context::epoch(arg3));
        0x2::transfer::public_transfer<0x2::coin::Coin<0xe5e91f6fd467126fbfcfcd820092c01eb7dcf00d83d1b1c4907e3d0d59104a63::squidsquids::SQUIDSQUIDS>>(0x2::coin::split<0xe5e91f6fd467126fbfcfcd820092c01eb7dcf00d83d1b1c4907e3d0d59104a63::squidsquids::SQUIDSQUIDS>(&mut v6, v7, arg3), @0xd3182da9d0fd0466f8aac23aaf22636ab388542952a9274dd30e12778e3f6764);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xe5e91f6fd467126fbfcfcd820092c01eb7dcf00d83d1b1c4907e3d0d59104a63::squidsquids::SQUIDSQUIDS>>(v6, v0);
    }

    // decompiled from Move bytecode v6
}

