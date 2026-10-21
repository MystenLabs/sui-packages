module 0xa9b29161fb4140f1bc4c6fd615cf012d097dfb9a597c5313905365601843d3c7::source {
    struct HANEUL has drop {
        dummy_field: bool,
    }

    struct SettingsKey has copy, drop, store {
        dummy_field: bool,
    }

    struct Settings has store {
        signers: 0x2::vec_map::VecMap<vector<u8>, u64>,
        max_confidence_bps: u64,
        max_future_drift_ms: u64,
        default_step_limit: StepLimit,
    }

    struct StepLimit has copy, drop, store {
        base_bps: u64,
        bps_per_second: u64,
        max_bps: u64,
    }

    struct StepLimitKey has copy, drop, store {
        pos0: u32,
    }

    public fun set_max_confidence_bps<T0>(arg0: &mut 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::source::Source<HANEUL>, arg1: &0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::config::Config, arg2: &0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::authority::PACKAGE, T0>, arg3: u64) {
        assert_package_admin_or_assistant<T0>(arg0, arg1, arg2);
        assert!(arg3 <= 10000, 13836184771233316873);
        let v0 = 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::source::source_id<HANEUL>(arg0);
        let v1 = settings_mut(arg0);
        v1.max_confidence_bps = arg3;
        0xa9b29161fb4140f1bc4c6fd615cf012d097dfb9a597c5313905365601843d3c7::events::set_max_confidence_bps(v0, v1.max_confidence_bps, arg3);
    }

    public fun set_max_future_drift_ms<T0>(arg0: &mut 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::source::Source<HANEUL>, arg1: &0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::config::Config, arg2: &0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::authority::PACKAGE, T0>, arg3: u64) {
        assert_package_admin_or_assistant<T0>(arg0, arg1, arg2);
        assert!(arg3 <= 60000, 13836466314929635339);
        let v0 = 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::source::source_id<HANEUL>(arg0);
        let v1 = settings_mut(arg0);
        v1.max_future_drift_ms = arg3;
        0xa9b29161fb4140f1bc4c6fd615cf012d097dfb9a597c5313905365601843d3c7::events::set_max_future_drift_ms(v0, v1.max_future_drift_ms, arg3);
    }

    public fun set_signer<T0>(arg0: &mut 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::source::Source<HANEUL>, arg1: &0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::config::Config, arg2: &0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::authority::PACKAGE, T0>, arg3: vector<u8>, arg4: u64, arg5: &0x2::clock::Clock) {
        assert_package_admin_or_assistant<T0>(arg0, arg1, arg2);
        assert!(0x1::vector::length<u8>(&arg3) == 32, 13835058703822225409);
        assert!(arg4 > 0x2::clock::timestamp_ms(arg5), 13835340183094034435);
        let v0 = 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::source::source_id<HANEUL>(arg0);
        let v1 = &mut settings_mut(arg0).signers;
        if (0x2::vec_map::contains<vector<u8>, u64>(v1, &arg3)) {
            *0x2::vec_map::get_mut<vector<u8>, u64>(v1, &arg3) = arg4;
        } else {
            assert!(0x2::vec_map::length<vector<u8>, u64>(v1) < 16, 13835903163112488967);
            0x2::vec_map::insert<vector<u8>, u64>(v1, arg3, arg4);
        };
        0xa9b29161fb4140f1bc4c6fd615cf012d097dfb9a597c5313905365601843d3c7::events::set_signer(v0, arg3, arg4);
    }

    public fun set_step_limit<T0>(arg0: &mut 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::source::Source<HANEUL>, arg1: &0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::config::Config, arg2: &0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::authority::PACKAGE, T0>, arg3: u32, arg4: u64, arg5: u64, arg6: u64) {
        assert_package_admin_or_assistant<T0>(arg0, arg1, arg2);
        let v0 = HANEUL{dummy_field: false};
        let v1 = 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::source::borrow_mut_id<HANEUL>(arg0, v0);
        let v2 = StepLimitKey{pos0: arg3};
        if (0x2::dynamic_field::exists<StepLimitKey>(v1, v2)) {
            *0x2::dynamic_field::borrow_mut<StepLimitKey, StepLimit>(v1, v2) = new_step_limit(arg4, arg5, arg6);
        } else {
            0x2::dynamic_field::add<StepLimitKey, StepLimit>(v1, v2, new_step_limit(arg4, arg5, arg6));
        };
        0xa9b29161fb4140f1bc4c6fd615cf012d097dfb9a597c5313905365601843d3c7::events::set_step_limit(0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::source::source_id<HANEUL>(arg0), 0x1::option::some<u32>(arg3), arg4, arg5, arg6);
    }

    public fun allows(arg0: &StepLimit, arg1: u128, arg2: u128, arg3: u64) : bool {
        ((0x1::u128::max(arg2, arg1) - 0x1::u128::min(arg2, arg1)) as u256) * (10000 as u256) * 1000 <= (arg1 as u256) * 0x1::u256::min((arg0.base_bps as u256) * 1000 + (arg0.bps_per_second as u256) * (arg3 as u256), (arg0.max_bps as u256) * 1000)
    }

    fun assert_package_admin_or_assistant<T0>(arg0: &0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::source::Source<HANEUL>, arg1: &0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::config::Config, arg2: &0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::authority::PACKAGE, T0>) {
        assert_version(arg0);
        0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::config::assert_package_version(arg1);
        0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::authority::assert_is_admin_or_assistant<T0>();
        0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::config::assert_package_authority_cap_is_valid<T0>(arg1, arg2);
    }

    public(friend) fun assert_version(arg0: &0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::source::Source<HANEUL>) {
        0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::source::assert_version<HANEUL>(arg0, 1);
    }

    public fun authorize<T0>(arg0: &mut 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::source::Source<HANEUL>, arg1: &0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::config::Config, arg2: &0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::authority::PACKAGE, T0>) {
        assert_version(arg0);
        0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::source::set_authorized<HANEUL, T0>(arg0, arg1, arg2, true);
    }

    public fun base_bps(arg0: &StepLimit) : u64 {
        arg0.base_bps
    }

    public fun bps_per_second(arg0: &StepLimit) : u64 {
        arg0.bps_per_second
    }

    public fun create<T0>(arg0: &mut 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::config::Config, arg1: &0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::authority::PACKAGE, T0>) : 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::source::Source<HANEUL> {
        let v0 = HANEUL{dummy_field: false};
        let v1 = 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::source::create<HANEUL, T0>(arg0, arg1, &v0, 1);
        let v2 = HANEUL{dummy_field: false};
        let v3 = SettingsKey{dummy_field: false};
        let v4 = StepLimit{
            base_bps       : 50,
            bps_per_second : 50,
            max_bps        : 2000,
        };
        let v5 = Settings{
            signers             : 0x2::vec_map::empty<vector<u8>, u64>(),
            max_confidence_bps  : 100,
            max_future_drift_ms : 3000,
            default_step_limit  : v4,
        };
        0x2::dynamic_field::add<SettingsKey, Settings>(0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::source::borrow_mut_id<HANEUL>(&mut v1, v2), v3, v5);
        v1
    }

    public fun deauthorize<T0>(arg0: &mut 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::source::Source<HANEUL>, arg1: &0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::config::Config, arg2: &0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::authority::PACKAGE, T0>) {
        assert_version(arg0);
        0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::source::set_authorized<HANEUL, T0>(arg0, arg1, arg2, false);
    }

    public fun default_step_limit(arg0: &0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::source::Source<HANEUL>) : StepLimit {
        settings(arg0).default_step_limit
    }

    public fun has_own_step_limit(arg0: &0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::source::Source<HANEUL>, arg1: u32) : bool {
        let v0 = StepLimitKey{pos0: arg1};
        0x2::dynamic_field::exists<StepLimitKey>(0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::source::borrow_id<HANEUL>(arg0), v0)
    }

    public fun max_bps(arg0: &StepLimit) : u64 {
        arg0.max_bps
    }

    public fun max_confidence_bps(arg0: &0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::source::Source<HANEUL>) : u64 {
        settings(arg0).max_confidence_bps
    }

    public fun max_future_drift_ms(arg0: &0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::source::Source<HANEUL>) : u64 {
        settings(arg0).max_future_drift_ms
    }

    fun new_step_limit(arg0: u64, arg1: u64, arg2: u64) : StepLimit {
        let v0 = if (arg2 <= 10000) {
            if (arg1 <= 10000) {
                arg0 <= arg2
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 13836748348252225549);
        StepLimit{
            base_bps       : arg0,
            bps_per_second : arg1,
            max_bps        : arg2,
        }
    }

    public fun remove_signer<T0>(arg0: &mut 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::source::Source<HANEUL>, arg1: &0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::config::Config, arg2: &0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::authority::PACKAGE, T0>, arg3: vector<u8>) {
        assert_package_admin_or_assistant<T0>(arg0, arg1, arg2);
        let v0 = 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::source::source_id<HANEUL>(arg0);
        let v1 = &mut settings_mut(arg0).signers;
        assert!(0x2::vec_map::contains<vector<u8>, u64>(v1, &arg3), 13835621756855123973);
        let (_, _) = 0x2::vec_map::remove<vector<u8>, u64>(v1, &arg3);
        0xa9b29161fb4140f1bc4c6fd615cf012d097dfb9a597c5313905365601843d3c7::events::removed_signer(v0, arg3);
    }

    public fun remove_step_limit<T0>(arg0: &mut 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::source::Source<HANEUL>, arg1: &0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::config::Config, arg2: &0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::authority::PACKAGE, T0>, arg3: u32) {
        assert_package_admin_or_assistant<T0>(arg0, arg1, arg2);
        let v0 = HANEUL{dummy_field: false};
        let v1 = 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::source::borrow_mut_id<HANEUL>(arg0, v0);
        let v2 = StepLimitKey{pos0: arg3};
        assert!(0x2::dynamic_field::exists<StepLimitKey>(v1, v2), 13837029535466258447);
        0x2::dynamic_field::remove<StepLimitKey, StepLimit>(v1, v2);
        0xa9b29161fb4140f1bc4c6fd615cf012d097dfb9a597c5313905365601843d3c7::events::removed_step_limit(0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::source::source_id<HANEUL>(arg0), arg3);
    }

    public fun set_default_step_limit<T0>(arg0: &mut 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::source::Source<HANEUL>, arg1: &0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::config::Config, arg2: &0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::authority::PACKAGE, T0>, arg3: u64, arg4: u64, arg5: u64) {
        assert_package_admin_or_assistant<T0>(arg0, arg1, arg2);
        let v0 = 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::source::source_id<HANEUL>(arg0);
        settings_mut(arg0).default_step_limit = new_step_limit(arg3, arg4, arg5);
        0xa9b29161fb4140f1bc4c6fd615cf012d097dfb9a597c5313905365601843d3c7::events::set_step_limit(v0, 0x1::option::none<u32>(), arg3, arg4, arg5);
    }

    fun settings(arg0: &0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::source::Source<HANEUL>) : &Settings {
        let v0 = SettingsKey{dummy_field: false};
        0x2::dynamic_field::borrow<SettingsKey, Settings>(0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::source::borrow_id<HANEUL>(arg0), v0)
    }

    fun settings_mut(arg0: &mut 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::source::Source<HANEUL>) : &mut Settings {
        let v0 = HANEUL{dummy_field: false};
        let v1 = SettingsKey{dummy_field: false};
        0x2::dynamic_field::borrow_mut<SettingsKey, Settings>(0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::source::borrow_mut_id<HANEUL>(arg0, v0), v1)
    }

    public fun signer_expires_at_ms(arg0: &0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::source::Source<HANEUL>, arg1: &vector<u8>) : 0x1::option::Option<u64> {
        0x2::vec_map::try_get<vector<u8>, u64>(&settings(arg0).signers, arg1)
    }

    public fun signers(arg0: &0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::source::Source<HANEUL>) : vector<vector<u8>> {
        0x2::vec_map::keys<vector<u8>, u64>(&settings(arg0).signers)
    }

    public(friend) fun source_cap(arg0: &0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::source::Source<HANEUL>) : &0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::authority::SourceCap {
        let v0 = HANEUL{dummy_field: false};
        0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::source::borrow_source_cap<HANEUL>(arg0, v0)
    }

    public fun step_limit(arg0: &0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::source::Source<HANEUL>, arg1: u32) : StepLimit {
        let v0 = 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::source::borrow_id<HANEUL>(arg0);
        let v1 = StepLimitKey{pos0: arg1};
        if (0x2::dynamic_field::exists<StepLimitKey>(v0, v1)) {
            *0x2::dynamic_field::borrow<StepLimitKey, StepLimit>(v0, v1)
        } else {
            settings(arg0).default_step_limit
        }
    }

    // decompiled from Move bytecode v7
}

