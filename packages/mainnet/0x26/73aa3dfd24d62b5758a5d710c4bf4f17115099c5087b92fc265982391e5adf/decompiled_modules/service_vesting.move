module 0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::service_vesting {
    struct Feature has drop {
        dummy_field: bool,
    }

    struct Config has store, key {
        id: 0x2::object::UID,
        info: VestingInfo,
        project: 0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::project::ProjectInfo,
        is_open_claim_vesting: bool,
    }

    struct VestingInfo has drop, store {
        tge_time: u64,
        tge_unlock_percent: u64,
        number_of_cliff_months: u64,
        number_of_month: u64,
        number_of_linear: u64,
        token_type: 0x1::string::String,
    }

    struct Period has store {
        period_id: u64,
        release_time: u64,
        percentage: u64,
        unlock_amount: u64,
        is_withdrawal: bool,
    }

    struct VestingDetail has store {
        total_lock_mount: u64,
        total_unlock_amount: u64,
        period_list: vector<Period>,
    }

    struct SERVICE_VESTING has drop {
        dummy_field: bool,
    }

    fun display<T0: key>(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"YouSUI x {project.name} <> {name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{project.link_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{project.image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{project.description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{project.website}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"YouSUI Creator"));
        let v4 = 0x2::display::new_with_fields<T0>(arg0, v0, v2, arg1);
        0x2::display::update_version<T0>(&mut v4);
        0x2::transfer::public_transfer<0x2::display::Display<T0>>(v4, 0x2::tx_context::sender(arg1));
    }

    public(friend) fun add(arg0: &mut 0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::service::Service, arg1: 0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::project::ProjectInfo, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: 0x1::string::String, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 <= 0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::utils::max_percent(), 500);
        let v0 = VestingInfo{
            tge_time               : arg2,
            tge_unlock_percent     : arg3,
            number_of_cliff_months : arg4,
            number_of_month        : arg5,
            number_of_linear       : arg6,
            token_type             : arg7,
        };
        let v1 = Config{
            id                    : 0x2::object::new(arg8),
            info                  : v0,
            project               : arg1,
            is_open_claim_vesting : false,
        };
        0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::service::add_feature<Feature, Config>(arg0, v1);
    }

    fun add_vesting(arg0: &mut 0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::service::Service, arg1: u64, arg2: address) {
        let v0 = 0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::service::get_feature_mut<Feature, Config>(arg0);
        if (!0x2::dynamic_field::exists_<address>(&v0.id, arg2)) {
            let v1 = VestingDetail{
                total_lock_mount    : arg1,
                total_unlock_amount : 0,
                period_list         : build_vesting_period(&v0.info, arg1),
            };
            0x2::dynamic_field::add<address, VestingDetail>(&mut v0.id, arg2, v1);
        } else {
            let v2 = 0x2::dynamic_field::borrow_mut<address, VestingDetail>(&mut v0.id, arg2);
            assert!(v2.total_unlock_amount == 0, 503);
            v2.total_lock_mount = v2.total_lock_mount + arg1;
            let v3 = &mut v2.period_list;
            update_add_vesting_period(&v0.info, v3, arg1);
        };
    }

    fun build_vesting_period(arg0: &VestingInfo, arg1: u64) : vector<Period> {
        let v0 = 0x1::vector::empty<Period>();
        let v1 = arg0.number_of_month / arg0.number_of_linear;
        let v2 = 0;
        while (v1 + 1 > v2) {
            let v3 = if (v2 == 0) {
                Period{period_id: v2, release_time: arg0.tge_time, percentage: arg0.tge_unlock_percent, unlock_amount: 0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::utils::cal_amount_with_percent(arg1, arg0.tge_unlock_percent), is_withdrawal: false}
            } else {
                let v4 = (0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::utils::max_percent() - arg0.tge_unlock_percent) / v1;
                Period{period_id: v2, release_time: arg0.tge_time + (arg0.number_of_cliff_months + v2 * arg0.number_of_linear) * 300000, percentage: v4, unlock_amount: 0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::utils::cal_amount_with_percent(arg1, v4), is_withdrawal: false}
            };
            0x1::vector::push_back<Period>(&mut v0, v3);
            v2 = v2 + 1;
        };
        v0
    }

    public(friend) fun check_is_open_claim_vesting(arg0: &0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::service::Service) : bool {
        let v0 = 0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::utils::get_key_by_struct<Feature>();
        0x2::vec_set::contains<0x1::string::String>(0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::service::features(arg0), &v0) && 0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::service::get_feature<Feature, Config>(arg0).is_open_claim_vesting
    }

    public(friend) fun execute_add_vesting(arg0: &mut 0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::service::Service, arg1: u64, arg2: address) {
        let v0 = 0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::utils::get_key_by_struct<Feature>();
        if (0x2::vec_set::contains<0x1::string::String>(0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::service::features(arg0), &v0)) {
            add_vesting(arg0, arg1, arg2);
        };
    }

    public(friend) fun execute_sub_vesting(arg0: &mut 0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::service::Service, arg1: u64, arg2: address) {
        let v0 = 0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::utils::get_key_by_struct<Feature>();
        if (0x2::vec_set::contains<0x1::string::String>(0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::service::features(arg0), &v0)) {
            sub_vesting(arg0, arg1, arg2);
        };
    }

    public(friend) fun get_id(arg0: &0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::service::Service) : 0x2::object::ID {
        0x2::object::uid_to_inner(&0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::service::get_feature<Feature, Config>(arg0).id)
    }

    fun init(arg0: SERVICE_VESTING, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<SERVICE_VESTING>(arg0, arg1);
        display<Config>(&v0, arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    public(friend) fun remove(arg0: &mut 0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::service::Service) {
        let Config {
            id                    : v0,
            info                  : _,
            project               : _,
            is_open_claim_vesting : _,
        } = 0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::service::remove_feature<Feature, Config>(arg0);
        0x2::object::delete(v0);
    }

    public(friend) fun set_is_open_claim_vesting(arg0: &mut 0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::service::Service, arg1: bool) {
        let v0 = 0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::utils::get_key_by_struct<Feature>();
        if (0x2::vec_set::contains<0x1::string::String>(0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::service::features(arg0), &v0)) {
            0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::service::get_feature_mut<Feature, Config>(arg0).is_open_claim_vesting = arg1;
        };
    }

    public(friend) fun set_is_vesting_info(arg0: &mut 0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::service::Service, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: 0x1::string::String) {
        let v0 = 0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::utils::get_key_by_struct<Feature>();
        if (0x2::vec_set::contains<0x1::string::String>(0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::service::features(arg0), &v0)) {
            let v1 = VestingInfo{
                tge_time               : arg1,
                tge_unlock_percent     : arg2,
                number_of_cliff_months : arg3,
                number_of_month        : arg4,
                number_of_linear       : arg5,
                token_type             : arg6,
            };
            0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::service::get_feature_mut<Feature, Config>(arg0).info = v1;
        };
    }

    fun sub_vesting(arg0: &mut 0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::service::Service, arg1: u64, arg2: address) {
        let v0 = 0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::service::get_feature_mut<Feature, Config>(arg0);
        assert!(0x2::dynamic_field::exists_<address>(&v0.id, arg2), 504);
        let v1 = 0x2::dynamic_field::borrow_mut<address, VestingDetail>(&mut v0.id, arg2);
        assert!(v1.total_unlock_amount == 0, 503);
        assert!(v1.total_lock_mount >= arg1, 505);
        v1.total_lock_mount = v1.total_lock_mount - arg1;
        let v2 = &mut v1.period_list;
        update_sub_vesting_period(&v0.info, v2, arg1);
    }

    fun update_add_vesting_period(arg0: &VestingInfo, arg1: &mut vector<Period>, arg2: u64) {
        let v0 = arg0.number_of_month / arg0.number_of_linear;
        let v1 = 0;
        while (v0 + 1 > v1) {
            let v2 = 0x1::vector::borrow_mut<Period>(arg1, v1);
            if (v1 == 0) {
                v2.unlock_amount = v2.unlock_amount + 0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::utils::cal_amount_with_percent(arg2, arg0.tge_unlock_percent);
            } else {
                v2.unlock_amount = v2.unlock_amount + 0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::utils::cal_amount_with_percent(arg2, (0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::utils::max_percent() - arg0.tge_unlock_percent) / v0);
            };
            v1 = v1 + 1;
        };
    }

    fun update_sub_vesting_period(arg0: &VestingInfo, arg1: &mut vector<Period>, arg2: u64) {
        let v0 = arg0.number_of_month / arg0.number_of_linear;
        let v1 = 0;
        while (v0 + 1 > v1) {
            let v2 = 0x1::vector::borrow_mut<Period>(arg1, v1);
            if (v1 == 0) {
                v2.unlock_amount = v2.unlock_amount - 0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::utils::cal_amount_with_percent(arg2, arg0.tge_unlock_percent);
            } else {
                v2.unlock_amount = v2.unlock_amount - 0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::utils::cal_amount_with_percent(arg2, (0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::utils::max_percent() - arg0.tge_unlock_percent) / v0);
            };
            v1 = v1 + 1;
        };
    }

    public(friend) fun update_withdraw(arg0: &0x2::clock::Clock, arg1: &mut 0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::service::Service, arg2: vector<u64>, arg3: address) : u64 {
        let v0 = 0x2::dynamic_field::borrow_mut<address, VestingDetail>(&mut 0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::service::get_feature_mut<Feature, Config>(arg1).id, arg3);
        let v1 = 0;
        while (!0x1::vector::is_empty<u64>(&arg2)) {
            let v2 = 0x1::vector::borrow_mut<Period>(&mut v0.period_list, 0x1::vector::pop_back<u64>(&mut arg2));
            assert!(0x2::clock::timestamp_ms(arg0) >= v2.release_time, 501);
            assert!(!v2.is_withdrawal, 502);
            v2.is_withdrawal = true;
            v1 = v1 + v2.unlock_amount;
        };
        v0.total_unlock_amount = v0.total_unlock_amount + v1;
        v1
    }

    // decompiled from Move bytecode v6
}

