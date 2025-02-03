module 0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::service_vesting {
    struct Feature has drop {
        dummy_field: bool,
    }

    struct Config has store, key {
        id: 0x2::object::UID,
        info: VestingInfo,
        project: 0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::project::ProjectInfo,
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

    public(friend) fun add(arg0: &mut 0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::service::Service, arg1: 0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::project::ProjectInfo, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: 0x1::string::String, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 <= 0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::utils::max_percent(), 500);
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
        0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::service::add_feature<Feature, Config>(arg0, v1);
    }

    fun add_vesting(arg0: &mut 0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::service::Service, arg1: u64, arg2: address) {
        let v0 = 0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::service::get_feature_mut<Feature, Config>(arg0);
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

    fun build_migrate_vesting_period(arg0: &mut vector<Period>, arg1: &VestingInfo, arg2: u64) {
        let v0 = arg1.number_of_month / arg1.number_of_linear;
        let v1 = 0;
        while (0x2::math::max(v0 + 1, 0x1::vector::length<Period>(arg0)) > v1) {
            if (v0 + 1 > v1) {
                if (0x1::vector::length<Period>(arg0) > v1) {
                    let v2 = 0x1::vector::borrow_mut<Period>(arg0, v1);
                    if (v1 == 0) {
                        v2.release_time = arg1.tge_time;
                        v2.percentage = arg1.tge_unlock_percent;
                        v2.unlock_amount = 0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::utils::cal_amount_with_percent(arg2, arg1.tge_unlock_percent);
                    } else {
                        let v3 = (0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::utils::max_percent() - arg1.tge_unlock_percent) / v0;
                        v2.release_time = arg1.tge_time + (arg1.number_of_cliff_months + v1 * arg1.number_of_linear) * 2592000000;
                        v2.percentage = v3;
                        v2.unlock_amount = 0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::utils::cal_amount_with_percent(arg2, v3);
                    };
                } else {
                    let v4 = if (v1 == 0) {
                        Period{period_id: v1, release_time: arg1.tge_time, percentage: arg1.tge_unlock_percent, unlock_amount: 0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::utils::cal_amount_with_percent(arg2, arg1.tge_unlock_percent), is_withdrawal: false}
                    } else {
                        let v5 = (0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::utils::max_percent() - arg1.tge_unlock_percent) / v0;
                        Period{period_id: v1, release_time: arg1.tge_time + (arg1.number_of_cliff_months + v1 * arg1.number_of_linear) * 2592000000, percentage: v5, unlock_amount: 0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::utils::cal_amount_with_percent(arg2, v5), is_withdrawal: false}
                    };
                    0x1::vector::push_back<Period>(arg0, v4);
                };
            } else {
                let v6 = 0x1::vector::borrow_mut<Period>(arg0, v1);
                v6.release_time = arg1.tge_time + 315576000000;
                v6.percentage = 0;
                v6.unlock_amount = 0;
            };
            v1 = v1 + 1;
        };
    }

    fun build_vesting_period(arg0: &VestingInfo, arg1: u64) : vector<Period> {
        let v0 = 0x1::vector::empty<Period>();
        let v1 = arg0.number_of_month / arg0.number_of_linear;
        let v2 = 0;
        while (v1 + 1 > v2) {
            let v3 = if (v2 == 0) {
                Period{period_id: v2, release_time: arg0.tge_time, percentage: arg0.tge_unlock_percent, unlock_amount: 0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::utils::cal_amount_with_percent(arg1, arg0.tge_unlock_percent), is_withdrawal: false}
            } else {
                let v4 = (0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::utils::max_percent() - arg0.tge_unlock_percent) / v1;
                Period{period_id: v2, release_time: arg0.tge_time + (arg0.number_of_cliff_months + v2 * arg0.number_of_linear) * 2592000000, percentage: v4, unlock_amount: 0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::utils::cal_amount_with_percent(arg1, v4), is_withdrawal: false}
            };
            0x1::vector::push_back<Period>(&mut v0, v3);
            v2 = v2 + 1;
        };
        v0
    }

    public(friend) fun check_is_open_claim_vesting(arg0: &0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::service::Service) : bool {
        let v0 = 0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::utils::get_key_by_struct<Feature>();
        0x2::vec_set::contains<0x1::string::String>(0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::service::features(arg0), &v0) && 0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::service::get_feature<Feature, Config>(arg0).is_open_claim_vesting
    }

    public(friend) fun execute_add_vesting(arg0: &mut 0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::service::Service, arg1: u64, arg2: address) {
        let v0 = 0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::utils::get_key_by_struct<Feature>();
        if (0x2::vec_set::contains<0x1::string::String>(0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::service::features(arg0), &v0)) {
            add_vesting(arg0, arg1, arg2);
        };
    }

    public(friend) fun execute_migrate_vesting(arg0: &mut 0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::service::Service, arg1: address) {
        let v0 = 0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::utils::get_key_by_struct<Feature>();
        if (0x2::vec_set::contains<0x1::string::String>(0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::service::features(arg0), &v0)) {
            migrate_vesting(arg0, arg1);
        };
    }

    public(friend) fun execute_sub_vesting(arg0: &mut 0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::service::Service, arg1: u64, arg2: address) {
        let v0 = 0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::utils::get_key_by_struct<Feature>();
        if (0x2::vec_set::contains<0x1::string::String>(0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::service::features(arg0), &v0)) {
            sub_vesting(arg0, arg1, arg2);
        };
    }

    public(friend) fun get_id(arg0: &0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::service::Service) : 0x2::object::ID {
        0x2::object::uid_to_inner(&0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::service::get_feature<Feature, Config>(arg0).id)
    }

    fun init(arg0: SERVICE_VESTING, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<SERVICE_VESTING>(arg0, arg1);
        display<Config>(&v0, arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    fun migrate_vesting(arg0: &mut 0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::service::Service, arg1: address) {
        let v0 = 0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::service::get_feature_mut<Feature, Config>(arg0);
        if (0x2::dynamic_field::exists_<address>(&v0.id, arg1)) {
            let v1 = 0x2::dynamic_field::borrow_mut<address, VestingDetail>(&mut v0.id, arg1);
            if (v1.total_unlock_amount == 0 && v1.total_lock_mount != 0) {
                let v2 = &mut v1.period_list;
                build_migrate_vesting_period(v2, &v0.info, v1.total_lock_mount);
            };
        };
    }

    public(friend) fun remove(arg0: &mut 0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::service::Service) {
        let Config {
            id                    : v0,
            info                  : _,
            project               : _,
            is_open_claim_vesting : _,
        } = 0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::service::remove_feature<Feature, Config>(arg0);
        0x2::object::delete(v0);
    }

    public(friend) fun set_is_open_claim_vesting(arg0: &mut 0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::service::Service, arg1: bool) {
        let v0 = 0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::utils::get_key_by_struct<Feature>();
        if (0x2::vec_set::contains<0x1::string::String>(0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::service::features(arg0), &v0)) {
            0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::service::get_feature_mut<Feature, Config>(arg0).is_open_claim_vesting = arg1;
        };
    }

    public(friend) fun set_is_vesting_info(arg0: &mut 0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::service::Service, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: 0x1::string::String) {
        let v0 = 0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::utils::get_key_by_struct<Feature>();
        if (0x2::vec_set::contains<0x1::string::String>(0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::service::features(arg0), &v0)) {
            let v1 = VestingInfo{
                tge_time               : arg1,
                tge_unlock_percent     : arg2,
                number_of_cliff_months : arg3,
                number_of_month        : arg4,
                number_of_linear       : arg5,
                token_type             : arg6,
            };
            0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::service::get_feature_mut<Feature, Config>(arg0).info = v1;
        };
    }

    fun sub_vesting(arg0: &mut 0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::service::Service, arg1: u64, arg2: address) {
        let v0 = 0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::service::get_feature_mut<Feature, Config>(arg0);
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
                v2.unlock_amount = v2.unlock_amount + 0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::utils::cal_amount_with_percent(arg2, arg0.tge_unlock_percent);
            } else {
                v2.unlock_amount = v2.unlock_amount + 0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::utils::cal_amount_with_percent(arg2, (0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::utils::max_percent() - arg0.tge_unlock_percent) / v0);
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
                v2.unlock_amount = v2.unlock_amount - 0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::utils::cal_amount_with_percent(arg2, arg0.tge_unlock_percent);
            } else {
                v2.unlock_amount = v2.unlock_amount - 0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::utils::cal_amount_with_percent(arg2, (0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::utils::max_percent() - arg0.tge_unlock_percent) / v0);
            };
            v1 = v1 + 1;
        };
    }

    public(friend) fun update_withdraw(arg0: &0x2::clock::Clock, arg1: &mut 0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::service::Service, arg2: vector<u64>, arg3: address) : u64 {
        let v0 = 0x2::dynamic_field::borrow_mut<address, VestingDetail>(&mut 0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::service::get_feature_mut<Feature, Config>(arg1).id, arg3);
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

    public(friend) fun update_withdraw_from_index_by_admin(arg0: &mut 0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::service::Service, arg1: vector<u64>, arg2: vector<address>) {
        assert!(!0x1::vector::is_empty<u64>(&arg1), 506);
        assert!(!0x1::vector::is_empty<address>(&arg2), 506);
        let v0 = 0x6e80d8698dad095892a8563b9384f6c7dad24ec855323af36882f1db5ddc4d41::service::get_feature_mut<Feature, Config>(arg0);
        while (!0x1::vector::is_empty<address>(&arg2)) {
            let v1 = 0x2::dynamic_field::borrow_mut<address, VestingDetail>(&mut v0.id, 0x1::vector::pop_back<address>(&mut arg2));
            let v2 = 0;
            while (v2 < 0x1::vector::length<u64>(&arg1)) {
                0x1::vector::borrow_mut<Period>(&mut v1.period_list, *0x1::vector::borrow<u64>(&arg1, v2)).is_withdrawal = true;
                v2 = v2 + 1;
            };
        };
    }

    // decompiled from Move bytecode v6
}

