module 0xe5bad555746563f1429f651a0dc79d47f0cbf68a84349e85ea7882bcd18cda4f::launchpad_vesting {
    struct Vesting has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        project: 0xe5bad555746563f1429f651a0dc79d47f0cbf68a84349e85ea7882bcd18cda4f::launchpad_project::ProjectInfo,
        info: VestingInfo,
    }

    struct VestingInfo has store {
        tge_time: u64,
        tge_unlock_percent: u64,
        number_of_cliff_months: u64,
        number_of_linear_month: u64,
    }

    struct VestingDetail has store {
        total_lock_mount: u64,
        total_unlock_amount: u64,
        period_list: vector<Period>,
    }

    struct Period has store {
        period_id: u64,
        releaseTime: u64,
        percentage: u64,
        unlockAmount: u64,
        isWithdrawal: bool,
    }

    struct LAUNCHPAD_VESTING has drop {
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

    public(friend) fun add_vesting(arg0: u64, arg1: &mut 0xe5bad555746563f1429f651a0dc79d47f0cbf68a84349e85ea7882bcd18cda4f::launchpad_project::Project, arg2: 0x1::string::String, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = borrow_mut_vesting(arg1, convert_to_vesting_string(arg2));
        assert!(arg0 < v1.info.tge_time, 203);
        if (!0x2::dynamic_field::exists_<address>(&v1.id, v0)) {
            let v2 = VestingDetail{
                total_lock_mount    : arg3,
                total_unlock_amount : 0,
                period_list         : build_vesting_period(&v1.info, arg3),
            };
            0x2::dynamic_field::add<address, VestingDetail>(&mut v1.id, v0, v2);
        } else {
            let v3 = 0x2::dynamic_field::borrow_mut<address, VestingDetail>(&mut v1.id, v0);
            v3.total_lock_mount = v3.total_lock_mount + arg3;
            let v4 = &mut v3.period_list;
            update_vesting_period(&v1.info, v4, arg3);
        };
    }

    fun borrow_mut_vesting(arg0: &mut 0xe5bad555746563f1429f651a0dc79d47f0cbf68a84349e85ea7882bcd18cda4f::launchpad_project::Project, arg1: 0x1::string::String) : &mut Vesting {
        0xe5bad555746563f1429f651a0dc79d47f0cbf68a84349e85ea7882bcd18cda4f::launchpad_project::borrow_mut_dynamic_object_field<Vesting>(arg0, arg1)
    }

    fun borrow_vesting(arg0: &0xe5bad555746563f1429f651a0dc79d47f0cbf68a84349e85ea7882bcd18cda4f::launchpad_project::Project, arg1: 0x1::string::String) : &Vesting {
        0xe5bad555746563f1429f651a0dc79d47f0cbf68a84349e85ea7882bcd18cda4f::launchpad_project::borrow_dynamic_object_field<Vesting>(arg0, arg1)
    }

    fun build_vesting_period(arg0: &VestingInfo, arg1: u64) : vector<Period> {
        let v0 = 0x1::vector::empty<Period>();
        let v1 = 0;
        while (arg0.number_of_linear_month + 1 > v1) {
            let v2 = if (v1 == 0) {
                Period{period_id: v1, releaseTime: arg0.tge_time, percentage: arg0.tge_unlock_percent, unlockAmount: cal_amount_with_percent(arg1, arg0.tge_unlock_percent), isWithdrawal: false}
            } else {
                let v3 = (100000000000 - arg0.tge_unlock_percent) / arg0.number_of_linear_month;
                Period{period_id: v1, releaseTime: arg0.tge_time + (arg0.number_of_cliff_months + v1) * 300000, percentage: v3, unlockAmount: cal_amount_with_percent(arg1, v3), isWithdrawal: false}
            };
            0x1::vector::push_back<Period>(&mut v0, v2);
            v1 = v1 + 1;
        };
        v0
    }

    fun cal_amount_with_percent(arg0: u64, arg1: u64) : u64 {
        0xe5bad555746563f1429f651a0dc79d47f0cbf68a84349e85ea7882bcd18cda4f::utils::mul_u64_div_u64(arg0, arg1, 100000000000)
    }

    fun convert_to_vesting_string(arg0: 0x1::string::String) : 0x1::string::String {
        0x1::string::append_utf8(&mut arg0, b" <> Vesting");
        arg0
    }

    fun init(arg0: LAUNCHPAD_VESTING, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<LAUNCHPAD_VESTING>(arg0, arg1);
        display<Vesting>(&v0, arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    public(friend) fun new_vesting(arg0: &0x2::clock::Clock, arg1: &0xe5bad555746563f1429f651a0dc79d47f0cbf68a84349e85ea7882bcd18cda4f::launchpad_project::Project, arg2: 0x1::string::String, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : (Vesting, 0x1::string::String, 0x2::object::ID) {
        let v0 = convert_to_vesting_string(arg2);
        assert!(arg3 >= 0x2::clock::timestamp_ms(arg0), 201);
        assert!(arg4 <= 100000000000, 202);
        let v1 = 0x2::object::new(arg7);
        let v2 = VestingInfo{
            tge_time               : arg3,
            tge_unlock_percent     : arg4,
            number_of_cliff_months : arg5,
            number_of_linear_month : arg6,
        };
        let v3 = Vesting{
            id      : v1,
            name    : v0,
            project : 0xe5bad555746563f1429f651a0dc79d47f0cbf68a84349e85ea7882bcd18cda4f::launchpad_project::get_project_info(arg1),
            info    : v2,
        };
        (v3, v0, 0x2::object::uid_to_inner(&v1))
    }

    fun update_vesting_period(arg0: &VestingInfo, arg1: &mut vector<Period>, arg2: u64) {
        let v0 = 0;
        while (arg0.number_of_linear_month + 1 > v0) {
            if (v0 == 0) {
                0x1::vector::borrow_mut<Period>(arg1, v0).unlockAmount = cal_amount_with_percent(arg2, arg0.tge_unlock_percent);
            } else {
                0x1::vector::borrow_mut<Period>(arg1, v0).unlockAmount = cal_amount_with_percent(arg2, (100000000000 - arg0.tge_unlock_percent) / arg0.number_of_linear_month);
            };
            v0 = v0 + 1;
        };
    }

    public(friend) fun update_withdraw(arg0: &0x2::clock::Clock, arg1: &mut 0xe5bad555746563f1429f651a0dc79d47f0cbf68a84349e85ea7882bcd18cda4f::launchpad_project::Project, arg2: 0x1::string::String, arg3: vector<u64>, arg4: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::dynamic_field::borrow_mut<address, VestingDetail>(&mut borrow_mut_vesting(arg1, convert_to_vesting_string(arg2)).id, 0x2::tx_context::sender(arg4));
        let v1 = 0;
        while (!0x1::vector::is_empty<u64>(&arg3)) {
            let v2 = 0x1::vector::borrow_mut<Period>(&mut v0.period_list, 0x1::vector::pop_back<u64>(&mut arg3));
            assert!(0x2::clock::timestamp_ms(arg0) >= v2.releaseTime, 204);
            v2.isWithdrawal = true;
            v1 = v1 + v2.unlockAmount;
        };
        v0.total_unlock_amount = v0.total_unlock_amount + v1;
        v1
    }

    // decompiled from Move bytecode v6
}

