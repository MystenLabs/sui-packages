module 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::tails_staking {
    struct TailsStakingRegistry has key {
        id: 0x2::object::UID,
        config: vector<u64>,
        tails_manager_cap: 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::ManagerCap,
        tails: 0x2::object_table::ObjectTable<address, 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>,
        tails_metadata: 0x2::bag::Bag,
        staking_infos: 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::BigVector,
        profit_assets: vector<0x1::type_name::TypeName>,
        transfer_policy: 0x2::transfer_policy::TransferPolicy<0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>,
    }

    struct StakingInfo has drop, store {
        user: address,
        tails: vector<u64>,
        profits: vector<u64>,
        u64_padding: vector<u64>,
    }

    struct UpdateTailsStakingRegistryConfigEvent has copy, drop {
        index: u64,
        log: vector<u64>,
        bcs_padding: vector<vector<u8>>,
    }

    struct SetProfitSharingEvent has copy, drop {
        token: 0x1::type_name::TypeName,
        level_profits: vector<u64>,
        level_counts: vector<u64>,
        log: vector<u64>,
        bcs_padding: vector<vector<u8>>,
    }

    struct RemoveProfitSharingEvent has copy, drop {
        token: 0x1::type_name::TypeName,
        log: vector<u64>,
        bcs_padding: vector<vector<u8>>,
    }

    struct ClaimProfitSharingEvent has copy, drop {
        tails: vector<u64>,
        profit_asset: 0x1::type_name::TypeName,
        log: vector<u64>,
        bcs_padding: vector<vector<u8>>,
    }

    struct StakeTailsEvent has copy, drop {
        tails: address,
        log: vector<u64>,
        bcs_padding: vector<vector<u8>>,
    }

    struct UnstakeTailsEvent has copy, drop {
        tails: address,
        log: vector<u64>,
        bcs_padding: vector<vector<u8>>,
    }

    struct TransferTailsEvent has copy, drop {
        tails: address,
        recipient: address,
        log: vector<u64>,
        bcs_padding: vector<vector<u8>>,
    }

    struct DailySignUpEvent has copy, drop {
        tails: vector<u64>,
        log: vector<u64>,
        bcs_padding: vector<vector<u8>>,
    }

    struct ExpUpEvent has copy, drop {
        tails: address,
        log: vector<u64>,
        bcs_padding: vector<vector<u8>>,
    }

    struct ExpDownEvent has copy, drop {
        tails: address,
        log: vector<u64>,
        bcs_padding: vector<vector<u8>>,
    }

    struct LevelUpEvent has copy, drop {
        tails: address,
        log: vector<u64>,
        bcs_padding: vector<vector<u8>>,
    }

    public fun claim_profit_sharing<T0>(arg0: &mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::Version, arg1: &mut TailsStakingRegistry, arg2: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::version_check(arg0);
        let v0 = 0x1::type_name::get<T0>();
        let (v1, v2) = 0x1::vector::index_of<0x1::type_name::TypeName>(&arg1.profit_assets, &v0);
        if (!v1) {
            abort 5
        } else {
            let v3 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::length(&arg1.staking_infos);
            let v4 = (0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::slice_size(&arg1.staking_infos) as u64);
            let v5 = 0;
            let v6 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::borrow_slice_mut<StakingInfo>(&mut arg1.staking_infos, v5);
            let v7 = v6;
            let v8 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::get_slice_length<StakingInfo>(v6);
            let v9 = 0;
            while (v9 < v3) {
                let v10 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::borrow_from_slice_mut<StakingInfo>(v7, v9 % v4);
                if (v10.user == 0x2::tx_context::sender(arg2)) {
                    let v11 = 0x1::vector::empty<u64>();
                    0x1::vector::push_back<u64>(&mut v11, *0x1::vector::borrow<u64>(&v10.profits, v2));
                    let v12 = ClaimProfitSharingEvent{
                        tails        : v10.tails,
                        profit_asset : v0,
                        log          : v11,
                        bcs_padding  : vector[],
                    };
                    0x2::event::emit<ClaimProfitSharingEvent>(v12);
                    *0x1::vector::borrow_mut<u64>(&mut v10.profits, v2) = 0;
                    return 0x2::balance::split<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.id, v0), *0x1::vector::borrow<u64>(&v10.profits, v2))
                };
                if (v9 + 1 < v3 && v9 + 1 == v5 * v4 + v8) {
                    let v13 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::get_slice_idx<StakingInfo>(v7) + 1;
                    v5 = v13;
                    let v14 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::borrow_slice_mut<StakingInfo>(&mut arg1.staking_infos, v13);
                    v7 = v14;
                    v8 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::get_slice_length<StakingInfo>(v14);
                };
                v9 = v9 + 1;
            };
            abort 7
        };
    }

    entry fun daily_sign_up(arg0: &mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::Version, arg1: &mut TailsStakingRegistry, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::version_check(arg0);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) == *0x1::vector::borrow<u64>(&arg1.config, 4), 3);
        0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::charge_fee<0x2::sui::SUI>(arg0, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        let v0 = 0x2::bag::borrow<vector<u8>, vector<address>>(&arg1.tails_metadata, b"tails_ids");
        let v1 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::length(&arg1.staking_infos);
        let v2 = (0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::slice_size(&arg1.staking_infos) as u64);
        let v3 = 0;
        let v4 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::borrow_slice_mut<StakingInfo>(&mut arg1.staking_infos, v3);
        let v5 = v4;
        let v6 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::get_slice_length<StakingInfo>(v4);
        let v7 = 0;
        while (v7 < v1) {
            let v8 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::borrow_from_slice_mut<StakingInfo>(v5, v7 % v2);
            if (v8.user == 0x2::tx_context::sender(arg4)) {
                let v9 = 0x2::clock::timestamp_ms(arg3);
                if (v9 / 86400000 - *0x1::vector::borrow<u64>(&v8.u64_padding, 0) / 86400000 == 0) {
                    abort 0
                };
                *0x1::vector::borrow_mut<u64>(&mut v8.u64_padding, 0) = v9;
                let v10 = 0;
                let v11 = *0x1::vector::borrow<u64>(&arg1.config, 3);
                while (v10 < 0x1::vector::length<u64>(&v8.tails)) {
                    0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::nft_exp_up(&arg1.tails_manager_cap, 0x2::object_table::borrow_mut<address, 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(&mut arg1.tails, *0x1::vector::borrow<address>(v0, *0x1::vector::borrow<u64>(&v8.tails, v10) - 1)), v11);
                    v10 = v10 + 1;
                };
                let v12 = 0x1::vector::empty<u64>();
                let v13 = &mut v12;
                0x1::vector::push_back<u64>(v13, v11);
                0x1::vector::push_back<u64>(v13, *0x1::vector::borrow<u64>(&arg1.config, 4));
                let v14 = DailySignUpEvent{
                    tails       : v8.tails,
                    log         : v12,
                    bcs_padding : vector[],
                };
                0x2::event::emit<DailySignUpEvent>(v14);
                return
            };
            if (v7 + 1 < v1 && v7 + 1 == v3 * v2 + v6) {
                let v15 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::get_slice_idx<StakingInfo>(v5) + 1;
                v3 = v15;
                let v16 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::borrow_slice_mut<StakingInfo>(&mut arg1.staking_infos, v15);
                v5 = v16;
                v6 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::get_slice_length<StakingInfo>(v16);
            };
            v7 = v7 + 1;
        };
        abort 7
    }

    fun deprecated() {
        abort 999
    }

    public fun exp_down(arg0: &0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::Version, arg1: &mut TailsStakingRegistry, arg2: &mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::user::TypusUserRegistry, arg3: address, arg4: u64, arg5: &0x2::tx_context::TxContext) {
        deprecated();
    }

    public fun exp_down_with_fee(arg0: &mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::Version, arg1: &mut TailsStakingRegistry, arg2: &mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::user::TypusUserRegistry, arg3: address, arg4: u64, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &0x2::tx_context::TxContext) {
        0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::version_check(arg0);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg5) == *0x1::vector::borrow<u64>(&arg1.config, 5), 3);
        0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::charge_fee<0x2::sui::SUI>(arg0, 0x2::coin::into_balance<0x2::sui::SUI>(arg5));
        if (!0x2::object_table::contains<address, 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(&arg1.tails, arg3)) {
            abort 7
        };
        let v0 = 0x2::object_table::borrow_mut<address, 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(&mut arg1.tails, arg3);
        0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::nft_exp_down(&arg1.tails_manager_cap, v0, arg4);
        0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::user::add_tails_exp_amount_(arg0, arg2, 0x2::tx_context::sender(arg6), arg4);
        let v1 = 0x2::object::id_address<0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(v0);
        let v2 = 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::tails_number(v0);
        let v3 = 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::tails_level(v0);
        let v4 = 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::level_up(&arg1.tails_manager_cap, v0);
        if (0x1::option::is_some<u64>(&v4)) {
            0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::update_image_url(&arg1.tails_manager_cap, v0, *0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::borrow<vector<u8>>(0x2::table::borrow<u64, 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::BigVector>(0x2::bag::borrow<vector<u8>, 0x2::table::Table<u64, 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::BigVector>>(&arg1.tails_metadata, b"tails_ipfs_urls"), v3), v2 - 1));
        };
        *0x1::vector::borrow_mut<u64>(0x2::bag::borrow_mut<vector<u8>, vector<u64>>(&mut arg1.tails_metadata, b"tails_levels"), v2 - 1) = v3;
        let v5 = 0x1::vector::empty<u64>();
        let v6 = &mut v5;
        0x1::vector::push_back<u64>(v6, v2);
        0x1::vector::push_back<u64>(v6, arg4);
        let v7 = ExpDownEvent{
            tails       : v1,
            log         : v5,
            bcs_padding : vector[],
        };
        0x2::event::emit<ExpDownEvent>(v7);
    }

    public fun exp_down_without_staking(arg0: &0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::Version, arg1: &TailsStakingRegistry, arg2: &mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::user::TypusUserRegistry, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: address, arg6: u64, arg7: &0x2::tx_context::TxContext) {
        deprecated();
    }

    public fun exp_down_without_staking_with_fee(arg0: &mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::Version, arg1: &TailsStakingRegistry, arg2: &mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::user::TypusUserRegistry, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: address, arg6: u64, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: &0x2::tx_context::TxContext) {
        0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::version_check(arg0);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg7) == *0x1::vector::borrow<u64>(&arg1.config, 5), 3);
        0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::charge_fee<0x2::sui::SUI>(arg0, 0x2::coin::into_balance<0x2::sui::SUI>(arg7));
        let v0 = 0x2::kiosk::borrow_mut<0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(arg3, arg4, 0x2::object::id_from_address(arg5));
        0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::nft_exp_down(&arg1.tails_manager_cap, v0, arg6);
        0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::user::add_tails_exp_amount_(arg0, arg2, 0x2::tx_context::sender(arg8), arg6);
        let v1 = 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::tails_number(v0);
        let v2 = 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::level_up(&arg1.tails_manager_cap, v0);
        if (0x1::option::is_some<u64>(&v2)) {
            0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::update_image_url(&arg1.tails_manager_cap, v0, *0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::borrow<vector<u8>>(0x2::table::borrow<u64, 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::BigVector>(0x2::bag::borrow<vector<u8>, 0x2::table::Table<u64, 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::BigVector>>(&arg1.tails_metadata, b"tails_ipfs_urls"), 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::tails_level(v0)), v1 - 1));
        };
        let v3 = 0x1::vector::empty<u64>();
        let v4 = &mut v3;
        0x1::vector::push_back<u64>(v4, v1);
        0x1::vector::push_back<u64>(v4, arg6);
        let v5 = ExpDownEvent{
            tails       : 0x2::object::id_address<0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(v0),
            log         : v3,
            bcs_padding : vector[],
        };
        0x2::event::emit<ExpDownEvent>(v5);
    }

    public fun exp_up(arg0: &0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::Version, arg1: &mut TailsStakingRegistry, arg2: &mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::user::TypusUserRegistry, arg3: address, arg4: u64, arg5: &0x2::tx_context::TxContext) {
        0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::version_check(arg0);
        if (!0x2::object_table::contains<address, 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(&arg1.tails, arg3)) {
            abort 7
        };
        let v0 = 0x2::object_table::borrow_mut<address, 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(&mut arg1.tails, arg3);
        0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::nft_exp_up(&arg1.tails_manager_cap, v0, arg4);
        0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::user::remove_tails_exp_amount_(arg0, arg2, 0x2::tx_context::sender(arg5), arg4);
        let v1 = 0x1::vector::empty<u64>();
        let v2 = &mut v1;
        0x1::vector::push_back<u64>(v2, 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::tails_number(v0));
        0x1::vector::push_back<u64>(v2, arg4);
        let v3 = ExpUpEvent{
            tails       : 0x2::object::id_address<0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(v0),
            log         : v1,
            bcs_padding : vector[],
        };
        0x2::event::emit<ExpUpEvent>(v3);
    }

    public fun exp_up_without_staking(arg0: &0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::Version, arg1: &TailsStakingRegistry, arg2: &mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::user::TypusUserRegistry, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: address, arg6: u64, arg7: &0x2::tx_context::TxContext) {
        0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::version_check(arg0);
        let v0 = 0x2::kiosk::borrow_mut<0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(arg3, arg4, 0x2::object::id_from_address(arg5));
        0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::nft_exp_up(&arg1.tails_manager_cap, v0, arg6);
        0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::user::remove_tails_exp_amount_(arg0, arg2, 0x2::tx_context::sender(arg7), arg6);
        let v1 = 0x1::vector::empty<u64>();
        let v2 = &mut v1;
        0x1::vector::push_back<u64>(v2, 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::tails_number(v0));
        0x1::vector::push_back<u64>(v2, arg6);
        let v3 = ExpUpEvent{
            tails       : 0x2::object::id_address<0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(v0),
            log         : v1,
            bcs_padding : vector[],
        };
        0x2::event::emit<ExpUpEvent>(v3);
    }

    public(friend) fun get_level_counts(arg0: &0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::Version, arg1: &TailsStakingRegistry) : vector<u64> {
        0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::version_check(arg0);
        let v0 = vector[0, 0, 0, 0, 0, 0, 0];
        let v1 = 0x2::bag::borrow<vector<u8>, vector<u64>>(&arg1.tails_metadata, b"tails_levels");
        let v2 = (0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::slice_size(&arg1.staking_infos) as u64);
        let v3 = 0;
        let v4 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::borrow_slice<StakingInfo>(&arg1.staking_infos, v3);
        let v5 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::get_slice_length<StakingInfo>(v4);
        let v6 = 0;
        while (v6 < 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::length(&arg1.staking_infos)) {
            let v7 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::borrow_from_slice<StakingInfo>(v4, v6 % v2);
            let v8 = 0;
            let v9 = 0x1::vector::length<u64>(&v7.tails);
            while (v8 < v9) {
                let v10 = *0x1::vector::borrow<u64>(v1, *0x1::vector::borrow<u64>(&v7.tails, v8) - 1);
                *0x1::vector::borrow_mut<u64>(&mut v0, v10 - 1) = *0x1::vector::borrow<u64>(&v0, v10 - 1) + 1;
                v8 = v8 + 1;
            };
            if (v6 + 1 < v9 && v6 + 1 == v3 * v2 + v5) {
                let v11 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::get_slice_idx<StakingInfo>(v4) + 1;
                v3 = v11;
                let v12 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::borrow_slice<StakingInfo>(&arg1.staking_infos, v11);
                v4 = v12;
                v5 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::get_slice_length<StakingInfo>(v12);
            };
            v6 = v6 + 1;
        };
        v0
    }

    public(friend) fun get_staking_info(arg0: &0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::Version, arg1: &TailsStakingRegistry, arg2: address) : vector<u8> {
        0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::version_check(arg0);
        let v0 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::length(&arg1.staking_infos);
        let v1 = (0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::slice_size(&arg1.staking_infos) as u64);
        let v2 = 0;
        let v3 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::borrow_slice<StakingInfo>(&arg1.staking_infos, v2);
        let v4 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::get_slice_length<StakingInfo>(v3);
        let v5 = 0;
        while (v5 < v0) {
            if (0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::borrow_from_slice<StakingInfo>(v3, v5 % v1).user == arg2) {
                return 0x1::bcs::to_bytes<StakingInfo>(0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::borrow_from_slice<StakingInfo>(v3, v5 % v1))
            };
            if (v5 + 1 < v0 && v5 + 1 == v2 * v1 + v4) {
                let v6 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::get_slice_idx<StakingInfo>(v3) + 1;
                v2 = v6;
                let v7 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::borrow_slice<StakingInfo>(&arg1.staking_infos, v6);
                v3 = v7;
                v4 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::get_slice_length<StakingInfo>(v7);
            };
            v5 = v5 + 1;
        };
        b""
    }

    public(friend) fun get_staking_infos(arg0: &0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::Version, arg1: &TailsStakingRegistry, arg2: address) : vector<vector<u8>> {
        0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::version_check(arg0);
        let v0 = vector[];
        let v1 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::length(&arg1.staking_infos);
        let v2 = (0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::slice_size(&arg1.staking_infos) as u64);
        let v3 = 0;
        let v4 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::borrow_slice<StakingInfo>(&arg1.staking_infos, v3);
        let v5 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::get_slice_length<StakingInfo>(v4);
        let v6 = 0;
        while (v6 < v1) {
            if (0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::borrow_from_slice<StakingInfo>(v4, v6 % v2).user == arg2) {
                0x1::vector::push_back<vector<u8>>(&mut v0, 0x1::bcs::to_bytes<StakingInfo>(0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::borrow_from_slice<StakingInfo>(v4, v6 % v2)));
            };
            if (v6 + 1 < v1 && v6 + 1 == v3 * v2 + v5) {
                let v7 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::get_slice_idx<StakingInfo>(v4) + 1;
                v3 = v7;
                let v8 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::borrow_slice<StakingInfo>(&arg1.staking_infos, v7);
                v4 = v8;
                v5 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::get_slice_length<StakingInfo>(v8);
            };
            v6 = v6 + 1;
        };
        v0
    }

    public fun import_tails(arg0: &mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::Version, arg1: &mut TailsStakingRegistry, arg2: vector<0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>, arg3: vector<address>, arg4: &0x2::tx_context::TxContext) {
        0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::verify(arg0, arg4);
        assert!(0x1::vector::length<0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(&arg2) == 0x1::vector::length<address>(&arg3), 4);
        while (!0x1::vector::is_empty<0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(&arg2)) {
            let v0 = 0x1::vector::pop_back<0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(&mut arg2);
            if (0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::contains_u64_padding(&arg1.tails_manager_cap, &v0, 0x1::string::utf8(b"updating_url"))) {
                0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::remove_u64_padding(&arg1.tails_manager_cap, &mut v0, 0x1::string::utf8(b"updating_url"));
            };
            if (0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::contains_u64_padding(&arg1.tails_manager_cap, &v0, 0x1::string::utf8(b"attendance_ms"))) {
                0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::remove_u64_padding(&arg1.tails_manager_cap, &mut v0, 0x1::string::utf8(b"attendance_ms"));
            };
            if (0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::contains_u64_padding(&arg1.tails_manager_cap, &v0, 0x1::string::utf8(b"snapshot_ms"))) {
                0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::remove_u64_padding(&arg1.tails_manager_cap, &mut v0, 0x1::string::utf8(b"snapshot_ms"));
            };
            if (0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::contains_u64_padding(&arg1.tails_manager_cap, &v0, 0x1::string::utf8(b"usd_in_deposit"))) {
                0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::remove_u64_padding(&arg1.tails_manager_cap, &mut v0, 0x1::string::utf8(b"usd_in_deposit"));
            };
            if (0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::contains_u64_padding(&arg1.tails_manager_cap, &v0, 0x1::string::utf8(b"dice_profit"))) {
                0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::remove_u64_padding(&arg1.tails_manager_cap, &mut v0, 0x1::string::utf8(b"dice_profit"));
            };
            if (0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::contains_u64_padding(&arg1.tails_manager_cap, &v0, 0x1::string::utf8(b"exp_profit"))) {
                0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::remove_u64_padding(&arg1.tails_manager_cap, &mut v0, 0x1::string::utf8(b"exp_profit"));
            };
            *0x1::vector::borrow_mut<address>(0x2::bag::borrow_mut<vector<u8>, vector<address>>(&mut arg1.tails_metadata, b"tails_ids"), 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::tails_number(&v0) - 1) = 0x2::object::id_address<0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(&v0);
            *0x1::vector::borrow_mut<u64>(0x2::bag::borrow_mut<vector<u8>, vector<u64>>(&mut arg1.tails_metadata, b"tails_levels"), 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::tails_number(&v0) - 1) = 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::tails_level(&v0);
            let v1 = 0x1::vector::empty<u64>();
            0x1::vector::push_back<u64>(&mut v1, 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::tails_number(&v0));
            let v2 = StakingInfo{
                user        : 0x1::vector::pop_back<address>(&mut arg3),
                tails       : v1,
                profits     : vector[],
                u64_padding : vector[0],
            };
            0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::push_back<StakingInfo>(&mut arg1.staking_infos, v2);
            0x2::object_table::add<address, 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(&mut arg1.tails, 0x2::object::id_address<0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(&v0), v0);
        };
        0x1::vector::destroy_empty<0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(arg2);
    }

    entry fun init_tails_staking_registry(arg0: &0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::Version, arg1: 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::ManagerCap, arg2: 0x2::transfer_policy::TransferPolicy<0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>, arg3: &mut 0x2::tx_context::TxContext) {
        0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::verify(arg0, arg3);
        let v0 = 0x2::bag::new(arg3);
        let v1 = 0x2::table::new<u64, 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::BigVector>(arg3);
        let v2 = 1;
        while (v2 <= 7) {
            0x2::table::add<u64, 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::BigVector>(&mut v1, v2, 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::new<vector<u8>>(1111, arg3));
            v2 = v2 + 1;
        };
        0x2::bag::add<vector<u8>, 0x2::table::Table<u64, 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::BigVector>>(&mut v0, b"tails_ipfs_urls", v1);
        0x2::bag::add<vector<u8>, vector<address>>(&mut v0, b"tails_ids", vector[]);
        0x2::bag::add<vector<u8>, vector<u64>>(&mut v0, b"tails_levels", vector[]);
        0x2::bag::add<vector<u8>, 0x2::table::Table<u64, vector<u8>>>(&mut v0, b"tails_webp_images", 0x2::table::new<u64, vector<u8>>(arg3));
        let v3 = TailsStakingRegistry{
            id                : 0x2::object::new(arg3),
            config            : vector[5, 50000000, 10000000, 10, 50000000, 10000000000],
            tails_manager_cap : arg1,
            tails             : 0x2::object_table::new<address, 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(arg3),
            tails_metadata    : v0,
            staking_infos     : 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::new<StakingInfo>(1000, arg3),
            profit_assets     : 0x1::vector::empty<0x1::type_name::TypeName>(),
            transfer_policy   : arg2,
        };
        0x2::transfer::share_object<TailsStakingRegistry>(v3);
    }

    entry fun level_up(arg0: &0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::Version, arg1: &mut TailsStakingRegistry, arg2: address, arg3: bool) {
        0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::version_check(arg0);
        if (!0x2::object_table::contains<address, 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(&arg1.tails, arg2)) {
            abort 7
        };
        let v0 = 0x2::object_table::borrow_mut<address, 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(&mut arg1.tails, arg2);
        let v1 = 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::level_up(&arg1.tails_manager_cap, v0);
        if (0x1::option::is_none<u64>(&v1)) {
            abort 2
        };
        let v2 = 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::tails_number(v0);
        let v3 = 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::tails_level(v0);
        if (arg3) {
            0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::update_image_url(&arg1.tails_manager_cap, v0, *0x2::table::borrow<u64, vector<u8>>(0x2::bag::borrow<vector<u8>, 0x2::table::Table<u64, vector<u8>>>(&arg1.tails_metadata, b"tails_webp_images"), v3 * 10000 + v2));
        } else {
            0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::update_image_url(&arg1.tails_manager_cap, v0, *0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::borrow<vector<u8>>(0x2::table::borrow<u64, 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::BigVector>(0x2::bag::borrow<vector<u8>, 0x2::table::Table<u64, 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::BigVector>>(&arg1.tails_metadata, b"tails_ipfs_urls"), v3), v2 - 1));
        };
        *0x1::vector::borrow_mut<u64>(0x2::bag::borrow_mut<vector<u8>, vector<u64>>(&mut arg1.tails_metadata, b"tails_levels"), v2 - 1) = v3;
        let v4 = 0x1::vector::empty<u64>();
        let v5 = &mut v4;
        0x1::vector::push_back<u64>(v5, v2);
        0x1::vector::push_back<u64>(v5, v3);
        let v6 = LevelUpEvent{
            tails       : 0x2::object::id_address<0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(v0),
            log         : v4,
            bcs_padding : vector[],
        };
        0x2::event::emit<LevelUpEvent>(v6);
    }

    public fun public_exp_down(arg0: &0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::ManagerCap, arg1: &0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::Version, arg2: &mut TailsStakingRegistry, arg3: address, arg4: u64) {
        0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::version_check(arg1);
        if (!0x2::object_table::contains<address, 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(&arg2.tails, arg3)) {
            abort 7
        };
        let v0 = 0x2::object_table::borrow_mut<address, 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(&mut arg2.tails, arg3);
        0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::nft_exp_down(&arg2.tails_manager_cap, v0, arg4);
        let v1 = 0x2::object::id_address<0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(v0);
        let v2 = 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::tails_number(v0);
        let v3 = 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::tails_level(v0);
        let v4 = 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::level_up(&arg2.tails_manager_cap, v0);
        if (0x1::option::is_some<u64>(&v4)) {
            0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::update_image_url(&arg2.tails_manager_cap, v0, *0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::borrow<vector<u8>>(0x2::table::borrow<u64, 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::BigVector>(0x2::bag::borrow<vector<u8>, 0x2::table::Table<u64, 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::BigVector>>(&arg2.tails_metadata, b"tails_ipfs_urls"), v3), v2 - 1));
        };
        *0x1::vector::borrow_mut<u64>(0x2::bag::borrow_mut<vector<u8>, vector<u64>>(&mut arg2.tails_metadata, b"tails_levels"), v2 - 1) = v3;
        let v5 = 0x1::vector::empty<u64>();
        let v6 = &mut v5;
        0x1::vector::push_back<u64>(v6, v2);
        0x1::vector::push_back<u64>(v6, arg4);
        let v7 = ExpDownEvent{
            tails       : v1,
            log         : v5,
            bcs_padding : vector[],
        };
        0x2::event::emit<ExpDownEvent>(v7);
    }

    public fun public_exp_down_without_staking(arg0: &0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::ManagerCap, arg1: &0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::Version, arg2: &TailsStakingRegistry, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: address, arg6: u64) {
        0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::version_check(arg1);
        let v0 = 0x2::kiosk::borrow_mut<0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(arg3, arg4, 0x2::object::id_from_address(arg5));
        0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::nft_exp_down(&arg2.tails_manager_cap, v0, arg6);
        let v1 = 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::tails_number(v0);
        let v2 = 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::level_up(&arg2.tails_manager_cap, v0);
        if (0x1::option::is_some<u64>(&v2)) {
            0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::update_image_url(&arg2.tails_manager_cap, v0, *0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::borrow<vector<u8>>(0x2::table::borrow<u64, 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::BigVector>(0x2::bag::borrow<vector<u8>, 0x2::table::Table<u64, 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::BigVector>>(&arg2.tails_metadata, b"tails_ipfs_urls"), 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::tails_level(v0)), v1 - 1));
        };
        let v3 = 0x1::vector::empty<u64>();
        let v4 = &mut v3;
        0x1::vector::push_back<u64>(v4, v1);
        0x1::vector::push_back<u64>(v4, arg6);
        let v5 = ExpDownEvent{
            tails       : 0x2::object::id_address<0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(v0),
            log         : v3,
            bcs_padding : vector[],
        };
        0x2::event::emit<ExpDownEvent>(v5);
    }

    public fun public_exp_up(arg0: &0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::ManagerCap, arg1: &0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::Version, arg2: &mut TailsStakingRegistry, arg3: address, arg4: u64) {
        0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::version_check(arg1);
        if (!0x2::object_table::contains<address, 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(&arg2.tails, arg3)) {
            abort 7
        };
        let v0 = 0x2::object_table::borrow_mut<address, 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(&mut arg2.tails, arg3);
        0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::nft_exp_up(&arg2.tails_manager_cap, v0, arg4);
        let v1 = 0x1::vector::empty<u64>();
        let v2 = &mut v1;
        0x1::vector::push_back<u64>(v2, 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::tails_number(v0));
        0x1::vector::push_back<u64>(v2, arg4);
        let v3 = ExpUpEvent{
            tails       : 0x2::object::id_address<0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(v0),
            log         : v1,
            bcs_padding : vector[],
        };
        0x2::event::emit<ExpUpEvent>(v3);
    }

    public fun public_exp_up_without_staking(arg0: &0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::ManagerCap, arg1: &0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::Version, arg2: &TailsStakingRegistry, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: address, arg6: u64) {
        0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::version_check(arg1);
        let v0 = 0x2::kiosk::borrow_mut<0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(arg3, arg4, 0x2::object::id_from_address(arg5));
        0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::nft_exp_up(&arg2.tails_manager_cap, v0, arg6);
        let v1 = 0x1::vector::empty<u64>();
        let v2 = &mut v1;
        0x1::vector::push_back<u64>(v2, 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::tails_number(v0));
        0x1::vector::push_back<u64>(v2, arg6);
        let v3 = ExpUpEvent{
            tails       : 0x2::object::id_address<0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(v0),
            log         : v1,
            bcs_padding : vector[],
        };
        0x2::event::emit<ExpUpEvent>(v3);
    }

    entry fun remove_ipfs_urls(arg0: &0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::Version, arg1: &mut TailsStakingRegistry, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::verify(arg0, arg3);
        let v0 = 0x2::bag::borrow_mut<vector<u8>, 0x2::table::Table<u64, 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::BigVector>>(&mut arg1.tails_metadata, b"tails_ipfs_urls");
        0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::drop<vector<u8>>(0x2::table::remove<u64, 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::BigVector>(v0, arg2));
        0x2::table::add<u64, 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::BigVector>(v0, arg2, 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::new<vector<u8>>(1111, arg3));
    }

    entry fun remove_profit_sharing<T0>(arg0: &0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::Version, arg1: &mut TailsStakingRegistry, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::verify(arg0, arg3);
        let v0 = 0x1::type_name::get<T0>();
        let (v1, v2) = 0x1::vector::index_of<0x1::type_name::TypeName>(&arg1.profit_assets, &v0);
        if (!v1) {
            abort 5
        };
        0x1::vector::swap_remove<0x1::type_name::TypeName>(&mut arg1.profit_assets, v2);
        let v3 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::length(&arg1.staking_infos);
        let v4 = (0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::slice_size(&arg1.staking_infos) as u64);
        let v5 = 0;
        let v6 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::borrow_slice_mut<StakingInfo>(&mut arg1.staking_infos, v5);
        let v7 = v6;
        let v8 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::get_slice_length<StakingInfo>(v6);
        let v9 = 0;
        while (v9 < v3) {
            0x1::vector::swap_remove<u64>(&mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::borrow_from_slice_mut<StakingInfo>(v7, v9 % v4).profits, v2);
            if (v9 + 1 < v3 && v9 + 1 == v5 * v4 + v8) {
                let v10 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::get_slice_idx<StakingInfo>(v7) + 1;
                v5 = v10;
                let v11 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::borrow_slice_mut<StakingInfo>(&mut arg1.staking_infos, v10);
                v7 = v11;
                v8 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::get_slice_length<StakingInfo>(v11);
            };
            v9 = v9 + 1;
        };
        let v12 = 0x2::dynamic_field::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.id, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v12, arg3), arg2);
        let v13 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v13, 0x2::balance::value<T0>(&v12));
        let v14 = RemoveProfitSharingEvent{
            token       : v0,
            log         : v13,
            bcs_padding : vector[],
        };
        0x2::event::emit<RemoveProfitSharingEvent>(v14);
    }

    entry fun remove_webp_bytes(arg0: &0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::Version, arg1: &mut TailsStakingRegistry, arg2: u64, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::verify(arg0, arg4);
        0x2::table::remove<u64, vector<u8>>(0x2::bag::borrow_mut<vector<u8>, 0x2::table::Table<u64, vector<u8>>>(&mut arg1.tails_metadata, b"tails_webp_images"), arg3 * 10000 + arg2);
    }

    entry fun set_profit_sharing<T0, T1>(arg0: &0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::Version, arg1: &mut TailsStakingRegistry, arg2: vector<u64>, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: u64, arg6: &0x2::tx_context::TxContext) {
        0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::verify(arg0, arg6);
        let v0 = vector[0, 0, 0, 0, 0, 0, 0];
        let v1 = 0;
        let v2 = 0x1::type_name::get<T0>();
        let (v3, v4) = 0x1::vector::index_of<0x1::type_name::TypeName>(&arg1.profit_assets, &v2);
        let v5 = 0x2::bag::borrow<vector<u8>, vector<u64>>(&arg1.tails_metadata, b"tails_levels");
        let v6 = (0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::slice_size(&arg1.staking_infos) as u64);
        let v7 = 0;
        let v8 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::borrow_slice_mut<StakingInfo>(&mut arg1.staking_infos, v7);
        let v9 = v8;
        let v10 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::get_slice_length<StakingInfo>(v8);
        let v11 = 0;
        while (v11 < 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::length(&arg1.staking_infos)) {
            let v12 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::borrow_from_slice_mut<StakingInfo>(v9, v11 % v6);
            let v13 = 0;
            let v14 = 0;
            let v15 = 0x1::vector::length<u64>(&v12.tails);
            while (v14 < v15) {
                let v16 = *0x1::vector::borrow<u64>(v5, *0x1::vector::borrow<u64>(&v12.tails, v14) - 1);
                v13 = v13 + *0x1::vector::borrow<u64>(&arg2, v16 - 1);
                *0x1::vector::borrow_mut<u64>(&mut v0, v16 - 1) = *0x1::vector::borrow<u64>(&v0, v16 - 1) + 1;
                v14 = v14 + 1;
            };
            0x1::vector::push_back<u64>(&mut v12.profits, v13);
            if (v3) {
                0x1::vector::swap_remove<u64>(&mut v12.profits, v4);
            };
            v1 = v1 + v13;
            if (v11 + 1 < v15 && v11 + 1 == v7 * v6 + v10) {
                let v17 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::get_slice_idx<StakingInfo>(v9) + 1;
                v7 = v17;
                let v18 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::borrow_slice_mut<StakingInfo>(&mut arg1.staking_infos, v17);
                v9 = v18;
                v10 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::get_slice_length<StakingInfo>(v18);
            };
            v11 = v11 + 1;
        };
        if (!v3) {
            0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg1.profit_assets, v2);
            if (!0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg1.id, v2)) {
                0x2::dynamic_field::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.id, v2, 0x2::balance::zero<T0>());
            };
        };
        let v19 = 0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.id, v2);
        0x2::balance::join<T0>(v19, 0x2::coin::into_balance<T0>(arg3));
        assert!(0x2::balance::value<T0>(v19) >= v1, 1);
        assert!(0x2::balance::value<T0>(v19) == v1, 4);
        let v20 = 0x1::vector::empty<u64>();
        let v21 = &mut v20;
        0x1::vector::push_back<u64>(v21, v1);
        0x1::vector::push_back<u64>(v21, 0x2::coin::value<T0>(&arg3));
        0x1::vector::push_back<u64>(v21, arg4);
        0x1::vector::push_back<u64>(v21, arg5);
        let v22 = 0x1::type_name::get<T1>();
        let v23 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v23, 0x1::bcs::to_bytes<0x1::type_name::TypeName>(&v22));
        let v24 = SetProfitSharingEvent{
            token         : v2,
            level_profits : arg2,
            level_counts  : v0,
            log           : v20,
            bcs_padding   : v23,
        };
        0x2::event::emit<SetProfitSharingEvent>(v24);
    }

    public fun stake_tails(arg0: &mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::Version, arg1: &mut TailsStakingRegistry, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: address, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &mut 0x2::tx_context::TxContext) {
        0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::version_check(arg0);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg5) == *0x1::vector::borrow<u64>(&arg1.config, 1), 3);
        0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::charge_fee<0x2::sui::SUI>(arg0, 0x2::coin::into_balance<0x2::sui::SUI>(arg5));
        0x2::kiosk::list<0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(arg2, arg3, 0x2::object::id_from_address(arg4), 0);
        let (v0, v1) = 0x2::kiosk::purchase<0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(arg2, 0x2::object::id_from_address(arg4), 0x2::coin::zero<0x2::sui::SUI>(arg6));
        let v2 = v0;
        let (_, _, _) = 0x2::transfer_policy::confirm_request<0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(&arg1.transfer_policy, v1);
        stake_tails_(arg1, v2, 0x2::tx_context::sender(arg6));
        let v6 = 0x1::vector::empty<u64>();
        let v7 = &mut v6;
        0x1::vector::push_back<u64>(v7, 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::tails_number(&v2));
        0x1::vector::push_back<u64>(v7, 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::tails_level(&v2));
        let v8 = StakeTailsEvent{
            tails       : 0x2::object::id_address<0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(&v2),
            log         : v6,
            bcs_padding : vector[],
        };
        0x2::event::emit<StakeTailsEvent>(v8);
    }

    fun stake_tails_(arg0: &mut TailsStakingRegistry, arg1: 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails, arg2: address) {
        *0x1::vector::borrow_mut<address>(0x2::bag::borrow_mut<vector<u8>, vector<address>>(&mut arg0.tails_metadata, b"tails_ids"), 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::tails_number(&arg1) - 1) = 0x2::object::id_address<0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(&arg1);
        *0x1::vector::borrow_mut<u64>(0x2::bag::borrow_mut<vector<u8>, vector<u64>>(&mut arg0.tails_metadata, b"tails_levels"), 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::tails_number(&arg1) - 1) = 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::tails_level(&arg1);
        let v0 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::length(&arg0.staking_infos);
        let v1 = (0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::slice_size(&arg0.staking_infos) as u64);
        let v2 = 0;
        let v3 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::borrow_slice<StakingInfo>(&arg0.staking_infos, v2);
        let v4 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::get_slice_length<StakingInfo>(v3);
        let v5 = 0;
        while (v5 < v0) {
            if (0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::borrow_from_slice<StakingInfo>(v3, v5 % v1).user == arg2) {
                break
            };
            if (v5 + 1 < v0 && v5 + 1 == v2 * v1 + v4) {
                let v6 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::get_slice_idx<StakingInfo>(v3) + 1;
                v2 = v6;
                let v7 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::borrow_slice<StakingInfo>(&arg0.staking_infos, v6);
                v3 = v7;
                v4 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::get_slice_length<StakingInfo>(v7);
            };
            v5 = v5 + 1;
        };
        if (v5 == v0) {
            let v8 = vector[];
            0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::utility::pad_u64_vector(&mut v8, 0x1::vector::length<0x1::type_name::TypeName>(&arg0.profit_assets) - 1);
            let v9 = StakingInfo{
                user        : arg2,
                tails       : vector[],
                profits     : v8,
                u64_padding : vector[0],
            };
            0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::push_back<StakingInfo>(&mut arg0.staking_infos, v9);
        };
        let v10 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::borrow_mut<StakingInfo>(&mut arg0.staking_infos, v5);
        assert!(0x1::vector::length<u64>(&v10.tails) < *0x1::vector::borrow<u64>(&arg0.config, 0), 6);
        0x1::vector::push_back<u64>(&mut v10.tails, 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::tails_number(&arg1));
        if (0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::contains_u64_padding(&arg0.tails_manager_cap, &arg1, 0x1::string::utf8(b"updating_url"))) {
            0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::remove_u64_padding(&arg0.tails_manager_cap, &mut arg1, 0x1::string::utf8(b"updating_url"));
        };
        if (0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::contains_u64_padding(&arg0.tails_manager_cap, &arg1, 0x1::string::utf8(b"attendance_ms"))) {
            0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::remove_u64_padding(&arg0.tails_manager_cap, &mut arg1, 0x1::string::utf8(b"attendance_ms"));
        };
        if (0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::contains_u64_padding(&arg0.tails_manager_cap, &arg1, 0x1::string::utf8(b"snapshot_ms"))) {
            0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::remove_u64_padding(&arg0.tails_manager_cap, &mut arg1, 0x1::string::utf8(b"snapshot_ms"));
        };
        if (0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::contains_u64_padding(&arg0.tails_manager_cap, &arg1, 0x1::string::utf8(b"usd_in_deposit"))) {
            0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::remove_u64_padding(&arg0.tails_manager_cap, &mut arg1, 0x1::string::utf8(b"usd_in_deposit"));
        };
        if (0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::contains_u64_padding(&arg0.tails_manager_cap, &arg1, 0x1::string::utf8(b"dice_profit"))) {
            0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::remove_u64_padding(&arg0.tails_manager_cap, &mut arg1, 0x1::string::utf8(b"dice_profit"));
        };
        if (0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::contains_u64_padding(&arg0.tails_manager_cap, &arg1, 0x1::string::utf8(b"exp_profit"))) {
            0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::remove_u64_padding(&arg0.tails_manager_cap, &mut arg1, 0x1::string::utf8(b"exp_profit"));
        };
        0x2::object_table::add<address, 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(&mut arg0.tails, 0x2::object::id_address<0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(&arg1), arg1);
    }

    public fun transfer_tails(arg0: &mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::Version, arg1: &TailsStakingRegistry, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: address, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: address, arg7: &mut 0x2::tx_context::TxContext) {
        0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::version_check(arg0);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg5) == *0x1::vector::borrow<u64>(&arg1.config, 2), 3);
        0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::charge_fee<0x2::sui::SUI>(arg0, 0x2::coin::into_balance<0x2::sui::SUI>(arg5));
        0x2::kiosk::list<0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(arg2, arg3, 0x2::object::id_from_address(arg4), 0);
        let (v0, v1) = 0x2::kiosk::purchase<0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(arg2, 0x2::object::id_from_address(arg4), 0x2::coin::zero<0x2::sui::SUI>(arg7));
        let v2 = v0;
        let (_, _, _) = 0x2::transfer_policy::confirm_request<0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(&arg1.transfer_policy, v1);
        let (v6, v7) = 0x2::kiosk::new(arg7);
        let v8 = v7;
        let v9 = v6;
        0x2::kiosk::lock<0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(&mut v9, &v8, &arg1.transfer_policy, v2);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v9);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v8, arg6);
        let v10 = 0x1::vector::empty<u64>();
        let v11 = &mut v10;
        0x1::vector::push_back<u64>(v11, 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::tails_number(&v2));
        0x1::vector::push_back<u64>(v11, 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::tails_level(&v2));
        let v12 = TransferTailsEvent{
            tails       : 0x2::object::id_address<0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(&v2),
            recipient   : arg6,
            log         : v10,
            bcs_padding : vector[],
        };
        0x2::event::emit<TransferTailsEvent>(v12);
    }

    public fun unstake_tails(arg0: &mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::Version, arg1: &mut TailsStakingRegistry, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: address, arg5: &0x2::tx_context::TxContext) {
        0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::version_check(arg0);
        let v0 = unstake_tails_(arg1, arg4, 0x2::tx_context::sender(arg5));
        0x2::kiosk::lock<0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(arg2, arg3, &arg1.transfer_policy, v0);
        let v1 = 0x1::vector::empty<u64>();
        let v2 = &mut v1;
        0x1::vector::push_back<u64>(v2, 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::tails_number(&v0));
        0x1::vector::push_back<u64>(v2, 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::tails_level(&v0));
        let v3 = UnstakeTailsEvent{
            tails       : 0x2::object::id_address<0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(&v0),
            log         : v1,
            bcs_padding : vector[],
        };
        0x2::event::emit<UnstakeTailsEvent>(v3);
    }

    fun unstake_tails_(arg0: &mut TailsStakingRegistry, arg1: address, arg2: address) : 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails {
        let v0 = 0x2::bag::borrow<vector<u8>, vector<address>>(&arg0.tails_metadata, b"tails_ids");
        let v1 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::length(&arg0.staking_infos);
        let v2 = (0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::slice_size(&arg0.staking_infos) as u64);
        let v3 = 0;
        let v4 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::borrow_slice_mut<StakingInfo>(&mut arg0.staking_infos, v3);
        let v5 = v4;
        let v6 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::get_slice_length<StakingInfo>(v4);
        let v7 = 0;
        while (v7 < v1) {
            let v8 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::borrow_from_slice_mut<StakingInfo>(v5, v7 % v2);
            if (v8.user == arg2) {
                let v9 = 0;
                loop {
                    while (v9 < 0x1::vector::length<u64>(&v8.tails)) {
                        if (*0x1::vector::borrow<address>(v0, *0x1::vector::borrow<u64>(&v8.tails, v9) - 1) == arg1) {
                            0x1::vector::remove<u64>(&mut v8.tails, v9);
                            if (0x1::vector::is_empty<u64>(&v8.tails)) {
                                0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::swap_remove<StakingInfo>(&mut arg0.staking_infos, v7);
                            };
                            return 0x2::object_table::remove<address, 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(&mut arg0.tails, arg1)
                        };
                        v9 = v9 + 1;
                    };
                    break
                };
            } else {
                if (v7 + 1 < v1 && v7 + 1 == v3 * v2 + v6) {
                    let v10 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::get_slice_idx<StakingInfo>(v5) + 1;
                    v3 = v10;
                    let v11 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::borrow_slice_mut<StakingInfo>(&mut arg0.staking_infos, v10);
                    v5 = v11;
                    v6 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::get_slice_length<StakingInfo>(v11);
                };
                v7 = v7 + 1;
            };
        };
        abort 7
    }

    entry fun update_tails_staking_registry_config(arg0: &0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::Version, arg1: &mut TailsStakingRegistry, arg2: u64, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::verify(arg0, arg4);
        while (0x1::vector::length<u64>(&arg1.config) < arg2 + 1) {
            0x1::vector::push_back<u64>(&mut arg1.config, 0);
        };
        let v0 = 0x1::vector::empty<u64>();
        let v1 = &mut v0;
        0x1::vector::push_back<u64>(v1, *0x1::vector::borrow<u64>(&arg1.config, arg2));
        0x1::vector::push_back<u64>(v1, arg3);
        let v2 = UpdateTailsStakingRegistryConfigEvent{
            index       : arg2,
            log         : v0,
            bcs_padding : vector[],
        };
        0x2::event::emit<UpdateTailsStakingRegistryConfigEvent>(v2);
        *0x1::vector::borrow_mut<u64>(&mut arg1.config, arg2) = arg3;
    }

    entry fun upload_ids(arg0: &0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::Version, arg1: &mut TailsStakingRegistry, arg2: &0x2::tx_context::TxContext) {
        0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::verify(arg0, arg2);
        let v0 = 6666;
        let v1 = 0x2::bag::borrow_mut<vector<u8>, vector<address>>(&mut arg1.tails_metadata, b"tails_ids");
        while (v0 > 0) {
            0x1::vector::push_back<address>(v1, @0x0);
            v0 = v0 - 1;
        };
    }

    entry fun upload_ipfs_urls(arg0: &0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::Version, arg1: &mut TailsStakingRegistry, arg2: u64, arg3: vector<vector<u8>>, arg4: &0x2::tx_context::TxContext) {
        0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::verify(arg0, arg4);
        let v0 = 0x2::table::borrow_mut<u64, 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::BigVector>(0x2::bag::borrow_mut<vector<u8>, 0x2::table::Table<u64, 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::BigVector>>(&mut arg1.tails_metadata, b"tails_ipfs_urls"), arg2);
        while (!0x1::vector::is_empty<vector<u8>>(&arg3)) {
            0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::push_back<vector<u8>>(v0, 0x1::vector::pop_back<vector<u8>>(&mut arg3));
        };
    }

    entry fun upload_levels(arg0: &0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::Version, arg1: &mut TailsStakingRegistry, arg2: &0x2::tx_context::TxContext) {
        0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::verify(arg0, arg2);
        let v0 = 6666;
        let v1 = 0x2::bag::borrow_mut<vector<u8>, vector<u64>>(&mut arg1.tails_metadata, b"tails_levels");
        while (v0 > 0) {
            0x1::vector::push_back<u64>(v1, 0);
            v0 = v0 - 1;
        };
    }

    entry fun upload_webp_bytes(arg0: &0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::Version, arg1: &mut TailsStakingRegistry, arg2: u64, arg3: u64, arg4: vector<u8>, arg5: &0x2::tx_context::TxContext) {
        0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::verify(arg0, arg5);
        let v0 = 0x2::bag::borrow_mut<vector<u8>, 0x2::table::Table<u64, vector<u8>>>(&mut arg1.tails_metadata, b"tails_webp_images");
        if (!0x2::table::contains<u64, vector<u8>>(v0, arg3 * 10000 + arg2)) {
            0x2::table::add<u64, vector<u8>>(v0, arg3 * 10000 + arg2, arg4);
        } else {
            let v1 = 0x2::table::borrow_mut<u64, vector<u8>>(v0, arg3 * 10000 + arg2);
            while (!0x1::vector::is_empty<u8>(&arg4)) {
                0x1::vector::push_back<u8>(v1, 0x1::vector::pop_back<u8>(&mut arg4));
            };
        };
    }

    public fun verify_staking_identity(arg0: &0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::Version, arg1: &TailsStakingRegistry, arg2: address, arg3: u64) : bool {
        0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::version_check(arg0);
        if (arg3 == 0) {
            return true
        };
        let v0 = 0x2::bag::borrow<vector<u8>, vector<u64>>(&arg1.tails_metadata, b"tails_levels");
        let v1 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::length(&arg1.staking_infos);
        let v2 = (0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::slice_size(&arg1.staking_infos) as u64);
        let v3 = 0;
        let v4 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::borrow_slice<StakingInfo>(&arg1.staking_infos, v3);
        let v5 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::get_slice_length<StakingInfo>(v4);
        let v6 = 0;
        while (v6 < v1) {
            let v7 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::borrow_from_slice<StakingInfo>(v4, v6 % v2);
            if (v7.user == arg2) {
                let v8 = 0;
                while (v8 < 0x1::vector::length<u64>(&v7.tails)) {
                    if (*0x1::vector::borrow<u64>(v0, *0x1::vector::borrow<u64>(&v7.tails, v8) - 1) >= arg3) {
                        return true
                    };
                    v8 = v8 + 1;
                };
                return false
            };
            if (v6 + 1 < v1 && v6 + 1 == v3 * v2 + v5) {
                let v9 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::get_slice_idx<StakingInfo>(v4) + 1;
                v3 = v9;
                let v10 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::borrow_slice<StakingInfo>(&arg1.staking_infos, v9);
                v4 = v10;
                v5 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::get_slice_length<StakingInfo>(v10);
            };
            v6 = v6 + 1;
        };
        false
    }

    // decompiled from Move bytecode v6
}

