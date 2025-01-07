module 0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::tails_staking {
    struct NftExtension has store, key {
        id: 0x2::object::UID,
        nft_table: 0x2::object_table::ObjectTable<address, 0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::Tails>,
        nft_manager_cap: 0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::ManagerCap,
        policy: 0x2::transfer_policy::TransferPolicy<0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::Tails>,
        fee: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct WithdrawEvent has copy, drop {
        sender: address,
        receiver: address,
        amount: u64,
    }

    struct TransferNftEvent has copy, drop {
        sender: address,
        receiver: address,
        nft_id: 0x2::object::ID,
        number: u64,
    }

    struct StakeNftEvent has copy, drop {
        sender: address,
        nft_id: 0x2::object::ID,
        number: u64,
        ts_ms: u64,
    }

    struct UnstakeNftEvent has copy, drop {
        sender: address,
        nft_id: 0x2::object::ID,
        number: u64,
    }

    struct DailyAttendEvent has copy, drop {
        sender: address,
        nft_id: 0x2::object::ID,
        number: u64,
        ts_ms: u64,
        exp_earn: u64,
    }

    struct UpdateDepositEvent has copy, drop {
        sender: address,
        nft_id: 0x2::object::ID,
        number: u64,
        before: u64,
        after: u64,
    }

    struct SnapshotNftEvent has copy, drop {
        sender: address,
        nft_id: 0x2::object::ID,
        number: u64,
        ts_ms: u64,
        exp_earn: u64,
    }

    struct LevelUpEvent has copy, drop {
        nft_id: 0x2::object::ID,
        number: u64,
        sender: address,
        level: u64,
    }

    struct UpdateUrlEvent has copy, drop {
        nft_id: 0x2::object::ID,
        number: u64,
        level: u64,
        url: vector<u8>,
    }

    struct Partner has store, key {
        id: 0x2::object::UID,
        exp_allocation: u64,
        partner_traits: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct PartnerKey has store, key {
        id: 0x2::object::UID,
        for: 0x2::object::ID,
        partner: 0x1::string::String,
    }

    struct ProfitSharing<phantom T0> has store {
        level_profits: vector<u64>,
        level_users: vector<u64>,
        total: u64,
        remaining: u64,
        pool: 0x2::balance::Balance<T0>,
    }

    struct ProfitSharingEvent has copy, drop {
        level_profits: vector<u64>,
        value: u64,
        token: 0x1::type_name::TypeName,
    }

    struct ClaimProfitSharingEvent has copy, drop {
        value: u64,
        token: 0x1::type_name::TypeName,
        sender: address,
        nft_id: 0x2::object::ID,
        number: u64,
        level: u64,
    }

    struct ClaimProfitSharingEventV2 has copy, drop {
        value: u64,
        token: 0x1::type_name::TypeName,
        sender: address,
        nft_id: 0x2::object::ID,
        number: u64,
        level: u64,
        name: 0x1::string::String,
    }

    entry fun level_up(arg0: &mut 0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::Registry, arg1: &0x2::tx_context::TxContext) {
        0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::version_check(arg0);
        assert!(0x2::dynamic_field::exists_<vector<u8>>(registry_uid(arg0), b"nft_extension"), 0);
        let v0 = 0x2::dynamic_field::borrow_mut<vector<u8>, NftExtension>(registry_mut_uid(arg0), b"nft_extension");
        let v1 = &mut v0.nft_table;
        let v2 = 0x2::tx_context::sender(arg1);
        assert!(0x2::object_table::contains<address, 0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::Tails>(v1, 0x2::tx_context::sender(arg1)), 2);
        let v3 = 0x2::object_table::borrow_mut<address, 0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::Tails>(v1, v2);
        let v4 = 0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::level_up(&v0.nft_manager_cap, v3);
        if (0x1::option::is_some<u64>(&v4)) {
            let v5 = LevelUpEvent{
                nft_id : 0x2::object::id<0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::Tails>(v3),
                number : 0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::tails_number(v3),
                sender : v2,
                level  : 0x1::option::extract<u64>(&mut v4),
            };
            0x2::event::emit<LevelUpEvent>(v5);
            0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::update_u64_padding(&v0.nft_manager_cap, v3, 0x1::string::utf8(b"updating_url"), 1);
        };
    }

    entry fun update_image_url(arg0: &mut 0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::Registry, arg1: address, arg2: vector<u8>, arg3: &0x2::tx_context::TxContext) {
        0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::version_check(arg0);
        0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::validate_registry_authority(arg0, arg3);
        assert!(0x2::dynamic_field::exists_<vector<u8>>(registry_uid(arg0), b"nft_extension"), 0);
        let v0 = 0x2::dynamic_field::borrow_mut<vector<u8>, NftExtension>(registry_mut_uid(arg0), b"nft_extension");
        let v1 = &mut v0.nft_table;
        assert!(0x2::object_table::contains<address, 0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::Tails>(v1, arg1), 2);
        let v2 = 0x2::object_table::borrow_mut<address, 0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::Tails>(v1, arg1);
        0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::update_image_url(&v0.nft_manager_cap, v2, arg2);
        0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::update_u64_padding(&v0.nft_manager_cap, v2, 0x1::string::utf8(b"updating_url"), 0);
        let v3 = UpdateUrlEvent{
            nft_id : 0x2::object::id<0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::Tails>(v2),
            number : 0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::tails_number(v2),
            level  : 0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::tails_level(v2),
            url    : arg2,
        };
        0x2::event::emit<UpdateUrlEvent>(v3);
    }

    entry fun add_exp(arg0: &mut 0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::Registry, arg1: address, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::version_check(arg0);
        0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::validate_registry_authority(arg0, arg3);
        assert!(0x2::dynamic_field::exists_<vector<u8>>(registry_uid(arg0), b"nft_extension"), 0);
        let v0 = 0x2::dynamic_field::borrow_mut<vector<u8>, NftExtension>(registry_mut_uid(arg0), b"nft_extension");
        let v1 = &mut v0.nft_table;
        assert!(0x2::object_table::contains<address, 0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::Tails>(v1, arg1), 2);
        0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::nft_exp_up(&v0.nft_manager_cap, 0x2::object_table::borrow_mut<address, 0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::Tails>(v1, arg1), arg2);
    }

    entry fun add_exp_coin_extension<T0>(arg0: &mut 0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::Registry, arg1: &0x2::tx_context::TxContext) {
        0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::version_check(arg0);
        0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::validate_registry_authority(arg0, arg1);
        assert!(0x2::dynamic_field::exists_<vector<u8>>(registry_uid(arg0), b"nft_extension"), 0);
        0x2::dynamic_field::add<0x1::string::String, 0x2::balance::Balance<T0>>(&mut 0x2::dynamic_field::borrow_mut<vector<u8>, NftExtension>(registry_mut_uid(arg0), b"nft_extension").id, 0x1::string::utf8(b"exp_coin"), 0x2::balance::zero<T0>());
    }

    entry fun add_nft_extension(arg0: &mut 0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::Registry, arg1: 0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::ManagerCap, arg2: &0x2::package::Publisher, arg3: &mut 0x2::tx_context::TxContext) {
        0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::version_check(arg0);
        assert!(!0x2::dynamic_field::exists_<vector<u8>>(registry_uid(arg0), b"nft_extension"), 0);
        let (v0, v1) = 0x2::transfer_policy::new<0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::Tails>(arg2, arg3);
        let v2 = NftExtension{
            id              : 0x2::object::new(arg3),
            nft_table       : 0x2::object_table::new<address, 0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::Tails>(arg3),
            nft_manager_cap : arg1,
            policy          : v0,
            fee             : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::dynamic_field::add<vector<u8>, NftExtension>(registry_mut_uid(arg0), b"nft_extension", v2);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::Tails>>(v1, 0x2::tx_context::sender(arg3));
    }

    entry fun add_partner_extension(arg0: &mut 0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::Registry, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::version_check(arg0);
        0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::validate_registry_authority(arg0, arg2);
        assert!(0x2::dynamic_field::exists_<vector<u8>>(registry_uid(arg0), b"nft_extension"), 0);
        let v0 = 0x2::object::new(arg2);
        let v1 = Partner{
            id             : v0,
            exp_allocation : 0,
            partner_traits : 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>(),
        };
        0x2::dynamic_field::add<0x1::string::String, Partner>(&mut 0x2::dynamic_field::borrow_mut<vector<u8>, NftExtension>(registry_mut_uid(arg0), b"nft_extension").id, arg1, v1);
        let v2 = PartnerKey{
            id      : 0x2::object::new(arg2),
            for     : 0x2::object::uid_to_inner(&v0),
            partner : arg1,
        };
        0x2::transfer::public_transfer<PartnerKey>(v2, 0x2::tx_context::sender(arg2));
    }

    entry fun add_partner_trait(arg0: &mut 0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::Registry, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &0x2::tx_context::TxContext) {
        0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::version_check(arg0);
        0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::validate_registry_authority(arg0, arg4);
        assert!(0x2::dynamic_field::exists_<vector<u8>>(registry_uid(arg0), b"nft_extension"), 0);
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut 0x2::dynamic_field::borrow_mut<0x1::string::String, Partner>(&mut 0x2::dynamic_field::borrow_mut<vector<u8>, NftExtension>(registry_mut_uid(arg0), b"nft_extension").id, arg1).partner_traits, arg2, arg3);
    }

    fun align_daily_ts(arg0: u64) : u64 {
        arg0 - arg0 % 86400000
    }

    entry fun allocate_profit_sharing<T0>(arg0: &mut 0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::Registry, arg1: vector<address>, arg2: &0x2::tx_context::TxContext) {
        0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::version_check(arg0);
        0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::validate_registry_authority(arg0, arg2);
        assert!(0x2::dynamic_field::exists_<vector<u8>>(registry_uid(arg0), b"nft_extension"), 0);
        let v0 = 0x2::dynamic_field::borrow_mut<vector<u8>, NftExtension>(registry_mut_uid(arg0), b"nft_extension");
        let v1 = 0x2::dynamic_field::borrow_mut<0x1::string::String, ProfitSharing<T0>>(&mut v0.id, 0x1::string::utf8(b"dice_profit_sharing"));
        let v2 = 0;
        while (0x1::vector::length<address>(&arg1) > 0) {
            let v3 = 0x2::object_table::borrow_mut<address, 0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::Tails>(&mut v0.nft_table, 0x1::vector::pop_back<address>(&mut arg1));
            let v4 = 0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::tails_level(v3) - 1;
            let v5 = *0x1::vector::borrow<u64>(&v1.level_profits, v4);
            if (!0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::contains_u64_padding(&v0.nft_manager_cap, v3, 0x1::string::utf8(b"dice_profit"))) {
                0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::insert_u64_padding(&v0.nft_manager_cap, v3, 0x1::string::utf8(b"dice_profit"), v5);
            } else {
                0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::update_u64_padding(&v0.nft_manager_cap, v3, 0x1::string::utf8(b"dice_profit"), v5);
            };
            v2 = v2 + v5;
            let v6 = 0x1::vector::borrow_mut<u64>(&mut v1.level_users, v4);
            *v6 = *v6 + 1;
        };
        v1.remaining = v1.remaining + v2;
        v1.total = v1.total + v2;
        assert!(0x2::balance::value<T0>(&v1.pool) >= v1.total, 7);
    }

    entry fun allocate_profit_sharing_w_value<T0>(arg0: &mut 0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::Registry, arg1: vector<address>, arg2: vector<u64>, arg3: &0x2::tx_context::TxContext) {
        0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::version_check(arg0);
        0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::validate_registry_authority(arg0, arg3);
        assert!(0x2::dynamic_field::exists_<vector<u8>>(registry_uid(arg0), b"nft_extension"), 0);
        let v0 = 0x2::dynamic_field::borrow_mut<vector<u8>, NftExtension>(registry_mut_uid(arg0), b"nft_extension");
        let v1 = 0x2::dynamic_field::borrow_mut<0x1::string::String, ProfitSharing<T0>>(&mut v0.id, 0x1::string::utf8(b"exp_profit_sharing"));
        let v2 = 0;
        while (0x1::vector::length<address>(&arg1) > 0) {
            let v3 = 0x2::object_table::borrow_mut<address, 0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::Tails>(&mut v0.nft_table, 0x1::vector::pop_back<address>(&mut arg1));
            let v4 = 0x1::vector::pop_back<u64>(&mut arg2);
            if (!0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::contains_u64_padding(&v0.nft_manager_cap, v3, 0x1::string::utf8(b"exp_profit"))) {
                0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::insert_u64_padding(&v0.nft_manager_cap, v3, 0x1::string::utf8(b"exp_profit"), v4);
            } else {
                0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::update_u64_padding(&v0.nft_manager_cap, v3, 0x1::string::utf8(b"exp_profit"), v4);
            };
            v2 = v2 + v4;
            let v5 = 0x1::vector::borrow_mut<u64>(&mut v1.level_users, 0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::tails_level(v3) - 1);
            *v5 = *v5 + 1;
        };
        v1.remaining = v1.remaining + v2;
        v1.total = v1.total + v2;
        assert!(0x2::balance::value<T0>(&v1.pool) >= v1.total, 7);
    }

    public fun bid<T0, T1>(arg0: &0x8bba3d8e3449349116c569543b5ded374615e9f11cbd2ba97b7a6bc5f45b12fe::ecosystem::Version, arg1: &mut 0x8bba3d8e3449349116c569543b5ded374615e9f11cbd2ba97b7a6bc5f45b12fe::user::TypusUserRegistry, arg2: &mut 0x8bba3d8e3449349116c569543b5ded374615e9f11cbd2ba97b7a6bc5f45b12fe::tgld::TgldRegistry, arg3: &mut 0x8bba3d8e3449349116c569543b5ded374615e9f11cbd2ba97b7a6bc5f45b12fe::leaderboard::TypusLeaderboardRegistry, arg4: &mut 0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::Registry, arg5: u64, arg6: vector<0x2::coin::Coin<T1>>, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0x342ef9f26e4e9c13c7b0031b2bd323455e7b2fc6de6fa366c6ce5fe76c4c7cb1::vault::TypusBidReceipt, 0x2::coin::Coin<T1>, vector<u64>) {
        0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::version_check(arg4);
        let v0 = 0x2::tx_context::sender(arg9);
        let (v1, v2, v3) = 0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::tds_user_entry::bid<T0, T1>(arg4, arg5, arg6, arg7, arg8, arg9);
        let v4 = v3;
        let v5 = *0x1::vector::borrow<u64>(&v4, 0);
        if (0x2::dynamic_field::exists_<vector<u8>>(registry_uid(arg4), b"nft_extension")) {
            let v6 = registry_mut_uid(arg4);
            let v7 = 0x2::dynamic_field::borrow_mut<vector<u8>, NftExtension>(v6, b"nft_extension");
            let v8 = &mut v7.nft_table;
            if (0x2::object_table::contains<address, 0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::Tails>(v8, v0)) {
                let v9 = 0x2::object_table::borrow_mut<address, 0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::Tails>(v8, v0);
                0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::first_bid(&v7.nft_manager_cap, v9);
                0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::nft_exp_up(&v7.nft_manager_cap, v9, v5 * 200);
            };
        };
        0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::add_accumulated_tgld_amount(registry_uid(arg4), arg0, arg1, arg2, v0, v5 * 200, arg9);
        0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::add_leaderboard_score(registry_uid(arg4), arg0, arg3, 0x1::ascii::string(b"bidding_leaderboard"), v0, v5 * 200, arg8, arg9);
        (v1, v2, v4)
    }

    entry fun claim_profit_sharing<T0>(arg0: &mut 0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::Registry, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::version_check(arg0);
        assert!(0x2::dynamic_field::exists_<vector<u8>>(registry_uid(arg0), b"nft_extension"), 0);
        let v0 = 0x2::dynamic_field::borrow_mut<vector<u8>, NftExtension>(registry_mut_uid(arg0), b"nft_extension");
        0x1::string::append_utf8(&mut arg1, b"_sharing");
        if (0x2::dynamic_field::exists_<0x1::string::String>(&v0.id, arg1)) {
            let v1 = 0x2::dynamic_field::borrow_mut<0x1::string::String, ProfitSharing<T0>>(&mut v0.id, arg1);
            assert!(0x2::balance::value<T0>(&v1.pool) == v1.remaining, 7);
            let v2 = 0;
            let v3 = 0x2::object_table::borrow_mut<address, 0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::Tails>(&mut v0.nft_table, 0x2::tx_context::sender(arg2));
            if (!0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::contains_u64_padding(&v0.nft_manager_cap, v3, arg1)) {
                0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::insert_u64_padding(&v0.nft_manager_cap, v3, arg1, 0);
            } else {
                v2 = 0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::get_u64_padding(&v0.nft_manager_cap, v3, arg1);
                0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::update_u64_padding(&v0.nft_manager_cap, v3, arg1, 0);
            };
            v1.remaining = v1.remaining - v2;
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v1.pool, v2), arg2), 0x2::tx_context::sender(arg2));
            assert!(0x2::balance::value<T0>(&v1.pool) == v1.remaining, 7);
            let v4 = ClaimProfitSharingEventV2{
                value  : v2,
                token  : 0x1::type_name::get<T0>(),
                sender : 0x2::tx_context::sender(arg2),
                nft_id : 0x2::object::id<0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::Tails>(v3),
                number : 0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::tails_number(v3),
                level  : 0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::tails_level(v3),
                name   : arg1,
            };
            0x2::event::emit<ClaimProfitSharingEventV2>(v4);
        };
    }

    public fun compound<T0, T1>(arg0: &mut 0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::Registry, arg1: u64, arg2: vector<0x342ef9f26e4e9c13c7b0031b2bd323455e7b2fc6de6fa366c6ce5fe76c4c7cb1::vault::TypusDepositReceipt>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x342ef9f26e4e9c13c7b0031b2bd323455e7b2fc6de6fa366c6ce5fe76c4c7cb1::vault::TypusDepositReceipt, vector<u64>) {
        0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::version_check(arg0);
        let (v0, v1) = 0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::tds_user_entry::compound<T0, T1>(arg0, arg1, arg2, arg4);
        let v2 = v1;
        if (0x2::dynamic_field::exists_<vector<u8>>(registry_uid(arg0), b"nft_extension")) {
            let v3 = 0x2::dynamic_field::borrow_mut<vector<u8>, NftExtension>(registry_mut_uid(arg0), b"nft_extension");
            if (0x2::object_table::contains<address, 0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::Tails>(&v3.nft_table, 0x2::tx_context::sender(arg4))) {
                let v4 = snapshot_(v3, arg3, 0x2::tx_context::sender(arg4));
                let v5 = 0x2::object_table::borrow_mut<address, 0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::Tails>(&mut v3.nft_table, 0x2::tx_context::sender(arg4));
                let v6 = v4 + *0x1::vector::borrow<u64>(&v2, 3);
                0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::update_u64_padding(&v3.nft_manager_cap, v5, 0x1::string::utf8(b"usd_in_deposit"), v6);
                let v7 = UpdateDepositEvent{
                    sender : 0x2::tx_context::sender(arg4),
                    nft_id : 0x2::object::id<0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::Tails>(v5),
                    number : 0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::tails_number(v5),
                    before : v4,
                    after  : v6,
                };
                0x2::event::emit<UpdateDepositEvent>(v7);
            };
        };
        (v0, v2)
    }

    entry fun consume_exp_coin_staked<T0>(arg0: &mut 0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::Registry, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::tx_context::TxContext) {
        0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::version_check(arg0);
        assert!(0x2::dynamic_field::exists_<vector<u8>>(registry_uid(arg0), b"nft_extension"), 0);
        let v0 = 0x2::dynamic_field::borrow_mut<vector<u8>, NftExtension>(registry_mut_uid(arg0), b"nft_extension");
        let v1 = &mut v0.nft_table;
        assert!(0x2::object_table::contains<address, 0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::Tails>(v1, 0x2::tx_context::sender(arg2)), 2);
        0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<0x1::string::String, 0x2::balance::Balance<T0>>(&mut v0.id, 0x1::string::utf8(b"exp_coin")), 0x2::coin::into_balance<T0>(arg1));
        0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::nft_exp_up(&v0.nft_manager_cap, 0x2::object_table::borrow_mut<address, 0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::Tails>(v1, 0x2::tx_context::sender(arg2)), 0x2::coin::value<T0>(&arg1));
    }

    public entry fun consume_exp_coin_unstaked<T0>(arg0: &mut 0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::Registry, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: 0x2::coin::Coin<T0>, arg5: &mut 0x2::tx_context::TxContext) {
        0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::version_check(arg0);
        assert!(0x2::dynamic_field::exists_<vector<u8>>(registry_uid(arg0), b"nft_extension"), 0);
        let v0 = 0x2::dynamic_field::borrow_mut<vector<u8>, NftExtension>(registry_mut_uid(arg0), b"nft_extension");
        0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<0x1::string::String, 0x2::balance::Balance<T0>>(&mut v0.id, 0x1::string::utf8(b"exp_coin")), 0x2::coin::into_balance<T0>(arg4));
        0x2::kiosk::list<0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::Tails>(arg1, arg2, arg3, 0);
        let (v1, v2) = 0x2::kiosk::purchase<0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::Tails>(arg1, arg3, 0x2::coin::zero<0x2::sui::SUI>(arg5));
        let v3 = v1;
        let (_, _, _) = 0x2::transfer_policy::confirm_request<0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::Tails>(&v0.policy, v2);
        0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::nft_exp_up(&v0.nft_manager_cap, &mut v3, 0x2::coin::value<T0>(&arg4));
        0x2::kiosk::lock<0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::Tails>(arg1, arg2, &v0.policy, v3);
    }

    entry fun daily_attend(arg0: &mut 0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::Registry, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::version_check(arg0);
        assert!(0x2::dynamic_field::exists_<vector<u8>>(registry_uid(arg0), b"nft_extension"), 0);
        let v0 = 0x2::dynamic_field::borrow_mut<vector<u8>, NftExtension>(registry_mut_uid(arg0), b"nft_extension");
        let v1 = &mut v0.nft_table;
        assert!(0x2::object_table::contains<address, 0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::Tails>(v1, 0x2::tx_context::sender(arg2)), 2);
        let v2 = 0x2::object_table::borrow_mut<address, 0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::Tails>(v1, 0x2::tx_context::sender(arg2));
        let v3 = 0x2::clock::timestamp_ms(arg1);
        assert!(align_daily_ts(0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::get_u64_padding(&v0.nft_manager_cap, v2, 0x1::string::utf8(b"attendance_ms"))) < align_daily_ts(v3), 3);
        0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::update_u64_padding(&v0.nft_manager_cap, v2, 0x1::string::utf8(b"attendance_ms"), v3);
        let v4 = *0x2::dynamic_field::borrow<0x1::string::String, u64>(&v0.id, 0x1::string::utf8(b"daily_attend_exp"));
        0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::nft_exp_up(&v0.nft_manager_cap, v2, v4);
        let v5 = DailyAttendEvent{
            sender   : 0x2::tx_context::sender(arg2),
            nft_id   : 0x2::object::id<0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::Tails>(v2),
            number   : 0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::tails_number(v2),
            ts_ms    : 0x2::clock::timestamp_ms(arg1),
            exp_earn : v4,
        };
        0x2::event::emit<DailyAttendEvent>(v5);
    }

    public fun deposit<T0, T1>(arg0: &mut 0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::Registry, arg1: u64, arg2: vector<0x2::coin::Coin<T0>>, arg3: u64, arg4: vector<0x342ef9f26e4e9c13c7b0031b2bd323455e7b2fc6de6fa366c6ce5fe76c4c7cb1::vault::TypusDepositReceipt>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (vector<0x2::coin::Coin<T0>>, 0x342ef9f26e4e9c13c7b0031b2bd323455e7b2fc6de6fa366c6ce5fe76c4c7cb1::vault::TypusDepositReceipt, vector<u64>) {
        0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::version_check(arg0);
        let (v0, v1, v2) = 0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::tds_user_entry::deposit<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg6);
        let v3 = v2;
        if (0x2::dynamic_field::exists_<vector<u8>>(registry_uid(arg0), b"nft_extension")) {
            let v4 = 0x2::dynamic_field::borrow_mut<vector<u8>, NftExtension>(registry_mut_uid(arg0), b"nft_extension");
            if (0x2::object_table::contains<address, 0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::Tails>(&v4.nft_table, 0x2::tx_context::sender(arg6))) {
                let v5 = snapshot_(v4, arg5, 0x2::tx_context::sender(arg6));
                let v6 = 0x2::object_table::borrow_mut<address, 0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::Tails>(&mut v4.nft_table, 0x2::tx_context::sender(arg6));
                0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::first_deposit(&v4.nft_manager_cap, v6);
                let v7 = v5 + *0x1::vector::borrow<u64>(&v3, 1);
                0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::update_u64_padding(&v4.nft_manager_cap, v6, 0x1::string::utf8(b"usd_in_deposit"), v7);
                let v8 = UpdateDepositEvent{
                    sender : 0x2::tx_context::sender(arg6),
                    nft_id : 0x2::object::id<0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::Tails>(v6),
                    number : 0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::tails_number(v6),
                    before : v5,
                    after  : v7,
                };
                0x2::event::emit<UpdateDepositEvent>(v8);
            };
        };
        (v0, v1, v3)
    }

    public(friend) fun get_staked_level(arg0: &0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::Registry, arg1: address) : u64 {
        assert!(0x2::dynamic_field::exists_<vector<u8>>(registry_uid(arg0), b"nft_extension"), 0);
        let v0 = &0x2::dynamic_field::borrow<vector<u8>, NftExtension>(registry_uid(arg0), b"nft_extension").nft_table;
        if (0x2::object_table::contains<address, 0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::Tails>(v0, arg1)) {
            return 0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::tails_level(0x2::object_table::borrow<address, 0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::Tails>(v0, arg1))
        };
        0
    }

    public fun has_staked(arg0: &0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::Registry, arg1: address) : bool {
        assert!(0x2::dynamic_field::exists_<vector<u8>>(registry_uid(arg0), b"nft_extension"), 0);
        0x2::object_table::contains<address, 0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::Tails>(&0x2::dynamic_field::borrow<vector<u8>, NftExtension>(registry_uid(arg0), b"nft_extension").nft_table, arg1)
    }

    public fun migrate_nft_extension(arg0: &mut 0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::Registry, arg1: 0x2::object_table::ObjectTable<address, 0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::Tails>, arg2: 0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::ManagerCap, arg3: 0x2::transfer_policy::TransferPolicy<0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::Tails>, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) {
        0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::version_check(arg0);
        0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::validate_registry_authority(arg0, arg5);
        assert!(!0x2::dynamic_field::exists_<vector<u8>>(registry_uid(arg0), b"nft_extension"), 0);
        let v0 = NftExtension{
            id              : 0x2::object::new(arg5),
            nft_table       : arg1,
            nft_manager_cap : arg2,
            policy          : arg3,
            fee             : 0x2::coin::into_balance<0x2::sui::SUI>(arg4),
        };
        0x2::dynamic_field::add<vector<u8>, NftExtension>(registry_mut_uid(arg0), b"nft_extension", v0);
    }

    public(friend) fun mut_nft_table(arg0: &mut 0x2::object::UID) : (&mut 0x2::object_table::ObjectTable<address, 0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::Tails>, &0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::ManagerCap) {
        assert!(0x2::dynamic_field::exists_<vector<u8>>(arg0, b"nft_extension"), 0);
        let v0 = 0x2::dynamic_field::borrow_mut<vector<u8>, NftExtension>(arg0, b"nft_extension");
        (&mut v0.nft_table, &v0.nft_manager_cap)
    }

    public fun new_bid<T0, T1>(arg0: &mut 0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::Registry, arg1: u64, arg2: vector<0x2::coin::Coin<T1>>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x342ef9f26e4e9c13c7b0031b2bd323455e7b2fc6de6fa366c6ce5fe76c4c7cb1::vault::TypusBidReceipt, vector<u64>) {
        abort 999
    }

    public fun new_bid_v2<T0, T1>(arg0: &mut 0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::Registry, arg1: u64, arg2: vector<0x2::coin::Coin<T1>>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x342ef9f26e4e9c13c7b0031b2bd323455e7b2fc6de6fa366c6ce5fe76c4c7cb1::vault::TypusBidReceipt, 0x2::coin::Coin<T1>, vector<u64>) {
        abort 999
    }

    public fun partner_add_exp(arg0: &mut 0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::Registry, arg1: &PartnerKey, arg2: address, arg3: u64) {
        0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::version_check(arg0);
        assert!(0x2::dynamic_field::exists_<vector<u8>>(registry_uid(arg0), b"nft_extension"), 0);
        let v0 = 0x2::dynamic_field::borrow_mut<vector<u8>, NftExtension>(registry_mut_uid(arg0), b"nft_extension");
        let v1 = &mut v0.nft_table;
        let v2 = 0x2::dynamic_field::borrow_mut<0x1::string::String, Partner>(&mut v0.id, arg1.partner);
        assert!(&arg1.for == 0x2::object::borrow_id<Partner>(v2), 6);
        if (0x2::object_table::contains<address, 0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::Tails>(v1, arg2)) {
            let v3 = 0x2::object_table::borrow_mut<address, 0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::Tails>(v1, arg2);
            let v4 = 0x2::vec_map::keys<0x1::string::String, 0x1::string::String>(&v2.partner_traits);
            let v5 = 0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::tails_attributes(v3);
            let v6 = true;
            while (0x1::vector::length<0x1::string::String>(&v4) > 0) {
                let v7 = 0x1::vector::pop_back<0x1::string::String>(&mut v4);
                if (0x2::vec_map::get<0x1::string::String, 0x1::string::String>(&v5, &v7) != 0x2::vec_map::get<0x1::string::String, 0x1::string::String>(&v2.partner_traits, &v7)) {
                    v6 = false;
                };
            };
            if (v6) {
                0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::nft_exp_up(&v0.nft_manager_cap, v3, arg3);
                v2.exp_allocation = v2.exp_allocation - arg3;
            };
        };
    }

    public fun reduce_usd_in_deposit(arg0: &mut 0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::Registry, arg1: address, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::version_check(arg0);
        0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::validate_registry_authority(arg0, arg4);
        if (0x2::dynamic_field::exists_<vector<u8>>(registry_uid(arg0), b"nft_extension")) {
            let v0 = 0x2::dynamic_field::borrow_mut<vector<u8>, NftExtension>(registry_mut_uid(arg0), b"nft_extension");
            if (0x2::object_table::contains<address, 0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::Tails>(&v0.nft_table, arg1)) {
                let v1 = snapshot_(v0, arg3, arg1);
                let v2 = 0x2::object_table::borrow_mut<address, 0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::Tails>(&mut v0.nft_table, arg1);
                let v3 = if (v1 > arg2) {
                    v1 - arg2
                } else {
                    0
                };
                0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::update_u64_padding(&v0.nft_manager_cap, v2, 0x1::string::utf8(b"usd_in_deposit"), v3);
                let v4 = UpdateDepositEvent{
                    sender : arg1,
                    nft_id : 0x2::object::id<0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::Tails>(v2),
                    number : 0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::tails_number(v2),
                    before : v1,
                    after  : v3,
                };
                0x2::event::emit<UpdateDepositEvent>(v4);
            };
        };
    }

    fun registry_mut_uid(arg0: &mut 0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::Registry) : &mut 0x2::object::UID {
        let (v0, _, _, _, _, _, _, _, _, _, _, _) = 0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::get_mut_registry_inner(arg0);
        v0
    }

    fun registry_uid(arg0: &0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::Registry) : &0x2::object::UID {
        let (v0, _, _, _, _, _, _, _, _, _, _, _) = 0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::get_registry_inner(arg0);
        v0
    }

    entry fun remove_exp_coin_extension<T0>(arg0: &mut 0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::Registry, arg1: &mut 0x2::tx_context::TxContext) {
        0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::version_check(arg0);
        0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::validate_registry_authority(arg0, arg1);
        assert!(0x2::dynamic_field::exists_<vector<u8>>(registry_uid(arg0), b"nft_extension"), 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::dynamic_field::remove<0x1::string::String, 0x2::balance::Balance<T0>>(&mut 0x2::dynamic_field::borrow_mut<vector<u8>, NftExtension>(registry_mut_uid(arg0), b"nft_extension").id, 0x1::string::utf8(b"exp_coin")), arg1), 0x2::tx_context::sender(arg1));
    }

    public fun remove_nft_extension(arg0: &mut 0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::Registry, arg1: &mut 0x2::tx_context::TxContext) : (0x2::object_table::ObjectTable<address, 0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::Tails>, 0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::ManagerCap, 0x2::transfer_policy::TransferPolicy<0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::Tails>, 0x2::coin::Coin<0x2::sui::SUI>) {
        0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::version_check(arg0);
        0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::validate_registry_authority(arg0, arg1);
        assert!(0x2::dynamic_field::exists_<vector<u8>>(registry_uid(arg0), b"nft_extension"), 0);
        let NftExtension {
            id              : v0,
            nft_table       : v1,
            nft_manager_cap : v2,
            policy          : v3,
            fee             : v4,
        } = 0x2::dynamic_field::remove<vector<u8>, NftExtension>(registry_mut_uid(arg0), b"nft_extension");
        0x2::object::delete(v0);
        (v1, v2, v3, 0x2::coin::from_balance<0x2::sui::SUI>(v4, arg1))
    }

    entry fun remove_partner_extension(arg0: &mut 0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::Registry, arg1: 0x1::string::String, arg2: &0x2::tx_context::TxContext) {
        0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::version_check(arg0);
        0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::validate_registry_authority(arg0, arg2);
        assert!(0x2::dynamic_field::exists_<vector<u8>>(registry_uid(arg0), b"nft_extension"), 0);
        let Partner {
            id             : v0,
            exp_allocation : _,
            partner_traits : _,
        } = 0x2::dynamic_field::remove<0x1::string::String, Partner>(&mut 0x2::dynamic_field::borrow_mut<vector<u8>, NftExtension>(registry_mut_uid(arg0), b"nft_extension").id, arg1);
        0x2::object::delete(v0);
    }

    entry fun remove_partner_trait(arg0: &mut 0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::Registry, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &0x2::tx_context::TxContext) {
        0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::version_check(arg0);
        0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::validate_registry_authority(arg0, arg3);
        assert!(0x2::dynamic_field::exists_<vector<u8>>(registry_uid(arg0), b"nft_extension"), 0);
        let (_, _) = 0x2::vec_map::remove<0x1::string::String, 0x1::string::String>(&mut 0x2::dynamic_field::borrow_mut<0x1::string::String, Partner>(&mut 0x2::dynamic_field::borrow_mut<vector<u8>, NftExtension>(registry_mut_uid(arg0), b"nft_extension").id, arg1).partner_traits, &arg2);
    }

    entry fun remove_profit_sharing<T0>(arg0: &mut 0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::Registry, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::version_check(arg0);
        0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::validate_registry_authority(arg0, arg2);
        assert!(0x2::dynamic_field::exists_<vector<u8>>(registry_uid(arg0), b"nft_extension"), 0);
        let v0 = 0x2::dynamic_field::borrow_mut<vector<u8>, NftExtension>(registry_mut_uid(arg0), b"nft_extension");
        if (0x2::dynamic_field::exists_<0x1::string::String>(&v0.id, arg1)) {
            let ProfitSharing {
                level_profits : _,
                level_users   : _,
                total         : _,
                remaining     : _,
                pool          : v5,
            } = 0x2::dynamic_field::remove<0x1::string::String, ProfitSharing<T0>>(&mut v0.id, arg1);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v5, arg2), 0x2::tx_context::sender(arg2));
        };
    }

    entry fun set_profit_sharing<T0>(arg0: &mut 0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::Registry, arg1: 0x1::string::String, arg2: vector<u64>, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::tx_context::TxContext) {
        0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::version_check(arg0);
        0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::validate_registry_authority(arg0, arg4);
        assert!(0x1::vector::length<u64>(&arg2) == 7, 8);
        assert!(0x2::dynamic_field::exists_<vector<u8>>(registry_uid(arg0), b"nft_extension"), 0);
        let v0 = ProfitSharingEvent{
            level_profits : arg2,
            value         : 0x2::coin::value<T0>(&arg3),
            token         : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<ProfitSharingEvent>(v0);
        let v1 = ProfitSharing<T0>{
            level_profits : arg2,
            level_users   : vector[0, 0, 0, 0, 0, 0, 0],
            total         : 0,
            remaining     : 0,
            pool          : 0x2::coin::into_balance<T0>(arg3),
        };
        0x2::dynamic_field::add<0x1::string::String, ProfitSharing<T0>>(&mut 0x2::dynamic_field::borrow_mut<vector<u8>, NftExtension>(registry_mut_uid(arg0), b"nft_extension").id, arg1, v1);
    }

    entry fun snapshot(arg0: &mut 0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::Registry, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::version_check(arg0);
        assert!(0x2::dynamic_field::exists_<vector<u8>>(registry_uid(arg0), b"nft_extension"), 0);
        let v0 = 0x2::dynamic_field::borrow_mut<vector<u8>, NftExtension>(registry_mut_uid(arg0), b"nft_extension");
        if (0x2::object_table::contains<address, 0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::Tails>(&v0.nft_table, 0x2::tx_context::sender(arg2))) {
            snapshot_(v0, arg1, 0x2::tx_context::sender(arg2));
        };
    }

    fun snapshot_(arg0: &mut NftExtension, arg1: &0x2::clock::Clock, arg2: address) : u64 {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = 0x2::object_table::borrow_mut<address, 0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::Tails>(&mut arg0.nft_table, arg2);
        let v2 = 0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::get_u64_padding(&arg0.nft_manager_cap, v1, 0x1::string::utf8(b"usd_in_deposit"));
        let v3 = v2 * (v0 - 0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::get_u64_padding(&arg0.nft_manager_cap, v1, 0x1::string::utf8(b"snapshot_ms"))) / 60000 / 12000;
        0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::nft_exp_up(&arg0.nft_manager_cap, v1, v3);
        0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::update_u64_padding(&arg0.nft_manager_cap, v1, 0x1::string::utf8(b"snapshot_ms"), v0);
        let v4 = SnapshotNftEvent{
            sender   : arg2,
            nft_id   : 0x2::object::id<0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::Tails>(v1),
            number   : 0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::tails_number(v1),
            ts_ms    : v0,
            exp_earn : v3,
        };
        0x2::event::emit<SnapshotNftEvent>(v4);
        v2
    }

    public entry fun stake_nft(arg0: &mut 0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::Registry, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &mut 0x2::tx_context::TxContext) {
        stake_nft_(arg0, arg1, arg2, arg3, arg4, arg5, 0, arg6);
    }

    fun stake_nft_(arg0: &mut 0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::Registry, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::version_check(arg0);
        assert!(0x2::dynamic_field::exists_<vector<u8>>(registry_uid(arg0), b"nft_extension"), 0);
        let v0 = 0x2::dynamic_field::borrow_mut<vector<u8>, NftExtension>(registry_mut_uid(arg0), b"nft_extension");
        let v1 = &mut v0.nft_table;
        assert!(!0x2::object_table::contains<address, 0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::Tails>(v1, 0x2::tx_context::sender(arg7)), 1);
        0x2::kiosk::list<0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::Tails>(arg1, arg2, arg3, 0);
        let (v2, v3) = 0x2::kiosk::purchase<0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::Tails>(arg1, arg3, 0x2::coin::zero<0x2::sui::SUI>(arg7));
        let v4 = v2;
        let (_, _, _) = 0x2::transfer_policy::confirm_request<0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::Tails>(&v0.policy, v3);
        0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::insert_u64_padding(&v0.nft_manager_cap, &mut v4, 0x1::string::utf8(b"updating_url"), 0);
        if (!0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::contains_u64_padding(&v0.nft_manager_cap, &v4, 0x1::string::utf8(b"attendance_ms"))) {
            0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::insert_u64_padding(&v0.nft_manager_cap, &mut v4, 0x1::string::utf8(b"attendance_ms"), 0);
        };
        let v8 = 0x2::clock::timestamp_ms(arg4);
        if (!0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::contains_u64_padding(&v0.nft_manager_cap, &v4, 0x1::string::utf8(b"snapshot_ms"))) {
            0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::insert_u64_padding(&v0.nft_manager_cap, &mut v4, 0x1::string::utf8(b"snapshot_ms"), v8);
        } else {
            0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::update_u64_padding(&v0.nft_manager_cap, &mut v4, 0x1::string::utf8(b"snapshot_ms"), v8);
        };
        if (!0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::contains_u64_padding(&v0.nft_manager_cap, &v4, 0x1::string::utf8(b"usd_in_deposit"))) {
            0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::insert_u64_padding(&v0.nft_manager_cap, &mut v4, 0x1::string::utf8(b"usd_in_deposit"), arg6);
        } else {
            0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::update_u64_padding(&v0.nft_manager_cap, &mut v4, 0x1::string::utf8(b"usd_in_deposit"), arg6);
        };
        0x2::object_table::add<address, 0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::Tails>(v1, 0x2::tx_context::sender(arg7), v4);
        let v9 = StakeNftEvent{
            sender : 0x2::tx_context::sender(arg7),
            nft_id : arg3,
            number : 0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::tails_number(&v4),
            ts_ms  : v8,
        };
        0x2::event::emit<StakeNftEvent>(v9);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg5) == 50000000, 5);
        0x2::balance::join<0x2::sui::SUI>(&mut v0.fee, 0x2::coin::into_balance<0x2::sui::SUI>(arg5));
    }

    public entry fun switch_nft(arg0: &mut 0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::Registry, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = unstake_nft_(arg0, arg1, arg2, arg6);
        stake_nft_(arg0, arg1, arg2, arg3, arg4, arg5, v0, arg6);
    }

    public entry fun transfer_nft(arg0: &mut 0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::Registry, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: address, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &mut 0x2::tx_context::TxContext) {
        0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::version_check(arg0);
        assert!(0x2::dynamic_field::exists_<vector<u8>>(registry_uid(arg0), b"nft_extension"), 0);
        let v0 = 0x2::dynamic_field::borrow_mut<vector<u8>, NftExtension>(registry_mut_uid(arg0), b"nft_extension");
        0x2::kiosk::list<0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::Tails>(arg1, arg2, arg3, 0);
        let (v1, v2) = 0x2::kiosk::purchase<0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::Tails>(arg1, arg3, 0x2::coin::zero<0x2::sui::SUI>(arg6));
        let v3 = v1;
        let (_, _, _) = 0x2::transfer_policy::confirm_request<0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::Tails>(&v0.policy, v2);
        let (v7, v8) = 0x2::kiosk::new(arg6);
        let v9 = v8;
        let v10 = v7;
        0x2::kiosk::lock<0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::Tails>(&mut v10, &v9, &v0.policy, v3);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v10);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v9, arg4);
        let v11 = TransferNftEvent{
            sender   : 0x2::tx_context::sender(arg6),
            receiver : arg4,
            nft_id   : arg3,
            number   : 0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::tails_number(&v3),
        };
        0x2::event::emit<TransferNftEvent>(v11);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg5) == 10000000, 5);
        0x2::balance::join<0x2::sui::SUI>(&mut v0.fee, 0x2::coin::into_balance<0x2::sui::SUI>(arg5));
    }

    public entry fun unstake_nft(arg0: &mut 0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::Registry, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: &0x2::tx_context::TxContext) {
        unstake_nft_(arg0, arg1, arg2, arg3);
    }

    fun unstake_nft_(arg0: &mut 0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::Registry, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: &0x2::tx_context::TxContext) : u64 {
        0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::version_check(arg0);
        assert!(0x2::dynamic_field::exists_<vector<u8>>(registry_uid(arg0), b"nft_extension"), 0);
        let v0 = 0x2::dynamic_field::borrow_mut<vector<u8>, NftExtension>(registry_mut_uid(arg0), b"nft_extension");
        let v1 = &mut v0.nft_table;
        assert!(0x2::object_table::contains<address, 0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::Tails>(v1, 0x2::tx_context::sender(arg3)), 2);
        let v2 = 0x2::object_table::remove<address, 0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::Tails>(v1, 0x2::tx_context::sender(arg3));
        assert!(0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::get_u64_padding(&v0.nft_manager_cap, &v2, 0x1::string::utf8(b"updating_url")) == 0, 4);
        0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::remove_u64_padding(&v0.nft_manager_cap, &mut v2, 0x1::string::utf8(b"updating_url"));
        0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::remove_u64_padding(&v0.nft_manager_cap, &mut v2, 0x1::string::utf8(b"usd_in_deposit"));
        if (0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::contains_u64_padding(&v0.nft_manager_cap, &v2, 0x1::string::utf8(b"dice_profit"))) {
            0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::remove_u64_padding(&v0.nft_manager_cap, &mut v2, 0x1::string::utf8(b"dice_profit"));
        };
        if (0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::contains_u64_padding(&v0.nft_manager_cap, &v2, 0x1::string::utf8(b"exp_profit"))) {
            0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::remove_u64_padding(&v0.nft_manager_cap, &mut v2, 0x1::string::utf8(b"exp_profit"));
        };
        0x2::kiosk::lock<0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::Tails>(arg1, arg2, &v0.policy, v2);
        let v3 = UnstakeNftEvent{
            sender : 0x2::tx_context::sender(arg3),
            nft_id : 0x2::object::id<0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::Tails>(&v2),
            number : 0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::tails_number(&v2),
        };
        0x2::event::emit<UnstakeNftEvent>(v3);
        0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::get_u64_padding(&v0.nft_manager_cap, &v2, 0x1::string::utf8(b"usd_in_deposit"))
    }

    public fun unsubscribe<T0, T1>(arg0: &mut 0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::Registry, arg1: u64, arg2: vector<0x342ef9f26e4e9c13c7b0031b2bd323455e7b2fc6de6fa366c6ce5fe76c4c7cb1::vault::TypusDepositReceipt>, arg3: 0x1::option::Option<u64>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x342ef9f26e4e9c13c7b0031b2bd323455e7b2fc6de6fa366c6ce5fe76c4c7cb1::vault::TypusDepositReceipt, vector<u64>) {
        0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::version_check(arg0);
        let (v0, v1) = 0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::tds_user_entry::unsubscribe<T0, T1>(arg0, arg1, arg2, arg3, arg5);
        let v2 = v1;
        let v3 = *0x1::vector::borrow<u64>(&v2, 1);
        if (0x2::dynamic_field::exists_<vector<u8>>(registry_uid(arg0), b"nft_extension")) {
            let v4 = 0x2::dynamic_field::borrow_mut<vector<u8>, NftExtension>(registry_mut_uid(arg0), b"nft_extension");
            if (0x2::object_table::contains<address, 0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::Tails>(&v4.nft_table, 0x2::tx_context::sender(arg5))) {
                let v5 = snapshot_(v4, arg4, 0x2::tx_context::sender(arg5));
                let v6 = 0x2::object_table::borrow_mut<address, 0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::Tails>(&mut v4.nft_table, 0x2::tx_context::sender(arg5));
                let v7 = if (v5 > v3) {
                    v5 - v3
                } else {
                    0
                };
                0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::update_u64_padding(&v4.nft_manager_cap, v6, 0x1::string::utf8(b"usd_in_deposit"), v7);
                let v8 = UpdateDepositEvent{
                    sender : 0x2::tx_context::sender(arg5),
                    nft_id : 0x2::object::id<0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::Tails>(v6),
                    number : 0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::tails_number(v6),
                    before : v5,
                    after  : v7,
                };
                0x2::event::emit<UpdateDepositEvent>(v8);
            };
        };
        (v0, v2)
    }

    entry fun update_daily_attend_exp(arg0: &mut 0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::Registry, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::version_check(arg0);
        0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::validate_registry_authority(arg0, arg2);
        assert!(0x2::dynamic_field::exists_<vector<u8>>(registry_uid(arg0), b"nft_extension"), 0);
        let v0 = 0x2::dynamic_field::borrow_mut<vector<u8>, NftExtension>(registry_mut_uid(arg0), b"nft_extension");
        if (0x2::dynamic_field::exists_<0x1::string::String>(&v0.id, 0x1::string::utf8(b"daily_attend_exp"))) {
            *0x2::dynamic_field::borrow_mut<0x1::string::String, u64>(&mut v0.id, 0x1::string::utf8(b"daily_attend_exp")) = arg1;
        } else {
            0x2::dynamic_field::add<0x1::string::String, u64>(&mut v0.id, 0x1::string::utf8(b"daily_attend_exp"), arg1);
        };
    }

    entry fun update_exp_allocation(arg0: &mut 0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::Registry, arg1: 0x1::string::String, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::version_check(arg0);
        0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::validate_registry_authority(arg0, arg3);
        assert!(0x2::dynamic_field::exists_<vector<u8>>(registry_uid(arg0), b"nft_extension"), 0);
        0x2::dynamic_field::borrow_mut<0x1::string::String, Partner>(&mut 0x2::dynamic_field::borrow_mut<vector<u8>, NftExtension>(registry_mut_uid(arg0), b"nft_extension").id, arg1).exp_allocation = arg2;
    }

    public fun withdraw<T0, T1>(arg0: &mut 0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::Registry, arg1: u64, arg2: vector<0x342ef9f26e4e9c13c7b0031b2bd323455e7b2fc6de6fa366c6ce5fe76c4c7cb1::vault::TypusDepositReceipt>, arg3: 0x1::option::Option<u64>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x1::option::Option<0x342ef9f26e4e9c13c7b0031b2bd323455e7b2fc6de6fa366c6ce5fe76c4c7cb1::vault::TypusDepositReceipt>, vector<u64>) {
        0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::version_check(arg0);
        let (v0, v1, v2) = 0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::tds_user_entry::withdraw<T0, T1>(arg0, arg1, arg2, arg3, arg5);
        let v3 = v2;
        let v4 = *0x1::vector::borrow<u64>(&v3, 1);
        if (0x2::dynamic_field::exists_<vector<u8>>(registry_uid(arg0), b"nft_extension")) {
            let v5 = 0x2::dynamic_field::borrow_mut<vector<u8>, NftExtension>(registry_mut_uid(arg0), b"nft_extension");
            if (0x2::object_table::contains<address, 0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::Tails>(&v5.nft_table, 0x2::tx_context::sender(arg5))) {
                let v6 = snapshot_(v5, arg4, 0x2::tx_context::sender(arg5));
                let v7 = 0x2::object_table::borrow_mut<address, 0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::Tails>(&mut v5.nft_table, 0x2::tx_context::sender(arg5));
                let v8 = if (v6 > v4) {
                    v6 - v4
                } else {
                    0
                };
                0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::update_u64_padding(&v5.nft_manager_cap, v7, 0x1::string::utf8(b"usd_in_deposit"), v8);
                let v9 = UpdateDepositEvent{
                    sender : 0x2::tx_context::sender(arg5),
                    nft_id : 0x2::object::id<0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::Tails>(v7),
                    number : 0x26febf6beb6a642d0d57604f9acac3dcffa39d718f9c6cb98ada6e82b4ff4941::typus_nft::tails_number(v7),
                    before : v6,
                    after  : v8,
                };
                0x2::event::emit<UpdateDepositEvent>(v9);
            };
        };
        (v0, v1, v3)
    }

    entry fun withdraw_fee(arg0: &mut 0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::Registry, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::version_check(arg0);
        0xd9b4c34b9ec55ca6e9ec37b2231a8c503c1e843ea31adb7db2a817b6cf226f56::typus_dov_single::validate_registry_authority(arg0, arg2);
        assert!(0x2::dynamic_field::exists_<vector<u8>>(registry_uid(arg0), b"nft_extension"), 0);
        let v0 = 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut 0x2::dynamic_field::borrow_mut<vector<u8>, NftExtension>(registry_mut_uid(arg0), b"nft_extension").fee), arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v0, arg1);
        let v1 = WithdrawEvent{
            sender   : 0x2::tx_context::sender(arg2),
            receiver : arg1,
            amount   : 0x2::coin::value<0x2::sui::SUI>(&v0),
        };
        0x2::event::emit<WithdrawEvent>(v1);
    }

    // decompiled from Move bytecode v6
}

