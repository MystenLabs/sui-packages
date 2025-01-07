module 0xa76499eda1d37751473de5f30e106f35943ada2f6ea764861243e7f5aa5bcc97::tails_staking {
    struct NftExtension has store, key {
        id: 0x2::object::UID,
        nft_table: 0x2::object_table::ObjectTable<address, 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>,
        nft_manager_cap: 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::ManagerCap,
        policy: 0x2::transfer_policy::TransferPolicy<0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>,
        fee: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct TransferNftEvent has copy, drop {
        sender: address,
        receiver: address,
        nft_id: 0x2::object::ID,
        number: u64,
    }

    struct WithdrawEvent has copy, drop {
        sender: address,
        receiver: address,
        amount: u64,
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

    entry fun add_exp(arg0: &mut 0xa76499eda1d37751473de5f30e106f35943ada2f6ea764861243e7f5aa5bcc97::typus_dov_single::Registry, arg1: &0xa76499eda1d37751473de5f30e106f35943ada2f6ea764861243e7f5aa5bcc97::typus_dov_single::ManagerCap, arg2: address, arg3: u64) {
        assert!(0x2::dynamic_field::exists_<vector<u8>>(0xa76499eda1d37751473de5f30e106f35943ada2f6ea764861243e7f5aa5bcc97::typus_dov_single::registry_uid(arg0), b"nft_extension"), 0);
        let v0 = 0x2::dynamic_field::borrow_mut<vector<u8>, NftExtension>(0xa76499eda1d37751473de5f30e106f35943ada2f6ea764861243e7f5aa5bcc97::typus_dov_single::registry_mut_uid(arg0), b"nft_extension");
        let v1 = &mut v0.nft_table;
        assert!(0x2::object_table::contains<address, 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(v1, arg2), 2);
        0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::nft_exp_up(&v0.nft_manager_cap, 0x2::object_table::borrow_mut<address, 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(v1, arg2), arg3);
    }

    entry fun add_nft_extension(arg0: &mut 0xa76499eda1d37751473de5f30e106f35943ada2f6ea764861243e7f5aa5bcc97::typus_dov_single::Registry, arg1: 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::ManagerCap, arg2: &0x2::package::Publisher, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::dynamic_field::exists_<vector<u8>>(0xa76499eda1d37751473de5f30e106f35943ada2f6ea764861243e7f5aa5bcc97::typus_dov_single::registry_uid(arg0), b"nft_extension"), 0);
        let (v0, v1) = 0x2::transfer_policy::new<0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(arg2, arg3);
        let v2 = NftExtension{
            id              : 0x2::object::new(arg3),
            nft_table       : 0x2::object_table::new<address, 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(arg3),
            nft_manager_cap : arg1,
            policy          : v0,
            fee             : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::dynamic_field::add<vector<u8>, NftExtension>(0xa76499eda1d37751473de5f30e106f35943ada2f6ea764861243e7f5aa5bcc97::typus_dov_single::registry_mut_uid(arg0), b"nft_extension", v2);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>>(v1, 0x2::tx_context::sender(arg3));
    }

    fun align_daily_ts(arg0: u64) : u64 {
        arg0 - arg0 % 86400000
    }

    entry fun daily_attend(arg0: &mut 0xa76499eda1d37751473de5f30e106f35943ada2f6ea764861243e7f5aa5bcc97::typus_dov_single::Registry, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::dynamic_field::exists_<vector<u8>>(0xa76499eda1d37751473de5f30e106f35943ada2f6ea764861243e7f5aa5bcc97::typus_dov_single::registry_uid(arg0), b"nft_extension"), 0);
        let v0 = 0x2::dynamic_field::borrow_mut<vector<u8>, NftExtension>(0xa76499eda1d37751473de5f30e106f35943ada2f6ea764861243e7f5aa5bcc97::typus_dov_single::registry_mut_uid(arg0), b"nft_extension");
        let v1 = &mut v0.nft_table;
        assert!(0x2::object_table::contains<address, 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(v1, 0x2::tx_context::sender(arg2)), 2);
        let v2 = 0x2::object_table::borrow_mut<address, 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(v1, 0x2::tx_context::sender(arg2));
        let v3 = 0x2::clock::timestamp_ms(arg1);
        if (!0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::contains_u64_padding(&v0.nft_manager_cap, v2, 0x1::string::utf8(b"attendance_ms"))) {
            0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::insert_u64_padding(&v0.nft_manager_cap, v2, 0x1::string::utf8(b"attendance_ms"), 0);
        };
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

    entry fun deposit_w_nft<T0, T1, T2>(arg0: &mut 0xa76499eda1d37751473de5f30e106f35943ada2f6ea764861243e7f5aa5bcc97::typus_dov_single::Registry, arg1: &0xa76499eda1d37751473de5f30e106f35943ada2f6ea764861243e7f5aa5bcc97::typus_dov_single::AdditionalConfigRegistry, arg2: u64, arg3: vector<0x2::coin::Coin<T0>>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::dynamic_field::exists_<vector<u8>>(0xa76499eda1d37751473de5f30e106f35943ada2f6ea764861243e7f5aa5bcc97::typus_dov_single::registry_uid(arg0), b"nft_extension"), 0);
        let v0 = 0x2::dynamic_field::borrow_mut<vector<u8>, NftExtension>(0xa76499eda1d37751473de5f30e106f35943ada2f6ea764861243e7f5aa5bcc97::typus_dov_single::registry_mut_uid(arg0), b"nft_extension");
        let v1 = &mut v0.nft_table;
        assert!(0x2::object_table::contains<address, 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(v1, 0x2::tx_context::sender(arg5)), 2);
        0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::first_deposit(&v0.nft_manager_cap, 0x2::object_table::borrow_mut<address, 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(v1, 0x2::tx_context::sender(arg5)));
        0xa76499eda1d37751473de5f30e106f35943ada2f6ea764861243e7f5aa5bcc97::typus_dov_single::deposit<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    entry fun level_up(arg0: &mut 0xa76499eda1d37751473de5f30e106f35943ada2f6ea764861243e7f5aa5bcc97::typus_dov_single::Registry, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::dynamic_field::exists_<vector<u8>>(0xa76499eda1d37751473de5f30e106f35943ada2f6ea764861243e7f5aa5bcc97::typus_dov_single::registry_uid(arg0), b"nft_extension"), 0);
        let v0 = 0x2::dynamic_field::borrow_mut<vector<u8>, NftExtension>(0xa76499eda1d37751473de5f30e106f35943ada2f6ea764861243e7f5aa5bcc97::typus_dov_single::registry_mut_uid(arg0), b"nft_extension");
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

    entry fun new_bid_w_nft<T0, T1, T2>(arg0: &mut 0xa76499eda1d37751473de5f30e106f35943ada2f6ea764861243e7f5aa5bcc97::typus_dov_single::Registry, arg1: &mut 0xa76499eda1d37751473de5f30e106f35943ada2f6ea764861243e7f5aa5bcc97::typus_dov_single::AdditionalConfigRegistry, arg2: u64, arg3: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg4: &0x2::clock::Clock, arg5: vector<0x2::coin::Coin<T1>>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::dynamic_field::exists_<vector<u8>>(0xa76499eda1d37751473de5f30e106f35943ada2f6ea764861243e7f5aa5bcc97::typus_dov_single::registry_uid(arg0), b"nft_extension"), 0);
        let v0 = 0x2::dynamic_field::borrow_mut<vector<u8>, NftExtension>(0xa76499eda1d37751473de5f30e106f35943ada2f6ea764861243e7f5aa5bcc97::typus_dov_single::registry_mut_uid(arg0), b"nft_extension");
        let v1 = &mut v0.nft_table;
        assert!(0x2::object_table::contains<address, 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(v1, 0x2::tx_context::sender(arg7)), 2);
        let v2 = 0x2::object_table::borrow_mut<address, 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(v1, 0x2::tx_context::sender(arg7));
        0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::first_bid(&v0.nft_manager_cap, v2);
        0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::nft_exp_up(&v0.nft_manager_cap, v2, 0xa76499eda1d37751473de5f30e106f35943ada2f6ea764861243e7f5aa5bcc97::typus_dov_single::f_new_bid<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7) * 50);
    }

    entry fun stake_nft(arg0: &mut 0xa76499eda1d37751473de5f30e106f35943ada2f6ea764861243e7f5aa5bcc97::typus_dov_single::Registry, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::dynamic_field::exists_<vector<u8>>(0xa76499eda1d37751473de5f30e106f35943ada2f6ea764861243e7f5aa5bcc97::typus_dov_single::registry_uid(arg0), b"nft_extension"), 0);
        let v0 = 0x2::dynamic_field::borrow_mut<vector<u8>, NftExtension>(0xa76499eda1d37751473de5f30e106f35943ada2f6ea764861243e7f5aa5bcc97::typus_dov_single::registry_mut_uid(arg0), b"nft_extension");
        let v1 = &mut v0.nft_table;
        0x2::kiosk::list<0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(arg1, arg2, arg3, 0);
        let (v2, v3) = 0x2::kiosk::purchase<0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(arg1, arg3, 0x2::coin::zero<0x2::sui::SUI>(arg5));
        let v4 = v2;
        let (_, _, _) = 0x2::transfer_policy::confirm_request<0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(&v0.policy, v3);
        if (!0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::contains_u64_padding(&v0.nft_manager_cap, &mut v4, 0x1::string::utf8(b"attendance_ms"))) {
            0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::insert_u64_padding(&v0.nft_manager_cap, &mut v4, 0x1::string::utf8(b"attendance_ms"), 0);
        };
        0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::insert_u64_padding(&v0.nft_manager_cap, &mut v4, 0x1::string::utf8(b"updating_url"), 0);
        assert!(!0x2::object_table::contains<address, 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(v1, 0x2::tx_context::sender(arg5)), 1);
        0x2::object_table::add<address, 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(v1, 0x2::tx_context::sender(arg5), v4);
        let v8 = StakeNftEvent{
            sender : 0x2::tx_context::sender(arg5),
            nft_id : arg3,
            number : 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::tails_number(&v4),
            ts_ms  : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<StakeNftEvent>(v8);
    }

    entry fun transfer_nft(arg0: &mut 0xa76499eda1d37751473de5f30e106f35943ada2f6ea764861243e7f5aa5bcc97::typus_dov_single::Registry, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::dynamic_field::exists_<vector<u8>>(0xa76499eda1d37751473de5f30e106f35943ada2f6ea764861243e7f5aa5bcc97::typus_dov_single::registry_uid(arg0), b"nft_extension"), 0);
        let v0 = 0x2::dynamic_field::borrow_mut<vector<u8>, NftExtension>(0xa76499eda1d37751473de5f30e106f35943ada2f6ea764861243e7f5aa5bcc97::typus_dov_single::registry_mut_uid(arg0), b"nft_extension");
        0x2::kiosk::list<0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(arg1, arg2, arg3, 0);
        let (v1, v2) = 0x2::kiosk::purchase<0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(arg1, arg3, 0x2::coin::zero<0x2::sui::SUI>(arg5));
        let v3 = v1;
        let (_, _, _) = 0x2::transfer_policy::confirm_request<0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(&v0.policy, v2);
        let (v7, v8) = 0x2::kiosk::new(arg5);
        let v9 = v8;
        let v10 = v7;
        0x2::kiosk::lock<0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(&mut v10, &v9, &v0.policy, v3);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v10);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v9, arg4);
        let v11 = TransferNftEvent{
            sender   : 0x2::tx_context::sender(arg5),
            receiver : arg4,
            nft_id   : arg3,
            number   : 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::tails_number(&v3),
        };
        0x2::event::emit<TransferNftEvent>(v11);
    }

    entry fun unstake_nft(arg0: &mut 0xa76499eda1d37751473de5f30e106f35943ada2f6ea764861243e7f5aa5bcc97::typus_dov_single::Registry, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::dynamic_field::exists_<vector<u8>>(0xa76499eda1d37751473de5f30e106f35943ada2f6ea764861243e7f5aa5bcc97::typus_dov_single::registry_uid(arg0), b"nft_extension"), 0);
        let v0 = 0x2::dynamic_field::borrow_mut<vector<u8>, NftExtension>(0xa76499eda1d37751473de5f30e106f35943ada2f6ea764861243e7f5aa5bcc97::typus_dov_single::registry_mut_uid(arg0), b"nft_extension");
        let v1 = &mut v0.nft_table;
        assert!(0x2::object_table::contains<address, 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(v1, 0x2::tx_context::sender(arg4)), 2);
        let v2 = 0x2::object_table::remove<address, 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(v1, 0x2::tx_context::sender(arg4));
        assert!(0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::get_u64_padding(&v0.nft_manager_cap, &v2, 0x1::string::utf8(b"updating_url")) == 0, 4);
        0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::remove_u64_padding(&v0.nft_manager_cap, &mut v2, 0x1::string::utf8(b"updating_url"));
        0x2::kiosk::lock<0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(arg1, arg2, &v0.policy, v2);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) == 50000000, 5);
        0x2::balance::join<0x2::sui::SUI>(&mut v0.fee, 0x2::coin::into_balance<0x2::sui::SUI>(arg3));
        let v3 = UnstakeNftEvent{
            sender : 0x2::tx_context::sender(arg4),
            nft_id : 0x2::object::id<0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(&v2),
            number : 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::tails_number(&v2),
        };
        0x2::event::emit<UnstakeNftEvent>(v3);
    }

    entry fun update_image_url(arg0: &mut 0xa76499eda1d37751473de5f30e106f35943ada2f6ea764861243e7f5aa5bcc97::typus_dov_single::Registry, arg1: &0xa76499eda1d37751473de5f30e106f35943ada2f6ea764861243e7f5aa5bcc97::typus_dov_single::ManagerCap, arg2: address, arg3: vector<u8>) {
        assert!(0x2::dynamic_field::exists_<vector<u8>>(0xa76499eda1d37751473de5f30e106f35943ada2f6ea764861243e7f5aa5bcc97::typus_dov_single::registry_uid(arg0), b"nft_extension"), 0);
        let v0 = 0x2::dynamic_field::borrow_mut<vector<u8>, NftExtension>(0xa76499eda1d37751473de5f30e106f35943ada2f6ea764861243e7f5aa5bcc97::typus_dov_single::registry_mut_uid(arg0), b"nft_extension");
        let v1 = &mut v0.nft_table;
        assert!(0x2::object_table::contains<address, 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(v1, arg2), 2);
        let v2 = 0x2::object_table::borrow_mut<address, 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(v1, arg2);
        0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::update_image_url(&v0.nft_manager_cap, v2, arg3);
        0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::update_u64_padding(&v0.nft_manager_cap, v2, 0x1::string::utf8(b"updating_url"), 0);
        let v3 = UpdateUrlEvent{
            nft_id : 0x2::object::id<0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(v2),
            number : 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::tails_number(v2),
            level  : 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::tails_level(v2),
            url    : arg3,
        };
        0x2::event::emit<UpdateUrlEvent>(v3);
    }

    entry fun withdraw_fee(arg0: &mut 0xa76499eda1d37751473de5f30e106f35943ada2f6ea764861243e7f5aa5bcc97::typus_dov_single::Registry, arg1: &0xa76499eda1d37751473de5f30e106f35943ada2f6ea764861243e7f5aa5bcc97::typus_dov_single::ManagerCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::dynamic_field::exists_<vector<u8>>(0xa76499eda1d37751473de5f30e106f35943ada2f6ea764861243e7f5aa5bcc97::typus_dov_single::registry_uid(arg0), b"nft_extension"), 0);
        let v0 = 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut 0x2::dynamic_field::borrow_mut<vector<u8>, NftExtension>(0xa76499eda1d37751473de5f30e106f35943ada2f6ea764861243e7f5aa5bcc97::typus_dov_single::registry_mut_uid(arg0), b"nft_extension").fee), arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v0, arg2);
        let v1 = WithdrawEvent{
            sender   : 0x2::tx_context::sender(arg3),
            receiver : arg2,
            amount   : 0x2::coin::value<0x2::sui::SUI>(&v0),
        };
        0x2::event::emit<WithdrawEvent>(v1);
    }

    // decompiled from Move bytecode v6
}

