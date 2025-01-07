module 0x9346203b8cd6f2f7bf6002bbf6c087308214556c3b17ce8c000397f2de886cc2::tails_staking {
    struct NftExtension has store, key {
        id: 0x2::object::UID,
        nft_table: 0x2::object_table::ObjectTable<address, 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>,
        nft_manager_cap: 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::ManagerCap,
        policy: 0x2::transfer_policy::TransferPolicy<0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>,
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

    entry fun add_exp(arg0: &mut 0x9346203b8cd6f2f7bf6002bbf6c087308214556c3b17ce8c000397f2de886cc2::typus_dov_single::Registry, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x9346203b8cd6f2f7bf6002bbf6c087308214556c3b17ce8c000397f2de886cc2::typus_dov_single::version_check(arg0);
        0x9346203b8cd6f2f7bf6002bbf6c087308214556c3b17ce8c000397f2de886cc2::typus_dov_single::validate_registry_authority(arg0, arg3);
        assert!(0x2::dynamic_field::exists_<vector<u8>>(registry_uid(arg0), b"nft_extension"), 0);
        let v0 = 0x2::dynamic_field::borrow_mut<vector<u8>, NftExtension>(registry_mut_uid(arg0), b"nft_extension");
        let v1 = &mut v0.nft_table;
        assert!(0x2::object_table::contains<address, 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(v1, arg1), 2);
        0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::nft_exp_up(&v0.nft_manager_cap, 0x2::object_table::borrow_mut<address, 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(v1, arg1), arg2);
    }

    entry fun add_exp_coin_extension<T0>(arg0: &mut 0x9346203b8cd6f2f7bf6002bbf6c087308214556c3b17ce8c000397f2de886cc2::typus_dov_single::Registry, arg1: &mut 0x2::tx_context::TxContext) {
        0x9346203b8cd6f2f7bf6002bbf6c087308214556c3b17ce8c000397f2de886cc2::typus_dov_single::version_check(arg0);
        0x9346203b8cd6f2f7bf6002bbf6c087308214556c3b17ce8c000397f2de886cc2::typus_dov_single::validate_registry_authority(arg0, arg1);
        assert!(0x2::dynamic_field::exists_<vector<u8>>(registry_uid(arg0), b"nft_extension"), 0);
        0x2::dynamic_field::add<0x1::string::String, 0x2::balance::Balance<T0>>(&mut 0x2::dynamic_field::borrow_mut<vector<u8>, NftExtension>(registry_mut_uid(arg0), b"nft_extension").id, 0x1::string::utf8(b"exp_coin"), 0x2::balance::zero<T0>());
    }

    entry fun add_nft_extension(arg0: &mut 0x9346203b8cd6f2f7bf6002bbf6c087308214556c3b17ce8c000397f2de886cc2::typus_dov_single::Registry, arg1: 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::ManagerCap, arg2: &0x2::package::Publisher, arg3: &mut 0x2::tx_context::TxContext) {
        0x9346203b8cd6f2f7bf6002bbf6c087308214556c3b17ce8c000397f2de886cc2::typus_dov_single::version_check(arg0);
        assert!(!0x2::dynamic_field::exists_<vector<u8>>(registry_uid(arg0), b"nft_extension"), 0);
        let (v0, v1) = 0x2::transfer_policy::new<0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(arg2, arg3);
        let v2 = NftExtension{
            id              : 0x2::object::new(arg3),
            nft_table       : 0x2::object_table::new<address, 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(arg3),
            nft_manager_cap : arg1,
            policy          : v0,
            fee             : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::dynamic_field::add<vector<u8>, NftExtension>(registry_mut_uid(arg0), b"nft_extension", v2);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>>(v1, 0x2::tx_context::sender(arg3));
    }

    entry fun add_partner_extension(arg0: &mut 0x9346203b8cd6f2f7bf6002bbf6c087308214556c3b17ce8c000397f2de886cc2::typus_dov_single::Registry, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        0x9346203b8cd6f2f7bf6002bbf6c087308214556c3b17ce8c000397f2de886cc2::typus_dov_single::version_check(arg0);
        0x9346203b8cd6f2f7bf6002bbf6c087308214556c3b17ce8c000397f2de886cc2::typus_dov_single::validate_registry_authority(arg0, arg2);
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

    entry fun add_partner_trait(arg0: &mut 0x9346203b8cd6f2f7bf6002bbf6c087308214556c3b17ce8c000397f2de886cc2::typus_dov_single::Registry, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        0x9346203b8cd6f2f7bf6002bbf6c087308214556c3b17ce8c000397f2de886cc2::typus_dov_single::version_check(arg0);
        0x9346203b8cd6f2f7bf6002bbf6c087308214556c3b17ce8c000397f2de886cc2::typus_dov_single::validate_registry_authority(arg0, arg4);
        assert!(0x2::dynamic_field::exists_<vector<u8>>(registry_uid(arg0), b"nft_extension"), 0);
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut 0x2::dynamic_field::borrow_mut<0x1::string::String, Partner>(&mut 0x2::dynamic_field::borrow_mut<vector<u8>, NftExtension>(registry_mut_uid(arg0), b"nft_extension").id, arg1).partner_traits, arg2, arg3);
    }

    fun align_daily_ts(arg0: u64) : u64 {
        arg0 - arg0 % 86400000
    }

    public(friend) entry fun compound<T0, T1>(arg0: &mut 0x9346203b8cd6f2f7bf6002bbf6c087308214556c3b17ce8c000397f2de886cc2::typus_dov_single::Registry, arg1: u64, arg2: vector<0xd3b97a40e70f5a15dfa78598dd9c1db8c6bc16f579d78cbb0d86465e3565c130::vault::TypusDepositReceipt>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x9346203b8cd6f2f7bf6002bbf6c087308214556c3b17ce8c000397f2de886cc2::typus_dov_single::version_check(arg0);
        let v0 = 0x9346203b8cd6f2f7bf6002bbf6c087308214556c3b17ce8c000397f2de886cc2::tds_user_entry::compound<T0, T1>(arg0, arg1, arg2, arg4);
        if (0x2::dynamic_field::exists_<vector<u8>>(registry_uid(arg0), b"nft_extension")) {
            let v1 = 0x2::dynamic_field::borrow_mut<vector<u8>, NftExtension>(registry_mut_uid(arg0), b"nft_extension");
            if (0x2::object_table::contains<address, 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(&v1.nft_table, 0x2::tx_context::sender(arg4))) {
                let v2 = snapshot_(v1, arg3, arg4);
                let v3 = 0x2::object_table::borrow_mut<address, 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(&mut v1.nft_table, 0x2::tx_context::sender(arg4));
                let v4 = v2 + v0;
                0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::update_u64_padding(&v1.nft_manager_cap, v3, 0x1::string::utf8(b"usd_in_deposit"), v4);
                let v5 = UpdateDepositEvent{
                    sender : 0x2::tx_context::sender(arg4),
                    nft_id : 0x2::object::id<0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(v3),
                    number : 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::tails_number(v3),
                    before : v2,
                    after  : v4,
                };
                0x2::event::emit<UpdateDepositEvent>(v5);
            };
        };
    }

    entry fun consume_exp_coin_staked<T0>(arg0: &mut 0x9346203b8cd6f2f7bf6002bbf6c087308214556c3b17ce8c000397f2de886cc2::typus_dov_single::Registry, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x9346203b8cd6f2f7bf6002bbf6c087308214556c3b17ce8c000397f2de886cc2::typus_dov_single::version_check(arg0);
        assert!(0x2::dynamic_field::exists_<vector<u8>>(registry_uid(arg0), b"nft_extension"), 0);
        let v0 = 0x2::dynamic_field::borrow_mut<vector<u8>, NftExtension>(registry_mut_uid(arg0), b"nft_extension");
        let v1 = &mut v0.nft_table;
        assert!(0x2::object_table::contains<address, 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(v1, 0x2::tx_context::sender(arg2)), 2);
        0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<0x1::string::String, 0x2::balance::Balance<T0>>(&mut v0.id, 0x1::string::utf8(b"exp_coin")), 0x2::coin::into_balance<T0>(arg1));
        0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::nft_exp_up(&v0.nft_manager_cap, 0x2::object_table::borrow_mut<address, 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(v1, 0x2::tx_context::sender(arg2)), 0x2::coin::value<T0>(&arg1));
    }

    entry fun consume_exp_coin_unstaked<T0>(arg0: &mut 0x9346203b8cd6f2f7bf6002bbf6c087308214556c3b17ce8c000397f2de886cc2::typus_dov_single::Registry, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: 0x2::coin::Coin<T0>, arg5: &mut 0x2::tx_context::TxContext) {
        0x9346203b8cd6f2f7bf6002bbf6c087308214556c3b17ce8c000397f2de886cc2::typus_dov_single::version_check(arg0);
        assert!(0x2::dynamic_field::exists_<vector<u8>>(registry_uid(arg0), b"nft_extension"), 0);
        let v0 = 0x2::dynamic_field::borrow_mut<vector<u8>, NftExtension>(registry_mut_uid(arg0), b"nft_extension");
        0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<0x1::string::String, 0x2::balance::Balance<T0>>(&mut v0.id, 0x1::string::utf8(b"exp_coin")), 0x2::coin::into_balance<T0>(arg4));
        0x2::kiosk::list<0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(arg1, arg2, arg3, 0);
        let (v1, v2) = 0x2::kiosk::purchase<0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(arg1, arg3, 0x2::coin::zero<0x2::sui::SUI>(arg5));
        let v3 = v1;
        let (_, _, _) = 0x2::transfer_policy::confirm_request<0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(&v0.policy, v2);
        0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::nft_exp_up(&v0.nft_manager_cap, &mut v3, 0x2::coin::value<T0>(&arg4));
        0x2::kiosk::lock<0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(arg1, arg2, &v0.policy, v3);
    }

    entry fun daily_attend(arg0: &mut 0x9346203b8cd6f2f7bf6002bbf6c087308214556c3b17ce8c000397f2de886cc2::typus_dov_single::Registry, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        0x9346203b8cd6f2f7bf6002bbf6c087308214556c3b17ce8c000397f2de886cc2::typus_dov_single::version_check(arg0);
        assert!(0x2::dynamic_field::exists_<vector<u8>>(registry_uid(arg0), b"nft_extension"), 0);
        let v0 = 0x2::dynamic_field::borrow_mut<vector<u8>, NftExtension>(registry_mut_uid(arg0), b"nft_extension");
        let v1 = &mut v0.nft_table;
        assert!(0x2::object_table::contains<address, 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(v1, 0x2::tx_context::sender(arg2)), 2);
        let v2 = 0x2::object_table::borrow_mut<address, 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(v1, 0x2::tx_context::sender(arg2));
        let v3 = 0x2::clock::timestamp_ms(arg1);
        assert!(align_daily_ts(0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::get_u64_padding(&v0.nft_manager_cap, v2, 0x1::string::utf8(b"attendance_ms"))) < align_daily_ts(v3), 3);
        0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::update_u64_padding(&v0.nft_manager_cap, v2, 0x1::string::utf8(b"attendance_ms"), v3);
        let v4 = 10;
        0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::nft_exp_up(&v0.nft_manager_cap, v2, v4);
        let v5 = DailyAttendEvent{
            sender   : 0x2::tx_context::sender(arg2),
            nft_id   : 0x2::object::id<0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(v2),
            number   : 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::tails_number(v2),
            ts_ms    : 0x2::clock::timestamp_ms(arg1),
            exp_earn : v4,
        };
        0x2::event::emit<DailyAttendEvent>(v5);
    }

    public(friend) entry fun deposit<T0, T1>(arg0: &mut 0x9346203b8cd6f2f7bf6002bbf6c087308214556c3b17ce8c000397f2de886cc2::typus_dov_single::Registry, arg1: u64, arg2: vector<0x2::coin::Coin<T0>>, arg3: u64, arg4: vector<0xd3b97a40e70f5a15dfa78598dd9c1db8c6bc16f579d78cbb0d86465e3565c130::vault::TypusDepositReceipt>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x9346203b8cd6f2f7bf6002bbf6c087308214556c3b17ce8c000397f2de886cc2::typus_dov_single::version_check(arg0);
        let v0 = 0x9346203b8cd6f2f7bf6002bbf6c087308214556c3b17ce8c000397f2de886cc2::tds_user_entry::deposit<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg6);
        if (0x2::dynamic_field::exists_<vector<u8>>(registry_uid(arg0), b"nft_extension")) {
            let v1 = 0x2::dynamic_field::borrow_mut<vector<u8>, NftExtension>(registry_mut_uid(arg0), b"nft_extension");
            if (0x2::object_table::contains<address, 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(&v1.nft_table, 0x2::tx_context::sender(arg6))) {
                let v2 = snapshot_(v1, arg5, arg6);
                let v3 = 0x2::object_table::borrow_mut<address, 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(&mut v1.nft_table, 0x2::tx_context::sender(arg6));
                0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::first_deposit(&v1.nft_manager_cap, v3);
                let v4 = v2 + v0;
                0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::update_u64_padding(&v1.nft_manager_cap, v3, 0x1::string::utf8(b"usd_in_deposit"), v4);
                let v5 = UpdateDepositEvent{
                    sender : 0x2::tx_context::sender(arg6),
                    nft_id : 0x2::object::id<0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(v3),
                    number : 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::tails_number(v3),
                    before : v2,
                    after  : v4,
                };
                0x2::event::emit<UpdateDepositEvent>(v5);
            };
        };
    }

    public fun has_staked(arg0: &0x9346203b8cd6f2f7bf6002bbf6c087308214556c3b17ce8c000397f2de886cc2::typus_dov_single::Registry, arg1: address) : bool {
        assert!(0x2::dynamic_field::exists_<vector<u8>>(registry_uid(arg0), b"nft_extension"), 0);
        0x2::object_table::contains<address, 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(&0x2::dynamic_field::borrow<vector<u8>, NftExtension>(registry_uid(arg0), b"nft_extension").nft_table, arg1)
    }

    entry fun level_up(arg0: &mut 0x9346203b8cd6f2f7bf6002bbf6c087308214556c3b17ce8c000397f2de886cc2::typus_dov_single::Registry, arg1: &mut 0x2::tx_context::TxContext) {
        0x9346203b8cd6f2f7bf6002bbf6c087308214556c3b17ce8c000397f2de886cc2::typus_dov_single::version_check(arg0);
        assert!(0x2::dynamic_field::exists_<vector<u8>>(registry_uid(arg0), b"nft_extension"), 0);
        let v0 = 0x2::dynamic_field::borrow_mut<vector<u8>, NftExtension>(registry_mut_uid(arg0), b"nft_extension");
        let v1 = &mut v0.nft_table;
        let v2 = 0x2::tx_context::sender(arg1);
        assert!(0x2::object_table::contains<address, 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(v1, 0x2::tx_context::sender(arg1)), 2);
        let v3 = 0x2::object_table::borrow_mut<address, 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(v1, v2);
        let v4 = 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::level_up(&v0.nft_manager_cap, v3);
        if (0x1::option::is_some<u64>(&v4)) {
            let v5 = LevelUpEvent{
                nft_id : 0x2::object::id<0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(v3),
                number : 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::tails_number(v3),
                sender : v2,
                level  : 0x1::option::extract<u64>(&mut v4),
            };
            0x2::event::emit<LevelUpEvent>(v5);
            0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::update_u64_padding(&v0.nft_manager_cap, v3, 0x1::string::utf8(b"updating_url"), 1);
        };
    }

    public fun migrate_nft_extension(arg0: &mut 0x9346203b8cd6f2f7bf6002bbf6c087308214556c3b17ce8c000397f2de886cc2::typus_dov_single::Registry, arg1: 0x2::object_table::ObjectTable<address, 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>, arg2: 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::ManagerCap, arg3: 0x2::transfer_policy::TransferPolicy<0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) {
        0x9346203b8cd6f2f7bf6002bbf6c087308214556c3b17ce8c000397f2de886cc2::typus_dov_single::version_check(arg0);
        0x9346203b8cd6f2f7bf6002bbf6c087308214556c3b17ce8c000397f2de886cc2::typus_dov_single::validate_registry_authority(arg0, arg5);
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

    public(friend) entry fun new_bid<T0, T1>(arg0: &mut 0x9346203b8cd6f2f7bf6002bbf6c087308214556c3b17ce8c000397f2de886cc2::typus_dov_single::Registry, arg1: u64, arg2: vector<0x2::coin::Coin<T1>>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x9346203b8cd6f2f7bf6002bbf6c087308214556c3b17ce8c000397f2de886cc2::typus_dov_single::version_check(arg0);
        let v0 = 0x9346203b8cd6f2f7bf6002bbf6c087308214556c3b17ce8c000397f2de886cc2::tds_user_entry::new_bid<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
        if (0x2::dynamic_field::exists_<vector<u8>>(registry_uid(arg0), b"nft_extension")) {
            let v1 = 0x2::dynamic_field::borrow_mut<vector<u8>, NftExtension>(registry_mut_uid(arg0), b"nft_extension");
            let v2 = &mut v1.nft_table;
            if (0x2::object_table::contains<address, 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(v2, 0x2::tx_context::sender(arg5))) {
                let v3 = 0x2::object_table::borrow_mut<address, 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(v2, 0x2::tx_context::sender(arg5));
                0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::first_bid(&v1.nft_manager_cap, v3);
                0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::nft_exp_up(&v1.nft_manager_cap, v3, v0 * 200);
            };
        };
    }

    public fun partner_add_exp(arg0: &mut 0x9346203b8cd6f2f7bf6002bbf6c087308214556c3b17ce8c000397f2de886cc2::typus_dov_single::Registry, arg1: &PartnerKey, arg2: address, arg3: u64) {
        0x9346203b8cd6f2f7bf6002bbf6c087308214556c3b17ce8c000397f2de886cc2::typus_dov_single::version_check(arg0);
        assert!(0x2::dynamic_field::exists_<vector<u8>>(registry_uid(arg0), b"nft_extension"), 0);
        let v0 = 0x2::dynamic_field::borrow_mut<vector<u8>, NftExtension>(registry_mut_uid(arg0), b"nft_extension");
        let v1 = &mut v0.nft_table;
        let v2 = 0x2::dynamic_field::borrow_mut<0x1::string::String, Partner>(&mut v0.id, arg1.partner);
        assert!(&arg1.for == 0x2::object::borrow_id<Partner>(v2), 6);
        if (0x2::object_table::contains<address, 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(v1, arg2)) {
            let v3 = 0x2::object_table::borrow_mut<address, 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(v1, arg2);
            let v4 = 0x2::vec_map::keys<0x1::string::String, 0x1::string::String>(&v2.partner_traits);
            let v5 = 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::tails_attributes(v3);
            let v6 = true;
            while (0x1::vector::length<0x1::string::String>(&v4) > 0) {
                let v7 = 0x1::vector::pop_back<0x1::string::String>(&mut v4);
                if (0x2::vec_map::get<0x1::string::String, 0x1::string::String>(&v5, &v7) != 0x2::vec_map::get<0x1::string::String, 0x1::string::String>(&v2.partner_traits, &v7)) {
                    v6 = false;
                };
            };
            if (v6) {
                0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::nft_exp_up(&v0.nft_manager_cap, v3, arg3);
                v2.exp_allocation = v2.exp_allocation - arg3;
            };
        };
    }

    fun registry_mut_uid(arg0: &mut 0x9346203b8cd6f2f7bf6002bbf6c087308214556c3b17ce8c000397f2de886cc2::typus_dov_single::Registry) : &mut 0x2::object::UID {
        let (v0, _, _, _, _, _, _, _, _, _, _, _) = 0x9346203b8cd6f2f7bf6002bbf6c087308214556c3b17ce8c000397f2de886cc2::typus_dov_single::get_mut_registry_inner(arg0);
        v0
    }

    fun registry_uid(arg0: &0x9346203b8cd6f2f7bf6002bbf6c087308214556c3b17ce8c000397f2de886cc2::typus_dov_single::Registry) : &0x2::object::UID {
        let (v0, _, _, _, _, _, _, _, _, _, _, _) = 0x9346203b8cd6f2f7bf6002bbf6c087308214556c3b17ce8c000397f2de886cc2::typus_dov_single::get_registry_inner(arg0);
        v0
    }

    entry fun remove_exp_coin_extension<T0>(arg0: &mut 0x9346203b8cd6f2f7bf6002bbf6c087308214556c3b17ce8c000397f2de886cc2::typus_dov_single::Registry, arg1: &mut 0x2::tx_context::TxContext) {
        0x9346203b8cd6f2f7bf6002bbf6c087308214556c3b17ce8c000397f2de886cc2::typus_dov_single::version_check(arg0);
        0x9346203b8cd6f2f7bf6002bbf6c087308214556c3b17ce8c000397f2de886cc2::typus_dov_single::validate_registry_authority(arg0, arg1);
        assert!(0x2::dynamic_field::exists_<vector<u8>>(registry_uid(arg0), b"nft_extension"), 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::dynamic_field::remove<0x1::string::String, 0x2::balance::Balance<T0>>(&mut 0x2::dynamic_field::borrow_mut<vector<u8>, NftExtension>(registry_mut_uid(arg0), b"nft_extension").id, 0x1::string::utf8(b"exp_coin")), arg1), 0x2::tx_context::sender(arg1));
    }

    public fun remove_nft_extension(arg0: &mut 0x9346203b8cd6f2f7bf6002bbf6c087308214556c3b17ce8c000397f2de886cc2::typus_dov_single::Registry, arg1: &mut 0x2::tx_context::TxContext) : (0x2::object_table::ObjectTable<address, 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>, 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::ManagerCap, 0x2::transfer_policy::TransferPolicy<0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>, 0x2::coin::Coin<0x2::sui::SUI>) {
        0x9346203b8cd6f2f7bf6002bbf6c087308214556c3b17ce8c000397f2de886cc2::typus_dov_single::version_check(arg0);
        0x9346203b8cd6f2f7bf6002bbf6c087308214556c3b17ce8c000397f2de886cc2::typus_dov_single::validate_registry_authority(arg0, arg1);
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

    entry fun remove_partner_extension(arg0: &mut 0x9346203b8cd6f2f7bf6002bbf6c087308214556c3b17ce8c000397f2de886cc2::typus_dov_single::Registry, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        0x9346203b8cd6f2f7bf6002bbf6c087308214556c3b17ce8c000397f2de886cc2::typus_dov_single::version_check(arg0);
        0x9346203b8cd6f2f7bf6002bbf6c087308214556c3b17ce8c000397f2de886cc2::typus_dov_single::validate_registry_authority(arg0, arg2);
        assert!(0x2::dynamic_field::exists_<vector<u8>>(registry_uid(arg0), b"nft_extension"), 0);
        let Partner {
            id             : v0,
            exp_allocation : _,
            partner_traits : _,
        } = 0x2::dynamic_field::remove<0x1::string::String, Partner>(&mut 0x2::dynamic_field::borrow_mut<vector<u8>, NftExtension>(registry_mut_uid(arg0), b"nft_extension").id, arg1);
        0x2::object::delete(v0);
    }

    entry fun remove_partner_trait(arg0: &mut 0x9346203b8cd6f2f7bf6002bbf6c087308214556c3b17ce8c000397f2de886cc2::typus_dov_single::Registry, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        0x9346203b8cd6f2f7bf6002bbf6c087308214556c3b17ce8c000397f2de886cc2::typus_dov_single::version_check(arg0);
        0x9346203b8cd6f2f7bf6002bbf6c087308214556c3b17ce8c000397f2de886cc2::typus_dov_single::validate_registry_authority(arg0, arg3);
        assert!(0x2::dynamic_field::exists_<vector<u8>>(registry_uid(arg0), b"nft_extension"), 0);
        let (_, _) = 0x2::vec_map::remove<0x1::string::String, 0x1::string::String>(&mut 0x2::dynamic_field::borrow_mut<0x1::string::String, Partner>(&mut 0x2::dynamic_field::borrow_mut<vector<u8>, NftExtension>(registry_mut_uid(arg0), b"nft_extension").id, arg1).partner_traits, &arg2);
    }

    entry fun snapshot(arg0: &mut 0x9346203b8cd6f2f7bf6002bbf6c087308214556c3b17ce8c000397f2de886cc2::typus_dov_single::Registry, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        0x9346203b8cd6f2f7bf6002bbf6c087308214556c3b17ce8c000397f2de886cc2::typus_dov_single::version_check(arg0);
        assert!(0x2::dynamic_field::exists_<vector<u8>>(registry_uid(arg0), b"nft_extension"), 0);
        let v0 = 0x2::dynamic_field::borrow_mut<vector<u8>, NftExtension>(registry_mut_uid(arg0), b"nft_extension");
        if (0x2::object_table::contains<address, 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(&v0.nft_table, 0x2::tx_context::sender(arg2))) {
            snapshot_(v0, arg1, arg2);
        };
    }

    fun snapshot_(arg0: &mut NftExtension, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = 0x2::object_table::borrow_mut<address, 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(&mut arg0.nft_table, 0x2::tx_context::sender(arg2));
        let v2 = 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::get_u64_padding(&arg0.nft_manager_cap, v1, 0x1::string::utf8(b"usd_in_deposit"));
        let v3 = v2 * (v0 - 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::get_u64_padding(&arg0.nft_manager_cap, v1, 0x1::string::utf8(b"snapshot_ms"))) / 60000 / 6000;
        0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::nft_exp_up(&arg0.nft_manager_cap, v1, v3);
        0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::update_u64_padding(&arg0.nft_manager_cap, v1, 0x1::string::utf8(b"snapshot_ms"), v0);
        let v4 = SnapshotNftEvent{
            sender   : 0x2::tx_context::sender(arg2),
            nft_id   : 0x2::object::id<0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(v1),
            number   : 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::tails_number(v1),
            ts_ms    : v0,
            exp_earn : v3,
        };
        0x2::event::emit<SnapshotNftEvent>(v4);
        v2
    }

    entry fun snapshot_and_calibrate(arg0: &mut 0x9346203b8cd6f2f7bf6002bbf6c087308214556c3b17ce8c000397f2de886cc2::typus_dov_single::Registry, arg1: vector<address>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x9346203b8cd6f2f7bf6002bbf6c087308214556c3b17ce8c000397f2de886cc2::typus_dov_single::version_check(arg0);
        0x9346203b8cd6f2f7bf6002bbf6c087308214556c3b17ce8c000397f2de886cc2::typus_dov_single::validate_registry_authority(arg0, arg3);
        assert!(0x2::dynamic_field::exists_<vector<u8>>(registry_uid(arg0), b"nft_extension"), 0);
        let v0 = 0x2::dynamic_field::borrow_mut<vector<u8>, NftExtension>(registry_mut_uid(arg0), b"nft_extension");
        let v1 = 0x2::clock::timestamp_ms(arg2);
        while (0x1::vector::length<address>(&arg1) > 0) {
            let v2 = 0x1::vector::pop_back<address>(&mut arg1);
            let v3 = 0x2::object_table::borrow_mut<address, 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(&mut v0.nft_table, v2);
            let v4 = 0;
            if (0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::contains_u64_padding(&v0.nft_manager_cap, v3, 0x1::string::utf8(b"usd_in_deposit"))) {
                v4 = 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::get_u64_padding(&v0.nft_manager_cap, v3, 0x1::string::utf8(b"usd_in_deposit"));
                0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::update_u64_padding(&v0.nft_manager_cap, v3, 0x1::string::utf8(b"usd_in_deposit"), 0);
            } else {
                0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::insert_u64_padding(&v0.nft_manager_cap, v3, 0x1::string::utf8(b"usd_in_deposit"), 0);
            };
            let v5 = v1;
            if (0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::contains_u64_padding(&v0.nft_manager_cap, v3, 0x1::string::utf8(b"snapshot_ms"))) {
                v5 = 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::get_u64_padding(&v0.nft_manager_cap, v3, 0x1::string::utf8(b"snapshot_ms"));
                0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::update_u64_padding(&v0.nft_manager_cap, v3, 0x1::string::utf8(b"snapshot_ms"), v1);
            } else {
                0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::insert_u64_padding(&v0.nft_manager_cap, v3, 0x1::string::utf8(b"snapshot_ms"), v1);
            };
            let v6 = v4 * (v1 - v5) / 60000 / 6000;
            0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::nft_exp_up(&v0.nft_manager_cap, v3, v6);
            let v7 = SnapshotNftEvent{
                sender   : v2,
                nft_id   : 0x2::object::id<0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(v3),
                number   : 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::tails_number(v3),
                ts_ms    : v1,
                exp_earn : v6,
            };
            0x2::event::emit<SnapshotNftEvent>(v7);
        };
    }

    entry fun stake_nft(arg0: &mut 0x9346203b8cd6f2f7bf6002bbf6c087308214556c3b17ce8c000397f2de886cc2::typus_dov_single::Registry, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &mut 0x2::tx_context::TxContext) {
        0x9346203b8cd6f2f7bf6002bbf6c087308214556c3b17ce8c000397f2de886cc2::typus_dov_single::version_check(arg0);
        assert!(0x2::dynamic_field::exists_<vector<u8>>(registry_uid(arg0), b"nft_extension"), 0);
        let v0 = 0x2::dynamic_field::borrow_mut<vector<u8>, NftExtension>(registry_mut_uid(arg0), b"nft_extension");
        let v1 = &mut v0.nft_table;
        assert!(!0x2::object_table::contains<address, 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(v1, 0x2::tx_context::sender(arg6)), 1);
        0x2::kiosk::list<0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(arg1, arg2, arg3, 0);
        let (v2, v3) = 0x2::kiosk::purchase<0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(arg1, arg3, 0x2::coin::zero<0x2::sui::SUI>(arg6));
        let v4 = v2;
        let (_, _, _) = 0x2::transfer_policy::confirm_request<0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(&v0.policy, v3);
        0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::insert_u64_padding(&v0.nft_manager_cap, &mut v4, 0x1::string::utf8(b"updating_url"), 0);
        if (!0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::contains_u64_padding(&v0.nft_manager_cap, &mut v4, 0x1::string::utf8(b"attendance_ms"))) {
            0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::insert_u64_padding(&v0.nft_manager_cap, &mut v4, 0x1::string::utf8(b"attendance_ms"), 0);
        };
        let v8 = 0x2::clock::timestamp_ms(arg4);
        if (!0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::contains_u64_padding(&v0.nft_manager_cap, &mut v4, 0x1::string::utf8(b"snapshot_ms"))) {
            0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::insert_u64_padding(&v0.nft_manager_cap, &mut v4, 0x1::string::utf8(b"snapshot_ms"), v8);
        } else {
            0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::update_u64_padding(&v0.nft_manager_cap, &mut v4, 0x1::string::utf8(b"snapshot_ms"), v8);
        };
        if (!0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::contains_u64_padding(&v0.nft_manager_cap, &mut v4, 0x1::string::utf8(b"usd_in_deposit"))) {
            0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::insert_u64_padding(&v0.nft_manager_cap, &mut v4, 0x1::string::utf8(b"usd_in_deposit"), 0);
        } else {
            0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::update_u64_padding(&v0.nft_manager_cap, &mut v4, 0x1::string::utf8(b"usd_in_deposit"), 0);
        };
        0x2::object_table::add<address, 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(v1, 0x2::tx_context::sender(arg6), v4);
        let v9 = StakeNftEvent{
            sender : 0x2::tx_context::sender(arg6),
            nft_id : arg3,
            number : 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::tails_number(&v4),
            ts_ms  : v8,
        };
        0x2::event::emit<StakeNftEvent>(v9);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg5) == 50000000, 5);
        0x2::balance::join<0x2::sui::SUI>(&mut v0.fee, 0x2::coin::into_balance<0x2::sui::SUI>(arg5));
    }

    entry fun transfer_nft(arg0: &mut 0x9346203b8cd6f2f7bf6002bbf6c087308214556c3b17ce8c000397f2de886cc2::typus_dov_single::Registry, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: address, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &mut 0x2::tx_context::TxContext) {
        0x9346203b8cd6f2f7bf6002bbf6c087308214556c3b17ce8c000397f2de886cc2::typus_dov_single::version_check(arg0);
        assert!(0x2::dynamic_field::exists_<vector<u8>>(registry_uid(arg0), b"nft_extension"), 0);
        let v0 = 0x2::dynamic_field::borrow_mut<vector<u8>, NftExtension>(registry_mut_uid(arg0), b"nft_extension");
        0x2::kiosk::list<0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(arg1, arg2, arg3, 0);
        let (v1, v2) = 0x2::kiosk::purchase<0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(arg1, arg3, 0x2::coin::zero<0x2::sui::SUI>(arg6));
        let v3 = v1;
        let (_, _, _) = 0x2::transfer_policy::confirm_request<0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(&v0.policy, v2);
        let (v7, v8) = 0x2::kiosk::new(arg6);
        let v9 = v8;
        let v10 = v7;
        0x2::kiosk::lock<0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(&mut v10, &v9, &v0.policy, v3);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v10);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v9, arg4);
        let v11 = TransferNftEvent{
            sender   : 0x2::tx_context::sender(arg6),
            receiver : arg4,
            nft_id   : arg3,
            number   : 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::tails_number(&v3),
        };
        0x2::event::emit<TransferNftEvent>(v11);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg5) == 10000000, 5);
        0x2::balance::join<0x2::sui::SUI>(&mut v0.fee, 0x2::coin::into_balance<0x2::sui::SUI>(arg5));
    }

    entry fun unstake_nft(arg0: &mut 0x9346203b8cd6f2f7bf6002bbf6c087308214556c3b17ce8c000397f2de886cc2::typus_dov_single::Registry, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: &mut 0x2::tx_context::TxContext) {
        0x9346203b8cd6f2f7bf6002bbf6c087308214556c3b17ce8c000397f2de886cc2::typus_dov_single::version_check(arg0);
        assert!(0x2::dynamic_field::exists_<vector<u8>>(registry_uid(arg0), b"nft_extension"), 0);
        let v0 = 0x2::dynamic_field::borrow_mut<vector<u8>, NftExtension>(registry_mut_uid(arg0), b"nft_extension");
        let v1 = &mut v0.nft_table;
        assert!(0x2::object_table::contains<address, 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(v1, 0x2::tx_context::sender(arg3)), 2);
        let v2 = 0x2::object_table::remove<address, 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(v1, 0x2::tx_context::sender(arg3));
        assert!(0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::get_u64_padding(&v0.nft_manager_cap, &v2, 0x1::string::utf8(b"updating_url")) == 0, 4);
        0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::remove_u64_padding(&v0.nft_manager_cap, &mut v2, 0x1::string::utf8(b"updating_url"));
        0x2::kiosk::lock<0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(arg1, arg2, &v0.policy, v2);
        let v3 = UnstakeNftEvent{
            sender : 0x2::tx_context::sender(arg3),
            nft_id : 0x2::object::id<0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(&v2),
            number : 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::tails_number(&v2),
        };
        0x2::event::emit<UnstakeNftEvent>(v3);
    }

    public(friend) entry fun unsubscribe<T0, T1>(arg0: &mut 0x9346203b8cd6f2f7bf6002bbf6c087308214556c3b17ce8c000397f2de886cc2::typus_dov_single::Registry, arg1: u64, arg2: vector<0xd3b97a40e70f5a15dfa78598dd9c1db8c6bc16f579d78cbb0d86465e3565c130::vault::TypusDepositReceipt>, arg3: 0x1::option::Option<u64>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x9346203b8cd6f2f7bf6002bbf6c087308214556c3b17ce8c000397f2de886cc2::typus_dov_single::version_check(arg0);
        let v0 = 0x9346203b8cd6f2f7bf6002bbf6c087308214556c3b17ce8c000397f2de886cc2::tds_user_entry::unsubscribe<T0, T1>(arg0, arg1, arg2, arg3, arg5);
        if (0x2::dynamic_field::exists_<vector<u8>>(registry_uid(arg0), b"nft_extension")) {
            let v1 = 0x2::dynamic_field::borrow_mut<vector<u8>, NftExtension>(registry_mut_uid(arg0), b"nft_extension");
            if (0x2::object_table::contains<address, 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(&v1.nft_table, 0x2::tx_context::sender(arg5))) {
                let v2 = snapshot_(v1, arg4, arg5);
                let v3 = 0x2::object_table::borrow_mut<address, 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(&mut v1.nft_table, 0x2::tx_context::sender(arg5));
                let v4 = if (v2 > v0) {
                    v2 - v0
                } else {
                    0
                };
                0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::update_u64_padding(&v1.nft_manager_cap, v3, 0x1::string::utf8(b"usd_in_deposit"), v4);
                let v5 = UpdateDepositEvent{
                    sender : 0x2::tx_context::sender(arg5),
                    nft_id : 0x2::object::id<0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(v3),
                    number : 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::tails_number(v3),
                    before : v2,
                    after  : v4,
                };
                0x2::event::emit<UpdateDepositEvent>(v5);
            };
        };
    }

    entry fun update_exp_allocation(arg0: &mut 0x9346203b8cd6f2f7bf6002bbf6c087308214556c3b17ce8c000397f2de886cc2::typus_dov_single::Registry, arg1: 0x1::string::String, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x9346203b8cd6f2f7bf6002bbf6c087308214556c3b17ce8c000397f2de886cc2::typus_dov_single::version_check(arg0);
        0x9346203b8cd6f2f7bf6002bbf6c087308214556c3b17ce8c000397f2de886cc2::typus_dov_single::validate_registry_authority(arg0, arg3);
        assert!(0x2::dynamic_field::exists_<vector<u8>>(registry_uid(arg0), b"nft_extension"), 0);
        0x2::dynamic_field::borrow_mut<0x1::string::String, Partner>(&mut 0x2::dynamic_field::borrow_mut<vector<u8>, NftExtension>(registry_mut_uid(arg0), b"nft_extension").id, arg1).exp_allocation = arg2;
    }

    entry fun update_image_url(arg0: &mut 0x9346203b8cd6f2f7bf6002bbf6c087308214556c3b17ce8c000397f2de886cc2::typus_dov_single::Registry, arg1: address, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        0x9346203b8cd6f2f7bf6002bbf6c087308214556c3b17ce8c000397f2de886cc2::typus_dov_single::version_check(arg0);
        0x9346203b8cd6f2f7bf6002bbf6c087308214556c3b17ce8c000397f2de886cc2::typus_dov_single::validate_registry_authority(arg0, arg3);
        assert!(0x2::dynamic_field::exists_<vector<u8>>(registry_uid(arg0), b"nft_extension"), 0);
        let v0 = 0x2::dynamic_field::borrow_mut<vector<u8>, NftExtension>(registry_mut_uid(arg0), b"nft_extension");
        let v1 = &mut v0.nft_table;
        assert!(0x2::object_table::contains<address, 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(v1, arg1), 2);
        let v2 = 0x2::object_table::borrow_mut<address, 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(v1, arg1);
        0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::update_image_url(&v0.nft_manager_cap, v2, arg2);
        0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::update_u64_padding(&v0.nft_manager_cap, v2, 0x1::string::utf8(b"updating_url"), 0);
        let v3 = UpdateUrlEvent{
            nft_id : 0x2::object::id<0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(v2),
            number : 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::tails_number(v2),
            level  : 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::tails_level(v2),
            url    : arg2,
        };
        0x2::event::emit<UpdateUrlEvent>(v3);
    }

    public(friend) entry fun withdraw<T0, T1>(arg0: &mut 0x9346203b8cd6f2f7bf6002bbf6c087308214556c3b17ce8c000397f2de886cc2::typus_dov_single::Registry, arg1: u64, arg2: vector<0xd3b97a40e70f5a15dfa78598dd9c1db8c6bc16f579d78cbb0d86465e3565c130::vault::TypusDepositReceipt>, arg3: 0x1::option::Option<u64>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x9346203b8cd6f2f7bf6002bbf6c087308214556c3b17ce8c000397f2de886cc2::typus_dov_single::version_check(arg0);
        let v0 = 0x9346203b8cd6f2f7bf6002bbf6c087308214556c3b17ce8c000397f2de886cc2::tds_user_entry::withdraw<T0, T1>(arg0, arg1, arg2, arg3, arg5);
        if (0x2::dynamic_field::exists_<vector<u8>>(registry_uid(arg0), b"nft_extension")) {
            let v1 = 0x2::dynamic_field::borrow_mut<vector<u8>, NftExtension>(registry_mut_uid(arg0), b"nft_extension");
            if (0x2::object_table::contains<address, 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(&v1.nft_table, 0x2::tx_context::sender(arg5))) {
                let v2 = snapshot_(v1, arg4, arg5);
                let v3 = 0x2::object_table::borrow_mut<address, 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(&mut v1.nft_table, 0x2::tx_context::sender(arg5));
                let v4 = if (v2 > v0) {
                    v2 - v0
                } else {
                    0
                };
                0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::update_u64_padding(&v1.nft_manager_cap, v3, 0x1::string::utf8(b"usd_in_deposit"), v4);
                let v5 = UpdateDepositEvent{
                    sender : 0x2::tx_context::sender(arg5),
                    nft_id : 0x2::object::id<0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(v3),
                    number : 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::tails_number(v3),
                    before : v2,
                    after  : v4,
                };
                0x2::event::emit<UpdateDepositEvent>(v5);
            };
        };
    }

    entry fun withdraw_fee(arg0: &mut 0x9346203b8cd6f2f7bf6002bbf6c087308214556c3b17ce8c000397f2de886cc2::typus_dov_single::Registry, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x9346203b8cd6f2f7bf6002bbf6c087308214556c3b17ce8c000397f2de886cc2::typus_dov_single::version_check(arg0);
        0x9346203b8cd6f2f7bf6002bbf6c087308214556c3b17ce8c000397f2de886cc2::typus_dov_single::validate_registry_authority(arg0, arg2);
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

