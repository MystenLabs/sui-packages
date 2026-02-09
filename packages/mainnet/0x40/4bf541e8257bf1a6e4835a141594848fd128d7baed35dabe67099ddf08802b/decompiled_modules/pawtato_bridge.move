module 0x404bf541e8257bf1a6e4835a141594848fd128d7baed35dabe67099ddf08802b::pawtato_bridge {
    struct DepositEvent has copy, drop {
        nft_id: 0x2::object::ID,
        depositor: address,
        depositor_id: u64,
        nft_type: 0x1::string::String,
    }

    struct WithdrawEvent has copy, drop {
        nft_id: 0x2::object::ID,
        recipient: address,
        nft_type: 0x1::string::String,
    }

    struct WithdrawInitEvent has copy, drop {
        nft_id: 0x2::object::ID,
        recipient: address,
        secret: 0x1::string::String,
        cooldown_ts: u64,
        nft_type: 0x1::string::String,
    }

    struct WithdrawCancelEvent has copy, drop {
        nft_id: 0x2::object::ID,
        nft_type: 0x1::string::String,
    }

    struct PAWTATO_BRIDGE has drop {
        dummy_field: bool,
    }

    struct PawtatoBridgeCap has store, key {
        id: 0x2::object::UID,
    }

    struct NftInfo has copy, drop, store {
        depositor: address,
        deposited_at: u64,
        depositor_id: u64,
        nft_type: 0x1::string::String,
        wd_cooldown_ts: u64,
        wd_recipient: address,
        wd_secret: 0x1::string::String,
        config: vector<u64>,
    }

    struct PawtatoBridgeRegistry has key {
        id: 0x2::object::UID,
        version: u64,
        paused: bool,
        kiosk: 0x2::kiosk::Kiosk,
        kiosk_cap: 0x2::kiosk::KioskOwnerCap,
        nft_info: 0x2::table::Table<0x2::object::ID, NftInfo>,
        total_deposits: u64,
        total_withdrawals: u64,
        total_held: u64,
    }

    fun assert_active(arg0: &PawtatoBridgeRegistry) {
        assert!(!arg0.paused, 1);
        assert!(arg0.version == 1, 2);
    }

    public entry fun cancel_withdraw(arg0: &0xc3dc70c7ca20eaf2e1c52826cf5b9fb2712e34a1d6f3de5f4dfb727c32d62c36::pawtato_admin::BridgeWithdrawCap, arg1: &mut PawtatoBridgeRegistry, arg2: 0x2::object::ID) {
        assert_active(arg1);
        assert!(0x2::table::contains<0x2::object::ID, NftInfo>(&arg1.nft_info, arg2), 3);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, NftInfo>(&mut arg1.nft_info, arg2);
        assert!(v0.wd_cooldown_ts != 0, 5);
        v0.wd_cooldown_ts = 0;
        v0.wd_recipient = @0x0;
        v0.wd_secret = 0x1::string::utf8(b"");
        let v1 = WithdrawCancelEvent{
            nft_id   : arg2,
            nft_type : v0.nft_type,
        };
        0x2::event::emit<WithdrawCancelEvent>(v1);
    }

    fun deposit<T0: store + key>(arg0: &mut PawtatoBridgeRegistry, arg1: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: u64, arg6: &0x2::clock::Clock, arg7: &0x7c369055372dc2ca64563911d51fc7e5ff8e162a8a6c5be3301b3831d21917ca::table_allowlist_rule::AllowlistRegistry, arg8: &mut 0x2::tx_context::TxContext) {
        assert_active(arg0);
        assert!(0x2::kiosk::has_access(arg2, arg3), 4);
        let v0 = &mut arg0.kiosk;
        transfer_nft_between_kiosks<T0>(arg2, arg3, v0, &arg0.kiosk_cap, arg1, arg4, arg7, arg8);
        let v1 = 0x2::tx_context::sender(arg8);
        let v2 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()));
        let v3 = NftInfo{
            depositor      : v1,
            deposited_at   : 0x2::clock::timestamp_ms(arg6),
            depositor_id   : arg5,
            nft_type       : v2,
            wd_cooldown_ts : 0,
            wd_recipient   : @0x0,
            wd_secret      : 0x1::string::utf8(b""),
            config         : 0x1::vector::empty<u64>(),
        };
        0x2::table::add<0x2::object::ID, NftInfo>(&mut arg0.nft_info, arg4, v3);
        arg0.total_deposits = arg0.total_deposits + 1;
        arg0.total_held = arg0.total_held + 1;
        let v4 = DepositEvent{
            nft_id       : arg4,
            depositor    : v1,
            depositor_id : arg5,
            nft_type     : v2,
        };
        0x2::event::emit<DepositEvent>(v4);
    }

    public entry fun deposit_hero(arg0: &mut PawtatoBridgeRegistry, arg1: &mut 0x2::transfer_policy::TransferPolicy<0xe0fa7b75a3dc8137b38bceb0c0c21c10e0f57c408fe9068694f58fd21e071925::pawtato_heroes::HERO>, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: u64, arg6: &0x2::clock::Clock, arg7: &0x7c369055372dc2ca64563911d51fc7e5ff8e162a8a6c5be3301b3831d21917ca::table_allowlist_rule::AllowlistRegistry, arg8: &mut 0x2::tx_context::TxContext) {
        deposit<0xe0fa7b75a3dc8137b38bceb0c0c21c10e0f57c408fe9068694f58fd21e071925::pawtato_heroes::HERO>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    public entry fun deposit_land(arg0: &mut PawtatoBridgeRegistry, arg1: &mut 0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato::LAND>, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: u64, arg6: &0x2::clock::Clock, arg7: &0x7c369055372dc2ca64563911d51fc7e5ff8e162a8a6c5be3301b3831d21917ca::table_allowlist_rule::AllowlistRegistry, arg8: &mut 0x2::tx_context::TxContext) {
        deposit<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato::LAND>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    fun init(arg0: PAWTATO_BRIDGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::new(arg1);
        let v2 = PawtatoBridgeRegistry{
            id                : 0x2::object::new(arg1),
            version           : 1,
            paused            : false,
            kiosk             : v0,
            kiosk_cap         : v1,
            nft_info          : 0x2::table::new<0x2::object::ID, NftInfo>(arg1),
            total_deposits    : 0,
            total_withdrawals : 0,
            total_held        : 0,
        };
        let v3 = PawtatoBridgeCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<PAWTATO_BRIDGE>(arg0, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::transfer<PawtatoBridgeCap>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<PawtatoBridgeRegistry>(v2);
    }

    public entry fun init_withdraw(arg0: &0xc3dc70c7ca20eaf2e1c52826cf5b9fb2712e34a1d6f3de5f4dfb727c32d62c36::pawtato_admin::BridgeWithdrawCap, arg1: &mut PawtatoBridgeRegistry, arg2: 0x2::object::ID, arg3: address, arg4: 0x1::string::String, arg5: &0x2::clock::Clock) {
        assert_active(arg1);
        assert!(0x2::table::contains<0x2::object::ID, NftInfo>(&arg1.nft_info, arg2), 3);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, NftInfo>(&mut arg1.nft_info, arg2);
        assert!(v0.wd_cooldown_ts == 0, 8);
        let v1 = 0x2::clock::timestamp_ms(arg5) + 259200000;
        v0.wd_cooldown_ts = v1;
        v0.wd_recipient = arg3;
        v0.wd_secret = arg4;
        let v2 = WithdrawInitEvent{
            nft_id      : arg2,
            recipient   : arg3,
            secret      : arg4,
            cooldown_ts : v1,
            nft_type    : v0.nft_type,
        };
        0x2::event::emit<WithdrawInitEvent>(v2);
    }

    public entry fun migrate_heroes_from_staking(arg0: &PawtatoBridgeCap, arg1: &0xe0fa7b75a3dc8137b38bceb0c0c21c10e0f57c408fe9068694f58fd21e071925::pawtato_heroes::HeroAdminCap, arg2: &mut PawtatoBridgeRegistry, arg3: &mut 0xe0fa7b75a3dc8137b38bceb0c0c21c10e0f57c408fe9068694f58fd21e071925::pawtato_hero_staking::HeroStakingPool, arg4: &mut 0x2::transfer_policy::TransferPolicy<0xe0fa7b75a3dc8137b38bceb0c0c21c10e0f57c408fe9068694f58fd21e071925::pawtato_heroes::HERO>, arg5: address, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert_active(arg2);
        let v0 = 0xe0fa7b75a3dc8137b38bceb0c0c21c10e0f57c408fe9068694f58fd21e071925::pawtato_hero_staking::migrate_user_heroes_to_kiosk(arg1, arg3, &mut arg2.kiosk, &arg2.kiosk_cap, arg4, arg5, arg8);
        let v1 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_defining_ids<0xe0fa7b75a3dc8137b38bceb0c0c21c10e0f57c408fe9068694f58fd21e071925::pawtato_heroes::HERO>()));
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x2::object::ID>(&v0)) {
            let v3 = *0x1::vector::borrow<0x2::object::ID>(&v0, v2);
            let v4 = NftInfo{
                depositor      : arg5,
                deposited_at   : 0x2::clock::timestamp_ms(arg7),
                depositor_id   : arg6,
                nft_type       : v1,
                wd_cooldown_ts : 0,
                wd_recipient   : @0x0,
                wd_secret      : 0x1::string::utf8(b""),
                config         : 0x1::vector::empty<u64>(),
            };
            0x2::table::add<0x2::object::ID, NftInfo>(&mut arg2.nft_info, v3, v4);
            arg2.total_deposits = arg2.total_deposits + 1;
            arg2.total_held = arg2.total_held + 1;
            let v5 = DepositEvent{
                nft_id       : v3,
                depositor    : arg5,
                depositor_id : arg6,
                nft_type     : v1,
            };
            0x2::event::emit<DepositEvent>(v5);
            v2 = v2 + 1;
        };
    }

    public entry fun migrate_lands_from_staking(arg0: &0xc3dc70c7ca20eaf2e1c52826cf5b9fb2712e34a1d6f3de5f4dfb727c32d62c36::pawtato_admin::AdminCap, arg1: &mut PawtatoBridgeRegistry, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::StakingPool, arg3: &mut 0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato::LAND>, arg4: &0x7c369055372dc2ca64563911d51fc7e5ff8e162a8a6c5be3301b3831d21917ca::table_allowlist_rule::AllowlistRegistry, arg5: address, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert_active(arg1);
        let v0 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::migrate_user_lands_to_kiosk(arg0, arg2, &mut arg1.kiosk, &arg1.kiosk_cap, arg3, arg4, arg5, arg8);
        let v1 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_defining_ids<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato::LAND>()));
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x2::object::ID>(&v0)) {
            let v3 = *0x1::vector::borrow<0x2::object::ID>(&v0, v2);
            let v4 = NftInfo{
                depositor      : arg5,
                deposited_at   : 0x2::clock::timestamp_ms(arg7),
                depositor_id   : arg6,
                nft_type       : v1,
                wd_cooldown_ts : 0,
                wd_recipient   : @0x0,
                wd_secret      : 0x1::string::utf8(b""),
                config         : 0x1::vector::empty<u64>(),
            };
            0x2::table::add<0x2::object::ID, NftInfo>(&mut arg1.nft_info, v3, v4);
            arg1.total_deposits = arg1.total_deposits + 1;
            arg1.total_held = arg1.total_held + 1;
            let v5 = DepositEvent{
                nft_id       : v3,
                depositor    : arg5,
                depositor_id : arg6,
                nft_type     : v1,
            };
            0x2::event::emit<DepositEvent>(v5);
            v2 = v2 + 1;
        };
    }

    public entry fun pause_bridge(arg0: &0xc3dc70c7ca20eaf2e1c52826cf5b9fb2712e34a1d6f3de5f4dfb727c32d62c36::pawtato_admin::BridgePauseCap, arg1: &mut PawtatoBridgeRegistry) {
        arg1.paused = true;
    }

    public fun set_hero_attributes(arg0: &0xc3dc70c7ca20eaf2e1c52826cf5b9fb2712e34a1d6f3de5f4dfb727c32d62c36::pawtato_admin::NFTUpgradeCap, arg1: &mut PawtatoBridgeRegistry, arg2: &0xe0fa7b75a3dc8137b38bceb0c0c21c10e0f57c408fe9068694f58fd21e071925::pawtato_heroes::HeroCollection, arg3: 0x2::object::ID, arg4: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>) {
        assert_active(arg1);
        assert!(0x2::table::contains<0x2::object::ID, NftInfo>(&arg1.nft_info, arg3), 3);
        0xe0fa7b75a3dc8137b38bceb0c0c21c10e0f57c408fe9068694f58fd21e071925::pawtato_heroes::set_attributes(arg0, arg2, 0x2::kiosk::borrow_mut<0xe0fa7b75a3dc8137b38bceb0c0c21c10e0f57c408fe9068694f58fd21e071925::pawtato_heroes::HERO>(&mut arg1.kiosk, &arg1.kiosk_cap, arg3), arg4);
    }

    public fun set_land_attributes(arg0: &0xc3dc70c7ca20eaf2e1c52826cf5b9fb2712e34a1d6f3de5f4dfb727c32d62c36::pawtato_admin::NFTUpgradeCap, arg1: &mut PawtatoBridgeRegistry, arg2: &0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato::NFTCollection, arg3: 0x2::object::ID, arg4: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>) {
        assert_active(arg1);
        assert!(0x2::table::contains<0x2::object::ID, NftInfo>(&arg1.nft_info, arg3), 3);
        0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato::set_attributes(arg0, arg2, 0x2::kiosk::borrow_mut<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato::LAND>(&mut arg1.kiosk, &arg1.kiosk_cap, arg3), arg4);
    }

    public entry fun set_paused(arg0: &PawtatoBridgeCap, arg1: &mut PawtatoBridgeRegistry, arg2: bool) {
        arg1.paused = arg2;
    }

    fun transfer_nft_between_kiosks<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg5: 0x2::object::ID, arg6: &0x7c369055372dc2ca64563911d51fc7e5ff8e162a8a6c5be3301b3831d21917ca::table_allowlist_rule::AllowlistRegistry, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::purchase_with_cap<T0>(arg0, 0x2::kiosk::list_with_purchase_cap<T0>(arg0, arg1, arg5, 0, arg7), 0x2::coin::zero<0x2::sui::SUI>(arg7));
        let v2 = v1;
        0x2::kiosk::lock<T0>(arg2, arg3, arg4, v0);
        if (0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::Rule>(arg4)) {
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<T0>(&mut v2, arg2);
        };
        if (0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::Rule>(arg4)) {
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<T0>(arg4, &mut v2, 0x2::coin::zero<0x2::sui::SUI>(arg7));
        };
        if (0x2::transfer_policy::has_rule<T0, 0x7c369055372dc2ca64563911d51fc7e5ff8e162a8a6c5be3301b3831d21917ca::table_allowlist_rule::TableAllowlistRule>(arg4)) {
            0x7c369055372dc2ca64563911d51fc7e5ff8e162a8a6c5be3301b3831d21917ca::table_allowlist_rule::resolve<T0>(arg4, &mut v2, arg6);
        };
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg4, v2);
    }

    public entry fun upgrade_version(arg0: &PawtatoBridgeCap, arg1: &mut PawtatoBridgeRegistry) {
        assert!(arg1.version < 1, 2);
        arg1.version = 1;
    }

    public entry fun withdraw<T0: store + key>(arg0: &0xc3dc70c7ca20eaf2e1c52826cf5b9fb2712e34a1d6f3de5f4dfb727c32d62c36::pawtato_admin::BridgeWithdrawCap, arg1: &mut PawtatoBridgeRegistry, arg2: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg3: vector<0x2::object::ID>, arg4: address, arg5: &0x2::clock::Clock, arg6: &0x7c369055372dc2ca64563911d51fc7e5ff8e162a8a6c5be3301b3831d21917ca::table_allowlist_rule::AllowlistRegistry, arg7: &mut 0x2::tx_context::TxContext) {
        assert_active(arg1);
        let v0 = 0x1::vector::length<0x2::object::ID>(&arg3);
        assert!(v0 > 0, 9);
        assert!(v0 <= 100, 10);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = *0x1::vector::borrow<0x2::object::ID>(&arg3, v1);
            assert!(0x2::table::contains<0x2::object::ID, NftInfo>(&arg1.nft_info, v2), 3);
            let v3 = 0x2::table::borrow<0x2::object::ID, NftInfo>(&arg1.nft_info, v2);
            assert!(v3.wd_cooldown_ts != 0, 5);
            assert!(0x2::clock::timestamp_ms(arg5) >= v3.wd_cooldown_ts, 6);
            assert!(arg4 == v3.wd_recipient, 7);
            v1 = v1 + 1;
        };
        let (v4, v5) = 0x2::kiosk::new(arg7);
        let v6 = v5;
        let v7 = v4;
        let v8 = 0;
        while (v8 < v0) {
            let v9 = *0x1::vector::borrow<0x2::object::ID>(&arg3, v8);
            let v10 = 0x2::table::remove<0x2::object::ID, NftInfo>(&mut arg1.nft_info, v9);
            let v11 = &mut arg1.kiosk;
            let v12 = &mut v7;
            transfer_nft_between_kiosks<T0>(v11, &arg1.kiosk_cap, v12, &v6, arg2, v9, arg6, arg7);
            arg1.total_withdrawals = arg1.total_withdrawals + 1;
            arg1.total_held = arg1.total_held - 1;
            let v13 = WithdrawEvent{
                nft_id    : v9,
                recipient : arg4,
                nft_type  : v10.nft_type,
            };
            0x2::event::emit<WithdrawEvent>(v13);
            v8 = v8 + 1;
        };
        0x2::transfer::public_transfer<0x2::kiosk::Kiosk>(v7, arg4);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v6, arg4);
    }

    // decompiled from Move bytecode v6
}

